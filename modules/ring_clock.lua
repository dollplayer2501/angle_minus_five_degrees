--
-- Ring Clock - Month, day, hour 24, hour 12, days
--

function drawing_ring_clock(_context,
    -- position
    _ring_position_x, _ring_position_y,
    -- ring
    _ring_angle_start, _ring_angle_end,
    _ring_radius, _ring_width, _ring_gap,
    _enabled_secs,
    -- caption
    _caption_position_x, _caption_position_y, _caption_increment_y,
    _caption_align, _caption_font_face, _caption_font_size, _caption_font_weight,
    -- color
    _color_ring)


    -- draw ring

    local _get_second = function(_angle, _start)
        return (tonumber(os.date('%S')) / 60 * _angle) + _start
    end

    local _get_minites = function(_angle, _start)
        return (tonumber(os.date('%M')) / 60 * _angle) + _start
    end

    local _get_hour12 = function(_angle, _start)
        return (tonumber(os.date('%I')) / 12 * _angle) + _start
    end

    local _get_hour24 = function(_angle, _start)
        return (tonumber(os.date('%H')) / 24 * _angle) + _start
    end

    local _get_month = function(_angle, _start)
        return (tonumber(os.date('%m')) / 12 * _angle) + _start
    end

    local _get_days = function(_angle, _start)
        local tmp_year = tonumber(os.date('%G'))
        local tmp_today = tonumber(os.date('%d'))
        local tmp_month = tonumber(os.date('%m'))

        local tmp_mar_times = os.time({ year = tmp_year, month = 03, day = 01, hour = 00, min = 00, sec = 00 })
        local tmp_feb_times = os.time({ year = tmp_year, month = 02, day = 01, hour = 00, min = 00, sec = 00 })
        local tmp_feb_days = (os.difftime(tmp_mar_times, tmp_feb_times) / (24 * 60 * 60))
        local tmp_month_days = { 31, tmp_feb_days, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
        local tmp_days = tmp_month_days[tonumber(tmp_month)]

        return (tmp_today / tmp_days * _angle) + _start
    end


    local tmp_end = (true == _enabled_secs) and 5 or 4
    for ii = 0, tmp_end do
        local tmp_radius = _ring_radius + (_ring_width * ii) + (_ring_gap * ii)
        local tmp_ring_angle = _ring_angle_end - _ring_angle_start
        local tmp_fg_end_angle = 0

        if 0 == ii then
            tmp_fg_end_angle = (true == _enabled_secs)
                                and _get_second(tmp_ring_angle, _ring_angle_start)
                                or _get_minites(tmp_ring_angle, _ring_angle_start)
        elseif 1 == ii then
            tmp_fg_end_angle = (true == _enabled_secs)
                                and _get_minites(tmp_ring_angle, _ring_angle_start)
                                or _get_hour12(tmp_ring_angle, _ring_angle_start)
        elseif 2 == ii then
            tmp_fg_end_angle = (true == _enabled_secs)
                                and _get_hour12(tmp_ring_angle, _ring_angle_start)
                                or _get_hour24(tmp_ring_angle, _ring_angle_start)
        elseif 3 == ii then
            tmp_fg_end_angle = (true == _enabled_secs)
                                and _get_hour24(tmp_ring_angle, _ring_angle_start)
                                or _get_days(tmp_ring_angle, _ring_angle_start)
        elseif 4 == ii then
            tmp_fg_end_angle = (true == _enabled_secs)
                                and _get_days(tmp_ring_angle, _ring_angle_start)
                                or _get_month(tmp_ring_angle, _ring_angle_start)
        elseif 5 == ii then
            tmp_fg_end_angle = _get_month(tmp_ring_angle, _ring_angle_start)
        end

        -- draw foreground
        drawing_ring(_context, _ring_position_x, _ring_position_y, tmp_radius,
            changing_angle_to_radian(_ring_angle_start), changing_angle_to_radian(tmp_fg_end_angle),
            _ring_width, CAIRO_LINE_CAP_BUTT, _color_ring.fg_normal)

        -- draw background
        drawing_ring(_context, _ring_position_x, _ring_position_y, tmp_radius,
            changing_angle_to_radian(tmp_fg_end_angle), changing_angle_to_radian(_ring_angle_end),
            _ring_width, CAIRO_LINE_CAP_BUTT, _color_ring.bg)
    end

    -- draw caption

    local tmp_text = (true == _enabled_secs)
        and { 'Seconds', 'Minutes', 'Hours 12', 'Hours 24', 'Days', 'Months', }
        or { 'Minutes', 'Hours 12', 'Hours 24', 'Days', 'Months', }

    for ii = 0, #tmp_text do
        local tmp_positon_y = _caption_position_y + (_caption_increment_y * ii)

        drawing_text(_context, _caption_align, _caption_position_x, tmp_positon_y, _caption_font_size,
            tmp_text[ii + 1],
            _caption_font_face, CAIRO_FONT_SLANT_NORMAL, _caption_font_weight, _color_ring.caption)
    end
end
