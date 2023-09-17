--
-- Text Top
--

function drawing_text_top(_context, _conky_parse_updates, _const,
    -- values
    _conky_parse_top,
    -- Left side, ${top name n}
    _position_x_name, _position_y_name, _adjust_x_name,
    -- Right size, ${top cpu n}
    _position_x_cpu, _position_y_cpu, _adjust_x_cpu,
    -- location etc
    _adjust_y, _increment_y,
    -- font
    _font_face, _font_size, _font_weight,
    -- color
    _color_text_top)


    if 2 > _conky_parse_updates then
        return
    end


    for ii = 0, 5 do

        drawing_text(_context, _const.ALIGN.LEFT,
            _position_x_name + _adjust_x_name,
            _position_y_name + _adjust_y + (_increment_y * ii),
            _font_size,
            _conky_parse_top['name' .. (ii + 1)],
            _font_face, CAIRO_FONT_SLANT_NORMAL, _font_weight, _color_text_top['fg_' .. (ii + 1)])

        drawing_text(_context, _const.ALIGN.RIGHT,
            _position_x_cpu + _adjust_x_cpu,
            _position_y_cpu + _adjust_y + (_increment_y * ii),
            _font_size,
            string.format('%s%%',
                _conky_parse_top['cpu' .. (ii + 1)]
            ),
            _font_face, CAIRO_FONT_SLANT_NORMAL, _font_weight, _color_text_top['fg_' .. (ii + 1)])
    end
end
