--
-- More Ring
--

function get_config_ring_more(_const, _config)
    local tmp_ring_radius = 200

    return {
        -- position
        ring_center_x = _const.CENTER_POSITION.THEME.X,
        ring_center_y = _const.CENTER_POSITION.THEME.Y,

        -- ring
        ring_angle_start = 270,
        ring_angle_end = 359,
        ring_radius = tmp_ring_radius,
        ring_width = 20,
        ring_gap = 5,

        -- caption
        caption_position_x = _const.CENTER_POSITION.THEME.X - 8,
        caption_position_y = _const.CENTER_POSITION.THEME.Y - tmp_ring_radius + 6,
        caption_increment_y = 25,
        caption_align = _const.ALIGN.RIGHT,
        caption_font_face = _const.FONT_FACE_2_1,
        caption_font_size = 12,
        caption_font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
