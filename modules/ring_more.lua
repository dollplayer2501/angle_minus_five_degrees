--
-- More Ring
--

function drawing_ring_more(_context, _conky_parse_updates,
    -- values
    _conky_parse_memperc,
    _conky_parse_temps,
    _usage_limit_memory,
    -- position
    _ring_center_x, _ring_center_y,
    -- ring
    _ring_angle_start, _ring_angle_end,
    _ring_radius, _ring_width, _ring_gap,
    -- caption
    _caption_position_x, _caption_position_y, _caption_increment_y,
    _caption_align, _caption_font_face, _caption_font_size, _caption_font_weight,
    --color
    _color_ring)


    if 4 > _conky_parse_updates then
        return
    end


    -- draw ring

    for ii = 0, 1 do
        local tmp_radius = _ring_radius + (_ring_width * ii) + (_ring_gap * ii)
        local tmp_ring_angle = _ring_angle_end - _ring_angle_start
        local tmp_fg_end_angle = _ring_angle_start
        local tmp_fg_color = _color_ring.fg_normal

        if 0 == ii then
            -- 0: memperc
            tmp_fg_end_angle = (tonumber(_conky_parse_memperc) / 100 * tmp_ring_angle) + _ring_angle_start
            tmp_fg_color = _usage_limit_memory < tonumber(_conky_parse_memperc) and _color_ring.fg_high or _color_ring.fg_normal
        elseif 1 == ii then
            -- 1: temperature
            tmp_fg_end_angle = (tonumber(_conky_parse_temps) / 100 * tmp_ring_angle) + _ring_angle_start
        end

        -- ring foreground
        drawing_ring(_context, _ring_center_x, _ring_center_y, tmp_radius,
            changing_angle_to_radian(_ring_angle_start), changing_angle_to_radian(tmp_fg_end_angle),
            _ring_width, CAIRO_LINE_CAP_BUTT, tmp_fg_color)

        -- ring background
        drawing_ring(_context, _ring_center_x, _ring_center_y, tmp_radius,
            changing_angle_to_radian(tmp_fg_end_angle), changing_angle_to_radian(_ring_angle_end),
            _ring_width, CAIRO_LINE_CAP_BUTT, _color_ring.bg)
    end

    -- draw caption

    for ii = 0, 1 do
        local tmp_positon_y = _caption_position_y - (_caption_increment_y * ii)

        if 0 == ii then
            drawing_text(_context, _caption_align, _caption_position_x, tmp_positon_y, _caption_font_size,
                string.format(
                    'Mem: %s%%',
                        _conky_parse_memperc
                ),
                _caption_font_face, CAIRO_FONT_SLANT_NORMAL, _caption_font_weight, _color_ring.caption)
        elseif 1 == ii then
            drawing_text(_context, _caption_align, _caption_position_x, tmp_positon_y, _caption_font_size,
                string.format(
                    'Temp: %sc',
                        _conky_parse_temps
                ),
                _caption_font_face, CAIRO_FONT_SLANT_NORMAL, _caption_font_weight, _color_ring.caption)
        end
    end
end
