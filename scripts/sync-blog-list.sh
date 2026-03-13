#!/bin/bash
BLOG_DIR="blog"
BLOG_HTML="blog.html"

echo "=== 博客同步 ==="

extract_meta() {
    local file=$1
    local image=$(grep -E 'featured-image|class="hero' -A1 "$file" 2>/dev/null | grep 'src=' | sed 's/.*src="\([^"]*\)".*/\1/' | head -1)
    local title=$(grep -oP '(?<=<title>)[^<]+' "$file" 2>/dev/null | head -1 | sed 's/ |.*//')
    local category=$(grep -oP '(?<=<span class="category-tag">)[^<]+' "$file" 2>/dev/null | head -1)
    local date=$(grep -oP '(?<=<span>)[A-Za-z]+ \d+, \d{4}' "$file" 2>/dev/null | head -1)
    
    [ -z "$image" ] && image="https://eventdecorsigns.com/images/products/welcome-sign-ai-1.webp"
    [ -z "$title" ] && title=$(basename "$file" .html | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/')
    [ -z "$category" ] && category="Wedding Tips"
    [ -z "$date" ] && date="Mar 14, 2026"
    
    echo "$image|$title|$category|$date"
}

START=$(grep -n 'class="blog-gallery' "$BLOG_HTML" | head -1 | cut -d: -f1)
[ -z "$START" ] && START=$(grep -n 'class="blog-card"' "$BLOG_HTML" | head -1 | cut -d: -f1)
END=$(awk -v s="$START" 'NR>s && /<\/section>/{print NR; exit}' "$BLOG_HTML")
[ -z "$END" ] && END=$((START + 50))

echo "区域: $START - $END"

NEW_CARDS=""
for file in $(ls -t $BLOG_DIR/*.html 2>/dev/null); do
    fname=$(basename "$file")
    url="blog/$fname"
    meta=$(extract_meta "$file")
    img=$(echo "$meta" | cut -d'|' -f1)
    ttl=$(echo "$meta" | cut -d'|' -f2)
    cat=$(echo "$meta" | cut -d'|' -f3)
    dat=$(echo "$meta" | cut -d'|' -f4)
    
    NEW_CARDS="${NEW_CARDS}            <a href=\"$url\" class=\"blog-card\">
                <div class=\"blog-image\"><img loading=\"lazy\" src=\"$img\" alt=\"$ttl\" width=\"400\" height=\"250\" style=\"width:100%;height:100%;object-fit:cover;\"></div>
                <div class=\"blog-overlay\">
                    <span class=\"blog-category\">$cat</span>
                    <h3>$ttl</h3>
                    <span class=\"blog-date\">$dat</span>
                </div>
            </a>
"
done

head -n $((START - 1)) "$BLOG_HTML" > "${BLOG_HTML}.new"
echo "$NEW_CARDS" >> "${BLOG_HTML}.new"
tail -n +$((END)) "$BLOG_HTML" >> "${BLOG_HTML}.new"
mv "${BLOG_HTML}.new" "$BLOG_HTML"

echo "✅ 同步完成"
