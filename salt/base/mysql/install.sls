include:
  - packages
  - zabbix.agent
  - salt.minion
  - mysql.monitor

{% set redis_dbdir = salt['pillar.get']('redis:dir', '/data/redis/') %}
{% set redis_logdir = salt['pillar.get']('redis_logdir', '/var/log/redis') %}
mysql_pkg:
  file.managed:
    - name: /usr/local/src/mysql-5.6.29.tar.gz
    - source: salt://redis/files/mysql-5.6.29.tar.gz
    - mode: 644
decompress_mysql:
  cmd.run:
    - cwd: /usr/local/src/
    - name: tar zxf mysql-5.6.29.tar.gz
    - unless: test -d /usr/local/src/mysql-5.6.29

make_mysql:
  cmd.run:
    - cwd: /usr/local/src/mysql-5.6.29/
    - names:
      - mkdir -p /data/{3306,3307} && chown -R www.www /data/{3306,3307}
      - cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.6.29 -DMYSQL_DATADIR=/usr/local/mysql-5.6.29/data -DMYSQL_UNIX_ADDR=/usr/local/mysql-5.6.29/tmp/mysql.sock -DMYSQL_USER=www -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=gbk,gb2312,utf8,ascii -DENABLED_LOCAL_INFILE=ON -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 -DWITH_FAST_MUTEXES=1 -DWITH_ZLIB=bundled -DENABLED_LOCAL_INFILE=1 -DWITH_READLINE=1 -DWITH_EMBEDDED_SERVER=1 -DWITH_DEBUG=0 -DWITH_SSL=yes  && make && make install 
    - unless: test -d /usr/local/mysql-5.6.29
mysql_symlink:
  file.symlink:
    - name: /usr/local/mysql-5.6.29
    - target: /usr/local/mysql
    - cmd.wait:
      - watch:
        - cmd: make_mysql

initialization_mysql:
  - cmd.run:
    - cwd: /usr/local/mysql-5.6.29/  
    - names:
      - ./scripts/mysql_install_db --basedir=/usr/local/mysql-5.6.29/ --datedir=/data/3306/data --user=www
    - cmd.wait:
      - watch:
        - cmd: make_mysql

mysql_conf:
  file.managed:
    - name: /data/3306/my.cnf
    - source: salt://mysql/files/my.cnf
    - template: jinja
    - defaultes:
      bind: 127.0.0.1
      port: 6379
    - user: www
    - group: www
    - mode: 644
    - backup: minion
    - cmd.wait:
      - watch:
        - cmd: make_redis
/etc/init.d/:
  file.managed:
    - source: salt://redis/files/redis
    - mode: 755
    - user: root
    - group: root
    - backup: minion
{{ redis_dbdir }}:
  cmd.run:
    - name: mkdir -p {{ redis_dbdir }}
    - unless: test -d {{ redis_dbdir }}
{{ redis_logdir }}:
  cmd.run:
    - name: mkdir -p {{ redis_logdir }}
    - unless: test -d {{ redis_logdir }}
