FROM python:3.8.6-buster

ENV HOME /
WORKDIR ${HOME}
COPY . ${HOME}

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 5000

CMD mlflow server --host 0.0.0.0