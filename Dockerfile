FROM python:3.8.6-buster

ENV HOME /
WORKDIR ${HOME}
COPY . ${HOME}

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE $PORT

CMD mlflow server --backend-store-uri ${DATABASE_URL} --host 0.0.0.0