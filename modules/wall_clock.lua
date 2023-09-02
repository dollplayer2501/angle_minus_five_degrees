--
-- Wall Clock
--

function drawing_wall_clock(_context,
    _center_x, _center_y,
    -- 12 hour
    _radius_hour12, _width_hour12,
    -- 24 hour
    _radius_hour24, _width_hour24,
    -- minutes
    _radius_mins, _width_mins,
    -- seconds
    _radius_secs, _width_secs, _display_secs,
    -- etc
    _line_cap, _color_wall_clock)


    local tmp_secs_sys = tonumber(os.date('%S'))
    local tmp_mins_sys = tonumber(os.date('%M'))
    local tmp_hours12_sys = tonumber(os.date('%I'))
    local tmp_hours24_sys = tonumber(os.date('%H'))

    local tmp_secs_arc = (2 * math.pi / 60) * tmp_secs_sys
    local tmp_mins_arc = (2 * math.pi / 60) * tmp_mins_sys + tmp_secs_arc / 60
    local tmp_hours12_arc = (2 * math.pi / 12) * tmp_hours12_sys + tmp_mins_arc / 12
    local tmp_hours24_arc = (2 * math.pi / 24) * tmp_hours24_sys + tmp_mins_arc / 24


    -- 12 hour

    local tmp_hour12_length_x = _center_x + _radius_hour12 * math.sin(tmp_hours12_arc)
    local tmp_hour12_length_y = _center_y - _radius_hour12 * math.cos(tmp_hours12_arc)

    drawing_line(_context, _center_x, _center_y, tmp_hour12_length_x, tmp_hour12_length_y,
        _width_hour12, _line_cap, _color_wall_clock.hour12)

    -- 24 hour

    local tmp_hour24_length_x = _center_x + _radius_hour24 * math.sin(tmp_hours24_arc)
    local tmp_hour24_length_y = _center_y - _radius_hour24 * math.cos(tmp_hours24_arc)

    drawing_line(_context, _center_x, _center_y, tmp_hour24_length_x, tmp_hour24_length_y,
        _width_hour24, _line_cap, _color_wall_clock.hour24)

    -- minutes

    local tmp_mins_length_x = _center_x + _radius_mins * math.sin(tmp_mins_arc)
    local tmp_mins_length_y = _center_y - _radius_mins * math.cos(tmp_mins_arc)

    drawing_line(_context, _center_x, _center_y, tmp_mins_length_x, tmp_mins_length_y,
        _width_mins, _line_cap, _color_wall_clock.mins)

    -- seconds

    if true == _display_secs then
        local tmp_secs_length_x = _center_x + _radius_secs * math.sin(tmp_secs_arc)
        local tmp_secs_length_y = _center_y - _radius_secs * math.cos(tmp_secs_arc)

        drawing_line(_context, _center_x, _center_y, tmp_secs_length_x, tmp_secs_length_y,
            _width_secs, _line_cap, _color_wall_clock.secs)
    end
end
