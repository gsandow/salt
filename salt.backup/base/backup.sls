/data/scripts/backup.sh:
  file.managed:
    - name: /data/scripts/backup.sh
    - source: salt://files/backup.sh
    - user: root
    - group: root
    - mode: 644
