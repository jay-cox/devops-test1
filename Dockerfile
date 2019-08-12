FROM python:3.7

COPY requirements.txt /
WORKDIR /

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install --upgrade pytest

COPY app/ /app/
COPY tests/ /tests/

RUN pytest tests/

WORKDIR /app

ENV FLASK_APP=$WORKDIR/app.py

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app