
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_bianjie_shengjie (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  areacode int) AS $$
    SELECT geometry, areacode FROM (
        SELECT * FROM tj_bianjie_shengjie WHERE geometry && bbox AND zoom_level <10
        UNION ALL 
        SELECT * FROM tj_bianjie_shengjie WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;