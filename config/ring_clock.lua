--
-- Ring Clock
--

function get_config_ring_clock(_const, _config)
    local tmp_ring_radius = 200

    return {
        -- position
        ring_position_x = _const.CENTER_POSITION.THEME.X,
        ring_position_y = _const.CENTER_POSITION.THEME.Y,

        -- etc
        display_secs = _config.display_seconds.ring_clock,

        -- ring
        ring_angle_start = 90,
        ring_angle_end = 179,
        ring_radius = tmp_ring_radius,
        ring_width = 20,
        ring_gap = 5,

        -- caption
        caption_position_x = _const.CENTER_POSITION.THEME.X + 8,
        caption_position_y = _const.CENTER_POSITION.THEME.Y + tmp_ring_radius + 7,
        caption_increment_y = 25,
        aption_align = _const.ALIGN.LEFT,
        caption_font_face = _const.FONT_FACE_2_1,
        caption_font_size = 12,
        caption_font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
