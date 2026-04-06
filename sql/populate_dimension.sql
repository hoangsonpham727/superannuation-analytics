INSERT INTO dim_fund_type (fund_type_name)
SELECT DISTINCT fund_type
FROM staging_master_all
WHERE fund_type IS NOT NULL
ORDER BY fund_type;

INSERT INTO dim_table_group (table_group_name)
SELECT DISTINCT table_group
FROM staging_master_all
WHERE table_group IS NOT NULL
ORDER BY table_group;

INSERT INTO dim_metric (metric_name, table_group_id, is_subcategory, value_unit)
SELECT DISTINCT
    s.metric,
    tg.table_group_id,
    CASE WHEN s.is_subcategory = 'TRUE' THEN 1 ELSE 0 END,
    s.value_unit
FROM staging_master_all s
JOIN dim_table_group tg ON tg.table_group_name = s.table_group
WHERE s.metric IS NOT NULL
ORDER BY s.metric;

INSERT INTO dim_date (quarter, date, year, month, fin_year, quarter_label)
SELECT DISTINCT
    s.quarter,
    STR_TO_DATE(s.date, '%Y-%m-%d'),
    CAST(s.year     AS UNSIGNED),
    CAST(s.month    AS UNSIGNED),
    CAST(s.fin_year AS UNSIGNED),
    s.quarter_label
FROM staging_master_all s
WHERE s.quarter IS NOT NULL
ORDER BY STR_TO_DATE(s.date, '%Y-%m-%d');