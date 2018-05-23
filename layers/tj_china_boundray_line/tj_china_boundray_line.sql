
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_china_boundray_line (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  gbcode int) AS $$
    SELECT geometry, gbcode FROM (
        SELECT * FROM china_boundray_line WHERE geometry && bbox AND zoom_level <10
        UNION ALL 
        SELECT * FROM china_boundray_line WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;