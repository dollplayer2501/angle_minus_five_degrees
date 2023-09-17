--
-- Wall Clock
--

function drawing_wall_clock(_context,
    -- position
    _center_x, _center_y,
    -- Clock hands - 12 hour
    _hands_radius_hour12, _hands_width_hour12,
    -- Clock hands - 24 hour
    _hands_radius_hour24, _hands_width_hour24,
    -- Clock hands - minutes
    _hands_update_interval_mins, _hands_radius_mins, _hands_width_mins,
    -- Clock hands - seconds
    _hands_display_secs, _hands_radius_secs, _hands_width_secs,
    -- Clock marks - 12 hour
    _marks_radius_from_hour12, _marks_radius_to_hour12, _marks_width_hour12,
    -- Clock marks - minutes
    _marks_display_mins, _marks_radius_from_mins, _marks_radius_to_mins, _marks_width_mins,
    -- Clock marks - 24 hour
    _marks_radius_from_hour24, _marks_radius_to_hour24, _marks_width_hour24,
    -- Clock number - 24 hour
    _number_display_hour24,
    _number_adjust_x_hour24, _number_adjust_y_hour24,
    _number_font_align_hour24, _number_font_size_hour24, _number_font_face_hour24, _number_font_weight_hour24,
    -- etc
    _hands_line_cap, _marks_line_cap,
    -- color
    _color_wall_clock)


    --
    -- Clock marks - 12 hour
    --

    cairo_set_line_width(_context, _marks_width_hour12)
    cairo_set_line_cap(_context, _marks_line_cap)
    cairo_set_source_rgba(_context,
        _color_wall_clock.marks.hour12.red, _color_wall_clock.marks.hour12.green, _color_wall_clock.marks.hour12.blue,
        _color_wall_clock.marks.hour12.alpha)
    local tmp_num = 12
    local tmp_marks_angle = math.rad(360 / tmp_num)
    for ii = 0, tmp_num - 1, 1 do
        if 0 ~= ii % 3 then
            cairo_move_to(_context,
                _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_from_hour12,
                _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_from_hour12
            )
            cairo_line_to(_context,
                _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_to_hour12,
                _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_to_hour12
            )
            cairo_stroke(_context)
        end
    end


    --
    -- Clock marks - minutes
    --

    if true == _marks_display_mins then
        cairo_set_line_width(_context, _marks_width_mins)
        cairo_set_line_cap(_context, _marks_line_cap)
        cairo_set_source_rgba(_context,
            _color_wall_clock.marks.mins.red, _color_wall_clock.marks.mins.green, _color_wall_clock.marks.mins.blue,
            _color_wall_clock.marks.mins.alpha)
        local tmp_num = 60
        local tmp_marks_angle = math.rad(360 / tmp_num)
        for ii = 0, tmp_num - 1, 1 do
            if 0 ~= ii % 5 then
                cairo_move_to(_context,
                    _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_from_mins,
                    _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_from_mins
                )
                cairo_line_to(_context,
                    _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_to_mins,
                    _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_to_mins
                )
                cairo_stroke(_context)
            end
        end
    end


    --
    -- Clock marks and number - 24 hour
    --

    cairo_set_line_width(_context, _marks_width_hour24)
    cairo_set_line_cap(_context, _marks_line_cap)
    local tmp_num = 24
    local tmp_marks_angle = math.rad(360 / tmp_num)
    for ii = 0, tmp_num - 1, 1 do

        -- marks
        cairo_set_source_rgba(_context,
            _color_wall_clock.marks.hour24.red, _color_wall_clock.marks.hour24.green, _color_wall_clock.marks.hour24.blue,
            _color_wall_clock.marks.hour24.alpha)
        cairo_move_to(_context,
            _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_from_hour24,
            _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_from_hour24
        )
        cairo_line_to(_context,
            _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_to_hour24,
            _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_to_hour24
        )
        cairo_stroke(_context)

        -- number
        if true == _number_display_hour24 then
            local display_num = 0 == ii and 0 or math.abs(24 - ii)
            drawing_text(_context, _number_font_align_hour24,
                _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_to_hour24 + _number_adjust_x_hour24,
                _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_to_hour24 + _number_adjust_y_hour24,
                _number_font_size_hour24,
                display_num,
                _number_font_face_hour24, CAIRO_FONT_SLANT_NORMAL, _number_font_weight_hour24, _color_wall_clock.number.hour24)
        end
    end


    --
    --
    --

    local tmp_secs_sys = tonumber(os.date('%S'))
    local tmp_mins_sys = tonumber(os.date('%M'))
    local tmp_hours12_sys = tonumber(os.date('%I'))
    local tmp_hours24_sys =  tonumber(os.date('%H'))

    local tmp_secs_arc = (2 * math.pi / 60) * tmp_secs_sys
    local tmp_secs_arc_tmp = (2 * math.pi / 60) * math.floor(tmp_secs_sys / _hands_update_interval_mins) * _hands_update_interval_mins
    local tmp_mins_arc = (2 * math.pi / 60) * tmp_mins_sys + (tmp_secs_arc_tmp / 60)
    local tmp_hours12_arc = (2 * math.pi / 12) * tmp_hours12_sys + (tmp_mins_arc / 12)
    local tmp_hours24_arc = (2 * math.pi / 24) * tmp_hours24_sys + (tmp_mins_arc / 24)


    --
    -- Clock hands -- 12 hour
    --

    local tmp_hour12_length_x = _center_x + _hands_radius_hour12 * math.sin(tmp_hours12_arc)
    local tmp_hour12_length_y = _center_y - _hands_radius_hour12 * math.cos(tmp_hours12_arc)
    drawing_line(_context,
        _center_x, _center_y, tmp_hour12_length_x, tmp_hour12_length_y,
        _hands_width_hour12, _hands_line_cap, _color_wall_clock.hands.hour12)


    --
    -- Clock hands -- 24 hour
    --

    local tmp_hour24_length_x = _center_x + _hands_radius_hour24 * math.sin(tmp_hours24_arc)
    local tmp_hour24_length_y = _center_y - _hands_radius_hour24 * math.cos(tmp_hours24_arc)
    drawing_line(_context,
        _center_x, _center_y, tmp_hour24_length_x, tmp_hour24_length_y,
        _hands_width_hour24, _hands_line_cap, _color_wall_clock.hands.hour24)


    --
    -- Clock hands -- minutes
    --

    local tmp_mins_length_x = _center_x + _hands_radius_mins * math.sin(tmp_mins_arc)
    local tmp_mins_length_y = _center_y - _hands_radius_mins * math.cos(tmp_mins_arc)
    drawing_line(_context,
        _center_x, _center_y, tmp_mins_length_x, tmp_mins_length_y,
        _hands_width_mins, _hands_line_cap, _color_wall_clock.hands.mins)


    --
    -- Clock hands -- seconds
    --

    if true == _hands_display_secs then
        local tmp_secs_length_x = _center_x + _hands_radius_secs * math.sin(tmp_secs_arc)
        local tmp_secs_length_y = _center_y - _hands_radius_secs * math.cos(tmp_secs_arc)
        drawing_line(_context,
            _center_x, _center_y, tmp_secs_length_x, tmp_secs_length_y,
            _hands_width_secs, _hands_line_cap, _color_wall_clock.hands.secs)
    end
end
