# FROM python:3.6-slim

# # config app
# ENV APP_HOME="/app" \
#   APP_PATH="/app/server"

# # install packages & config docker
# RUN apt-get update && \
#   apt-get -y install wget firefox-esr && \
#   apt-get -y autoremove && \
#   apt-get clean

# RUN pip install selenium && mkdir -p $APP_PATH 

# COPY ./* $APP_PATH/

# RUN cd $APP_PATH && pip install -r requirements.txt && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
#   echo "Asia/Shanghai" > /etc/timezone

# WORKDIR ${APP_PATH}

# # RUN main.py
# CMD ["/usr/local/bin/python", "-u", "/app/server/cv_main.py"]


FROM mcr.microsoft.com/playwright/python:v1.22.0-focal

# config app
ENV APP_PATH="/"

ENV LC_ALL="C.UTF-8"

COPY ./main.py ./slide.py ./scheduler.py ./requirements.txt $APP_PATH/
ARG DEBIAN_FRONTEND=noninteractive

RUN pip install -r /requirements.txt

RUN \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
    # echo "Asia/Shanghai" > /etc/timezone

WORKDIR ${APP_PATH}

# RUN main.py
ENTRYPOINT [ "python3", "/scheduler.py"]