INSERT INTO fact_superannuation (fund_type_id, metric_id, date_id, value)
SELECT
    ft.fund_type_id,
    m.metric_id,
    d.date_id,
    CASE
        WHEN s.value = '' OR s.value IS NULL THEN NULL
        ELSE CAST(s.value AS DECIMAL(18,2))
    END
FROM staging_master_all s
JOIN dim_fund_type   ft ON ft.fund_type_name  = s.fund_type
JOIN dim_metric      m  ON m.metric_name      = s.metric
                       AND m.table_group_id   = (
                               SELECT table_group_id
                               FROM dim_table_group
                               WHERE table_group_name = s.table_group
                           )
JOIN dim_date        d  ON d.quarter          = s.quarter
WHERE s.value IS NOT NULL
  AND s.value != '';