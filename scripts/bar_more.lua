--
-- Bar more
--

function drawing_bar_more(_context, _conky_parse_updates,
    -- bar
    _bar_position_x, _bar_position_y,
    _bar_gap_y,
    _bar_line_width, _bar_value_width,
    _conky_parse_cpu0,
    _conky_parse_memperc,
    _conky_parse_fs_free_perc,
    _usage_limit,
    -- caption
    _caption_position_x, _caption_position_y,
    _caption_align, _caption_font_face, _caption_font_size,
    -- color
    _color_bar)


    if 4 > _conky_parse_updates then
        return
    end


    -- draw bar

    for ii = 1, 3 do
        local tmp_length = 0
        local tmp_color = _color_bar.normal

        if 1 == ii then
            -- CPU load average
            tmp_length = tonumber(_conky_parse_cpu0) / 100 * _bar_value_width
            tmp_color = (_usage_limit.CPU < tonumber(_conky_parse_cpu0)) and _color_bar.high or _color_bar.normal

        elseif 2 == ii then
            -- Memory usage
            tmp_length = tonumber(_conky_parse_memperc) / 100 * _bar_value_width
            tmp_color = (_usage_limit.MEMORY < tonumber(_conky_parse_memperc)) and _color_bar.high or _color_bar.normal

        elseif 3 == ii then
            -- Storage usage
            tmp_length = (100 - tonumber(_conky_parse_fs_free_perc)) / 100 * _bar_value_width
        end

        drawing_line(_context,
            _bar_position_x, _bar_position_y + (_bar_gap_y * ii),
            _bar_position_x + tmp_length, _bar_position_y + (_bar_gap_y * ii),
            _bar_line_width, CAIRO_LINE_CAP_BUTT, tmp_color)
    end

    -- draw caption

    drawing_text(_context, _caption_align,
        _caption_position_x, _caption_position_y, _caption_font_size,
        string.format('CPU0:%s%%, Mem:%s%%, Disk:%s%%',
            _conky_parse_cpu0,
            _conky_parse_memperc,
            100 - _conky_parse_fs_free_perc
        ),
        _caption_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD, _color_bar.caption)
end
