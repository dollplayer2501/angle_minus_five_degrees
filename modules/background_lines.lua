--
-- Background (Lines)
--

function drawing_background_lines(_context, _conky_parse_updates, _const,
    -- position
    _center_x, _center_y,
    -- left bottom width
    _today_width_body, _today_width_margin,
    -- top right gimmick
    _display_top_right_gimmick, _highlight_length,
    -- etc
    _line_cap,
    -- color
    _color_line, _color_debug)


    local today_width = _today_width_body + _today_width_margin


    --
    -- Main - Holizontal - Left to right
    --
    drawing_line(_context,
        _center_x - today_width - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y,
        _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y,
        _const.BACKGROUND.LINES.WIDTH.BOLD, _line_cap, _color_line.normal)

    --
    -- Main - Vertical - Top to bottom
    --
    drawing_line(_context,
        _center_x,
        _center_y - _const.BACKGROUND.LINES.LENGTH.CENTER_TO.TOP,
        _center_x,
        _center_y + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.BOTTOM,
        _const.BACKGROUND.LINES.WIDTH.BOLD, _line_cap, _color_line.normal)


    --
    -- Top, Left
    --

    -- Top, Left - Vertical
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH,
        _center_y - _const.BACKGROUND.LINES.LENGTH.CENTER_TO.TOP,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH,
        _center_y + _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Top, Left - Holizontal -- indicator, top
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Top, Left - Holizontal -- indicator, middle
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH - _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
        _center_y - _const.CPU_LOAD_AVERAGE.HEIGHT,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y - _const.CPU_LOAD_AVERAGE.HEIGHT,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Top, Left - Holizontal -- indicator, bottom
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH - _const.BACKGROUND.LINES.LENGTH.ADDITION.SMALL,
        _center_y - (_const.CPU_LOAD_AVERAGE.HEIGHT / 2),
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH + _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
        _center_y - (_const.CPU_LOAD_AVERAGE.HEIGHT / 2),
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)


    --
    -- Top, Right
    --

    -- Top, Right -- Holizontal
    drawing_line(_context,
        _center_x - _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
        _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
        _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Top, Right -- Vertical
    if true == _display_top_right_gimmick then

        local tmp_value = _conky_parse_updates % _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT
        -- The following is for speeding up the movement.
        -- local tmp_value = (_conky_parse_updates % (_const.LINE_LENGTH.HEIGHT.TOP_RIGHT / _highlight_length)) * _highlight_length

        -- Top, Right -- Vertical line 1/3 at upper
        drawing_line(_context,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT,
            _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT,
            _center_y - tmp_value - _highlight_length,
            _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

        -- Top, Right -- Vertical line 2/3 at highlight
        drawing_line(_context,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT, _center_y - tmp_value - _highlight_length,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT, _center_y - tmp_value + _highlight_length,
            _const.BACKGROUND.LINES.WIDTH.BOLDER, _line_cap, _color_line.high)

        -- Top, Right -- Vertical line 2/3 at lower
        drawing_line(_context,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT,
            _center_y - tmp_value + _highlight_length,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT,
            _center_y + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
            _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

        -- Top, Right -- Vertical -- indicator, right
        drawing_line(_context,
            _center_x + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,
            _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
            _center_x + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,
            _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
            _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

        -- Top, Right -- Vertical -- indicator, middle/left
        drawing_line(_context,
            _center_x + (_const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT / 2),
            _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT - _const.BACKGROUND.LINES.LENGTH.ADDITION.SMALL,
            _center_x + (_const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT / 2),
            _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT + _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
            _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)
    else

        -- Top, Right -- Vertical
        drawing_line(_context,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT,
            _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
            _center_x + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT,
            _center_y + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
            _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)
    end


    --
    -- Bottom, Right
    --

    -- Bottom, Right -- Vertical
    drawing_line(_context,
        _center_x + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,
        _center_y - _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
        _center_x + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT,
        _center_y + _const.BACKGROUND.LINES.LENGTH.CENTER_TO.BOTTOM,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Bottom, Right -- Holizontal -- indicator
    drawing_line(_context,
        _center_x + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
        _center_x + _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)


    --
    -- Bottom, Left
    --

    -- Bottom, Left -- Holizontal
    drawing_line(_context,
        _center_x - today_width - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
        _center_x + _const.BACKGROUND.LINES.LENGTH.ADDITION.NORMAL,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Bottom, Left -- Vertical
    drawing_line(_context,
        _center_x - today_width,
        _center_y - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_x - today_width,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)

    -- Bottom, Left -- Vertical -- indicator
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT - _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH,
        _center_y + _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT + _const.BACKGROUND.LINES.LENGTH.ADDITION.LARGE,
        _const.BACKGROUND.LINES.WIDTH.NORMAL, _line_cap, _color_line.normal)
end
