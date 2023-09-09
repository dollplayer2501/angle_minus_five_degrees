--
--
--

function get_config_text_top(_const, _config)
    return {
        -- Left side, ${top name n}
        position_x_name = _const.CENTER_POSITION.THEME.X,
        position_y_name = _const.CENTER_POSITION.THEME.Y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
        adjust_x_name = 10,

        -- Right size, ${top cpu n}
        position_x_cpu = _const.CENTER_POSITION.THEME.X + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,
        position_y_cpu = _const.CENTER_POSITION.THEME.Y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
        adjust_x_cpu = -10,

        -- location etc
        adjust_y = 28,
        increment_y = 20,

        -- font
        font_face = _const.FONT_FACE_2_2,
        font_size = 18,
        font_weight = CAIRO_FONT_WEIGHT_BOLD,
    }
end
