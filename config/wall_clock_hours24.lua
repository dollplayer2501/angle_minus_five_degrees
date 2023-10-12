--
-- Wall Clock Hours 24
--

function get_config_wall_clock_hours24(_const, _config, _today_width)

    local tmp_marks_radius_from = _today_width.WIDTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE + 200 - 60
    local tmp_marks_radius_to   = _today_width.WIDTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE + 200 + 60

    return {
        -- position
        center_x = _const.CENTER_POSITION.THEME.X,
        center_y = _const.CENTER_POSITION.THEME.Y,

        -- Clock hands - 24 hour
        hands_radius_hour24 = tmp_marks_radius_from + 300,
        hands_width_hour24 = 4,
        hands_back_length_rate_hour24 = 0.1,

        -- Clock marks - 24 hour - main hand
        marks_radius_from_hour24_main = tmp_marks_radius_from - 30,
        marks_radius_to_hour24_main   = tmp_marks_radius_to,
        marks_width_hour24_main = 2,

        -- Clock marks - 24 hour - sub hand - short (10 min)
        marks_radius_from_hour24_sub_short = tmp_marks_radius_from,
        marks_radius_to_hour24_sub_short   = tmp_marks_radius_to - 80,
        marks_width_hour24_sub_short = 2,

        -- Clock marks - 24 hour - sub hand - long (30min)
        marks_radius_from_hour24_sub_long = tmp_marks_radius_from - 30,
        marks_radius_to_hour24_sub_long   = tmp_marks_radius_to - 40,
        marks_width_hour24_sub_long = 2,

        -- Clock number - 24 hour
        number_display_hour24 = _config.wall_clock.display_number_hour24,
        number_adjust_x_hour24 = 0,
        number_adjust_y_hour24 = -10,
        number_font_align_x_hour24 = _const.ALIGN.LEFT,
        number_font_size_hour24 = 84,
        number_font_face_hour24 = _const.FONT_FACE_2_1,
        number_font_weight_hour24 = CAIRO_FONT_WEIGHT_NORMAL,

        -- etc
        hands_update_interval_mins = _config.wall_clock.update_interval_minutes,
        hands_hour24_fix_degree = 271,
        hands_line_cap = CAIRO_LINE_CAP_ROUND,
        marks_line_cap = CAIRO_LINE_CAP_ROUND,
    }
end
