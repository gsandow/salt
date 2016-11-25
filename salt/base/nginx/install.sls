include:
  - packages

{% set logdir = salt['pillar.get']('logdir', '/var/log/nginx') %}

/usr/local/src/nginx-1.9.14.tar.gz:
  file.managed:
    - name: /usr/local/src/nginx-1.9.14.tar.gz
    - source: salt://nginx/files/nginx-1.9.14.tar.gz
    - mode: 644
configue_nginx:
  cmd.run:
    - cwd: /usr/local/src/
    - name: tar zxf nginx-1.9.14.tar.gz
    - unless: test -d /usr/local/src/nginx-1.9.14
nginx_compile:
  cmd.run:
    - cwd: /usr/local/src/nginx-1.9.14/
    - names:
      - ./configure --prefix=/usr/local/nginx-1.9.14 --user=nginx --group=nginx --with-file-aio --with-http_dav_module --with-pcre --with-http_stub_status_module --with-http_xslt_module --with-http_ssl_module --with-http_realip_module && make && make install
      - ln -s /usr/local/nginx-1.9.14 /usr/local/nginx
    - unless: test -d /usr/local/nginx-1.9.14
/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - mode: 644
    - template: jinja
    - user: root
    - group: root
    - backup: minion
/etc/init.d/nginx:
  file.managed:
    - source: salt://nginx/files/nginx
    - mode: 755
    - user: root
    - group: root
    - backup: minion
{{ logdir }}:
  cmd.run:
    - name: mkdir -p {{ logdir }}
    - unless: test -d {{ logdir }}
