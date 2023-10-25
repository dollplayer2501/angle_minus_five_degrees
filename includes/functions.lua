--
--
--



--
-- trim
--

function triming(_str)
    return (string.gsub(_str, '^%s*(.-)%s*$', '%1'))
end


--
-- Convert number to three digit commna separated
--

function converting_number_to_three_digit_commna_separated(_num)
    --
    -- 123456789      => 123,456,789
    -- 123456789.1234 => 123,456,789.1234
    -- 123,456,789    => nil
    --
    -- Values that are too large number are not suported and are display as is.
    -- It is unclear how far it can be displayed.
    --

    local tmp_str_1 = tostring(tonumber(_num))

    -- Extract decimal places
    local tmp_str_2 = ''
    local tmp_match_s = string.find(tmp_str_1, '.', 1, true)
    if nil ~= tmp_match_s then
        tmp_str_2 = string.sub(tmp_str_1, tmp_match_s)
        tmp_str_1 = string.sub(tmp_str_1, 1, tmp_match_s - 1)
    end

    local ii = 1
    tmp_str_1 = string.reverse(tmp_str_1)
    while (ii <= string.len(tmp_str_1)) do
        tmp_str_2 = ',' .. string.reverse(string.sub(tmp_str_1, ii, ii + 2)) .. tmp_str_2
      ii = ii + 3
    end

    return string.sub(tmp_str_2, 2)
end


--
-- check prime number
--

function checking_prime_number(_num)
    for ii = 2, math.sqrt(_num) do
        if 0 == _num % ii then
            return false
        end
    end
    return true
end


--
-- append array table
--

function appendding_array_table(_array_from, _array_to)
    local tmp_array = {}

    for ii = 1, #_array_from, 1 do
        table.insert(tmp_array, _array_from[ii])
    end

    for ii = 1, #_array_to, 1 do
        table.insert(tmp_array, _array_to[ii])
    end

    return tmp_array
end


--
-- displaying time ago
--

function displaying_time_ago(_secs)
    --
    -- Maybe it has a bug ?
    --

    if 1 * 60 > _secs then
        -- 1 minute or less
        return string.format('%s %s', _secs, 'seconds')
    elseif 1 * 60 * 60 > _secs then
        -- 1 hour or less
        local tmp_min_number = math.floor(_secs / (1 * 60))
        local tmp_min_suffix = (1 < tmp_min_number) and 'minutes' or 'min.'

        return string.format('%s %s', tmp_min_number, tmp_min_suffix)
    elseif 1 * 60 * 60 * 24 > _secs then
        -- 1 day or less
        local tmp_hour_number = math.floor(_secs / (1 * 60 * 60))
        local tmp_hour_suffix = (1 < tmp_hour_number) and 'hours' or 'hour'
        local tmp_min_number = math.floor((_secs - (tmp_hour_number * 60 * 60)) / (1 * 60))
        local tmp_min_suffix = (1 < tmp_min_number) and 'minutes' or 'min.'

        if 0 == tmp_min_number then
            return string.format('%s %s', tmp_hour_number, tmp_hour_suffix)
        else
            return string.format('%s %s %s %s',
                tmp_hour_number, tmp_hour_suffix, tmp_min_number, tmp_min_suffix)
        end
    else
        -- 1 day or more
--        tmp_day = math.floor(_secs / (1 * 60 * 60 * 24))
--        tmp_hour = math.floor((_secs - (tmp_day * 60 * 60 * 24)) / (1 * 60 * 60))
--        return string.format('%s day %s hour', tmp_day, tmp_hour)

        local tmp_day_number = math.floor(_secs / (1 * 60 * 60 * 24))
        local tmp_day_suffix = (1 < tmp_day_number) and 'days' or 'day'

        local tmp_hour_number = math.floor((_secs - (tmp_day_number * 60 * 60 * 24)) / (1 * 60 * 60))
        local tmp_hour_suffix = (1 < tmp_hour_number) and 'hours' or 'hour'

        if 0 == tmp_hour_number then
            return string.format('%s %s', tmp_day_number, tmp_day_suffix)
        else
            return string.format('%s %s %s %s',
            tmp_day_number, tmp_day_suffix, tmp_hour_number, tmp_hour_suffix)
        end
    end
end


--
-- change time to arc
--

function changing_time_to_arc(_secs, _mins, _hours12, _hours24, _hands_update_interval_mins)
    local tmp_secs_arc = (2 * math.pi / 60) * _secs
    local tmp_secs_arc_tmp = (2 * math.pi / 60) * math.floor(_secs / _hands_update_interval_mins) * _hands_update_interval_mins
    local tmp_mins_arc = (2 * math.pi / 60) * _mins + (tmp_secs_arc_tmp / 60)
    local tmp_hours12_arc = (2 * math.pi / 12) * _hours12 + (tmp_mins_arc / 12)
    local tmp_hours24_arc = (2 * math.pi / 24) * _hours24 + (tmp_mins_arc / 24)

    return tmp_secs_arc, tmp_secs_arc_tmp, tmp_mins_arc, tmp_hours12_arc, tmp_hours24_arc
end


--
-- set hex to rgba
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
-- change angle to radian
--

function changing_angle_to_radian(_angle)
    return (_angle - 90) * (math.pi / 180)
end


--
-- draw line
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
-- set text extents
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
-- get text width
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
-- draw text
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
        (const.ALIGN.RIGHT == _align) and (_pos_x - extents.width - extents.x_bearing) or _pos_x,
        _pos_y)

    cairo_set_source_rgba(_context, _color.red, _color.green, _color.blue, _color.alpha)
    cairo_show_text(_context, _text)
    cairo_new_path(_context)
end


--
-- display text and acquisition text width
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
-- draw ring
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
-- draw square
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


--
-- draw gradient square
--

function drawing_gradient_square(_context,
    _position_x, _position_y, _rect_width, _rect_height,
    _gradient_direction, _rect_step,
    _color_from_to)

    local const = get_const()

    local tmp_count_surface = const.DIRECTION.HORIZONTAL == _gradient_direction
        and math.floor(_rect_width / _rect_step)
        or math.floor(_rect_height / _rect_step)
    local tmp_one_rect_color = math.floor(tmp_count_surface / (#_color_from_to - 1))
    local tmp_color_start, tmp_color_end = _color_from_to[1], _color_from_to[#_color_from_to]

    for ii = 1, tmp_count_surface do

        --
        -- surface
        --

        local tmp_position_x, tmp_position_y, tmp_width, tmp_height
        if const.DIRECTION.HORIZONTAL == _gradient_direction then
            tmp_position_x = _position_x + (_rect_step * (ii - 1))
            tmp_position_y = _position_y
            tmp_width = ii == tmp_count_surface
                and _rect_width - (_rect_step * (ii - 1))
                or _rect_step
            tmp_height = _rect_height
        else
            tmp_position_x = _position_x
            tmp_position_y = _position_y + (_rect_step * (ii - 1))
            tmp_width = _rect_width
            tmp_height = ii == tmp_count_surface
                and _rect_height - (_rect_step * (ii - 1))
                or _rect_step
        end

        --
        -- color
        --

        local tmp_color_index = (ii - 1) // tmp_one_rect_color <= #_color_from_to - 2
            and ((ii - 1) // tmp_one_rect_color) + 1
            or #_color_from_to - 1
        local tmp_rect_base = tmp_color_index <= #_color_from_to - 2
            and tmp_one_rect_color
            or tmp_count_surface - (tmp_one_rect_color * (tmp_color_index - 1))
        local tmp_rect_now = ii - (tmp_one_rect_color * (tmp_color_index - 1))

        local tmp_color_start, tmp_color_end = _color_from_to[tmp_color_index], _color_from_to[tmp_color_index + 1]

        local tmp_color_red = tmp_color_start.red + ((tmp_color_end.red - tmp_color_start.red) / tmp_rect_base * tmp_rect_now)
        local tmp_color_green = tmp_color_start.green + ((tmp_color_end.green - tmp_color_start.green) / tmp_rect_base * tmp_rect_now)
        local tmp_color_blue = tmp_color_start.blue + ((tmp_color_end.blue - tmp_color_start.blue) / tmp_rect_base * tmp_rect_now)
        local tmp_color_alpha = tmp_color_start.alpha + ((tmp_color_end.alpha - tmp_color_start.alpha) / tmp_rect_base * tmp_rect_now)

        --
        -- drawing
        --

        cairo_rectangle(_context, tmp_position_x, tmp_position_y, tmp_width, tmp_height)
        cairo_set_line_width(_context, 0)
        cairo_set_source_rgba(_context, tmp_color_red, tmp_color_green, tmp_color_blue, tmp_color_alpha)
        cairo_fill_preserve(_context)
        cairo_stroke(_context)
    end
end


--
--  draw wall clock marks
--

function drawing_wall_clock_marks(_context,
    _center_x, _center_y, _marks_radius_from, _marks_radius_to,
    _marks_number, _marks_skip_count,
    _marks_width, _marks_line_cap,
    _marks_color)

    cairo_set_line_width(_context, _marks_width)
    cairo_set_line_cap(_context, _marks_line_cap)
    cairo_set_source_rgba(_context, _marks_color.red, _marks_color.green, _marks_color.blue, _marks_color.alpha)
    local tmp_marks_angle = math.rad(360 / _marks_number)
    for ii = 0, _marks_number - 1, 1 do
        local tmp_flg
        if nil == _marks_skip_count then
            tmp_flg = true
        else
            if 0 ~= ii % _marks_skip_count then
                tmp_flg = true
            else
                tmp_flg = false
            end
        end

        if true == tmp_flg then
            cairo_move_to(_context,
                _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_from,
                _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_from
            )
            cairo_line_to(_context,
                _center_x - math.sin(tmp_marks_angle * ii) * _marks_radius_to,
                _center_y - math.cos(tmp_marks_angle * ii) * _marks_radius_to
            )
            cairo_stroke(_context)
        end
    end
end


--
--  draw clock hands
--

function drawing_wall_clock_hands(_context,
    _center_x, _center_y,
    _hands_radius, _hours_arc, _hands_back_length_rate,
    _hands_width, _hands_line_cap,
    _hands_color)

    local tmp_length_x = _center_x + _hands_radius * math.sin(_hours_arc)
    local tmp_length_y = _center_y - _hands_radius * math.cos(_hours_arc)
    drawing_line(_context,
        _center_x, _center_y, tmp_length_x, tmp_length_y,
        _hands_width, _hands_line_cap, _hands_color)

    local tmp_length_x = _center_x - (_hands_radius * _hands_back_length_rate) * math.sin(_hours_arc)
    local tmp_length_y = _center_y + (_hands_radius * _hands_back_length_rate) * math.cos(_hours_arc)
    drawing_line(_context,
        _center_x, _center_y, tmp_length_x, tmp_length_y,
        _hands_width, _hands_line_cap, _hands_color)
end
