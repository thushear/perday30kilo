# 📦 构建指南

## 🎯 构建流程

由于 Hugo 的 PaperMod 主题特性，我们采用以下构建流程确保链接使用相对路径：

### 步骤 1：构建静态文件

```bash
cd /Users/kongming/code/github-backup/perday30kilo

# 使用 localhost 作为 baseURL 构建
hugo --minify
```

### 步骤 2：修复链接为相对路径

```bash
# 运行链接修复脚本
./fix-links.sh
```

这个脚本会自动将所有 `http://localhost/` 替换为 `/`，使链接变为相对路径。

### 步骤 3：提交到 Git

```bash
git add -A
git commit -m "更新博客内容"
git push
```

## 🔄 完整更新流程

```bash
# 1. 修改内容
# 编辑 content/ 目录下的 Markdown 文件

# 2. 构建并修复链接
hugo --minify && ./fix-links.sh

# 3. 本地预览（可选）
# 使用任意 Web 服务器预览 public/ 目录
python3 -m http.server 8000 --directory public
# 访问 http://localhost:8000

# 4. 提交推送
git add -A
git commit -m "更新博客内容"
git push
```

## 🚀 为什么要这样做？

Hugo 的 PaperMod 主题在 `baseURL` 为 `/` 时会出现构建错误，因此我们：

1. 使用 `baseURL = 'http://localhost/'` 构建
2. 用脚本自动替换为相对路径 `/`
3. 最终结果：所有链接都是相对路径，支持任意域名和IP访问

## ✅ 链接格式对比

### 替换前

```html
<a href="http://localhost/posts/">文章</a>
<link rel="canonical" href="http://localhost/" />
```

### 替换后

```html
<a href="/posts/">文章</a> <link rel="canonical" href="/" />
```

## 📝 配置文件说明

`hugo.toml` 配置：

```toml
baseURL = 'http://localhost/'  # 构建时使用
# 构建后通过 fix-links.sh 自动替换为 /
```

## 🎨 创建新文章

```bash
# 创建文章
hugo new posts/my-article.md

# 编辑文章内容
# 设置 draft: false

# 构建并修复
hugo --minify && ./fix-links.sh

# 提交
git add -A && git commit -m "添加新文章" && git push
```

## 🔧 工具脚本

### fix-links.sh

自动替换脚本内容：

```bash
#!/bin/bash
find public -name "*.html" -type f -exec sed -i '' 's|http://localhost/|/|g' {} \;
find public -name "*.xml" -type f -exec sed -i '' 's|http://localhost/|/|g' {} \;
```

**功能**：

- 替换所有 HTML 文件中的 localhost 链接
- 替换所有 XML 文件（sitemap、RSS）中的 localhost 链接
- 转换为相对路径，支持任意域名访问

## 🌐 部署到服务器

构建后的 `public/` 目录可以直接部署：

```bash
# 服务器上克隆仓库
git clone https://github.com/thushear/perday30kilo.git
cd perday30kilo

# 配置 Nginx 指向 public/ 目录
# 无需任何额外处理，直接使用即可

# 更新时
git pull
```

详见：[SERVER_DEPLOYMENT.md](SERVER_DEPLOYMENT.md)

## ❓ 常见问题

### Q1: 为什么不直接使用 relativeURLs = true？

**A**: PaperMod 主题与 relativeURLs 配置不兼容，会导致构建错误。

### Q2: 每次都要运行 fix-links.sh 吗？

**A**: 是的，每次构建后都需要运行该脚本。可以创建一个组合命令：

```bash
# 添加到 ~/.zshrc 或 ~/.bashrc
alias hugo-build='hugo --minify && ./fix-links.sh'
```

之后只需运行：

```bash
hugo-build
```

### Q3: 本地预览时链接正常吗？

**A**: 修复后的链接在本地 Web 服务器中完全正常工作。

### Q4: 能否自动化这个过程？

**A**: 可以，创建 Makefile 或使用 npm scripts：

```bash
# 创建 Makefile
cat > Makefile << 'EOF'
build:
	hugo --minify
	./fix-links.sh
	@echo "✅ 构建完成！"

deploy: build
	git add -A
	git commit -m "更新博客"
	git push
	@echo "🚀 部署完成！"
EOF

# 使用
make build    # 构建
make deploy   # 构建并部署
```

---

**提示**：此构建流程确保博客可以在任何域名、IP地址或子目录下正常访问！
