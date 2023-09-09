--
-- Network Graph
--  This is a buggy code!
--

function get_config_graph_network(_const, _config)
    return {
        -- interval
        time_interval = _config.graph_network_time_interval,

        -- array's count
        network_array_count_upspeed = _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,
        network_array_count_downspeed = _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,

        -- graph
        graprh_position_x = _const.CENTER_POSITION.THEME.X,
        graprh_position_y = _const.CENTER_POSITION.THEME.Y,
        graph_width = 1,
        graph_max_height = 50,

        -- caption
        caption_position_x = _const.CENTER_POSITION.THEME.X + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT - 2,
        caption_position_y_upspeed = _const.CENTER_POSITION.THEME.Y - 4,
        caption_position_y_downspeed = _const.CENTER_POSITION.THEME.Y + 14,
        caption_position_align = _const.ALIGN.RIGHT,
        caption_font_face = _const.FONT_FACE_2_1,
        caption_font_size = 12,
        caption_font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
