
CREATE OR REPLACE FUNCTION layer_tj_poi_airport (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, typecode text, name text, objectid int) AS $$
    SELECT geometry, typecode, name, objectid::int FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_poi_airport WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_poi_airport WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
