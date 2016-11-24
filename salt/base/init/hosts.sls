/etc/hosts:
  file.managed:
    - name: /etc/hosts
    - source: salt://init/files/hosts
    - backup: minion
    - mode: 644
