FROM postgres:latest
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=gymdb
COPY ./sql/*.sql /docker-entrypoint-initdb.d/
EXPOSE 5432