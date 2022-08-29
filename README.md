# Scaffold
Django, Celery, Postgres, and Redis. Dockerized. Brett's starting point.

The "app name" you will need to replace everywhere is `edgar_scrapper`

Note: If you start from here, follow the "update" section.

#### Install

```bash
make build  # Builds all Docker containers (specified in `docker-compose.yml`)
make run    # Runs all Docker containers
```

#### Running

```bash
docker-compose up       # Run all services with logging for each service
docker-compose up -D    # Run all services in the background (docker-compose down to bring down)
```

#### Adding a dependency

```bash
poetry add <package-name>           # Requires poetry to be installed locally
make build                          # Won't be avail to docker until built
git add poetry.lock pyproject.toml  # Don't forget to add the files to git
```

#### Updating
poetry pins versions. You will need to update all deps and rebuild.

```bash
make bash           # shell in
poetry update       # update poetry (inside docker)
exit                # exit out of docker
make rebuild          # build images (installs new deps)
```

#### Running a task

```bash
make shell
```

In the shell:

```python
from edgar_scrapper.celery import divide
task = divide.delay(1, 2)
```

#### Usage

- Follow log files: `docker-compose logs -f`



