server {
    server_name pine64 192.168.1.144;

    access_log /var/log/nginx/pine64-access.log;
    error_log /var/log/nginx/pine64-error.log;

    root /usr/local/src/personal_website;

    index index.html index.htm index.nginx-debian.html;

    location /rss {
        alias /usr/local/src/clx-rss/clx-rss;
        index index.php;

        location ~ \.php$ {
            index index.php;
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        }
    }

    location /recipes {
        alias /usr/local/src/recipes;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location /blog {
        alias /usr/local/src/blog;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location ~ /\.ht {
        deny all;
    }

    listen 80;
}

server {
    server_name www.groovestomp.com home.groovestomp.com;

    if ($host = home.groovestomp.com) {
        return 301 https://www.groovestomp.com$request_uri;
    } # managed by Certbot

    rewrite ^/about/$ https://www.groovestomp.com/cv/ permanent;
    rewrite ^/projects/$ https://www.groovestomp.com/code/ permanent;
    rewrite ^/post/index.xml$ https://www.groovestomp.com/blog/post/index.xml permanent;
    rewrite ^/tags(.*)$ https://www.groovestomp.com/blog/tags$1 permanent;
    rewrite ^/2020/(.*)$ https://www.groovestomp.com/blog/2020/$1 permanent;
    rewrite ^/2019/(.*)$ https://www.groovestomp.com/blog/2019/$1 permanent;
    rewrite ^/2018/(.*)$ https://www.groovestomp.com/blog/2018/$1 permanent;
    rewrite ^/2017/(.*)$ https://www.groovestomp.com/blog/2017/$1 permanent;
    rewrite ^/2016/(.*)$ https://www.groovestomp.com/blog/2016/$1 permanent;
    rewrite ^/2015/(.*)$ https://www.groovestomp.com/blog/2015/$1 permanent;
    rewrite ^/2014/(.*)$ https://www.groovestomp.com/blog/2014/$1 permanent;

    access_log /var/log/nginx/www.groovestomp.com-access.log;
    error_log /var/log/nginx/www.groovestomp.com-error.log;

    root /usr/local/src/personal_website;

    index index.html index.htm index.nginx-debian.html;

    location /rss {
        alias /usr/local/src/clx-rss/clx-rss;
        index index.php;

        location ~ \.php$ {
            index index.php;
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        }
    }

    location /recipes {
        alias /usr/local/src/recipes;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location /blog {
        alias /usr/local/src/blog;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location ~ /\.ht {
        deny all;
    }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/www.groovestomp.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/www.groovestomp.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name www.groovestomp.com;

    if ($host = www.groovestomp.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    listen [::]:80;
    return 404; # managed by Certbot
}