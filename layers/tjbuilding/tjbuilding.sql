
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

-- etldoc: layer_tjbuilding[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="<sql> layer_tjbuilding |<z0> z0 |<z1_2> z1_2 | <z3> z3 | <z4> z4 | <z5> z5 | <z6> z6 | <z7> z7 | <z8> z8 | <z9> z9 |<z10> z10 |<z11> z11 |<z12> z12|<z13> z13+"]

CREATE OR REPLACE FUNCTION layer_tjbuilding (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, render_height int, render_min_height int) AS $$
    SELECT  geometry,  render_height::int, render_min_height::int FROM (
        -- etldoc: fangwujianzhu ->  layer_tjbuilding:z13
        SELECT geom as geometry, fw_g as render_height, gc as render_min_height FROM fangwujianzhu WHERE geom && bbox AND zoom_level = 13
        UNION ALL
        -- etldoc: fangwujianzhu -> layer_tjbuilding:z14
        SELECT geom as geometry, fw_g as render_height, gc as render_min_height FROM fangwujianzhu WHERE geom && bbox AND zoom_level >= 14
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;