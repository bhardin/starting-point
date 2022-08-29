bash:
	$(MAKE) docker-compose-run cmd="bash"

# Specify the name of the build to be tagged `latest`
# docker build . -t worker:latest
build:
	$(MAKE) docker-compose-cmd cmd="build"

rebuild:
	$(MAKE) docker-compose-cmd cmd="build --no-cache"

shell:
	$(MAKE) docker-compose-run cmd="python manage.py shell_plus"

# docker-compose up -d
start:
	$(MAKE) docker-compose-cmd cmd="up -d"

stop:
	$(MAKE) docker-compose-cmd cmd="down"

### These Make commands are used by the makefile and should not be called directly unless you know what you're doing.

# Docker-Compose cmd
docker-compose-cmd:
	docker-compose $(cmd)

# Docker-Compose run
# $(MAKE) docker-compose-cmd cmd="run --rm web ./config/bin/wait-for-it -t 60 continuum-db:5432 -- $(cmd)"
docker-compose-run:
	$(MAKE) docker-compose-cmd cmd="run --rm web $(cmd)"
