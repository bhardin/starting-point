FROM python:3.10
ARG env

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
# PYTHONUNBUFFERED=1 avoids some stdout log anomalies.
ENV PYTHONUNBUFFERED=1
# ?
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /app

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    # deps for installing poetry
    curl \
    # deps for building python deps
    build-essential

# Poetry (Install & Config)
COPY pyproject.toml poetry.lock /app/
RUN pip install poetry==1.1.13
RUN poetry config virtualenvs.create false

# Install Python Dependencies
RUN if [ "env-$env" = "env-production" ] ; then poetry install --no-dev --no-interaction; else poetry install; fi

### The sed command is for replacing Windows line endings with UNIX line endings

COPY ./config/entrypoint /entrypoint
# RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint

COPY ./config/start /start
# RUN sed -i 's/\r$//g' /start
RUN chmod +x /start

COPY ./config/celery/worker/start /start-celeryworker
# RUN sed -i 's/\r$//g' /start-celeryworker
RUN chmod +x /start-celeryworker

COPY ./config/celery/beat/start /start-celerybeat
# RUN sed -i 's/\r$//g' /start-celerybeat
RUN chmod +x /start-celerybeat

COPY ./config/celery/flower/start /start-flower
# RUN sed -i 's/\r$//g' /start-flower
RUN chmod +x /start-flower

ENTRYPOINT ["/entrypoint"]
