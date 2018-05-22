
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE VIEW tj_lvhua_gongyuan_dizhigongyuan_all AS (
    SELECT *
    FROM fangwujianzhu
);

-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_lvhua_gongyuan_dizhigongyuan (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, grade int, name text) AS $$
    SELECT geometry, grade::int, name FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan_all WHERE geometry && bbox AND zoom_level = 11
        UNION ALL
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan_all WHERE geometry && bbox AND zoom_level = 12
        UNION ALL
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan_all WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan_all WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;