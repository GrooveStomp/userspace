server {
    server_name home.groovestomp.com pine64 192.168.1.144;
    access_log /var/log/nginx/groovestomp-access.log;
    error_log /var/log/nginx/groovestomp-error.log;

    listen 80;
    listen [::]:80;

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
}
