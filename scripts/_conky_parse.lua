--
--
--

function get_conky_parse()

    local const = get_const()


    -- 'gw_ip' can be obtained after a few seconds booting
    -- and if you run this conky_purse multiple times, it will fail the second time or more ?
    --     conky_parse('${execi 600 ip r | head -n 1 | cut -f 5 -d " "}'),  # NIC
    --     conky_parse('${execi 600 ip r | head -n 1 | cut -f 3 -d " "}'),  # Gateway
    --     conky_parse('${execi 600 ip r | head -n 1 | cut -f 9 -d " "}')   # IP Address
    local tmp_conky_parse_iface = conky_parse('${iface}')


    return {

        cpu = {
            -- Memo and caution:
            --  I am coding on the assumption that there are 4 CPUs.
            --  If you have more than 4 CPUs, you'll need to make major program modifications.
            --  For example, ring of CPU usage.
            cpu0 = tonumber(conky_parse('${cpu cpu0}')),
            cpu1 = tonumber(conky_parse('${cpu cpu1}')),
            cpu2 = tonumber(conky_parse('${cpu cpu2}')),
            cpu3 = tonumber(conky_parse('${cpu cpu3}')),
            cpu4 = tonumber(conky_parse('${cpu cpu4}')),
            name = conky_parse('${execi 600 lscpu | grep "Model name:" | cut -c34-}'),
        },

        hostnamectl = {
            hardware_vendor  = conky_parse('${execi 600 hostnamectl | grep "Hardware Vendor:" | cut -c19-}'),
            hardware_model   = conky_parse('${execi 600 hostnamectl | grep "Hardware Model:" | cut -c19-}'),
            operating_system = conky_parse('${execi 600 hostnamectl | grep "Operating System:" | cut -c19-}'),
            kernel           = conky_parse('${execi 600 hostnamectl | grep "Kernel:" | cut -c19-}'),
            architecture     = conky_parse('${execi 600 hostnamectl | grep "Architecture:" | cut -c19-}'),
        },

        uptime       = conky_parse('${execi 600 uptime -p | cut -c 4-}'),
        full_date    = conky_parse('${time %A, %B %-d, %Y}'),

        whoami       = conky_parse('${execi 600 whoami}'),
        hostname     = conky_parse('${execi 600 hostname}'),

        checkupdates = tonumber(conky_parse('${execi 600 checkupdates | wc -l}')),
        packman_Q    = tonumber(conky_parse('${execi 600 pacman -Q | wc -l}')),

        iface        = tmp_conky_parse_iface,
        gw_ip        = conky_parse('${gw_ip ' .. tmp_conky_parse_iface .. '}'),
        addrs        = conky_parse('${addrs ' .. tmp_conky_parse_iface .. '}'),
        upspeedf     = tonumber(conky_parse('${upspeedf ' .. tmp_conky_parse_iface .. '}')),
        downspeedf   = tonumber(conky_parse('${downspeedf ' .. tmp_conky_parse_iface .. '}')),

        -- Global IP Address, This is optional
        global_ip    = conky_parse('${execi 600 wget -q -O - http://checkip.amazonaws.com/}'),

        mem          = conky_parse('${mem}'),
        memmax       = conky_parse('${memmax}'),
        memperc      = conky_parse('${memperc}'),

        ibm_temps_0  = conky_parse('${ibm_temps 0}'),
        ibm_fan      = conky_parse('${ibm_fan}'),

        fs_free      = conky_parse('${fs_free ' .. const.FILESYSTEM .. '}'),
        fs_free_perc = conky_parse('${fs_free_perc ' .. const.FILESYSTEM .. '}'),
        fs_used      = conky_parse('${fs_used ' .. const.FILESYSTEM .. '}'),

        diskio_write = conky_parse('${diskio_write '.. const.DISK_DEVICE .. '}'),
        diskio_read  = conky_parse('${diskio_read '.. const.DISK_DEVICE .. '}'),
    }
end
