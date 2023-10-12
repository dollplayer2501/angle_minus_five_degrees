--
-- Wall Clock Hours 12
--

function drawing_wall_clock_hours12(_context,
    -- position
    _center_x, _center_y,
    -- Clock hands - 12 hour
    _hands_radius_hour12, _hands_width_hour12, _hands_back_length_rate_hour12,
    -- Clock hands - minutes
    _hands_radius_mins, _hands_width_mins, _hands_back_length_rate_mins,
    -- Clock hands - seconds
    _hands_display_secs, _hands_radius_secs, _hands_width_secs, _hands_back_length_rate_secs,
    -- Clock marks - 12 o'clock, top
    _marks_display_mins00, _marks_radius_from_mins00, _marks_radius_to_mins00, _marks_width_mins00,
    -- Clock marks - 15 minutes without 12 o'clock
    _marks_display_mins15, _marks_radius_from_mins15, _marks_radius_to_mins15, _marks_width_mins15,
    -- Clock marks - 10 minutes
    _marks_radius_from_mins10, _marks_radius_to_mins10, _marks_width_mins10,
    -- Clock marks - 1 minute
    _marks_display_mins01, _marks_radius_from_mins, _marks_radius_to_mins, _marks_width_mins,
    -- Clock number - 24 hour
    _number_display_mins10,
    _number_adjust_x_mins10, _number_adjust_y_mins10,
    _number_font_align_x_mins10, _number_font_size_mins10, _number_font_face_mins10, _number_font_weight_mins10,
    -- etc
    _hands_update_interval_mins,
    _hands_line_cap, _marks_line_cap,
    -- color
    _color_wall_clock)


    --
    --
    --

    local flg_debug = false
    local tmp_now_secs    = true == flg_debug and 0  or tonumber(os.date('%S'))
    local tmp_now_mins    = true == flg_debug and 0  or tonumber(os.date('%M'))
    local tmp_now_hours12 = true == flg_debug and 4  or tonumber(os.date('%I'))
    local tmp_now_hours24 = true == flg_debug and 16 or tonumber(os.date('%H'))

    local tmp_secs_arc_now, tmp_secs_arc_now_tmp, tmp_mins_arc_now, tmp_hours12_arc_now, tmp_hours24_arc_now =
        changing_time_to_arc(
            tmp_now_secs, tmp_now_mins, tmp_now_hours12, tmp_now_hours24, _hands_update_interval_mins
        )


    --
    -- Clock marks - 12 o'clock, top
    --

    if true == _marks_display_mins00 then
        drawing_wall_clock_marks(_context,
            _center_x, _center_y,
            _marks_radius_from_mins00, _marks_radius_to_mins00,
            1, nil,
            _marks_width_mins00, _marks_line_cap,
            _color_wall_clock.marks.mins00)
    end


    --
    -- Clock marks - 15 minutes without 12 o'clock
    --

    if true == _marks_display_mins15 then
        drawing_wall_clock_marks(_context,
            _center_x, _center_y,
            _marks_radius_from_mins15, _marks_radius_to_mins15,
            4, 4,
            _marks_width_mins15, _marks_line_cap,
            _color_wall_clock.marks.mins15)
    end


    --
    -- Clock marks - 10 minutes
    --

    drawing_wall_clock_marks(_context,
        _center_x, _center_y,
        _marks_radius_from_mins10, _marks_radius_to_mins10,
        12, 3,
        _marks_width_mins10, _marks_line_cap,
        _color_wall_clock.marks.mins10)


    --
    -- Clock marks - minutes
    --

    if true == _marks_display_mins01 then
        drawing_wall_clock_marks(_context,
            _center_x, _center_y,
            _marks_radius_from_mins, _marks_radius_to_mins,
            60, 5,
            _marks_width_mins, _marks_line_cap,
            _color_wall_clock.marks.mins01)
    end



    if true == _number_display_mins10 then
        local tmp_num = 12
        local tmp_marks_angle = math.rad(360 / tmp_num)
        for ii = 0, tmp_num - 1, 1 do
            local tmp_display_num = math.abs(ii - 12)
            drawing_text(_context, _number_font_align_x_mins10,
                _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_from_mins15 + _number_adjust_x_mins10,
                _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_from_mins15 + _number_adjust_y_mins10,
                _number_font_size_mins10,
                tmp_display_num,
                _number_font_face_mins10, CAIRO_FONT_SLANT_NORMAL, _number_font_weight_mins10, _color_wall_clock.number.mins10)
        end
    end


    --
    -- Clock hands -- 12 hour
    --

    drawing_wall_clock_hands(_context,
        _center_x, _center_y,
        _hands_radius_hour12, tmp_hours12_arc_now, _hands_back_length_rate_hour12,
        _hands_width_hour12, _hands_line_cap,
        _color_wall_clock.hands.hour12)


    --
    -- Clock hands -- minutes
    --

    drawing_wall_clock_hands(_context,
        _center_x, _center_y,
        _hands_radius_mins, tmp_mins_arc_now, _hands_back_length_rate_mins,
        _hands_width_mins, _hands_line_cap,
        _color_wall_clock.hands.mins)


    --
    -- Clock hands -- seconds
    --

    if true == _hands_display_secs then
        drawing_wall_clock_hands(_context,
            _center_x, _center_y,
            _hands_radius_secs, tmp_secs_arc_now, _hands_back_length_rate_secs,
            _hands_width_secs, _hands_line_cap,
            _color_wall_clock.hands.secs)
    end
end
