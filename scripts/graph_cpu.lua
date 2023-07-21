--
-- CPU Load Average Graph
--

function drawing_graph_cpu(_context, _conky_parse_updates,
    -- CPU load average
    _cpu_usage_value, _cpu_array_count, _cpu_usage_limit,
    -- graph
    _graprh_position_x, _graprh_position_y,
    _graph_width, _graph_height,
    -- caption
    _caption_position_align, _caption_start_x, _caption_start_y,
    _caption_font_face, _caption_font_size,
    -- color
    _color_graph)


    -- Set array of cpu load average

    if 4 > _conky_parse_updates then
        cpu_table_data = {}
        return
    end

    for ii = 1, _cpu_array_count do
        if nil == cpu_table_data[ii + 1] then
            cpu_table_data[ii + 1] = 0
        end
        cpu_table_data[ii] = cpu_table_data[ii + 1]
        if ii == _cpu_array_count then
            cpu_table_data[_cpu_array_count] = _cpu_usage_value
        end
    end

    -- draw graph

    for ii = 1, _cpu_array_count do
        local tmp_height_1 = (_graph_height / 100) * cpu_table_data[ii]
        local tmp_height_2 = (_cpu_usage_limit < cpu_table_data[ii]) and (tmp_height_1 / 7 * 2) or (tmp_height_1 / 2 * 1)

        drawing_line(_context,
            _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_1 * -1),
            _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_2 * -1),
            _graph_width, CAIRO_LINE_CAP_BUTT,
            (_cpu_usage_limit < cpu_table_data[ii]) and _color_graph.high or _color_graph.normal)
    end

    -- draw caption

    drawing_text(_context,
        _caption_position_align, _caption_start_x, _caption_start_y, _caption_font_size,
        string.format(
            'CPU0: %s%%',
                _cpu_usage_value
        ),
        _caption_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD, _color_graph.caption)
end
