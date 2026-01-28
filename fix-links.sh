#!/bin/bash
# 脚本：修复 public/ 目录中的 localhost 链接为相对路径
# 使用方法：./fix-links.sh

echo "开始替换 HTML 文件中的 localhost 链接..."

# 替换 http://localhost:1313/ （带端口）
find public -name "*.html" -type f -exec sed -i '' 's|http://localhost:1313/|/|g' {} \;
# 替换 http://localhost/ （不带端口）
find public -name "*.html" -type f -exec sed -i '' 's|http://localhost/|/|g' {} \;

# 替换所有 XML 文件
find public -name "*.xml" -type f -exec sed -i '' 's|http://localhost:1313/|/|g' {} \;
find public -name "*.xml" -type f -exec sed -i '' 's|http://localhost/|/|g' {} \;

echo "✅ 链接替换完成！"
echo "现在所有链接都是相对路径，可以在任何域名或IP下访问。"
