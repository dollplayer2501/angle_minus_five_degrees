--
-- Detail text
--

function drawing_text_detail(_context, _conky_parse_updates, _position_align,
    _position_x, _position_y,
    -- large size
    _adjust_x_large, _adjust_y_large, _font_size_large, _font_face_large, _font_weight,
    -- normal size
    _adjust_x_normal, _adjust_y_normal, _gap_y_normal, _font_size_normal, _font_face_normal,
    -- values
    _const_disk_device, _conky_parse, _usage_limit,
    -- color
    _color_detail)


    -- Today

    drawing_text(_context, _position_align,
        _position_x + _adjust_x_large, _position_y + _adjust_y_large, _font_size_large,
        -- 'Wednesday, September 29, 2024',
        string.format('%s',
            _conky_parse.full_date
        ),
        _font_face_large, CAIRO_FONT_SLANT_NORMAL, _font_weight, _color_detail.days)


    -- If you do not interpose delay processing,
    -- there is a possibility of null error of variable, especially network related.
    if 4 > _conky_parse_updates then
        return
    end


    local idx = -1

    -- This paragraph is right justifuied.
    -- If you insert a decorating word, for each decorating word,
    -- construct from the right.

    -- Uptime

    idx = idx + 1

    local tmp_width = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %s',
            _conky_parse.uptime
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD, _color_detail.body_normal)

    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format('%s',
            'Uptime is'
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- Hardware info

    idx = idx + 1
    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(
            '%s %s, %s, %s %s',
                _conky_parse.hostnamectl.hardware_vendor,
                _conky_parse.hostnamectl.hardware_model,
                _conky_parse.hostnamectl.operating_system,
                _conky_parse.hostnamectl.kernel,
                _conky_parse.hostnamectl.architecture
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- Packages

    idx = idx + 1

    if 0 < tonumber(_conky_parse.checkupdates) then

        local tmp_width_1 = display_text_and_acquisition_text_width(_context, _position_align,
            _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
            string.format('%s',
                ' packages'
            ),
            _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

        local tmp_width_2 = display_text_and_acquisition_text_width(_context, _position_align,
            _position_x + _adjust_x_normal - tmp_width_1, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
            string.format(' %s/%s ',
                _conky_parse.checkupdates,
                _conky_parse.packman_Q
            ),
            _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_strike)

        drawing_text(_context, _position_align,
            _position_x + _adjust_x_normal - tmp_width_1 - tmp_width_2, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
            string.format('%s@%s needs to update ',
                _conky_parse.whoami,
                _conky_parse.hostname
            ),
            _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)
    else

        drawing_text(_context, _position_align,
            _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
            string.format(
                '%s@%s do not need %s packages update',
                    _conky_parse.whoami,
                    _conky_parse.hostname,
                    _conky_parse.packman_Q
            ),
            _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)
    end

    -- Gate Way Address, IP Address

    idx = idx + 1
    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(
            'GW is %s, Local is %s, Global is %s',
                _conky_parse.gw_ip,
                _conky_parse.addrs,
                _conky_parse.global_ip  -- Global IP Address, This is optional
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- Network Up/Down Speed

    idx = idx + 1
    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(
            'NIC is %s, UpSpeed %sKib, DownSpeed %sKib',
                _conky_parse.iface,
                _conky_parse.upspeedf,
                _conky_parse.downspeedf
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- Disk info, strage

    idx = idx + 1
    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(
            '%s is %s used, %s, %s%% free',
                _const_disk_device,
                _conky_parse.fs_used,
                _conky_parse.fs_free,
                _conky_parse.fs_free_perc
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- Disk info, disk i/o

    idx = idx + 1
    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal, _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(
            'Disk IO write %s, read %s',
                _conky_parse.diskio_write,
                _conky_parse.diskio_read
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- CPU info

    idx = idx + 1

    local tmp_width_1 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %sc %srpm',
            _conky_parse.ibm_temps_0,
            _conky_parse.ibm_fan
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL,
        (_usage_limit.FAN < tonumber(_conky_parse.ibm_fan)) and _color_detail.body_strike or _color_detail.body_normal)

    local tmp_width_2 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %s',
            'used,'
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    local tmp_width_3 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1 - tmp_width_2,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %s%%',
            _conky_parse.cpu.cpu0
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL,
        (_usage_limit.FAN < tonumber(_conky_parse.ibm_fan)) and _color_detail.body_strike or _color_detail.body_normal) -- I dare to use CPU Fan

    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1 - tmp_width_2 - tmp_width_3,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format('CPU is %s,',
            _conky_parse.cpu.name
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    -- Memory Usage

    idx = idx + 1

    local tmp_width_1 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %s',
            'used'
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    local tmp_width_2 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %s%%',
            _conky_parse.memperc
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL,
        (_usage_limit.MEMORY < tonumber(_conky_parse.memperc)) and _color_detail.body_strike or _color_detail.body_normal)

    local tmp_width_3 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1 - tmp_width_2,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format('%s',
            ','
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)

    local tmp_width_4 = display_text_and_acquisition_text_width(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1 - tmp_width_2 - tmp_width_3,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format(' %s/%s',
            _conky_parse.mem,
            _conky_parse.memmax
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL,
        (_usage_limit.MEMORY < tonumber(_conky_parse.memperc)) and _color_detail.body_strike or _color_detail.body_normal)

    drawing_text(_context, _position_align,
        _position_x + _adjust_x_normal - tmp_width_1 - tmp_width_2 - tmp_width_3 - tmp_width_4,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx), _font_size_normal,
        string.format('%s',
            'Memory is'
        ),
        _font_face_normal, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL, _color_detail.body_normal)
end
