CREATE OR REPLACE FUNCTION slice_language_tags(tags hstore)
RETURNS hstore AS $$
    SELECT delete_empty_keys(slice(tags, ARRAY['name:ar', 'name:az', 'name:be', 'name:bg', 'name:br', 'name:bs', 'name:ca', 'name:cs', 'name:cy', 'name:da', 'name:de', 'name:el', 'name:en', 'name:eo', 'name:es', 'name:et', 'name:fi', 'name:fr', 'name:fy', 'name:ga', 'name:gd', 'name:he', 'name:hr', 'name:hu', 'name:hy', 'name:is', 'name:it', 'name:ja', 'name:ja_kana', 'name:ja_rm', 'name:ka', 'name:kk', 'name:kn', 'name:ko', 'name:ko_rm', 'name:la', 'name:lb', 'name:lt', 'name:lv', 'name:mk', 'name:mt', 'name:nl', 'name:no', 'name:pl', 'name:pt', 'name:rm', 'name:ro', 'name:ru', 'name:sk', 'name:sl', 'name:sq', 'name:sr', 'name:sr-Latn', 'name:sv', 'name:th', 'name:tr', 'name:uk', 'name:zh', 'int_name', 'loc_name', 'name', 'wikidata', 'wikipedia']))
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_china_boundray_polygon'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_china_boundray_polygon (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , adcode93 int) AS $$
    SELECT geometry,name, adcode93 FROM (
        SELECT * FROM china_boundray_polygon WHERE geometry && bbox   AND zoom_level >= 3     
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer water'; END$$;CREATE OR REPLACE FUNCTION water_class(waterway TEXT) RETURNS TEXT AS $$
    SELECT CASE WHEN waterway='' THEN 'lake' ELSE 'river' END;
$$ LANGUAGE SQL IMMUTABLE;



CREATE OR REPLACE VIEW water_z0 AS (
    -- etldoc:  ne_110m_ocean ->  water_z0
    SELECT geometry, 'ocean'::text AS class FROM ne_110m_ocean
    UNION ALL
    -- etldoc:  ne_110m_lakes ->  water_z0
    SELECT geometry, 'lake'::text AS class FROM ne_110m_lakes
);

CREATE OR REPLACE VIEW water_z1 AS (
    -- etldoc:  ne_110m_ocean ->  water_z1
    SELECT geometry, 'ocean'::text AS class FROM ne_110m_ocean
    UNION ALL
    -- etldoc:  ne_110m_lakes ->  water_z1
    SELECT geometry, 'lake'::text AS class FROM ne_110m_lakes
);

CREATE OR REPLACE VIEW water_z2 AS (
    -- etldoc:  ne_50m_ocean ->  water_z2
    SELECT geometry, 'ocean'::text AS class FROM ne_50m_ocean
    UNION ALL
    -- etldoc:  ne_50m_lakes ->  water_z2
    SELECT geometry, 'lake'::text AS class FROM ne_50m_lakes
);

CREATE OR REPLACE VIEW water_z4 AS (
    -- etldoc:  ne_50m_ocean ->  water_z4
    SELECT geometry, 'ocean'::text AS class FROM ne_50m_ocean
    UNION ALL
    -- etldoc:  ne_50m_lakes ->  water_z4
    SELECT geometry, 'lake'::text AS class FROM ne_50m_lakes
);

CREATE OR REPLACE VIEW water_z5 AS (
    -- etldoc:  ne_10m_ocean ->  water_z5
    SELECT geometry, 'ocean'::text AS class FROM ne_10m_ocean
    UNION ALL
    -- etldoc:  ne_10m_lakes ->  water_z5
    SELECT geometry, 'lake'::text AS class FROM ne_10m_lakes
);

CREATE OR REPLACE VIEW water_z6 AS (
    -- etldoc:  ne_10m_ocean ->  water_z6
    SELECT geometry, 'ocean'::text AS class FROM ne_10m_ocean
    UNION ALL
   -- etldoc:  osm_water_polygon_gen6 ->  water_z6
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon_gen6
);

CREATE OR REPLACE VIEW water_z7 AS (
    -- etldoc:  ne_10m_ocean ->  water_z7
    SELECT geometry, 'ocean'::text AS class FROM ne_10m_ocean
    UNION ALL
    -- etldoc:  osm_water_polygon_gen5 ->  water_z7
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon_gen5
);

CREATE OR REPLACE VIEW water_z8 AS (
    -- etldoc:  osm_ocean_polygon_gen4 ->  water_z8
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon_gen4
    UNION ALL
    -- etldoc:  osm_water_polygon_gen4 ->  water_z8
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon_gen4
);

CREATE OR REPLACE VIEW water_z9 AS (
    -- etldoc:  osm_ocean_polygon_gen3 ->  water_z9
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon_gen3
    UNION ALL
    -- etldoc:  osm_water_polygon_gen3 ->  water_z9
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon_gen3
);

CREATE OR REPLACE VIEW water_z10 AS (
    -- etldoc:  osm_ocean_polygon_gen2 ->  water_z10
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon_gen2
    UNION ALL
    -- etldoc:  osm_water_polygon_gen2 ->  water_z10
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon_gen2
);

CREATE OR REPLACE VIEW water_z11 AS (
    -- etldoc:  osm_ocean_polygon_gen1 ->  water_z11
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon_gen1
    UNION ALL
    -- etldoc:  osm_water_polygon_gen1 ->  water_z11
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon_gen1
);

CREATE OR REPLACE VIEW water_z12 AS (
    -- etldoc:  osm_ocean_polygon_gen1 ->  water_z12
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon
    UNION ALL
    -- etldoc:  osm_water_polygon ->  water_z12
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon
);

CREATE OR REPLACE VIEW water_z13 AS (
    -- etldoc:  osm_ocean_polygon ->  water_z13
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon
    UNION ALL
    -- etldoc:  osm_water_polygon ->  water_z13
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon
);

CREATE OR REPLACE VIEW water_z14 AS (
    -- etldoc:  osm_ocean_polygon ->  water_z14
    SELECT geometry, 'ocean'::text AS class FROM osm_ocean_polygon
    UNION ALL
    -- etldoc:  osm_water_polygon ->  water_z14
    SELECT geometry, water_class(waterway) AS class FROM osm_water_polygon
);

-- etldoc: layer_water [shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="layer_water |<z0> z0|<z1>z1|<z2>z2|<z3>z3 |<z4> z4|<z5>z5|<z6>z6|<z7>z7| <z8> z8 |<z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13|<z14_> z14+" ] ;

CREATE OR REPLACE FUNCTION layer_water (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, class text) AS $$
    SELECT geometry, class::text FROM (
        -- etldoc: water_z0 ->  layer_water:z0
        SELECT * FROM water_z0 WHERE zoom_level = 0
        UNION ALL
        -- etldoc: water_z1 ->  layer_water:z1
        SELECT * FROM water_z1 WHERE zoom_level = 1
        UNION ALL
        -- etldoc: water_z2 ->  layer_water:z2
        -- etldoc: water_z2 ->  layer_water:z3
        SELECT * FROM water_z2 WHERE zoom_level BETWEEN 2 AND 3
        UNION ALL
        -- etldoc: water_z4 ->  layer_water:z4
        SELECT * FROM water_z4 WHERE zoom_level = 4
        UNION ALL
        -- etldoc: water_z5 ->  layer_water:z5
        SELECT * FROM water_z5 WHERE zoom_level = 5
        UNION ALL
        -- etldoc: water_z6 ->  layer_water:z6
        SELECT * FROM water_z6 WHERE zoom_level = 6
        UNION ALL
        -- etldoc: water_z7 ->  layer_water:z7
        SELECT * FROM water_z7 WHERE zoom_level = 7
        UNION ALL
        -- etldoc: water_z8 ->  layer_water:z8
        SELECT * FROM water_z8 WHERE zoom_level = 8
        UNION ALL
        -- etldoc: water_z9 ->  layer_water:z9
        SELECT * FROM water_z9 WHERE zoom_level = 9
        UNION ALL
        -- etldoc: water_z10 ->  layer_water:z10
        SELECT * FROM water_z10 WHERE zoom_level = 10
        UNION ALL
        -- etldoc: water_z11 ->  layer_water:z11
        SELECT * FROM water_z11 WHERE zoom_level = 11
        UNION ALL
        -- etldoc: water_z12 ->  layer_water:z12
        SELECT * FROM water_z12 WHERE zoom_level = 12
        UNION ALL
        -- etldoc: water_z13 ->  layer_water:z13
        SELECT * FROM water_z13 WHERE zoom_level = 13
        UNION ALL
        -- etldoc: water_z14 ->  layer_water:z14_
        SELECT * FROM water_z14 WHERE zoom_level >= 14
    ) AS zoom_levels
    WHERE geometry && bbox;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_lvhua_gongyuan_dizhigongyuan'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_lvhua_gongyuan_dizhigongyuan (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, grade text, areacode int, name text) AS $$
    SELECT geometry, grade, areacode::int, name FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan WHERE geometry && bbox AND zoom_level >= 9 AND zoom_level <=12 
        UNION ALL
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan WHERE geometry && bbox AND zoom_level = 12
        UNION ALL
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_lvhua_gongyuan_dizhigongyuan WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_lvhua_gongyuan_senlingongyuan'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_lvhua_gongyuan_senlingongyuan (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, grade text) AS $$
    SELECT geometry, name, areacode::int, grade FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_lvhua_gongyuan_senlingongyuan WHERE geometry && bbox AND zoom_level = 12  AND zoom_level >=9
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_lvhua_gongyuan_senlingongyuan WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_lvhua_gongyuan_senlingongyuan WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_fangwujianzhu'; END$$;
-- etldoc: osm_border_linestring_gen2 -> boundary_z12
-- CREATE OR REPLACE VIEW boundary_z12 AS (
--     SELECT geometry, admin_level, disputed, maritime
--     FROM osm_border_linestring_gen2
-- );

-- -- etldoc: osm_border_linestring_gen1 -> boundary_z12
-- CREATE OR REPLACE VIEW boundary_z13 AS (
--     SELECT geometry, admin_level, disputed, maritime
--     FROM osm_border_linestring_gen1
-- );

-- etldoc: layer_tj_building[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tj_building |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_fangwujianzhu (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, render_height int, render_min_height int) AS $$
    SELECT  geometry,  render_height::int, render_min_height::int FROM (
        -- etldoc: fangwujianzhu ->  layer_tj_building:z13
        SELECT   geometry, fw_g as render_height, gc as render_min_height FROM tj_fangwu_fangwujianzhu WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tj_building:z14
        SELECT   geometry, fw_g as render_height, gc as render_min_height FROM tj_fangwu_fangwujianzhu WHERE geometry && bbox AND zoom_level >= 14
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_peitao_xuexiao'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_peitao_xuexiao (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, grade text) AS $$
    SELECT geometry, name, areacode::int, grade FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_peitao_xuexiao WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=9
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_peitao_xuexiao WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_peitao_xuexiao WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_peitao_xingzhengdanwei'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_peitao_xingzhengdanwei (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, featid int, type text) AS $$
    SELECT geometry, name, areacode::int, featid::int, type::text FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_peitao_xingzhengdanwei WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=9
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_peitao_xingzhengdanwei WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_peitao_xingzhengdanwei WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_peitao_yiyuan'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_peitao_yiyuan (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, grade text) AS $$
    SELECT geometry, name, areacode::int, grade FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_peitao_yiyuan WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=9
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_peitao_yiyuan WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_peitao_yiyuan WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_shuixi_haimian'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_shuixi_haimian (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, grade text) AS $$
    SELECT geometry, name, areacode::int, grade FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_haimian WHERE geometry && bbox AND zoom_level <= 12 AND zoom_level >=7
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_haimian WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_shuixi_haimian WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_shuixi_heliu'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_shuixi_heliu (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, type text) AS $$
    SELECT geometry, name, areacode::int, type FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_heliu WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=9
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_heliu WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_shuixi_heliu WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_shuixi_hupo'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_shuixi_hupo (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, grade text) AS $$
    SELECT geometry, name, areacode::int, grade FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_hupo WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_hupo WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_shuixi_hupo WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_shuixi_shuiku'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_shuixi_shuiku (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, grade text) AS $$
    SELECT geometry, name, areacode::int, grade FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_shuiku WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_shuixi_shuiku WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_shuixi_shuiku WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_yongdi_lindi'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_yongdi_lindi (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, areacode int) AS $$
    SELECT geometry, areacode::int FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_yongdi_lindi WHERE geometry && bbox AND zoom_level <= 12 AND zoom_level >=8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_yongdi_lindi WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_yongdi_lindi WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_yongdi_nongyongdi'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_yongdi_nongyongdi (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, areacode int) AS $$
    SELECT geometry, areacode::int FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_yongdi_nongyongdi WHERE geometry && bbox AND zoom_level <=13  AND zoom_level >=8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_yongdi_nongyongdi WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_yongdi_nongyongdi WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_bianjie_shengjie'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_bianjie_shengjie (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  areacode int) AS $$
    SELECT geometry, areacode FROM (
        SELECT * FROM tj_bianjie_shengjie_line WHERE geometry && bbox AND zoom_level <10
        UNION ALL 
        SELECT * FROM tj_bianjie_shengjie_line WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_bianjie_shijie'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_bianjie_shijie (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  areacode int) AS $$
    SELECT geometry, areacode FROM (
        SELECT * FROM tj_bianjie_shijie WHERE geometry && bbox AND zoom_level <10 AND zoom_level >=6
        UNION ALL 
        SELECT * FROM tj_bianjie_shijie WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_bianjie_xianbianjie'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_bianjie_xianbianjie (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  areacode int) AS $$
    SELECT geometry, areacode FROM (
        SELECT * FROM tj_bianjie_xianbianjie_line WHERE geometry && bbox AND zoom_level <10
        UNION ALL 
        SELECT * FROM tj_bianjie_xianbianjie_line WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_bianjie_xiangzhenjie'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_bianjie_xiangzhenjie (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  areacode int) AS $$
    SELECT geometry, areacode FROM (
        SELECT * FROM tj_bianjie_xiangzhenjie_line WHERE geometry && bbox AND zoom_level <10 AND zoom_level >=8
        UNION ALL 
        SELECT * FROM tj_bianjie_xiangzhenjie_line WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_china_boundray_line'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE FUNCTION layer_tj_china_boundray_line (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry,  gbcode int) AS $$
    SELECT geometry, gbcode FROM (
        SELECT * FROM china_boundray_line WHERE geometry && bbox AND zoom_level <10
        UNION ALL 
        SELECT * FROM china_boundray_line WHERE geometry && bbox AND zoom_level >= 10
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_daolu_gonglu'; END$$;-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_daolu_gonglu (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , type text, areacode int) AS $$
    SELECT geometry, name, type, areacode::int FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT geometry, name, type, areacode FROM tj_daolu_gonglu2 WHERE geometry && bbox AND zoom_level <= 12 AND zoom_level >= 8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT geometry, name, type, areacode FROM tj_daolu_gonglu2 WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT geometry, name, type, areacode FROM tj_daolu_gonglu2 WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_daolu_chengshidaolu'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_daolu_chengshidaolu (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, type text) AS $$
    SELECT geometry, name, areacode::int, type FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_daolu_chengshidaolu WHERE geometry && bbox AND zoom_level <= 12 AND zoom_level >=8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_daolu_chengshidaolu WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_daolu_chengshidaolu WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_daolu_tielu'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_daolu_tielu (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, active int, weight decimal) AS $$
    SELECT geometry, name, areacode::int, active::int, weight FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_daolu_tielu WHERE geometry && bbox AND zoom_level >= 8 AND zoom_level <= 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_daolu_tielu WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_daolu_xiangcundaolu'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_daolu_xiangcundaolu (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, type text) AS $$
    SELECT geometry, name, areacode::int, type FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_daolu_xiangcundaolu WHERE geometry && bbox AND zoom_level = 12 AND zoom_level >=8
        UNION ALL 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_daolu_xiangcundaolu WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_daolu_xiangcundaolu WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_daolu_zadao'; END$$;
-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_daolu_zadao (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , areacode int, type text) AS $$
    SELECT geometry, name, areacode::int, type FROM ( 
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_daolu_zadao WHERE geometry && bbox AND zoom_level <= 13  AND zoom_level >=9
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM tj_daolu_zadao WHERE geometry && bbox AND zoom_level > 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;DO $$ BEGIN RAISE NOTICE 'Layer tj_china_province'; END$$;
-- etldoc: fangwujianzhu -> tjbuilding_z13z14
CREATE OR REPLACE VIEW china_province_all AS (
    SELECT *
    FROM china_province
);

-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tj_china_province (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text , gbcode int) AS $$
    SELECT geometry, name, gbcode::int FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM china_province_all WHERE geometry && bbox AND zoom_level > 3 AND zoom_level < 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT * FROM china_province_all WHERE geometry && bbox AND zoom_level >= 13
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer poi'; END$$;DO $$
BEGIN
    IF NOT EXISTS (SELECT 1
                   FROM pg_type
                   WHERE typname = 'public_transport_stop_type') THEN
        CREATE TYPE public_transport_stop_type AS ENUM (
          'subway', 'tram_stop', 'bus_station', 'bus_stop'
        );
    END IF;
END
$$;
DROP TRIGGER IF EXISTS trigger_flag ON osm_poi_polygon;
DROP TRIGGER IF EXISTS trigger_refresh ON poi_polygon.updates;

-- etldoc:  osm_poi_polygon ->  osm_poi_polygon

CREATE OR REPLACE FUNCTION update_poi_polygon() RETURNS VOID AS $$
BEGIN
  UPDATE osm_poi_polygon
  SET geometry =
           CASE WHEN ST_NPoints(ST_ConvexHull(geometry))=ST_NPoints(geometry)
           THEN ST_Centroid(geometry)
           ELSE ST_PointOnSurface(geometry)
    END
  WHERE ST_GeometryType(geometry) <> 'ST_Point';

  UPDATE osm_poi_polygon
  SET subclass = 'subway'
  WHERE station = 'subway' and subclass='station';

  UPDATE osm_poi_polygon
    SET subclass = 'halt'
    WHERE funicular = 'yes' and subclass='station';

  UPDATE osm_poi_polygon
  SET tags = update_tags(tags, geometry)
  WHERE COALESCE(tags->'name:latin', tags->'name:nonlatin', tags->'name_int') IS NULL;

  ANALYZE osm_poi_polygon;
END;
$$ LANGUAGE plpgsql;

SELECT update_poi_polygon();

-- Handle updates

CREATE SCHEMA IF NOT EXISTS poi_polygon;

CREATE TABLE IF NOT EXISTS poi_polygon.updates(id serial primary key, t text, unique (t));
CREATE OR REPLACE FUNCTION poi_polygon.flag() RETURNS trigger AS $$
BEGIN
    INSERT INTO poi_polygon.updates(t) VALUES ('y')  ON CONFLICT(t) DO NOTHING;
    RETURN null;
END;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION poi_polygon.refresh() RETURNS trigger AS
  $BODY$
  BEGIN
    RAISE LOG 'Refresh poi_polygon';
    PERFORM update_poi_polygon();
    DELETE FROM poi_polygon.updates;
    RETURN null;
  END;
  $BODY$
language plpgsql;

CREATE TRIGGER trigger_flag
    AFTER INSERT OR UPDATE OR DELETE ON osm_poi_polygon
    FOR EACH STATEMENT
    EXECUTE PROCEDURE poi_polygon.flag();

CREATE CONSTRAINT TRIGGER trigger_refresh
    AFTER INSERT ON poi_polygon.updates
    INITIALLY DEFERRED
    FOR EACH ROW
    EXECUTE PROCEDURE poi_polygon.refresh();
DROP TRIGGER IF EXISTS trigger_flag ON osm_poi_point;
DROP TRIGGER IF EXISTS trigger_refresh ON poi_point.updates;

-- etldoc:  osm_poi_point ->  osm_poi_point
CREATE OR REPLACE FUNCTION update_osm_poi_point() RETURNS VOID AS $$
BEGIN
  UPDATE osm_poi_point
    SET subclass = 'subway'
    WHERE station = 'subway' and subclass='station';

  UPDATE osm_poi_point
    SET subclass = 'halt'
    WHERE funicular = 'yes' and subclass='station';

  UPDATE osm_poi_point
  SET tags = update_tags(tags, geometry)
  WHERE COALESCE(tags->'name:latin', tags->'name:nonlatin', tags->'name_int') IS NULL;

END;
$$ LANGUAGE plpgsql;

SELECT update_osm_poi_point();

CREATE OR REPLACE FUNCTION update_osm_poi_point_agg() RETURNS VOID AS $$
BEGIN
  UPDATE osm_poi_point p
  SET agg_stop = CASE
      WHEN p.subclass IN ('bus_stop', 'bus_station', 'tram_stop', 'subway')
        THEN 1
      ELSE NULL
  END;

  UPDATE osm_poi_point p
    SET agg_stop = (
      CASE
        WHEN p.subclass IN ('bus_stop', 'bus_station', 'tram_stop', 'subway')
            AND r.rk IS NULL OR r.rk = 1
          THEN 1
        ELSE NULL
      END)
    FROM osm_poi_stop_rank r
    WHERE p.osm_id = r.osm_id
  ;

END;
$$ LANGUAGE plpgsql;

-- Handle updates

CREATE SCHEMA IF NOT EXISTS poi_point;

CREATE TABLE IF NOT EXISTS poi_point.updates(id serial primary key, t text, unique (t));
CREATE OR REPLACE FUNCTION poi_point.flag() RETURNS trigger AS $$
BEGIN
    INSERT INTO poi_point.updates(t) VALUES ('y')  ON CONFLICT(t) DO NOTHING;
    RETURN null;
END;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION poi_point.refresh() RETURNS trigger AS
  $BODY$
  BEGIN
    RAISE LOG 'Refresh poi_point';
    PERFORM update_osm_poi_point();
    REFRESH MATERIALIZED VIEW osm_poi_stop_centroid;
    REFRESH MATERIALIZED VIEW osm_poi_stop_rank;
    PERFORM update_osm_poi_point_agg();
    DELETE FROM poi_point.updates;
    RETURN null;
  END;
  $BODY$
language plpgsql;

CREATE TRIGGER trigger_flag
    AFTER INSERT OR UPDATE OR DELETE ON osm_poi_point
    FOR EACH STATEMENT
    EXECUTE PROCEDURE poi_point.flag();

CREATE CONSTRAINT TRIGGER trigger_refresh
    AFTER INSERT ON poi_point.updates
    INITIALLY DEFERRED
    FOR EACH ROW
    EXECUTE PROCEDURE poi_point.refresh();
CREATE OR REPLACE FUNCTION poi_class_rank(class TEXT)
RETURNS INT AS $$
    SELECT CASE class
        WHEN 'hospital' THEN 20
        WHEN 'railway' THEN 40
        WHEN 'bus' THEN 50
        WHEN 'attraction' THEN 70
        WHEN 'harbor' THEN 75
        WHEN 'college' THEN 80
        WHEN 'school' THEN 85
        WHEN 'stadium' THEN 90
        WHEN 'zoo' THEN 95
        WHEN 'town_hall' THEN 100
        WHEN 'campsite' THEN 110
        WHEN 'cemetery' THEN 115
        WHEN 'park' THEN 120
        WHEN 'library' THEN 130
        WHEN 'police' THEN 135
        WHEN 'post' THEN 140
        WHEN 'golf' THEN 150
        WHEN 'shop' THEN 400
        WHEN 'grocery' THEN 500
        WHEN 'fast_food' THEN 600
        WHEN 'clothing_store' THEN 700
        WHEN 'bar' THEN 800
        ELSE 1000
    END;
$$ LANGUAGE SQL IMMUTABLE;

CREATE OR REPLACE FUNCTION poi_class(subclass TEXT, mapping_key TEXT)
RETURNS TEXT AS $$
    SELECT CASE
        WHEN subclass IN ('accessories','antiques','beauty','bed','boutique','camera','carpet','charity','chemist','chocolate','coffee','computer','confectionery','convenience','copyshop','cosmetics','garden_centre','doityourself','erotic','electronics','fabric','florist','frozen_food','furniture','video_games','video','general','gift','hardware','hearing_aids','hifi','ice_cream','interior_decoration','jewelry','kiosk','lamps','mall','massage','motorcycle','mobile_phone','newsagent','optician','outdoor','perfumery','perfume','pet','photo','second_hand','shoes','sports','stationery','tailor','tattoo','ticket','tobacco','toys','travel_agency','watches','weapons','wholesale') THEN 'shop'
        WHEN subclass IN ('townhall','public_building','courthouse','community_centre') THEN 'town_hall'
        WHEN subclass IN ('golf','golf_course','miniature_golf') THEN 'golf'
        WHEN subclass IN ('fast_food','food_court') THEN 'fast_food'
        WHEN subclass IN ('park','bbq') THEN 'park'
        WHEN subclass IN ('bus_stop','bus_station') THEN 'bus'
        WHEN (subclass='station' AND mapping_key = 'railway') OR subclass IN ('halt', 'tram_stop', 'subway') THEN 'railway'
        WHEN (subclass='station' AND mapping_key = 'aerialway') THEN 'aerialway'
        WHEN subclass IN ('subway_entrance','train_station_entrance') THEN 'entrance'
        WHEN subclass IN ('camp_site','caravan_site') THEN 'campsite'
        WHEN subclass IN ('laundry','dry_cleaning') THEN 'laundry'
        WHEN subclass IN ('supermarket','deli','delicatessen','department_store','greengrocer','marketplace') THEN 'grocery'
        WHEN subclass IN ('books','library') THEN 'library'
        WHEN subclass IN ('university','college') THEN 'college'
        WHEN subclass IN ('hotel','motel','bed_and_breakfast','guest_house','hostel','chalet','alpine_hut','camp_site') THEN 'lodging'
        WHEN subclass IN ('chocolate','confectionery') THEN 'ice_cream'
        WHEN subclass IN ('post_box','post_office') THEN 'post'
        WHEN subclass IN ('cafe') THEN 'cafe'
        WHEN subclass IN ('school','kindergarten') THEN 'school'
        WHEN subclass IN ('alcohol','beverages','wine') THEN 'alcohol_shop'
        WHEN subclass IN ('bar','nightclub') THEN 'bar'
        WHEN subclass IN ('marina','dock') THEN 'harbor'
        WHEN subclass IN ('car','car_repair','taxi') THEN 'car'
        WHEN subclass IN ('hospital','nursing_home', 'clinic') THEN 'hospital'
        WHEN subclass IN ('grave_yard','cemetery') THEN 'cemetery'
        WHEN subclass IN ('attraction','viewpoint') THEN 'attraction'
        WHEN subclass IN ('biergarten','pub') THEN 'beer'
        WHEN subclass IN ('music','musical_instrument') THEN 'music'
        WHEN subclass IN ('american_football','stadium','soccer','pitch') THEN 'stadium'
        WHEN subclass IN ('art','artwork','gallery','arts_centre') THEN 'art_gallery'
        WHEN subclass IN ('bag','clothes') THEN 'clothing_store'
        WHEN subclass IN ('swimming_area','swimming') THEN 'swimming'
        WHEN subclass IN ('castle','ruins') THEN 'castle'
        ELSE subclass
    END;
$$ LANGUAGE SQL IMMUTABLE;
DROP MATERIALIZED VIEW IF EXISTS osm_poi_stop_centroid CASCADE;
CREATE MATERIALIZED VIEW osm_poi_stop_centroid AS (
  SELECT
      uic_ref,
      count(*) as count,
			CASE WHEN count(*) > 2 THEN ST_Centroid(ST_UNION(geometry))
			ELSE NULL END AS centroid
  FROM osm_poi_point
	WHERE
		nullif(uic_ref, '') IS NOT NULL
		AND subclass IN ('bus_stop', 'bus_station', 'tram_stop', 'subway')
	GROUP BY
		uic_ref
	HAVING
		count(*) > 1
);

DROP MATERIALIZED VIEW IF EXISTS osm_poi_stop_rank CASCADE;
CREATE MATERIALIZED VIEW osm_poi_stop_rank AS (
	SELECT
		p.osm_id,
-- 		p.uic_ref,
-- 		p.subclass,
		ROW_NUMBER()
		OVER (
			PARTITION BY p.uic_ref
			ORDER BY
				p.subclass :: public_transport_stop_type NULLS LAST,
				ST_Distance(c.centroid, p.geometry)
		) AS rk
	FROM osm_poi_point p
		INNER JOIN osm_poi_stop_centroid c ON (p.uic_ref = c.uic_ref)
	WHERE
		subclass IN ('bus_stop', 'bus_station', 'tram_stop', 'subway')
	ORDER BY p.uic_ref, rk
);

ALTER TABLE osm_poi_point ADD COLUMN IF NOT EXISTS agg_stop INTEGER DEFAULT NULL;
SELECT update_osm_poi_point_agg();
-- etldoc: layer_poi[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="layer_poi | <z12> z12 | <z13> z13 | <z14_> z14+" ] ;

CREATE OR REPLACE FUNCTION layer_poi(bbox geometry, zoom_level integer, pixel_width numeric)
RETURNS TABLE(osm_id bigint, geometry geometry, name text, name_en text, name_de text, tags hstore, class text, subclass text, agg_stop integer, "rank" int) AS $$
    SELECT osm_id_hash AS osm_id, geometry, NULLIF(name, '') AS name,
        COALESCE(NULLIF(name_en, ''), name) AS name_en,
        COALESCE(NULLIF(name_de, ''), name, name_en) AS name_de,
        tags,
        poi_class(subclass, mapping_key) AS class,
        CASE
            WHEN subclass = 'information'
                THEN NULLIF(information, '')
            WHEN subclass = 'place_of_worship'
                    THEN NULLIF(religion, '')
            ELSE subclass
        END AS subclass,
        agg_stop,
        row_number() OVER (
            PARTITION BY LabelGrid(geometry, 100 * pixel_width)
            ORDER BY CASE WHEN name = '' THEN 2000 ELSE poi_class_rank(poi_class(subclass, mapping_key)) END ASC
        )::int AS "rank"
    FROM (
        -- etldoc: osm_poi_point ->  layer_poi:z12
        -- etldoc: osm_poi_point ->  layer_poi:z13
        SELECT *,
            osm_id*10 AS osm_id_hash FROM osm_poi_point
            WHERE geometry && bbox
                AND zoom_level BETWEEN 12 AND 13
                AND ((subclass='station' AND mapping_key = 'railway')
                    OR subclass IN ('halt', 'ferry_terminal'))
        UNION ALL

        -- etldoc: osm_poi_point ->  layer_poi:z14_
        SELECT *,
            osm_id*10 AS osm_id_hash FROM osm_poi_point
            WHERE geometry && bbox
                AND zoom_level >= 14

        UNION ALL
        -- etldoc: osm_poi_polygon ->  layer_poi:z12
        -- etldoc: osm_poi_polygon ->  layer_poi:z13
        SELECT *,
            NULL::INTEGER AS agg_stop,
            CASE WHEN osm_id<0 THEN -osm_id*10+4
                ELSE osm_id*10+1
            END AS osm_id_hash
        FROM osm_poi_polygon
            WHERE geometry && bbox
                AND zoom_level BETWEEN 12 AND 13
                AND ((subclass='station' AND mapping_key = 'railway')
                    OR subclass IN ('halt', 'ferry_terminal'))

        UNION ALL
        -- etldoc: osm_poi_polygon ->  layer_poi:z14_
        SELECT *,
            NULL::INTEGER AS agg_stop,
            CASE WHEN osm_id<0 THEN -osm_id*10+4
                ELSE osm_id*10+1
            END AS osm_id_hash
        FROM osm_poi_polygon
            WHERE geometry && bbox
                AND zoom_level >= 14
        ) as poi_union
    ORDER BY "rank"
    ;
$$ LANGUAGE SQL IMMUTABLE;
DO $$ BEGIN RAISE NOTICE 'Layer tj_poi_airport'; END$$;
CREATE OR REPLACE FUNCTION layer_tj_poi_airport (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, typecode text, name text, objectid int) AS $$
    SELECT geometry, typecode, name, objectid::int FROM (
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z13
        SELECT * FROM tj_poi_airport WHERE geometry && bbox AND  zoom_level < 14 AND zoom_level >= level_f AND zoom_level <= level_t 
        UNION ALL
        SELECT * FROM tj_poi_airport WHERE geometry && bbox AND zoom_level = 14

    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;

