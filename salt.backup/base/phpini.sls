/usr/local/php/lib/php.ini:
  file.managed:
    - name: /usr/local/php/lib/php.ini
    - source: salt://files/php.ini
    - user: root
    - group: root
    - mode: 644
