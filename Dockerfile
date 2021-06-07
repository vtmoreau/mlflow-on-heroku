FROM python:3.8.6-buster

ENV HOME /
WORKDIR ${HOME}
COPY . ${HOME}

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE $PORT

ENV DATABASE_URL ${DATABASE_URL//postgres:/postgresql:}

CMD mlflow server --backend-store-uri ${DATABASE_URL} \
    --default-artifact-root ./mlruns \
    --host 0.0.0.0 \
    --port ${PORT}