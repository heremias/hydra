# Docker file for python simple webservice build

FROM ubuntu:20.04
LABEL org.opencontainers.image.authors="mukaishohei76@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt -y install software-properties-common
RUN apt -y install apache2
RUN apt -y install wget
RUN apt-get -y install sudo
RUN curl -sSL https://get.docker.com/ | sh

# Python2.7
RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
RUN apt -y install libmysqlclient-dev python3-distutils
RUN apt -y install vim
RUN python3 get-pip.py

# Python3.6
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt -y install python3.6
RUN apt -y install python3.6-dev
RUN python3.6 get-pip.py

# Python3.7
RUN apt -y install python3.7
RUN apt -y install python3.7-dev
RUN python3.7 get-pip.py

# Python3.8
RUN apt -y install python3.8

# Python3.9
RUN apt -y install python3.9

# Python3.10
RUN apt -y install python3.10

# Http settings
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN mkdir -p /var/www/cgi-bin
RUN mkdir -p /var/www/lib
RUN apt-get update && apt-get install -y nodejs npm

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update && apt-get install -y nodejs
COPY ./public_html ./public_html
COPY rollup.config.js ./
COPY package*.json ./

RUN npm install

COPY ./src ./src

RUN npm run-script build
COPY cgi-bin /var/www/cgi-bin
COPY lib /var/www/lib
COPY apache2 /etc/apache2
RUN cp -r public_html/* /var/www/html

RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/cgi.load

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
