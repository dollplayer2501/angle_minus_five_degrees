--
-- CPU Load Average Ring
--

function drawing_ring_cpu(_context, _conky_parse_updates,
    _ring_center_x, _ring_center_y,
    -- ring
    _ring_angle_start, _ring_angle_end,
    _ring_radius, _ring_width, _ring_gap,
    _ring_cpu_usage_limit,
    -- caption
    _caption_start_x, _caption_start_y, _caption_increment_y,
    _caption_align, _caption_font_face, _caption_font_size,
    -- values
    _conky_parse_cpu,
    -- color
    _color_ring)


    if 4 > _conky_parse_updates then
        return
    end


    -- draw ring

    for ii = 0, 3 do
        local tmp_radius = _ring_radius + (_ring_width * ii) + (_ring_gap * ii)
        local tmp_usage = _conky_parse_cpu['cpu' .. (ii + 1)]
        local tmp_fg_end_angle = ((_ring_angle_end - _ring_angle_start) * tmp_usage / 100) + _ring_angle_start

        -- ring foreground usage
        local tmp_color_fg = (_ring_cpu_usage_limit < tmp_usage) and _color_ring.fg_high or _color_ring.fg_normal

        -- ring foreground
        drawing_ring(_context, _ring_center_x, _ring_center_y, tmp_radius,
            changing_angle_to_radian(_ring_angle_start), changing_angle_to_radian(tmp_fg_end_angle),
            _ring_width, CAIRO_LINE_CAP_BUTT, tmp_color_fg)

        -- ring background
        drawing_ring(_context, _ring_center_x, _ring_center_y, tmp_radius,
            changing_angle_to_radian(tmp_fg_end_angle), changing_angle_to_radian(_ring_angle_end),
            _ring_width, CAIRO_LINE_CAP_BUTT, _color_ring.bg)
    end

    -- draw caption

    for ii = 0, 3 do
        local tmp_positon_y = _caption_start_y - (_caption_increment_y * ii)
        local tmp_cpu_number = ii + 1
        local tmp_usage = _conky_parse_cpu['cpu' .. tmp_cpu_number]

        drawing_text(_context, _caption_align, _caption_start_x, tmp_positon_y, _caption_font_size,
            string.format(
                'CPU%s: %s%%',
                tmp_cpu_number, _conky_parse_cpu['cpu' .. tmp_cpu_number]
            ),
            _caption_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_ring.caption)
    end
end
