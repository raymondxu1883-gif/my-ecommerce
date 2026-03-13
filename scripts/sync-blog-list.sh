#!/bin/bash
# 自动同步 blog/ 目录的文章到 blog.html，并使用文章的 featured image

BLOG_DIR="blog"
BLOG_HTML="blog.html"

echo "=== 博客同步检查 ==="
BLOG_COUNT=$(ls $BLOG_DIR/*.html 2>/dev/null | wc -l | tr -d ' ')
HTML_COUNT=$(grep -c 'class="blog-card"' $BLOG_HTML 2>/dev/null | tr -d ' ')

echo "blog/ 目录文章数: $BLOG_COUNT"
echo "blog.html 链接数: $HTML_COUNT"

if [ "$BLOG_COUNT" = "$HTML_COUNT" ]; then
    echo "✅ 已同步"
fi

# 博客卡片模板 - 使用文章的 featured image
TEMPLATE='            <!-- Blog Post -->
            <a href="BLOG_URL" class="blog-card">
                <div class="blog-image"><img loading="lazy" src="BLOG_IMAGE" alt="BLOG_TITLE" width="400" height="250" style="width:100%;height:100%;object-fit:cover;"></div>
                <div class="blog-overlay">
                    <span class="blog-category">CATEGORY</span>
                    <h3>TITLE</h3>
                    <span class="blog-date">DATE</span>
                </div>
            </a>'

extract_meta() {
    local file=$1
    
    # 提取 featured image
    local image=$(grep -E 'featured-image|class="hero-image"' -A1 "$file" 2>/dev/null | grep 'src=' | sed 's/.*src="\([^"]*\)".*/\1/' | head -1)
    
    # 提取标题
    local title=$(grep -oP '(?<=<title>)[^<]+' "$file" 2>/dev/null | head -1 | sed 's/ |.*//')
    
    # 提取分类
    local category=$(grep -oP '(?<=<span class="category-tag">)[^<]+' "$file" 2>/dev/null | head -1)
    
    # 提取日期
    local date=$(grep -oP '(?<=<span>)[A-Za-z]+ \d+, \d{4}' "$file" 2>/dev/null | head -1)
    
    # 默认值
    [ -z "$image" ] && image="https://eventdecorsigns.com/images/products/welcome-sign-ai-1.webp"
    [ -z "$title" ] && title=$(basename "$file" .html | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/')
    [ -z "$category" ] && category="Wedding Tips"
    [ -z "$date" ] && date=$(date +"%b %d, %Y")
    
    echo "$image|$title|$category|$date"
}

# 找到博客区域
START_LINE=$(grep -n 'class="blog-card"' "$BLOG_HTML" | head -1 | cut -d: -f1)
if [ -z "$START_LINE" ]; then
    echo "❌ 错误: 找不到博客卡片区域"
    exit 1
fi

END_LINE=$(awk -v start="$START_LINE" 'NR>start && /<\/div>/ && /<\/section>/{print NR; exit}' "$BLOG_HTML")
[ -z "$END_LINE" ] && END_LINE=$((START_LINE + 20))

echo "博客区域: 第 $START_LINE 到 $END_LINE 行"

# 生成新卡片
NEW_CARDS=""

for file in $(ls -t $BLOG_DIR/*.html 2>/dev/null); do
    filename=$(basename "$file")
    url="blog/$filename"
    
    meta=$(extract_meta "$file")
    image=$(echo "$meta" | cut -d'|' -f1)
    title=$(echo "$meta" | cut -d'|' -f2)
    category=$(echo "$meta" | cut -d'|' -f3)
    date=$(echo "$meta" | cut -d'|' -f4)
    
    card="$TEMPLATE"
    card="${card//BLOG_URL/$url}"
    card="${card//BLOG_IMAGE/$image}"
    card="${card//BLOG_TITLE/$title}"
    card="${card//CATEGORY/$category}"
    card="${card//TITLE/$title}"
    card="${card//DATE/$date}"
    
    NEW_CARDS="$NEW_CARDS$card
"
done

# 重写文件
head -n $((START_LINE - 1)) "$BLOG_HTML" > "${BLOG_HTML}.new"
echo "$NEW_CARDS" >> "${BLOG_HTML}.new"
tail -n +$((END_LINE)) "$BLOG_HTML" >> "${BLOG_HTML}.new"

mv "${BLOG_HTML}.new" "$BLOG_HTML"

echo "✅ 同步完成！"
