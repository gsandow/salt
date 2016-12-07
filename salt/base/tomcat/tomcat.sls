tomcat-install:
  file.managed:
      - name: /usr/local/src/apache-tomcat-8.0.33.tar.gz
      - source: salt://tomcat/files/apache-tomcat-8.0.33.tar.gz 
      - mode: 644
      - unless: test -d /usr/local/src/apache-tomcat-8.0.33.tar.gz
  cmd.run:
    - cwd: /usr/local/src/
    - names:
      - tar zxf apache-tomcat-8.0.33.tar.gz -C /usr/local/
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
