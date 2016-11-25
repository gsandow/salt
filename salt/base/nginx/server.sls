include:
  - users.nginx
  - nginx.install

server-nginx:
  service.running:
    - name: nginx
    - enable: True
