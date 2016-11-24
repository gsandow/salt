/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://conf/nginx.conf
    - user: root
    - group: root
    - mode: 644
