--
-- Bar more
--

function get_config_bar_more(_const, _config)
    return {
        -- bar
        bar_position_x = _const.CENTER_POSITION.THEME.X,
        bar_position_y = _const.CENTER_POSITION.THEME.Y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
        bar_gap_y = 12,
        bar_line_width = 3,
        bar_length = _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,

        -- caption
        caption_position_x = _const.CENTER_POSITION.THEME.X + 4,
        caption_position_y = _const.CENTER_POSITION.THEME.Y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT + 16,
        caption_gap_y = 12,
        caption_align = _const.ALIGN.LEFT,
        caption_font_face = _const.FONT_FACE_2_1,
        caption_font_size = 12,
        caption_font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
