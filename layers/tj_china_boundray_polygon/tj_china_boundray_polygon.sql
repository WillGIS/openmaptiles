
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_china_boundray_polygon (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , adcode93 int) AS $$
    SELECT geometry,name, adcode93 FROM (
        SELECT * FROM china_boundray_polygon WHERE geometry && bbox   AND zoom_level >= 3     
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;