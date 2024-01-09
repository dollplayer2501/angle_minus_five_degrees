--
-- Detail text
--

function drawing_text_detail(_context, _conky_parse_updates,
    -- values
    _const_disk_device, _conky_parse, _usage_limit,
    -- display global ip address
    _display_global_ip_address,
    -- display swap
    _display_swap,
    -- position
    _position_x, _position_y, _position_align,
    -- large font
    _adjust_x_large, _adjust_y_large, _font_size_large, _font_face_large, _font_weight_large,
    -- normal font
    _adjust_x_normal, _adjust_y_normal, _gap_y_normal, _font_size_normal, _font_face_normal,
    -- color
    _color_detail)


    --
    --
    --

    local _drawing_text_with_properties_align_right = function(__context, __position_align,
        __position_x, __position_y, __font_size,
        _properties)

        local tmp_width = display_text_and_acquisition_text_width(__context, __position_align,
            __position_x, __position_y, __font_size,
            _properties[#_properties]._text,
            _properties[#_properties]._font_face, CAIRO_FONT_SLANT_NORMAL, _properties[#_properties]._font_weight,
            _properties[#_properties]._font_color)

        for ii = #_properties - 1, 1, -1 do
            if ii == #_properties then
                drawing_text(_context, __position_align,
                    __position_x - tmp_width, __position_y, __font_size,
                    _properties[ii]._text,
                    _properties[ii]._font_face, CAIRO_FONT_SLANT_NORMAL, _properties[ii]._font_weight,
                    _properties[ii]._font_color)
            else
                tmp_width = tmp_width + display_text_and_acquisition_text_width(_context, __position_align,
                    __position_x - tmp_width, __position_y, __font_size,
                    _properties[ii]._text,
                    _properties[ii]._font_face, CAIRO_FONT_SLANT_NORMAL, _properties[ii]._font_weight,
                    _properties[ii]._font_color)
            end
        end
    end


    --
    -- Today
    --

    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_large,
        _position_y + _adjust_y_large,
        _font_size_large, {
            {
                _text = string.format('%s',
                        _conky_parse.full_date
                    ),
                _font_face = _font_face_large,
                _font_weight = _font_weight_large,
                _font_color = true == checking_prime_number(tonumber(os.date('%Y%m%d')))
                    and _color_detail.days_strike or _color_detail.days_normal
            }
        })


    -- If you do not interpose delay processing,
    -- there is a possibility of null error of variable, especially network related.
    if 4 > _conky_parse_updates then
        return
    end


    local idx = -1

    -- This paragraph is right justifuied.
    -- If you insert a decorating word, for each decorating word,
    -- construct from the right.


    --
    -- Uptime
    --

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, {
            {
                _text = string.format('%s',
                        'Uptime is'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.uptime
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_BOLD,
                _font_color = _color_detail.body_normal
            }
        })


    --
    -- Login user name, Host name, Packages
    --

    local tmp_array = {
        {
            _text = string.format('%s@%s',
                    _conky_parse.whoami,
                    _conky_parse.hostname
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }
    }

    if 0 < tonumber(_conky_parse.checkupdates) then
        tmp_array = appendding_array_table(tmp_array, {
            {
                _text = string.format(' %s',
                        'needs to update'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal

            }, {
                _text = string.format(' %s',
                        _conky_parse.checkupdates
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_strike

            }, {
                _text = string.format('%s',
                        '/'
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal

            }, {
                _text = string.format('%s',
                        _conky_parse.packman_Q
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_strike
            }, {
                _text = string.format(' %s',
                        'packages'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })
    else
        tmp_array = appendding_array_table(tmp_array, {
            {
                _text = string.format(' do not need',
                        _conky_parse.packman_Q
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.packman_Q
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        'packages update'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })
    end

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, tmp_array)


    --
    -- Hardware info
    --

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, {
            {
                _text = string.format('%s %s',
                        _conky_parse.hostnamectl.hardware_vendor,
                        _conky_parse.hostnamectl.hardware_model
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ','
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.hostnamectl.operating_system
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ','
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s %s',
                        _conky_parse.hostnamectl.kernel,
                        _conky_parse.hostnamectl.architecture
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })


    --
    -- CPU info
    --

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, {
            {
                _text = string.format('%s',
                        _conky_parse.cpu.name
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ','
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s%%',
                        _conky_parse.cpu.cpu0
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _usage_limit.FAN < tonumber(_conky_parse.ibm_fan)
                     and _color_detail.body_strike or _color_detail.body_normal -- I dare to use CPU Fan
            }, {
                _text = string.format(' %s',
                        'used,'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s°C %srpm',
                        _conky_parse.ibm_temps_0,
                        _conky_parse.ibm_fan
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _usage_limit.FAN < tonumber(_conky_parse.ibm_fan)
                     and _color_detail.body_strike or _color_detail.body_normal -- I dare to use CPU Fan
            }
        })


    --
    -- Memory and Swap Usage
    --

    tmp_array = {
        {
            _text = string.format('%s',
                    'Memory is'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format(' %s',
                    _conky_parse.mem
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _usage_limit.MEMORY < tonumber(_conky_parse.memperc)
                and _color_detail.body_strike or _color_detail.body_normal
        }, {
            _text = string.format('%s',
                    '/'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format('%s',
                    _conky_parse.memmax
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _usage_limit.MEMORY < tonumber(_conky_parse.memperc)
                and _color_detail.body_strike or _color_detail.body_normal
        }, {
            _text = string.format('%s',
                    ','
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format(' %s%%',
                    _conky_parse.memperc
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _usage_limit.MEMORY < tonumber(_conky_parse.memperc)
                and _color_detail.body_strike or _color_detail.body_normal
        }, {
            _text = string.format(' %s',
                    'used'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }
    }

    if true == _display_swap then

        tmp_array = appendding_array_table(tmp_array, {
            {
                _text = string.format('%s',
                        ', Swap is'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.swap.swap
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ','
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s%%',
                        _conky_parse.swap.swapperc
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        'used,'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.swap.swapfree
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        'free'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })
    end

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, tmp_array)


    --
    -- NIC, Network Up/Down Speed
    --

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, {
            {
                _text = string.format('%s',
                        'NIC is'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.iface
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ', UpSpeed'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %sKib',
                        _conky_parse.upspeedf
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ', DownSpeed'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %sKib',
                        _conky_parse.downspeedf
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })


    --
    -- Gate Way Address, IP Address, Global IP Address
    --

    local tmp_global_iP_address = ''
    if true == _display_global_ip_address.display then
        tmp_global_iP_address = _conky_parse.global_ip
    else
        if '' ~= dummy_ip_address then
            tmp_global_iP_address = _display_global_ip_address.dummy_ip_address
        end
    end

    local tmp_array = {
        {
            _text = string.format('%s',
                    'GW is'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format(' %s',
                    _conky_parse.gw_ip
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format('%s',
                    ', Local is'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format(' %s',
                    _conky_parse.addrs
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }
    }

    if '' ~= tmp_global_iP_address then
        tmp_array = appendding_array_table(tmp_array, {
            {
                _text = string.format('%s',
                        ', Global is'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        tmp_global_iP_address
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })
    end

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, tmp_array)


    --
    -- Disk info, Strage, Disk I/O
    --

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx),
        _font_size_normal, {
            {
                _text = string.format('%s',
                        _const_disk_device
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ' is'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.fs_used
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        'used,'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.fs_free
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ','
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s%%',
                        _conky_parse.fs_free_perc
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        'free, Write'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.diskio_write
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format('%s',
                        ', Read'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        _conky_parse.diskio_read
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })


    --
    -- Conky info
    --

    local tmp_parse_updates = _conky_parse_updates -- + (24 * 60 * 60) + (2 * 60 * 60) - 10
        -- In order to easily change the variable value during debugging,
        -- it is replaced with another variable.

    local tmp_array = {
        {
            _text = string.format('%s',
                    converting_number_to_three_digit_commna_separated(tmp_parse_updates)
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = true == checking_prime_number(tonumber(tmp_parse_updates))
                and _color_detail.body_strike or _color_detail.body_normal
        }, {
            _text = string.format(' %s',
                    'sec.'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }
    }

    local tmp_time_ago = displaying_time_ago(tmp_parse_updates)
    if 60 - 1 < tmp_parse_updates then
        tmp_array = appendding_array_table(tmp_array, {
            {
                _text = string.format(' %s',
                        'about'
                    ),
                _font_face = _font_face_normal,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }, {
                _text = string.format(' %s',
                        tmp_time_ago
                    ),
                _font_face = _font_face_large,
                _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
                _font_color = _color_detail.body_normal
            }
        })
    end

    tmp_array = appendding_array_table(tmp_array, {
        {
            _text = string.format(' %s',
                    'elapsed by Conky ver.'
                ),
            _font_face = _font_face_normal,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }, {
            _text = string.format(' %s',
                    _conky_parse.conky_version
                ),
            _font_face = _font_face_large,
            _font_weight = CAIRO_FONT_WEIGHT_NORMAL,
            _font_color = _color_detail.body_normal
        }
    })

    idx = idx + 1
    _drawing_text_with_properties_align_right(_context, _position_align,
        _position_x + _adjust_x_normal,
        _position_y + _adjust_y_normal + (_gap_y_normal * idx) + 5,
        _font_size_normal * 0.8, tmp_array)
end
