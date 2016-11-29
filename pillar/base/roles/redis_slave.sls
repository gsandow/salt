redis:
  port: 6379
  bind: 0.0.0.0
  timeout: 300
  loglevel: warning
  dir: /data/redis/
  maxclients: 3000
  maxmemory: 1Gb
  master: 10.27.73.16
  master_port: 6379
