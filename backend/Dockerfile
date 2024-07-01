FROM python:3.10-slim

RUN pip install --upgrade pip

# Install system dependencies
RUN apt-get update && apt-get install -y pkg-config build-essential python3-dev default-libmysqlclient-dev

COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY . /app
WORKDIR /app

COPY ./entrypoint.sh .
ENTRYPOINT ["sh", "/app/entrypoint.sh"]