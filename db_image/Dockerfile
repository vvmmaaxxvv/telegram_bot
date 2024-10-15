FROM postgres:15.6

RUN mkdir -p /oracle/pg_data/archive/
RUN chown -R postgres:postgres /oracle/pg_data/archive/

COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh
COPY pg_hba.conf /pg_hba.conf
COPY postgresql.conf /postgresql.conf
