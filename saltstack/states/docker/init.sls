---

docker:
  pkg.installed:
    - name: docker

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - pkg: docker