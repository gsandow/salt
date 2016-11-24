/data/scripts/backup.sh:
  file.managed:
    - name: /data/scripts/backup.sh 
    - source: salt://init/files/backup.sh
    - backup: minion
    - mode: 644
