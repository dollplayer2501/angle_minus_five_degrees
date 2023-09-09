--
-- Background (Lines)
--

function get_config_background_lines(_const, _config)
    return {
        -- position
        center_x = _const.CENTER_POSITION.THEME.X,
        center_y = _const.CENTER_POSITION.THEME.Y,

        -- top right gimmick
        display_top_right_gimmick = _config.display_top_right_gimmick,
        highlight_length = 4,

        -- etc
        line_cap = CAIRO_LINE_CAP_BUTT,
    }
end
