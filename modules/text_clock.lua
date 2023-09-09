--
-- Clock Text
--

function drawing_text_clock(_context, _conky_parse_updates,
    -- position
    _position_x, _position_y,
    -- hours
    _hour_adjust_x, _hour_adjust_y,
    _hour_font_align, _hour_font_size, _hour_font_face,
    -- delimiter
    _delimiter_adjust_x, _delimiter_adjust_y,
    _delimiter_font_align, _delimiter_font_size, _delimiter_font_face,
    -- minutes
    _min_adjust_x, _min_adjust_y,
    _min_font_align, _min_font_size, _min_font_face,
    -- seconds
    _display_secs,
    _sec_adjust_x, _sec_adjust_y,
    _sec_font_align, _sec_font_size, _sec_font_face,
    -- color
    _color_text_clock)


    -- delimiter ':' blinks
    local tmp_color = _color_text_clock.delimiter_1
    if 3 > _conky_parse_updates then
        return
    elseif 3 == _conky_parse_updates then
        flg_text_blink = false -- this is not local
    else
        if false == flg_text_blink then
            flg_text_blink = true
            tmp_color = _color_text_clock.delimiter_2
        else
            flg_text_blink = false
        end
    end

    -- Hours

    drawing_text(_context, _hour_font_align,
        _position_x + _hour_adjust_x, _position_y + _hour_adjust_y, _hour_font_size,
        tostring(os.date('%H')),
        _hour_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.hour)

    -- Delimiter

    drawing_text(_context, _delimiter_font_align,
        _position_x + _delimiter_adjust_x, _position_y + _delimiter_adjust_y, _delimiter_font_size,
        ':',
        _delimiter_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, tmp_color)

    -- Seconds (not Minutes, becase z-order)

    if true == _display_secs then
        drawing_text(_context, _sec_font_align,
            _position_x + _sec_adjust_x, _position_y + _sec_adjust_y, _sec_font_size,
            tostring(os.date('%S')),
            _sec_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.sec)
    end

    -- Minutes

    drawing_text(_context, _min_font_align,
        _position_x + _min_adjust_x, _position_y + _min_adjust_y, _min_font_size,
        tostring(os.date('%M')),
        _min_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.mins)
end
