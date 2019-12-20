FROM postgres:12.1

#do not do in production
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres 

COPY init.sql /docker-entrypoint-initdb.d/