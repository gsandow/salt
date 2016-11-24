#!/bin/sh
hostn=$(hostname|awk -F . '{print $1}')
time=$(date +%Y%m%d -d -1day)
backup () {
mv /usr/local/tomcat/passport/loginlog/login_log-$time /backup/loginlog/
}
rsync_fun () {
/usr/bin/rsync -auvrtzopgP --progress --bwlimit=5000 --password-file=/etc/rsync.password /backup/ rsync_backup@10.51.48.249::${hostn}

find /backup/ -type f -mtime +3|xargs rm -f
}
main () {
backup
#rsync_fun 
}
main >> /var/log/backup.log  2>&1 
