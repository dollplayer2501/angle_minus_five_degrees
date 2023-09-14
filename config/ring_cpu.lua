--
-- CPU Load Average Ring
--

function get_config_ring_cpu(_const, _config)
    local tmp_ring_radius = 200

    return {
        -- value
        ring_cpu_usage_limit = _const.USAGE_LIMIT.CPU,

        -- position
        ring_position_x = _const.CENTER_POSITION.THEME.X,
        ring_position_y = _const.CENTER_POSITION.THEME.Y,

        -- ring
        ring_angle_start = 0,
        ring_angle_end = 89,
        ring_radius = tmp_ring_radius,
        ring_width = 20,
        ring_gap = 5,

        -- caption
        caption_position_x = _const.CENTER_POSITION.THEME.X + 4,
        caption_position_y = _const.CENTER_POSITION.THEME.Y - tmp_ring_radius + 8,
        caption_increment_y = 25,
        caption_align = _const.ALIGN.LEFT,
        caption_font_face = _const.FONT_FACE_2_1,
        caption_font_size = 12,
        caption_font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
