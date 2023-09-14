--
-- Debug lines
--

function drawing_debug_lines(_surface_create, _base_angle, _const, _color_debugging)

    local cr_debug0 = cairo_create(_surface_create)
    local cr_debug5 = cairo_create(_surface_create)

    cairo_rotate(cr_debug0, 0)             -- Normal
    cairo_rotate(cr_debug5, _base_angle)   -- -5 degree

    local tmp_objects = { cr_debug0, cr_debug5 }
    for ii = 1, 2 do

        -- Circle
        drawing_ring(tmp_objects[ii],
            _const.CENTER_POSITION.SCREEN.X, _const.CENTER_POSITION.SCREEN.Y,
            500, changing_angle_to_radian(0), changing_angle_to_radian(320), 1,
            CAIRO_LINE_CAP_BUTT, _color_debugging[ii])

        -- Holizental line
        drawing_line(tmp_objects[ii],
            _const.CENTER_POSITION.SCREEN.X - 200, _const.CENTER_POSITION.SCREEN.Y,
            _const.CENTER_POSITION.SCREEN.Y + 200, _const.CENTER_POSITION.SCREEN.Y,
            1, CAIRO_LINE_CAP_BUTT, _color_debugging[ii])

        -- Vertical line
        drawing_line(tmp_objects[ii],
            _const.CENTER_POSITION.SCREEN.X, _const.CENTER_POSITION.SCREEN.Y - 100,
            _const.CENTER_POSITION.SCREEN.X, _const.CENTER_POSITION.SCREEN.Y + 100,
            1, CAIRO_LINE_CAP_BUTT, _color_debugging[ii])
    end

    cairo_destroy(cr_debug0)
    cairo_destroy(cr_debug5)
end
