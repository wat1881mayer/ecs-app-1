FROM --platform=linux/x86_64 httpd:2.4
COPY index.html /usr/local/apache2/htdocs/index.html