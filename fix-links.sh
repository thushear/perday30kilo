#!/bin/bash
# 脚本：修复 public/ 目录中的 localhost 链接为相对路径
# 使用方法：./fix-links.sh

echo "开始替换 HTML 文件中的 localhost 链接..."

# 查找所有 HTML 文件并替换 http://localhost/ 为 /
find public -name "*.html" -type f -exec sed -i '' 's|http://localhost/|/|g' {} \;

# 查找所有 XML 文件并替换
find public -name "*.xml" -type f -exec sed -i '' 's|http://localhost/|/|g' {} \;

echo "✅ 链接替换完成！"
echo "现在所有链接都是相对路径，可以在任何域名或IP下访问。"
