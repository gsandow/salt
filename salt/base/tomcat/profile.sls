tomcat_path:
  file.append:
    - name: /etc/profile
    - text:
      - export JAVA_HOME=/usr/local/jdk
      - export MAVEN_HOME=/usr/local/maven3
      - export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:${MAVEN_HOME}/bin
      - export CLASSPATH=.$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar
      - export TOMCAT_HOME=/usr/local/tomcat
