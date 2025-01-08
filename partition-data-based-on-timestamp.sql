-- Example Table: orders (id, created_at, data_column)
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    data_column TEXT
);

-- Create partitioned table structure
CREATE TABLE orders_partitioned (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    data_column TEXT
) PARTITION BY RANGE (created_at);

-- Creating weekly partitions
CREATE TABLE orders_week_2025_01 PARTITION OF orders_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-01-08');

CREATE TABLE orders_week_2025_02 PARTITION OF orders_partitioned
    FOR VALUES FROM ('2025-01-08') TO ('2025-01-15');

-- Creating monthly partitions
CREATE TABLE orders_month_2025_01 PARTITION OF orders_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

-- Creating yearly partitions
CREATE TABLE orders_year_2025 PARTITION OF orders_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
