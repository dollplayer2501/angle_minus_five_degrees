--
-- Time(HH:MM) -- Text
--

function drawing_text_clock(_context, _conky_parse_updates,
    _position_x, _position_y,
    -- hour
    _hour_position_x_adjust, _hour_position_y_adjust, _hour_font_size, _hour_font_align, _hour_font_face,
    -- delimiter
    _delimiter_position_x_adjust, _delimiter_position_y_adjust, _delimiter_font_size, _delimiter_font_align, _delimiter_font_face,
    -- minutes
    _min_position_x_adjust, _min_position_y_adjust, _min_font_size, _min_font_align, _min_font_face,
    -- color
    _color_text_time)


    -- delimiter ':' blinks
    local tmp_color = _color_text_time.delimiter_1
    if 3 >  _conky_parse_updates then
        return
    elseif 3 == _conky_parse_updates then
        flg_text_blink = false -- this is not local
    else
        if false == flg_text_blink then
            flg_text_blink = true
            tmp_color = _color_text_time.delimiter_2
        else
            flg_text_blink = false
        end
    end

    -- Time - Hour
    drawing_text(_context, _hour_font_align,
        _position_x + _hour_position_x_adjust, _position_y + _hour_position_y_adjust, _hour_font_size,
        os.date('%H'),
        _hour_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_time.hour)

    -- Time - Delimiter
    drawing_text(_context, _delimiter_font_align,
        _position_x + _delimiter_position_x_adjust, _position_y + _delimiter_position_y_adjust, _delimiter_font_size,
        ':',
        _delimiter_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, tmp_color)

    -- Time - Min
    drawing_text(_context, _min_font_align,
        _position_x + _min_position_x_adjust, _position_y + _min_position_y_adjust, _min_font_size,
        os.date('%M'),
        _min_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_text_time.mins)
end
