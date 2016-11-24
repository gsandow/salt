/etc/bashrc:
  file.managed:
    - name: /etc/bashrc
    - source: salt://init/files/bashrc
    - backup: minion
    - mode: 644
