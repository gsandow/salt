base:
  '*':
    - zabbix.agent
    - roles.common
    - users
  'passport*.wankr.com.cn':
    - roles.web
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
