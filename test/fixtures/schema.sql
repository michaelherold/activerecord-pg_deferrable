CREATE TABLE IF NOT EXISTS test_table (
  id SERIAL PRIMARY KEY,
  ordering integer NOT NULL UNIQUE DEFERRABLE
);