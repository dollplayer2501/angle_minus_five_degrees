--
-- Detail text
--

function get_config_text_detail(_const, _config)
    return {
        -- display global ip address
        display_global_ip_address = _config.display_global_ip_address,

        -- position
        position_x = _const.CENTER_POSITION.THEME.X,
        position_y = _const.CENTER_POSITION.THEME.Y,
        position_align = _const.ALIGN.RIGHT,

        -- large font
        adjust_x_large = -10,
        adjust_y_large = 65,

        -- normal font
        adjust_x_normal = -10,
        adjust_y_normal = 105,
        gap_y_normal = 26,
        font_size_normal = 24,
        font_face_normal = _const.FONT_FACE_1,
    }
end
