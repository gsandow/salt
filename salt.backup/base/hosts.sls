/etc/hosts:
  file.managed:
    - name: /etc/hosts
    - source: salt://files/hosts
    - user: root
    - group: root
    - mode: 644
