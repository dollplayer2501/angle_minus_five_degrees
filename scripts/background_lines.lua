--
-- Background (Lines)
--

function drawing_background_lines(_context, _const,
    _center_x, _center_y,
    _today_width_body, _today_width_margin,
    _line_cap,
    _color_line, _color_debug)


    local today_width = _today_width_body + _today_width_margin


    --
    -- Main - Holizontal - Left to right
    --
    drawing_line(_context,
        _center_x - today_width - _const.LINE_LENGTH.ADDITION.LARGE, _center_y,
        _center_x + _const.LINE_LENGTH.CENTER_TO.RIGHT + _const.LINE_LENGTH.ADDITION.LARGE, _center_y,
        _const.LINE_WIDTH, _line_cap, _color_line)

    --
    -- Main - Vertical - Top to bottom
    --
    drawing_line(_context,
        _center_x, _center_y - _const.LINE_LENGTH.CENTER_TO.TOP,
        _center_x, _center_y + _const.LINE_LENGTH.CENTER_TO.BOTTOM,
        _const.LINE_WIDTH, _line_cap, _color_line)

    --
    -- Top, Left
    --

    -- Top, Left - Vertical
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y - _const.LINE_LENGTH.CENTER_TO.TOP,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y + _const.LINE_LENGTH.ADDITION.NORMAL,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Top, Left - Holizontal -- indicator, top
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH - _const.LINE_LENGTH.ADDITION.LARGE, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH + _const.LINE_LENGTH.ADDITION.LARGE, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Top, Left - Holizontal -- indicator, middle
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH - _const.LINE_LENGTH.ADDITION.NORMAL, _center_y - _const.CPU_LOAD_AVERAGE.HEIGHT,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH + _const.LINE_LENGTH.ADDITION.LARGE, _center_y - _const.CPU_LOAD_AVERAGE.HEIGHT,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Top, Left - Holizontal -- indicator, bottom
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH - _const.LINE_LENGTH.ADDITION.SMALL, _center_y - (_const.CPU_LOAD_AVERAGE.HEIGHT / 2),
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH + _const.LINE_LENGTH.ADDITION.NORMAL, _center_y - (_const.CPU_LOAD_AVERAGE.HEIGHT / 2),
        _const.LINE_WIDTH, _line_cap, _color_line)

    --
    -- Top, Right
    --

    -- Top, Right -- Vertical
    drawing_line(_context,
        _center_x + _const.LINE_LENGTH.CENTER_TO.RIGHT, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT - _const.LINE_LENGTH.ADDITION.LARGE,
        _center_x + _const.LINE_LENGTH.CENTER_TO.RIGHT, _center_y + _const.LINE_LENGTH.ADDITION.LARGE,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Top, Right -- Holizontal
    drawing_line(_context,
        _center_x - _const.LINE_LENGTH.ADDITION.NORMAL, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT,
        _center_x + _const.LINE_LENGTH.CENTER_TO.RIGHT + _const.LINE_LENGTH.ADDITION.LARGE, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Top, Right -- Vertical -- indicator, right
    drawing_line(_context,
        _center_x + _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT - _const.LINE_LENGTH.ADDITION.LARGE,
        _center_x + _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT + _const.LINE_LENGTH.ADDITION.LARGE,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Top, Right -- Vertical -- indicator, middle/left
    drawing_line(_context,
        _center_x + (_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT / 2), _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT - _const.LINE_LENGTH.ADDITION.SMALL,
        _center_x + (_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT / 2), _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT + _const.LINE_LENGTH.ADDITION.NORMAL,
        _const.LINE_WIDTH, _line_cap, _color_line)

    --
    -- Bottom, Right
    --

    -- Bottom, Right -- Vertical
    drawing_line(_context,
        _center_x + _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT, _center_y - _const.LINE_LENGTH.ADDITION.NORMAL,
        _center_x + _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT, _center_y + _const.LINE_LENGTH.CENTER_TO.BOTTOM,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Bottom, Right -- Holizontal -- indicator
    drawing_line(_context,
        _center_x + _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT - _const.LINE_LENGTH.ADDITION.LARGE, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT,
        _center_x + _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT + _const.LINE_LENGTH.ADDITION.LARGE, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT,
        _const.LINE_WIDTH, _line_cap, _color_line)

    --
    -- Bottom, Left
    --

    -- Bottom, Left -- Holizontal
    drawing_line(_context,
        _center_x - today_width - _const.LINE_LENGTH.ADDITION.LARGE, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT,
        _center_x + _const.LINE_LENGTH.ADDITION.NORMAL, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Bottom, Left -- Vertical
    drawing_line(_context,
        _center_x - today_width, _center_y - _const.LINE_LENGTH.ADDITION.LARGE,
        _center_x - today_width, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT + _const.LINE_LENGTH.ADDITION.LARGE,
        _const.LINE_WIDTH, _line_cap, _color_line)

    -- Bottom, Left -- Vertical -- indicator
    drawing_line(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT - _const.LINE_LENGTH.ADDITION.LARGE,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y + _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT + _const.LINE_LENGTH.ADDITION.LARGE,
        _const.LINE_WIDTH, _line_cap, _color_line)
end
