--
-- Wall Clock
--

function get_config_wall_clock(_const, _config)
    return {
        -- position
        center_x = _const.CENTER_POSITION.THEME.X,
        center_y = _const.CENTER_POSITION.THEME.Y,

        -- 12 hour
        radius_hour12 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 100,
        width_hour12 = 30,

        -- 24 hour
        radius_hour24 = _const.CENTER_POSITION.THEME.X / 2,
        width_hour24 = 12,

        -- minutes
        radius_mins =  _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 50,
        width_mins = 20,

        -- seconds
        display_secs = _config.display_seconds.wall_clock,
        radius_secs = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 80,
        width_secs = 10,

        -- etc
        line_cap = CAIRO_LINE_CAP_ROUND,
    }
end
