FROM python:3.8.6-buster

ENV HOME /
WORKDIR ${HOME}
COPY ./requirements.txt ./requirements.txt

RUN set -x && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    supervisor nginx apache2-utils

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN addgroup -gid 1000 www && \
    adduser -uid 1000 -H -D -s /bin/sh -G www www

COPY nginx.conf.template /app/nginx.conf.template
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./entrypoint.sh /app/entrypoint.sh
COPY ./webserver.sh /app/webserver.sh
COPY ./mlflow.sh /app/mlflow.sh

EXPOSE 6000

CMD ["/bin/bash", "/app/entrypoint.sh"]

# CMD mlflow server --backend-store-uri ${DATABASE_URL} \
#     --default-artifact-root ./mlruns \
#     --host 0.0.0.0 \
#     --port ${PORT}