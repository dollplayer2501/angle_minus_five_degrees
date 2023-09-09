--
-- Clock Text
--

function get_config_text_clock(_const, _config)
    return {
        -- position
        position_x = _const.CENTER_POSITION.THEME.X,
        position_y = _const.CENTER_POSITION.THEME.Y,

        -- hours
        hour_adjust_x = -25,
        hour_adjust_y = -60,
        hour_font_align = _const.ALIGN.RIGHT,
        hour_font_size = 450,
        hour_font_face = _const.FONT_FACE_2_1,

        -- delimiter
        delimiter_adjust_x = -25,
        delimiter_adjust_y = 8,
        delimiter_font_align = _const.ALIGN.LEFT,
        delimiter_font_size = 300,
        delimiter_font_face = _const.FONT_FACE_1,

        -- minutes
        min_adjust_x = 0,
        min_adjust_y = 150,
        min_font_align = _const.ALIGN.LEFT,
        min_font_size = 400,
        min_font_face = _const.FONT_FACE_2_1,

        -- seconds
        display_secs = _config.display_seconds.text_clock,
        sec_adjust_x = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 5,
        sec_adjust_y = -5,
        sec_font_align = _const.ALIGN.RIGHT,
        sec_font_size = 250,
        sec_font_face = _const.FONT_FACE_2_1,
    }
end
