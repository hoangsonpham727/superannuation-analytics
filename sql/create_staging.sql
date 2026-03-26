USE superannuation_db;

CREATE TABLE staging_master_all (
    fund_type       TEXT,
    table_group     TEXT,
    metric          TEXT,
    is_subcategory  TEXT,
    value_unit      TEXT,
    quarter         TEXT,
    date            TEXT,
    year            TEXT,
    month           TEXT,
    fin_year        TEXT,
    quarter_label   TEXT,
    value           TEXT
);