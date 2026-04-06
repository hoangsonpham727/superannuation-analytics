CREATE TABLE dim_fund_type (
    fund_type_id    INT          PRIMARY KEY AUTO_INCREMENT,
    fund_type_name  VARCHAR(50)  NOT NULL UNIQUE
);

CREATE TABLE dim_table_group (
    table_group_id   INT         PRIMARY KEY AUTO_INCREMENT,
    table_group_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dim_metric (
    metric_id      INT           PRIMARY KEY AUTO_INCREMENT,
    metric_name    VARCHAR(255)  NOT NULL,
    table_group_id INT           NOT NULL,
    is_subcategory TINYINT(1)    NOT NULL DEFAULT 0,
    value_unit     VARCHAR(10)   NOT NULL DEFAULT '$m',
    FOREIGN KEY (table_group_id) REFERENCES dim_table_group(table_group_id)
);

CREATE TABLE dim_date (
    date_id        INT          PRIMARY KEY AUTO_INCREMENT,
    quarter        VARCHAR(10)  NOT NULL UNIQUE,
    date           DATE         NOT NULL,
    year           INT          NOT NULL,
    month          INT          NOT NULL,
    fin_year       INT          NOT NULL,
    quarter_label  VARCHAR(5)   NOT NULL
);

CREATE TABLE fact_superannuation (
    fact_id        BIGINT        PRIMARY KEY AUTO_INCREMENT,
    fund_type_id   INT           NOT NULL,
    metric_id      INT           NOT NULL,
    date_id        INT           NOT NULL,
    value          DECIMAL(18,2) NULL,
    FOREIGN KEY (fund_type_id) REFERENCES dim_fund_type(fund_type_id),
    FOREIGN KEY (metric_id)    REFERENCES dim_metric(metric_id),
    FOREIGN KEY (date_id)      REFERENCES dim_date(date_id)
);