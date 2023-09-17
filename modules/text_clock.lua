--
-- Clock Text
--

function drawing_text_clock(_context, _conky_parse_updates, _config,
    -- position
    _position_x, _position_y,
    -- hours
    _hour_adjust_x, _hour_adjust_y,
    _hour_font_align, _hour_font_size, _hour_font_face,
    -- am/pm when 12 hour system is in effect
    _am_pm_adjust_x, _am_pm_adjust_y,
    _am_pm_font_align, _am_pm_font_size, _am_pm_font_face,
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
    -- etc
    _display_24_hour,
    _display_hour12_japanese_style,
    _suppression_hour_zero,
    -- color
    _color_text_clock)


    --
    -- delimiter ':' blinks
    --

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


    --
    -- Hours ... 12 or 24
    --

    local tmp_hour = tostring(os.date('%H'))
    if true ~= _display_24_hour then
        tmp_hour = tostring(os.date('%I'))
        if true == _display_hour12_japanese_style and '12' == tmp_hour then
            tmp_hour = '00'
        end
        if true == _suppression_hour_zero then
            tmp_hour = tostring(tonumber(tmp_hour))
        end
    end
    drawing_text(_context, _hour_font_align,
        _position_x + _hour_adjust_x, _position_y + _hour_adjust_y, _hour_font_size,
        tmp_hour,
        _hour_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.hour)


    --
    -- AM/PM
    --

    if true ~= _display_24_hour then
        drawing_text(_context, _am_pm_font_align,
            _position_x + _am_pm_adjust_x, _position_y + _am_pm_adjust_y, _am_pm_font_size,
            os.date('%p'),
            _am_pm_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.am_pm)
    end


    --
    -- Delimiter
    --

    drawing_text(_context, _delimiter_font_align,
        _position_x + _delimiter_adjust_x, _position_y + _delimiter_adjust_y, _delimiter_font_size,
        ':',
        _delimiter_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, tmp_color)


    --
    -- Seconds
    --

    if true == _display_secs then
        drawing_text(_context, _sec_font_align,
            _position_x + _sec_adjust_x, _position_y + _sec_adjust_y, _sec_font_size,
            tostring(os.date('%S')),
            _sec_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.sec)
    end


    --
    -- Minutes
    --

    drawing_text(_context, _min_font_align,
        _position_x + _min_adjust_x, _position_y + _min_adjust_y, _min_font_size,
        tostring(os.date('%M')),
        _min_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_clock.mins)
end
