# ⚡ 快速部署命令

## 🚀 服务器一键部署（Nginx）

```bash
# 1. 克隆仓库
cd /var/www
sudo git clone https://github.com/thushear/perday30kilo.git
cd perday30kilo

# 2. 配置 Nginx
sudo tee /etc/nginx/sites-available/perday30kilo > /dev/null << 'EOF'
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/perday30kilo/public;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    gzip on;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/json;
    
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
}
EOF

# 3. 启用站点
sudo ln -s /etc/nginx/sites-available/perday30kilo /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# 4. 设置权限
sudo chown -R www-data:www-data /var/www/perday30kilo/public
sudo chmod -R 755 /var/www/perday30kilo/public

# 完成！访问 http://your-domain.com
```

## 🔄 自动更新脚本

创建 `/var/www/update-blog.sh`：

```bash
#!/bin/bash
echo "=== 更新博客 $(date) ==="
cd /var/www/perday30kilo
git pull origin main
echo "✅ 更新完成"
```

使用：

```bash
# 赋予执行权限
sudo chmod +x /var/www/update-blog.sh

# 手动更新
sudo /var/www/update-blog.sh

# 或设置定时任务（每小时检查更新）
(crontab -l 2>/dev/null; echo "0 * * * * /var/www/update-blog.sh") | crontab -
```

## 🔒 配置 HTTPS（Let's Encrypt）

```bash
# 安装 certbot
sudo apt update
sudo apt install certbot python3-certbot-nginx

# 自动配置 HTTPS
sudo certbot --nginx -d your-domain.com

# 测试自动续期
sudo certbot renew --dry-run
```

## 🐳 Docker 快速部署

```bash
# 克隆仓库
git clone https://github.com/thushear/perday30kilo.git
cd perday30kilo

# 创建 Dockerfile
cat > Dockerfile << 'EOF'
FROM nginx:alpine
COPY public/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# 构建并运行
docker build -t perday30kilo-blog .
docker run -d -p 80:80 --name blog --restart unless-stopped perday30kilo-blog

# 完成！
```

## 📝 本地更新流程

```bash
# 1. 修改内容
cd /Users/kongming/code/github-backup/perday30kilo

# 2. 重新构建
hugo --minify

# 3. 提交推送
git add -A
git commit -m "更新博客内容"
git push

# 4. 服务器更新（SSH 到服务器）
cd /var/www/perday30kilo
git pull
```

## 🎯 常用命令

```bash
# 查看 Nginx 状态
sudo systemctl status nginx

# 测试 Nginx 配置
sudo nginx -t

# 重启 Nginx
sudo systemctl restart nginx

# 查看访问日志
sudo tail -f /var/log/nginx/access.log

# 查看错误日志
sudo tail -f /var/log/nginx/error.log

# 检查网站可访问性
curl -I http://your-domain.com
```

## 📚 详细文档

- **服务器部署详细指南**：[SERVER_DEPLOYMENT.md](SERVER_DEPLOYMENT.md)
- **本地开发指南**：[QUICKSTART.md](QUICKSTART.md)
- **GitHub Pages 部署**：[DEPLOYMENT.md](DEPLOYMENT.md)

---

**需要帮助？** 查看详细文档或提交 GitHub Issue
