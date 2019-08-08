ARG MYSQL_VERSION=5.7
FROM mysql:${MYSQL_VERSION}

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

COPY my.cnf /etc/mysql/conf.d/my.cnf

EXPOSE 3306

RUN mysql -u root -p admin1 -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin1';" \
    "CREATE DATABASE chatapp;" \
    "CREATE USER 'medz'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin2'" | echo "admin1"