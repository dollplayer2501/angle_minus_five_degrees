--
-- CPU Load Average Graph
--  Is this a buggy code?
--

function get_config_graph_cpu(_const, _config)
    local tmp_array_count = _const.CPU_LOAD_AVERAGE.LENGTH

    return {
        -- etc
        cpu_array_count = tmp_array_count,
        cpu_usage_limit = _const.USAGE_LIMIT.CPU,

        -- graph
        graprh_position_x = _const.CENTER_POSITION.THEME.X - tmp_array_count,
        graprh_position_y = _const.CENTER_POSITION.THEME.Y,
        graph_width = 1,
        graph_max_height = _const.CPU_LOAD_AVERAGE.HEIGHT,

        -- caption
        caption_position_x = _const.CENTER_POSITION.THEME.X - _const.CPU_LOAD_AVERAGE.LENGTH + 2,
        caption_position_y = _const.CENTER_POSITION.THEME.Y - 4,
        caption_position_align = _const.ALIGN.LEFT,
        caption_font_face = _const.FONT_FACE_2_1,
        caption_font_size = 12,
        caption_font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
