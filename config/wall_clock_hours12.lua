--
-- Wall Clock Hours 12
--

function get_config_wall_clock_hours12(_const, _config, _today_width)
    return {
        -- position
        center_x = _const.CENTER_POSITION.THEME.X,
        center_y = _const.CENTER_POSITION.THEME.Y,

        -- Clock hands - 12 hour
        hands_radius_hour12 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 80,
        hands_width_hour12 = 24,
        hands_back_length_rate_hour12 = 0.1,

        -- Clock hands - minutes
        hands_radius_mins = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 30,
        hands_width_mins = 16,
        hands_back_length_rate_mins = 0.1,

        -- Clock hands - seconds
        hands_display_secs = _config.display_seconds.wall_clock,
        hands_radius_secs = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 50,
        hands_width_secs = 8,
        hands_back_length_rate_secs = 0.2,

        -- Clock marks - 12 o'clock, top
        marks_display_mins00 = _config.wall_clock.display_marks_minutes00,
        marks_radius_from_mins00 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 200,
        marks_radius_to_mins00 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 80,
        marks_width_mins00 = 6,

        -- Clock marks - 15 minutes without 12 o'clock
        marks_display_mins15 = _config.wall_clock.display_marks_minutes15,
        marks_radius_from_mins15 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 120,
        marks_radius_to_mins15 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 80,
        marks_width_mins15 = 4,

        -- Clock marks - 10 minutes
        marks_radius_from_mins10 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 90,
        marks_radius_to_mins10 = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + 40,
        marks_width_mins10 = 2,

        -- Clock marks - 1 minute
        marks_display_mins01 = _config.wall_clock.display_marks_minutes01,
        marks_radius_from_mins = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 40,
        marks_radius_to_mins = _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT - 10,
        marks_width_mins = 2,

        -- Clock number - 24 hour
        number_display_mins10 = _config.wall_clock.display_number_mins10,
        number_adjust_x_mins10 = 0,
        number_adjust_y_mins10 = 10,
        number_font_align_x_mins10 = _const.ALIGN.LEFT,
        number_font_size_mins10 = 84,
        number_font_face_mins10 = _const.FONT_FACE_2_1,
        number_font_weight_mins10 = CAIRO_FONT_WEIGHT_NORMAL,

        -- etc
        hands_update_interval_mins = _config.wall_clock.update_interval_minutes,
        hands_line_cap = CAIRO_LINE_CAP_ROUND,
        marks_line_cap = CAIRO_LINE_CAP_ROUND,
    }
end
