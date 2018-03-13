{% from "gpg/map.jinja" import gpg with context %}

install-prereqs:
  pkg.installed:
    - pkgs: {{ gpg.packages | default([], true) }}
    - refresh: True

install-pip-deps:
  pip.installed:
    - names:
      - python-gnupg
    - reload_modules: True
    - require:
      - install-prereqs
