FROM oracle/database:18.4.0-xe
ENV ORACLE_PWD=mypassword
COPY ./startscript.sql /opt/oracle/scripts/setup/start.sql
VOLUME ["/opt/oracle/oradata"]
EXPOSE 1521