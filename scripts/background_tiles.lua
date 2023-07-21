--
-- Background (Tiles)
--

function drawing_background_tiles(_context, _const,
    _center_x, _center_y,
    _today_width_body, _today_width_margin,
    _color_background)


    -- Top, left

    drawing_square(_context,
        _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_LEFT,
        _const.CPU_LOAD_AVERAGE.LENGTH, _const.LINE_LENGTH.HEIGHT.TOP_LEFT,
        _color_background.top_left)

    -- Bottom, left

    local tmp = _today_width_body + _today_width_margin
    drawing_square(_context,
        _center_x - tmp, _center_y,
        tmp, _const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT,
        _color_background.bottom_left)

    -- Top, right

    drawing_square(_context,
        _center_x, _center_y - _const.LINE_LENGTH.HEIGHT.TOP_RIGHT,
        _const.LINE_LENGTH.WIDTH.TOP_RIGHT, _const.LINE_LENGTH.HEIGHT.TOP_RIGHT,
        _color_background.top_right)

    -- Bottom, right

    drawing_square(_context,
        _center_x, _center_y,
        _const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT, _const.LINE_LENGTH.HEIGHT.BOTTOM_RIGHT,
        _color_background.bottom_right)
end
