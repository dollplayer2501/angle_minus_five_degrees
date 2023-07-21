--
--
--

--
--
--
function setting_hex_to_rgba(_hex, _alpha)

    local color_red, color_green, color_blue = _hex:match('#?(..)(..)(..)')

    color_red, color_green, color_blue =
        tonumber(color_red, 16) / 255,
        tonumber(color_green, 16) / 255,
        tonumber(color_blue, 16) / 255

    color_red, color_green, color_blue =
        math.floor(color_red * 100) / 100,
        math.floor(color_green * 100) / 100,
        math.floor(color_blue * 100) / 100

    if _alpha == nil then
        return {
            red = color_red,
            green = color_green,
            blue = color_blue,
        }
    end

    return {
        red = color_red,
        green = color_green,
        blue = color_blue,
        alpha = _alpha,
    }
end



--
--
--
function changing_angle_to_radian(_angle)
    return (_angle - 90) * (math.pi / 180)
end



--
--
--
function drawing_line(_context,
    _start_x, _start_y, _end_x, _end_y,
    _width, _line_cap,
    _color)

    cairo_move_to(_context, _start_x, _start_y)
    cairo_line_to(_context, _end_x, _end_y)
    cairo_set_line_width(_context, _width)
    cairo_set_line_cap(_context, _line_cap)
    cairo_set_source_rgba(_context, _color.red, _color.green, _color.blue, _color.alpha)
    cairo_stroke(_context)
end



--
--
--
function _setting_text_extents(_context, _extents,
        _font_size,
        _text, _font_face, _font_slant, _font_weight)

    tolua.takeownership(_extents)

    cairo_select_font_face(_context, _font_face, _font_slant, _font_weight);
    cairo_set_font_size(_context, _font_size)
    cairo_text_extents(_context, _text, _extents)
end



--
--
--
function getting_text_width(_context,
    _font_size,
    _text, _font_face, _font_slant, _font_weight)

    local extents = cairo_text_extents_t:create()

    _setting_text_extents(_context, extents,
        _font_size,
        _text, _font_face, _font_slant, _font_weight)

    return extents.width + extents.x_bearing
end



--
--
--
function drawing_text(_context,
    _align,
    _pos_x, _pos_y, _font_size,
    _text, _font_face, _font_slant, _font_weight,
    _color)

    local const = get_const()
    local extents = cairo_text_extents_t:create()

    _setting_text_extents(_context, extents,
        _font_size,
        _text, _font_face, _font_slant, _font_weight)

    cairo_move_to(_context,
        (const.ALIGN_RIGHT == _align) and (_pos_x - extents.width - extents.x_bearing) or _pos_x,
        _pos_y)

    cairo_set_source_rgba(_context, _color.red, _color.green, _color.blue, _color.alpha)
    cairo_show_text(_context, _text)
    cairo_new_path(_context)
end



--
--
--
function display_text_and_acquisition_text_width(_context,
    _align,
    _pos_x, _pos_y, _font_size,
    _text, _font_face, _font_slant, _font_weight,
    _color)

    drawing_text(_context,
        _align,
        _pos_x, _pos_y, _font_size,
        _text, _font_face, _font_slant, _font_weight,
        _color)

    return getting_text_width(_context,
        _font_size,
        _text, _font_face, _font_slant, _font_weight)
end



--
--
--
function drawing_ring(_context,
    _center_x, _center_y, _radius, _start_angle, _end_angle,
    _width, _line_cap,
    _color)

    cairo_arc(_context, _center_x, _center_y, _radius, _start_angle, _end_angle)
    cairo_set_line_width(_context, _width)
    cairo_set_line_cap(_context, _line_cap)
    cairo_set_source_rgba(_context, _color.red, _color.green, _color.blue, _color.alpha)
    cairo_stroke(_context)
end



--
--
--
function drawing_square(_context,
    _top_left_x, _top_left_y, _rec_width, _rec_height,
    _fill_color)

    cairo_rectangle(_context, _top_left_x, _top_left_y, _rec_width, _rec_height)
    cairo_set_line_width(_context, 0)
    cairo_set_source_rgba(_context, _fill_color.red, _fill_color.green, _fill_color.blue, _fill_color.alpha)
    cairo_fill_preserve(_context)
    cairo_stroke(_context)
end
