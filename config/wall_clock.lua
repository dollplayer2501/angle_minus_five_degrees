--
-- Wall Clock
--

function get_config_wall_clock(_const, _config, _today_width)
    return {
        -- position
        center_x = _const.CENTER_POSITION.THEME.X,
        center_y = _const.CENTER_POSITION.THEME.Y,

        -- Clock hands - 12 hour
        hands_radius_hour12 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 80,
        hands_width_hour12 = 24,

        -- Clock hands - 24 hour
        hands_radius_hour24 = _today_width.WIDTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE + 300,
        hands_width_hour24 = 4,

        -- Clock hands - minutes
        hands_update_interval_mins = _config.wall_clock.update_interval_minutes,
        hands_radius_mins = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 30,
        hands_width_mins = 16,

        -- Clock hands - seconds
        hands_display_secs = _config.display_seconds.wall_clock,
        hands_radius_secs = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 50,
        hands_width_secs = 8,

        -- Clock marks - 12 hour
        marks_radius_from_hour12 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 50,
        marks_radius_to_hour12 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 70,
        marks_width_hour12 = 2,

        -- Clock marks - minutes
        marks_display_mins = _config.wall_clock.display_marks_minutes,
        marks_radius_from_mins = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 50,
        marks_radius_to_mins = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 10,
        marks_width_mins = 2,

        -- Clock marks - 24 hour
        marks_radius_from_hour24 = _today_width.WIDTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE + 200 - 60,
        marks_radius_to_hour24 = _today_width.WIDTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE + 200 + 60,
        marks_width_hour24 = 2,

        -- Clock number - 24 hour
        number_display_hour24 = _config.wall_clock.display_number_hour24,
        number_adjust_x_hour24 = 0,
        number_adjust_y_hour24 = -10,
        number_font_align_x_hour24 = _const.ALIGN.LEFT,
        number_font_size_hour24 = 60,
        number_font_face_hour24 = _const.FONT_FACE_2_2,
        number_font_weight_hour24 = CAIRO_FONT_WEIGHT_NORMAL,

        -- etc
        hands_line_cap = CAIRO_LINE_CAP_ROUND,
        marks_line_cap = CAIRO_LINE_CAP_ROUND,
    }
end
