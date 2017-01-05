/etc/profile:
  file.append:
    - text:
      - export HISTTIMEFORMAT="%F %T `whoami` "
      - export PS1='[\u@\h:\w]\$'
