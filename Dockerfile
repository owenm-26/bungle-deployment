FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN apt-get update && \
    apt-get install -y mysql-server libapache2-mod-php php-mysql php python curl  libapache2-mod-wsgi \
    libmysqlclient-dev libffi-dev build-essential python-dev libmysqlcppconn-dev libmysqlclient-dev apache2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && python get-pip.py
RUN pip install bottle MySQL-python
RUN a2enmod php7.2

RUN mkdir bungle
COPY . bungle
RUN chmod 777 -R /bungle 

ENTRYPOINT [ "./bungle/entrypoint.sh" ]