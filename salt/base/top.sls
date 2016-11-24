base:
  '*':
    - init.init
prod:
  'linux-node*':
    - cluster.haproxy-outside
