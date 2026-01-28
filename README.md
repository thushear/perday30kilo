# PerDay30Kilo 技术博客

![Hugo](https://img.shields.io/badge/Hugo-0.154.5-blue)
![Theme](https://img.shields.io/badge/Theme-PaperMod-green)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Deployment](https://img.shields.io/badge/Deployment-Universal-brightgreen)

专注于量化交易、AI 技术和软件工程的技术博客。

**✨ 特色**：使用相对路径，支持任意域名、IP地址和子目录部署！

## 📚 博客内容

- 量化交易系统开发
- Python 工程实践
- AI Agent 应用
- Web 全栈开发
- 技术思考与总结

## 🚀 本地运行

```bash
# 克隆仓库（包含子模块）
git clone --recurse-submodules https://github.com/thushear/perday30kilo.git
cd perday30kilo

# 启动开发服务器
hugo server -D

# 访问 http://localhost:1313
```

## 🏗️ 构建博客

```bash
# 1. 构建静态文件
hugo --minify

# 2. 修复链接为相对路径
./fix-links.sh

# 完成！public/ 目录可直接部署
```

详见：[BUILD_GUIDE.md](BUILD_GUIDE.md)

## 🛠️ 技术栈

- **生成器**: Hugo 0.154.5
- **主题**: PaperMod
- **部署**: GitHub Pages
- **语言**: Markdown

## 📝 写作

```bash
# 创建新文章
hugo new posts/your-article-name.md

# 编辑文章，设置 draft: false

# 构建并修复链接
hugo --minify && ./fix-links.sh

# 提交推送
git add -A && git commit -m "添加新文章" && git push
```

## 🌐 部署

### 方式 1：GitHub Pages（自动部署）

推送到 `main` 分支自动触发 GitHub Actions 构建和部署。

访问：https://thushear.github.io/perday30kilo/

详见：[DEPLOYMENT.md](DEPLOYMENT.md)

### 方式 2：自建服务器（直接部署）⭐

```bash
# 克隆仓库
git clone https://github.com/thushear/perday30kilo.git
cd perday30kilo

# 配置 Nginx 指向 public/ 目录
# 支持任意域名和IP访问，无需修改配置！
```

详见：[SERVER_DEPLOYMENT.md](SERVER_DEPLOYMENT.md) 或 [QUICK_DEPLOY.md](QUICK_DEPLOY.md)

## 📬 联系方式

- GitHub: [@kongming](https://github.com/kongming)
- 博客: [https://perday30kilo.github.io](https://perday30kilo.github.io)

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

⭐ 如果觉得有用，欢迎 Star！
