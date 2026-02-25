export async function onRequestGet(context) {
  const { request, env } = context;
  
  // 检查环境变量
  if (!env.GITHUB_CLIENT_ID || !env.GITHUB_CLIENT_SECRET) {
    return new Response("Missing env vars: GITHUB_CLIENT_ID or GITHUB_CLIENT_SECRET", { status: 500 });
  }
  
  const url = new URL(request.url);
  const code = url.searchParams.get('code');
  
  if (!code) {
    // 没有code，返回重定向到GitHub OAuth
    const redirectUrl = `https://github.com/login/oauth/authorize?client_id=${env.GITHUB_CLIENT_ID}&scope=repo`;
    return new Response(null, {
      status: 302,
      headers: { 'Location': redirectUrl }
    });
  }
  
  // 用code换取access token
  try {
    const tokenResponse = await fetch('https://github.com/login/oauth/access_token', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        client_id: env.GITHUB_CLIENT_ID,
        client_secret: env.GITHUB_CLIENT_SECRET,
        code: code
      })
    });
    
    const tokenData = await tokenResponse.json();
    
    if (tokenData.error) {
      return new Response("OAuth error: " + tokenData.error_description, { status: 400 });
    }
    
    const accessToken = tokenData.access_token;
    
    // 重定向回CMS后台，带上认证token
    return new Response(null, {
      status: 302,
      headers: {
        'Location': `/admin/#access_token=${accessToken}&token_type=bearer`,
      },
    });
  } catch (e) {
    return new Response("Error: " + e.message, { status: 500 });
  }
}
