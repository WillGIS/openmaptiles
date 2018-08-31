
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_dlgq_bendi1(bbox geometry, zoom_level int)
RETURNS TABLE(id int, geometry geometry, objectid int,tag text,featid int,cc text,cctj text) AS $$
    SELECT id int,geometry,objectid int,tag text,featid int,cc text,cctj text FROM (
        
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_dlgq_bendi_binhai WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_dlgq_bendi_binhai WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;


--select id,geometry,objectid,tag,featid,elemstime,areacode,feature,ccp,changetype,changety_1,cc,cctj,'阶段' from tj_dlgq_bendi_binhai LIMIT 10 offset 0