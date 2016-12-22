tomcat-install:
  file.managed:
      - name: /usr/local/src/apache-tomcat-8.0.33.tar.gz
      - source: salt://tomcat/files/apache-tomcat-8.0.33.tar.gz 
      - mode: 644
      - unless: test -d /usr/local/src/apache-tomcat-8.0.33.tar.gz
  cmd.run:
    - cwd: /usr/local/src/
    - names:
      - tar zxf apache-tomcat-8.0.33.tar.gz -C /usr/local/ && chown -R www.www /usr/local/apache-tomcat-8.0.33
    - unless: test -d /usr/local/apache-tomcat-8.0.33
/usr/local/tomcat:
  file.symlink:
    - target: /usr/local/apache-tomcat-8.0.33
    - unless: test -d /usr/local/tomcat
    - require:
      - cmd: tomcat-install

jdk-install:
  file.managed:
    - name: /usr/local/src/jdk-7u79-linux-x64.tar.gz
    - source: salt://tomcat/files/jdk-7u79-linux-x64.tar.gz
    - mode: 644
  cmd.run:
    - cwd: /usr/local/src/
    - names:
      - tar zxf jdk-7u79-linux-x64.tar.gz -C /usr/local/
    - unless: test -d /usr/local/jdk1.7.0_79
/usr/local/jdk:
  file.symlink:
    - target: /usr/local/jdk1.7.0_79
    - unless: test -d /usr/local/jdk
    - require:
      - cmd: jdk-install

/etc/init.d/tomcat:
  file.managed:
    - source: salt://tomcat/files/init.d/tomcat
    - mode: 755
    - user: root
    - group: root
    - backup: minion
configure_tomcat:
  file.recurse:
    - name: /usr/local/tomcat
    - source: salt://tomcat/files/tomcat
    - dir_mode: 755
    - file_mode: 755
    - template: jinja
    - backup: minion
    - defaults:
        eth0: {{ grains.ip4_interfaces.eth0[0] }}
    - user: www
    - group: www
nginx-roles:
  file.append:
    - name: /etc/salt/roles
    - text:
      - 'tomcat'
    - require:
      - file: roles
      - service: server-tomcat
      - service: salt-minion
    - watch_in:
      - module: sync_grains
