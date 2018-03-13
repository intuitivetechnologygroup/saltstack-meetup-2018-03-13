/etc/salt/gpgkeys:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

generate-gpg-py-script:
  file.managed:
    - name: /tmp/gpg-gen-key.py
    - source: salt://gpg/files/gpg-gen-key.py.j2
    - template: jinja

generate-key:
  cmd.run:
    - name: python /tmp/gpg-gen-key.py
