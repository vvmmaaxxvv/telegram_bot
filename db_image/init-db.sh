#!/bin/bash
set -e

cp /pg_hba.conf "$PGDATA/pg_hba.conf"
cp /postgresql.conf "$PGDATA/postgresql.conf"

echo "host replication ${DB_REPL_USER} 0.0.0.0/0 trust" >> "$PGDATA/pg_hba.conf"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE $DB_REPL_USER WITH REPLICATION PASSWORD '$DB_REPL_PASSWORD' LOGIN;
EOSQL

SQL_COMMAND=$(cat <<EOF
CREATE TABLE IF NOT EXISTS emails (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS phones (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL
);

-- Добавление тестовых данных в таблицу emails
INSERT INTO emails (email) VALUES
('test1@example.com'),
('test2@example.com')
ON CONFLICT DO NOTHING;

-- Добавление тестовых данных в таблицу phones
INSERT INTO phones (phone_number) VALUES
('89293453465'),
('82873451243')
ON CONFLICT DO NOTHING;
EOF
)

# Выполнение команды SQL
PGPASSWORD="$DB_REPL_PASSWORD" psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "$SQL_COMMAND"
