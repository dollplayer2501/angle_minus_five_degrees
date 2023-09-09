--
-- Background (Tiles)
--

function drawing_background_tiles(_context, _const,
    -- position
    _center_x, _center_y,
    -- left bottom width
    _today_width_body, _today_width_margin,
    -- gradient
    _display_gradient, _rect_step,
    -- color
    _color_background)


    --
    -- Top, left
    --
    if true == _display_gradient then
        drawing_gradient_square(_context,
            _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y - _const.BACKGROUND.LINES.LENGTH.CENTER_TO.TOP,
            _const.CPU_LOAD_AVERAGE.LENGTH, _const.BACKGROUND.LINES.LENGTH.CENTER_TO.TOP,
            _const.DIRECTION.VERTICAL, _rect_step,
            _color_background.top_left.gradient)
    else
        drawing_square(_context,
            _center_x - _const.CPU_LOAD_AVERAGE.LENGTH, _center_y - _const.BACKGROUND.LINES.LENGTH.CENTER_TO.TOP,
            _const.CPU_LOAD_AVERAGE.LENGTH, _const.BACKGROUND_LINE.LENGTH.CENTER_TO.TOP,
            _color_background.top_left.one)
    end

    --
    -- Bottom, left
    --
    local tmp = _today_width_body + _today_width_margin

    if true == _display_gradient then
        drawing_gradient_square(_context,
            _center_x - tmp, _center_y,
            tmp, _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
            _const.DIRECTION.HORIZONTAL, _rect_step,
            _color_background.bottom_left.gradient)
    else
        drawing_square(_context,
            _center_x - tmp, _center_y,
            tmp, _const.BACKGROUND.LINES.LENGTH.HEIGHT.BOTTOM_LEFT,
            _color_background.bottom_left.one)
    end

    --
    -- Top, right
    --
    if true == _display_gradient then
        drawing_gradient_square(_context,
            _center_x, _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
            _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT, _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
            _const.DIRECTION.HORIZONTAL, _rect_step,
            _color_background.top_right.gradient)
    else
        drawing_square(_context,
            _center_x, _center_y - _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
            _const.BACKGROUND.LINES.LENGTH.CENTER_TO.RIGHT, _const.BACKGROUND.LINES.LENGTH.HEIGHT.TOP_RIGHT,
            _color_background.top_right.one)
    end

    --
    -- Bottom, right
    --
    if true == _display_gradient then
        drawing_gradient_square(_context,
            _center_x, _center_y,
            _const.BACKGROUND.LINES.LENGTH.WIDTH.BOTTOM_RIGHT, _const.BACKGROUND.LINES.LENGTH.CENTER_TO.BOTTOM,
            _const.DIRECTION.VERTICAL, _rect_step,
            _color_background.bottom_right.gradient)
    else
        drawing_square(_context,
            _center_x, _center_y,
            _const.BACKGROUND_LINE.LENGTH.WIDTH.BOTTOM_RIGHT, _const.BACKGROUND.LINES.LENGTH.CENTER_TO.BOTTOM,
            _color_background.bottom_right.one)
    end
end
