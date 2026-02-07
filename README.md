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
└── script.js       # 交互脚本
```

## 功能特点

- ✅ 响应式设计，支持手机/平板/电脑
- ✅ 4个完整页面：首页、产品、关于我们、联系
- ✅ 产品分类筛选功能
- ✅ 加入购物车交互
- ✅ 联系表单
- ✅ 现代简约设计风格
- ✅ 滚动动画效果

## 快速部署到 Vercel（免费）

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
   
   按提示操作：
   - Set up and deploy? → `Y`
   - Which scope? → 选择你的账号
   - Link to existing project? → `N`
   - Project Name? → 输入项目名（如 `my-ecommerce`）
   - In which directory is your code located? → `./` → 回车

4. **完成！**
   - Vercel 会自动生成一个免费域名（如 `my-ecommerce.vercel.app`）
   - 访问这个链接就能看到你的网站！

### 方式二：GitHub + Vercel 自动部署

1. **创建 GitHub 仓库**
   - 访问 https://github.com/new
   - Repository name: `my-ecommerce`
   - Public → Create repository

2. **上传代码到 GitHub**
   ```bash
   cd ecommerce-site
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/你的用户名/my-ecommerce.git
   git push -u origin main
   ```

3. **连接 Vercel**
   - 访问 https://vercel.com
   - 点击 "Add New..." → Project
   - 导入你的 GitHub 仓库
   - 点击 Deploy

### 方式三：GitHub Pages（完全免费）

1. **上传到 GitHub**（同上）

2. **开启 GitHub Pages**
   - 进入仓库 → Settings → Pages
   - Source: 选择 "main" branch
   - 点击 Save

3. **访问你的网站**
   - 域名格式：`https://你的用户名.github.io/仓库名/`

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

### 更换图片
把 `product-image` 中的 emoji 换成真实图片：
```html
<div class="product-image">
    <img src="images/your-product.jpg" alt="产品名称" style="max-width: 100%;">
</div>
```

## 技术栈

- **HTML5** - 语义化结构
- **CSS3** - 响应式设计，Flexbox + Grid 布局
- **JavaScript** - 交互功能，无依赖
- **无框架** - 纯原生代码，轻量快速

## 浏览器支持

- Chrome 60+
- Firefox 60+
- Safari 11+
- Edge 79+

## 后续扩展建议

1. **添加真实后端**：可以用 Supabase、Firebase 或自建 API
2. **添加购物车功能**：用 localStorage 存储购物车数据
3. **SEO 优化**：添加 meta 标签、 sitemap
4. **分析统计**：添加 Google Analytics

## 许可证

MIT License - 欢迎商用和修改
