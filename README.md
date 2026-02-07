# 精品电商 - 静态网站

一个简约时尚的电商展示型静态网站，适合展示产品和品牌信息。

## 网站结构

```
ecommerce-site/
├── index.html      # 首页
├── products.html   # 产品展示页
├── about.html      # 关于我们
├── contact.html    # 联系我们
├── styles.css      # 样式文件
├── script.js       # 交互脚本
└── admin/          # CMS 管理后台
    ├── config.yml  # CMS 配置
    └── index.html  # CMS 入口
```

## 功能特点

- ✅ 响应式设计，支持手机/平板/电脑
- ✅ 4个完整页面：首页、产品、关于我们、联系
- ✅ 产品分类筛选功能
- ✅ 可视化后台管理（Decap CMS）
- ✅ 现代简约设计风格
- ✅ 滚动动画效果

## 可视化后台（Decap CMS）

### 访问方式

网站部署后，访问：`https://你的域名/admin`

用你的 GitHub 账号登录即可管理内容。

### 配置步骤（首次使用）

**步骤 1：推送新文件到 GitHub**

把 `admin/` 文件夹里的 `config.yml` 和 `index.html` 也上传到 GitHub 仓库。

**步骤 2：注册 Netlify Identity（免费）**

1. 打开 https://app.netlify.com
2. 用 GitHub 登录
3. 点击 **Add new site** → **Import an existing project**
4. 选择你的 GitHub 仓库 `raymondxu1883-gif/ecommerce-site`
5. 点击 **Deploy site**

**步骤 3：启用 Identity 和 Git Gateway**

1. 在 Netlify 站点页面，点击 **Site settings** → **Identity**
2. 点击 **Enable Identity**
3. 在 **Identity** 页面，找到 **Git Gateway**，点击 **Enable Git Gateway**

**步骤 4：配置 CMS**

1. 回到你的 Vercel 部署页面
2. 添加环境变量 `DECAP_SITE_ID` = 你的 Netlify 站点 ID

或者更简单的方案：直接在 Netlify 上部署，而不是 Vercel：

1. 删除 Vercel 的部署
2. 把网站迁移到 Netlify 免费托管
3. Netlify 原生支持 Decap CMS，无需额外配置

### 简化方案：不用 CMS 时

直接用 GitHub 网页版编辑：

1. 打开 https://github.com/raymondxu1883-gif/ecommerce-site
2. 点击要修改的文件（如 `index.html`）
3. 点击编辑图标（✏️）
4. 修改内容，点击 **Commit changes**
5. 网站自动更新（1-2分钟）

## 快速部署到 Vercel（当前方案）

### 方式一：使用 Vercel CLI（推荐）

1. **安装 Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **登录 Vercel**
   ```bash
   vercel login
   ```

3. **部署网站**
   ```bash
   cd ecommerce-site
   vercel
   ```

### 方式二：GitHub + Vercel 自动部署

1. **创建 GitHub 仓库**
   - 访问 https://github.com/new
   - Repository name: `ecommerce-site`
   - Public → Create repository

2. **上传代码到 GitHub**
   ```bash
   cd ecommerce-site
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/你的用户名/ecommerce-site.git
   git push -u origin main
   ```

3. **连接 Vercel**
   - 访问 https://vercel.com
   - 点击 **Add New...** → **Project**
   - 导入你的 GitHub 仓库
   - 点击 Deploy

## 自定义修改

### 修改网站标题和 Logo
编辑 `index.html`，找到：
```html
<div class="logo">🏪 精品电商</div>
```
把「精品电商」改成你的品牌名。

### 修改产品信息
编辑 `products.html`，修改产品卡片：
```html
<div class="product-card" data-category="bags">
    <div class="product-image">👜</div>
    <div class="product-info">
        <h3>你的产品名称</h3>
        <p class="description">产品描述</p>
        <p class="price">¥价格</p>
        <button class="btn btn-secondary">加入购物车</button>
    </div>
</div>
```

### 修改联系信息
编辑 `contact.html`，找到：
```html
<p>📧 example@email.com</p>
<p>📞 400-123-4567</p>
<p>北京市朝阳区xxx大厦</p>
```

## 技术栈

- **HTML5** - 语义化结构
- **CSS3** - 响应式设计，Flexbox + Grid 布局
- **JavaScript** - 交互功能，无依赖
- **Decap CMS** - 可视化内容管理
- **无框架** - 纯原生代码，轻量快速

## 浏览器支持

- Chrome 60+
- Firefox 60+
- Safari 11+
- Edge 79+

## 后续扩展建议

1. **添加真实电商功能**：升级到 Shopify、店匠或 WooCommerce
2. **SEO 优化**：添加 meta 标签、 sitemap
3. **分析统计**：添加 Google Analytics
4. **多语言支持**：添加英文版本

## 许可证

MIT License - 欢迎商用和修改
