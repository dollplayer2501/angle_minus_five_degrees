--
-- Network Graph
--

function drawing_graph_network(_context, _conky_parse_updates, _time_interval,
    -- network speed
    _network_upspeedf, _network_downspeedf,
    -- array's count
    _network_array_count_upspeed, _network_array_count_downspeed,
    -- graph
    _graprh_position_x, _graprh_position_y,
    _graph_width, _graph_max_height,
    -- caption
    _caption_position_x, _caption_position_y_upspeed, _caption_position_y_downspeed,
    _caption_position_align, _caption_font_face, _caption_font_size, _caption_font_weight,
    -- color
    _color_graph)


    if 4 > _conky_parse_updates then
        upspeedf_table_data = {}
        downspeedf_table_data = {}
        return
    end


    local _set_array = function(_array_data, _array_count, _value)
        for ii = 1, _array_count do
            if nil == _array_data[ii + 1] then
                _array_data[ii + 1] = 0
            end
            _array_data[ii] = _array_data[ii + 1]
            if ii == _array_count then
                if 0 == _network_downspeedf then
                    _array_data[_array_count] = 1
                else
                    _array_data[_array_count] = _value
                end
            end
        end

        return _array_data
    end

    local _get_max_value = function(_array_data, _array_count)
        local tmp_max_value = 0

        for ii = 1, _array_count do
            tmp_max_value = math.max(tmp_max_value, _array_data[ii])
        end
        if 1 >= tmp_max_value then
            tmp_max_value = 100
        end

        return tmp_max_value
    end

    local _drawing_graph = function(_context, _array_data, _array_count, _max_value,
        _position_x, _position_y, _graph_max_height, _graph_width, _color, _flg_up_down)

        for ii = 1, _array_count - 1 do
            local tmp_position_y_1 = math.ceil(_array_data[ii] / _max_value * _graph_max_height) + 2
            local tmp_position_y_2 = math.ceil(_array_data[ii + 1] / _max_value * _graph_max_height) + 2
            if 'up' == _flg_up_down then
                tmp_position_y_1 = tmp_position_y_1 * -1
                tmp_position_y_2 = tmp_position_y_2 * -1
            end

            local tmp_position_x_1 =
                _position_x
                + (_graph_width * _array_count * 2)
                - (_graph_width * (_array_count + ii))
                + 1
            local tmp_position_x_2 =
                _position_x
                + (_graph_width * _array_count * 2)
                - (_graph_width * (_array_count + ii + 1))
                + 1

            drawing_line(_context,
                tmp_position_x_1, _position_y + tmp_position_y_1,
                tmp_position_x_2, _position_y + tmp_position_y_2,
                _graph_width, CAIRO_LINE_CAP_BUTT,
                _color_graph.normal)
        end
    end


    -- draw graph

    if 0 == _conky_parse_updates % _time_interval then
        upspeedf_table_data = _set_array(upspeedf_table_data, _network_array_count_upspeed, _network_upspeedf)
        downspeedf_table_data = _set_array(downspeedf_table_data, _network_array_count_downspeed, _network_downspeedf)
    end

    local tmp_max_value_upspeed = _get_max_value(upspeedf_table_data, _network_array_count_upspeed)
    local tmp_max_value_downspeed = _get_max_value(downspeedf_table_data, _network_array_count_downspeed)

    _drawing_graph(_context, upspeedf_table_data, _network_array_count_upspeed, tmp_max_value_upspeed,
        _graprh_position_x, _graprh_position_y, _graph_max_height, _graph_width, _color_graph.normal, 'up')

    _drawing_graph(_context, downspeedf_table_data, _network_array_count_downspeed, tmp_max_value_downspeed,
        _graprh_position_x, _graprh_position_y, _graph_max_height, _graph_width, _color_graph.normal, 'down')

    -- draw caption

    drawing_text(_context, _caption_position_align,
        _caption_position_x, _caption_position_y_upspeed, _caption_font_size,
        string.format('UpSpeed: %sKiB',
                _network_upspeedf
            ),
        _caption_font_face, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD, _color_graph.caption)

    drawing_text(_context, _caption_position_align,
        _caption_position_x, _caption_position_y_downspeed, _caption_font_size,
        string.format('DownSpeed: %sKiB',
                _network_downspeedf
            ),
        _caption_font_face, CAIRO_FONT_SLANT_NORMAL, _caption_font_weight, _color_graph.caption)
end
