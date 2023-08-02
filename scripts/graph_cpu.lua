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


    if 4 > _conky_parse_updates then
        cpu_table_data = {}
        return
    end

    -- Set array of cpu load average
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
        -- Memo:
        --  ** This code is tentativery/prelinary. **
        --  Especially when the rate of increase/decrease is intense, the graph cannot be drawn clearly.
        --  In order to deal with this, I think that knowledge and implementation of differentation are necessary?

        local tmp_height_position_from = _graph_height * cpu_table_data[ii] / 100
        local tmp_height_position_to_1 = tmp_height_position_from - (tmp_height_position_from / 3 * 1)
        local tmp_height_position_to_2 = tmp_height_position_to_1 - (tmp_height_position_from / 3 * 1)
        local tmp_height_position_to_3 = nil
        local tmp_color_1 = _color_graph.normal_1
        local tmp_color_2 = _color_graph.normal_2
        local tmp_color_3 = nil

        if _cpu_usage_limit * 2 < cpu_table_data[ii] then
            tmp_height_position_to_1 = tmp_height_position_from - (tmp_height_position_from / 9 * 1)
            tmp_height_position_to_2 = tmp_height_position_to_1 - (tmp_height_position_from / 9 * 1)
            tmp_height_position_to_3 = tmp_height_position_to_2 - (tmp_height_position_from / 9 * 4)
            tmp_color_1 = _color_graph.high
            tmp_color_2 = _color_graph.normal_1
            tmp_color_3 = _color_graph.normal_2
        elseif _cpu_usage_limit * 1 < cpu_table_data[ii] then
            tmp_height_position_to_1 = tmp_height_position_from - (tmp_height_position_from / 6 * 1)
            tmp_height_position_to_2 = tmp_height_position_to_1 - (tmp_height_position_from / 6 * 2)
            tmp_color_1 = _color_graph.high
            tmp_color_2 = _color_graph.normal_2
        end

        drawing_line(_context,
            _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_position_from * -1),
            _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_position_to_1 * -1),
            _graph_width, CAIRO_LINE_CAP_BUTT, tmp_color_1)

        drawing_line(_context,
            _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_position_to_1 * -1),
            _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_position_to_2 * -1),
            _graph_width, CAIRO_LINE_CAP_BUTT, tmp_color_2)

        if nil ~= tmp_height_position_to_3 then
            drawing_line(_context,
                _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_position_to_2 * -1),
                _graprh_position_x + (_graph_width * (ii - 1)), _graprh_position_y + (tmp_height_position_to_3 * -1),
                _graph_width, CAIRO_LINE_CAP_BUTT, tmp_color_3)
        end

        if ii <= _cpu_array_count - 1 then
            local tmp_height_position_from_1 = _graph_height * cpu_table_data[ii + 0] / 100
            local tmp_height_position_from_2 = _graph_height * cpu_table_data[ii + 1] / 100

            drawing_line(_context,
                _graprh_position_x + (_graph_width * (ii + 0)), _graprh_position_y + (tmp_height_position_from_1 * -1),
                _graprh_position_x + (_graph_width * (ii + 1)), _graprh_position_y + (tmp_height_position_from_2 * -1),
                _graph_width, CAIRO_LINE_CAP_BUTT, _color_graph.normal_0)
        end
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
