--
-- Wall Clock Hours 24
--

function drawing_wall_clock_hours24(_context,
    -- position
    _center_x, _center_y,
    -- Clock hands - 24 hour
    _hands_radius_hour24, _hands_width_hour24, _hands_back_length_rate_hour24,
    -- Clock marks - 24 hour - main hand
    _marks_radius_from_hour24_main, _marks_radius_to_hour24_main, _marks_width_hour24_main,
    -- Clock marks - 24 hour - sub hand - short (10 min)
    _marks_radius_from_hour24_sub_short, _marks_radius_to_hour24_sub_short, _marks_width_hour24_sub_short,
    -- Clock marks - 24 hour - sub hand - long (30min)
    _marks_radius_from_hour24_sub_long, _marks_radius_to_hour24_sub_long, _marks_width_hour24_sub_long,
    -- Clock number - 24 hour
    _number_display_hour24,
    _number_adjust_x_hour24, _number_adjust_y_hour24,
    _number_font_align_hour24, _number_font_size_hour24, _number_font_face_hour24, _number_font_weight_hour24,
    -- etc
    _hands_update_interval_mins,
    _hands_hour24_fix_degree,
    _hands_line_cap, _marks_line_cap,
    -- color
    _color_wall_clock)


    --
    --
    --

    local tmp_hands_hour24_fix_arc = (2 * math.pi / 360) * _hands_hour24_fix_degree

    local flg_debug = false
    local tmp_now_secs    = true == flg_debug and 0  or tonumber(os.date('%S'))
    local tmp_now_mins    = true == flg_debug and 0  or tonumber(os.date('%M'))
    local tmp_now_hours12 = true == flg_debug and 4  or tonumber(os.date('%I'))
    local tmp_now_hours24 = true == flg_debug and 16 or tonumber(os.date('%H'))

    local tmp_secs_arc_now, tmp_secs_arc_now_tmp, tmp_mins_arc_now, tmp_hours12_arc_now, tmp_hours24_arc_now =
        changing_time_to_arc(
            tmp_now_secs, tmp_now_mins, tmp_now_hours12, tmp_now_hours24, _hands_update_interval_mins
        )

    local tmp_secs_arc_base, tmp_secs_arc_base_tmp, tmp_mins_arc_base, tmp_hours12_arc_base, tmp_hours24_arc_base =
        changing_time_to_arc(
            0, 0, 0, tmp_now_hours24, _hands_update_interval_mins
        )


    --
    -- Clock marks - 24 hour - main line
    --

    -- Memo: Cannot use function
    cairo_set_line_width(_context, _marks_width_hour24_main)
    cairo_set_line_cap(_context, _marks_line_cap)
    cairo_set_source_rgba(_context,
        _color_wall_clock.marks.hour24.red, _color_wall_clock.marks.hour24.green, _color_wall_clock.marks.hour24.blue,
        _color_wall_clock.marks.hour24.alpha)
    local tmp_num = 24
    local tmp_marks_angle = math.rad(360 / tmp_num)
    for ii = 0, tmp_num - 1, 1 do
        local jj = tmp_hands_hour24_fix_arc - (tmp_hours24_arc_now - tmp_hours24_arc_base)
        cairo_move_to(_context,
            _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_from_hour24_main,
            _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_from_hour24_main
        )
        cairo_line_to(_context,
            _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_main,
            _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_main
        )
        cairo_stroke(_context)
    end


    --
    -- Clock marks - 24 hour - sub line - short (10 min) and long (30min)
    --

    -- Memo: Cannot use function
    cairo_set_line_cap(_context, _marks_line_cap)
    cairo_set_source_rgba(_context,
        _color_wall_clock.marks.hour24.red, _color_wall_clock.marks.hour24.green, _color_wall_clock.marks.hour24.blue,
        _color_wall_clock.marks.hour24.alpha)
    local tmp_num = 24 * 6
    local tmp_marks_angle = math.rad(360 / tmp_num)
    for ii = 0, tmp_num - 1, 1 do
        local jj = tmp_hands_hour24_fix_arc - (tmp_hours24_arc_now - tmp_hours24_arc_base)
        if 0 ~= ii % 6 then
            if 0 == ii % 3 then
                -- 30 minutes
                cairo_set_line_width(_context, _marks_width_hour24_sub_long)
                cairo_move_to(_context,
                    _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_from_hour24_sub_long,
                    _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_from_hour24_sub_long
                )
                cairo_line_to(_context,
                    _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_sub_long,
                    _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_sub_long
                )
            else
                cairo_set_line_width(_context, _marks_width_hour24_sub_short)
                -- 10 minutes without 30 minutes
                cairo_move_to(_context,
                    _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_from_hour24_sub_short,
                    _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_from_hour24_sub_short
                )
                cairo_line_to(_context,
                    _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_sub_short,
                    _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_sub_short
                )
            end
            cairo_stroke(_context)
        end
    end


    --
    -- Clock number - 24 hour
    --

    local tmp_num = 24
    local tmp_marks_angle = math.rad(360 / tmp_num)
    for ii = 0, tmp_num - 1, 1 do
        if true == _number_display_hour24 then
            local jj = tmp_hands_hour24_fix_arc - (tmp_hours24_arc_now - tmp_hours24_arc_base)
            local tmp_display_num = tmp_now_hours24 + math.abs(ii - 24)
            if 24 < tmp_display_num then
                tmp_display_num = tmp_display_num - 24
            end
            if 24 == tmp_display_num then
                tmp_display_num = 0
            end
            drawing_text(_context, _number_font_align_hour24,
                _center_x - math.sin((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_main + _number_adjust_x_hour24,
                _center_y - math.cos((tmp_marks_angle * ii) - jj) * _marks_radius_to_hour24_main + _number_adjust_y_hour24,
                _number_font_size_hour24,
                tmp_display_num,
                _number_font_face_hour24, CAIRO_FONT_SLANT_NORMAL, _number_font_weight_hour24, _color_wall_clock.number.hour24)
        end
    end


    --
    -- Clock hands -- 24 hour .. fixed
    --

    drawing_wall_clock_hands(_context,
        _center_x, _center_y,
        _hands_radius_hour24, tmp_hands_hour24_fix_arc, _hands_back_length_rate_hour24,
        _hands_width_hour24, _hands_line_cap,
        _color_wall_clock.hands.hour24)
end
