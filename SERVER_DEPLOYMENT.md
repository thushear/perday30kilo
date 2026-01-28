# 🚀 服务器直接部署指南

本指南说明如何在服务器上直接部署博客，**无需安装 Hugo**。

## ✅ 为什么可以直接部署？

仓库中已包含构建好的 `public/` 目录，包含所有静态 HTML、CSS、XML 文件，可以直接作为网站根目录使用。

**文件大小**：约 304KB（轻量级）  
**文件数量**：40 个静态文件

## 📋 方式一：使用 Nginx 部署（推荐）

### 步骤 1：克隆仓库到服务器

```bash
# SSH 登录服务器
ssh user@your-server.com

# 克隆仓库
cd /var/www
git clone https://github.com/thushear/perday30kilo.git
cd perday30kilo
```

### 步骤 2：配置 Nginx

创建 Nginx 配置文件：

```bash
sudo nano /etc/nginx/sites-available/perday30kilo
```

添加以下配置：

```nginx
server {
    listen 80;
    server_name your-domain.com;  # 改为你的域名

    # 网站根目录指向 public 文件夹
    root /var/www/perday30kilo/public;
    index index.html;

    # 日志
    access_log /var/log/nginx/perday30kilo_access.log;
    error_log /var/log/nginx/perday30kilo_error.log;

    # 主要配置
    location / {
        try_files $uri $uri/ =404;
    }

    # Gzip 压缩
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript
               application/x-javascript application/xml+rss
               application/json application/javascript;

    # 缓存静态资源
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # 404 页面
    error_page 404 /404.html;
}
```

### 步骤 3：启用站点

```bash
# 创建软链接
sudo ln -s /etc/nginx/sites-available/perday30kilo /etc/nginx/sites-enabled/

# 测试配置
sudo nginx -t

# 重启 Nginx
sudo systemctl restart nginx
```

### 步骤 4：访问网站

浏览器访问：`http://your-domain.com`

### 步骤 5：配置 HTTPS（可选但推荐）

使用 Let's Encrypt 免费证书：

```bash
# 安装 certbot
sudo apt install certbot python3-certbot-nginx

# 自动配置 HTTPS
sudo certbot --nginx -d your-domain.com

# 自动续期测试
sudo certbot renew --dry-run
```

## 📋 方式二：使用 Apache 部署

### 步骤 1：克隆仓库

```bash
cd /var/www/html
git clone https://github.com/thushear/perday30kilo.git
```

### 步骤 2：配置 Apache

创建虚拟主机配置：

```bash
sudo nano /etc/apache2/sites-available/perday30kilo.conf
```

添加配置：

```apache
<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /var/www/html/perday30kilo/public

    <Directory /var/www/html/perday30kilo/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/perday30kilo_error.log
    CustomLog ${APACHE_LOG_DIR}/perday30kilo_access.log combined
</VirtualHost>
```

### 步骤 3：启用站点

```bash
# 启用站点
sudo a2ensite perday30kilo

# 启用必要模块
sudo a2enmod rewrite

# 重启 Apache
sudo systemctl restart apache2
```

## 📋 方式三：使用 Docker 部署

### 创建 Dockerfile

在仓库根目录创建 `Dockerfile`：

```dockerfile
FROM nginx:alpine

# 复制静态文件
COPY public/ /usr/share/nginx/html/

# 复制 Nginx 配置（可选）
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### 构建和运行

```bash
# 克隆仓库
git clone https://github.com/thushear/perday30kilo.git
cd perday30kilo

# 构建镜像
docker build -t perday30kilo-blog .

# 运行容器
docker run -d -p 80:80 --name blog perday30kilo-blog

# 或使用 docker-compose
cat > docker-compose.yml << 'EOF'
version: '3'
services:
  blog:
    build: .
    ports:
      - "80:80"
    restart: unless-stopped
EOF

docker-compose up -d
```

## 🔄 更新博客内容

### 方法 1：手动更新（在服务器上）

```bash
# SSH 到服务器
ssh user@your-server.com

# 进入博客目录
cd /var/www/perday30kilo

# 拉取最新代码
git pull origin main

# Nginx/Apache 会自动使用新文件，无需重启
```

### 方法 2：自动化部署（Webhook）

创建自动部署脚本 `/var/www/deploy-blog.sh`：

```bash
#!/bin/bash
cd /var/www/perday30kilo
git pull origin main
echo "Blog updated at $(date)" >> /var/log/blog-deploy.log
```

配置 GitHub Webhook：

1. 仓库 Settings → Webhooks → Add webhook
2. Payload URL: `http://your-server.com/webhook`
3. 配置 webhook 接收服务（如 webhook、adnanh/webhook）

### 方法 3：本地更新后推送

```bash
# 本地修改博客内容后
cd /Users/kongming/code/github-backup/perday30kilo

# 重新构建
hugo --minify

# 提交并推送
git add public/
git commit -m "更新博客内容"
git push

# 然后在服务器上执行 git pull
```

## 📊 目录结构

```
perday30kilo/
├── public/              # ← 网站根目录（Nginx/Apache 指向这里）
│   ├── index.html       # 首页
│   ├── about/           # 关于页面
│   ├── posts/           # 文章
│   ├── archives/        # 归档
│   ├── tags/            # 标签
│   ├── categories/      # 分类
│   ├── assets/          # CSS/JS
│   ├── sitemap.xml      # 站点地图
│   └── index.xml        # RSS Feed
├── content/             # 源文件（服务器上不需要）
├── themes/              # 主题（服务器上不需要）
└── hugo.toml            # 配置（服务器上不需要）
```

## 🔧 性能优化建议

### 1. 启用 Gzip 压缩

Nginx 配置已包含，Apache 需要：

```bash
sudo a2enmod deflate
sudo systemctl restart apache2
```

### 2. 配置浏览器缓存

静态资源缓存 30 天，减少服务器负载。

### 3. 使用 CDN（可选）

- **Cloudflare**：免费 CDN + DDoS 防护
- **又拍云**：国内 CDN，速度快
- **七牛云**：免费额度充足

### 4. 开启 HTTP/2

Nginx 配置：

```nginx
listen 443 ssl http2;
```

## 🐛 常见问题

### Q1: 页面显示 403 Forbidden

**原因**：文件权限问题

**解决**：

```bash
cd /var/www/perday30kilo
sudo chown -R www-data:www-data public/
sudo chmod -R 755 public/
```

### Q2: CSS/JS 加载失败

**原因**：baseURL 配置不正确

**解决**：

1. 检查 `hugo.toml` 中的 `baseURL`
2. 重新构建：`hugo --minify`
3. 推送到 GitHub

### Q3: 404 错误

**原因**：Nginx/Apache 配置错误

**解决**：

- 检查 `root` 路径是否指向 `public/` 目录
- 检查 `index.html` 是否存在

### Q4: 更新后内容不变

**原因**：浏览器缓存

**解决**：

- 强制刷新（Ctrl + F5）
- 或清除浏览器缓存

## 📈 监控和日志

### 查看访问日志

```bash
# Nginx
sudo tail -f /var/log/nginx/perday30kilo_access.log

# Apache
sudo tail -f /var/log/apache2/perday30kilo_access.log
```

### 查看错误日志

```bash
# Nginx
sudo tail -f /var/log/nginx/perday30kilo_error.log

# Apache
sudo tail -f /var/log/apache2/perday30kilo_error.log
```

## 🎯 部署检查清单

- [ ] 克隆仓库到服务器
- [ ] 配置 Nginx/Apache 指向 `public/` 目录
- [ ] 测试配置并重启服务
- [ ] 访问域名确认部署成功
- [ ] 配置 HTTPS 证书（推荐）
- [ ] 设置自动更新机制
- [ ] 配置日志轮转
- [ ] 监控服务器状态

## 📚 相关文档

- **本地开发**：`QUICKSTART.md`
- **GitHub Pages 部署**：`DEPLOYMENT.md`
- **Nginx 官方文档**：https://nginx.org/en/docs/
- **Apache 官方文档**：https://httpd.apache.org/docs/

---

## 🌟 优势总结

### ✅ 无需 Hugo 环境

- 服务器上不需要安装 Go 或 Hugo
- 减少依赖，降低维护成本

### ✅ 部署简单

- 只需配置 Web 服务器
- 标准静态网站部署流程

### ✅ 性能优秀

- 纯静态 HTML，响应速度快
- 服务器负载低

### ✅ 易于维护

- Git pull 即可更新
- 可配置自动化部署

---

**仓库地址**：https://github.com/thushear/perday30kilo  
**问题反馈**：GitHub Issues

祝部署顺利！🎉
