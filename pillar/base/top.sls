base:
  '*':
    - zabbix.agent
    - users
  'passport*.wankr.com.cn':
    - roles.www
    - roles.java
  'ytadmin*.wankr.com.cn':
    - roles.www
  'www.wankr.com.cn':
    - roles.www
  'test02.wankr.com.cn':
    - roles.admin
  'testweb*':
    - roles.web


  'testweb1':
    - roles.redis_server1
  'testweb2':
    - roles.redis_server1
  'testdb':
    - roles.redis_server1
    - roles.db
