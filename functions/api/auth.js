// 处理GitHub OAuth回调，替代Netlify Git Gateway
export async function onRequestGet(context) {
  const { request, env } = context;
  const url = new URL(request.url);
  const code = url.searchParams.get('code');

  // 用code换取access token
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
  const accessToken = tokenData.access_token;

  // 重定向回CMS后台，带上认证token
  return new Response(null, {
    status: 302,
    headers: {
      'Location': `/admin/#access_token=${accessToken}&token_type=bearer`,
    },
  });
}
