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

    location /recipes/ {
        alias /usr/local/src/recipes;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location /blog/ {
        alias /usr/local/src/blog;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location /radicale/ {
        proxy_pass        http://localhost:5232/; # The / is important!
        proxy_set_header  X-Script-Name /radicale;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  Host $http_host;
        proxy_pass_header Authorization;
    }

    location /bookmarks {
        alias /usr/local/src/shaarli;
        index index.php;
        try_files _ /index.php$is_args$args;

        location /bookmarks {
            if ($request_uri ~ ^([^.\?]*[^/])$) {
                return 301 $1/;
            }
        }

        location /bookmarks/ {
            index index.php;
        }

        # increase the maximum file upload size if needed: by default nginx limits file upload to 1MB (413 Entity Too Large error)
        client_max_body_size 100m;

        location ~ (index)\.php$ {
            # try_files $uri =404;
            # slim API - split URL path into (script_filename, path_info)
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            # pass PHP requests to PHP-FPM
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_pass unix:/run/php/php7.3-fpm.sock;
            # fastcgi_index index.php;
            # include fastcgi.conf;
        }

        location ~ /bookmarks/doc/html/ {
            default_type "text/html";
            try_files $uri $uri/ $uri.html =404;
        }

        location = /bookmarks/favicon.ico {
            # serve the Shaarli favicon from its custom location
            alias /usr/local/src/shaarli/assets/vintage/img/favicon.ico;
        }

        # allow client-side caching of static files
        location ~* \.(?:ico|css|js|gif|jpe?g|png|ttf|oet|woff2?)$ {
            expires    max;
            add_header Cache-Control "public, must-revalidate, proxy-revalidate";
            # HTTP 1.0 compatibility
            add_header Pragma public;
        }
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

    location /recipes/ {
        alias /usr/local/src/recipes;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location /blog/ {
        alias /usr/local/src/blog;
        index index.html;
        try_files $uri $uri/ =404;
    }

    location /radicale/ {
        proxy_pass        http://localhost:5232/; # The / is important!
        proxy_set_header  X-Script-Name /radicale;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  X-Remote-User $remote_user;
        proxy_set_header  Host $http_host;
        proxy_pass_header Authorization;
        auth_basic        "Radicale - Password Required";
        auth_basic_user_file /var/lib/radicale/users;
    }

    location /bookmarks {
        alias /usr/local/src/shaarli;
        index index.php;
        try_files _ /index.php$is_args$args;

        location /bookmarks {
            if ($request_uri ~ ^([^.\?]*[^/])$) {
                return 301 $1/;
            }
        }

        location /bookmarks/ {
            index index.php;
        }

        # increase the maximum file upload size if needed: by default nginx limits file upload to 1MB (413 Entity Too Large error)
        client_max_body_size 100m;

        location ~ (index)\.php$ {
            # try_files $uri =404;
            # slim API - split URL path into (script_filename, path_info)
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            # pass PHP requests to PHP-FPM
            include snippets/fastcgi-php.conf;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_pass unix:/run/php/php7.3-fpm.sock;
            # fastcgi_index index.php;
            # include fastcgi.conf;
        }

        location ~ /bookmarks/doc/html/ {
            default_type "text/html";
            try_files $uri $uri/ $uri.html =404;
        }

        location = /bookmarks/favicon.ico {
            # serve the Shaarli favicon from its custom location
            alias /usr/local/src/shaarli/assets/vintage/img/favicon.ico;
        }

        # allow client-side caching of static files
        location ~* \.(?:ico|css|js|gif|jpe?g|png|ttf|oet|woff2?)$ {
            expires    max;
            add_header Cache-Control "public, must-revalidate, proxy-revalidate";
            # HTTP 1.0 compatibility
            add_header Pragma public;
        }
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
