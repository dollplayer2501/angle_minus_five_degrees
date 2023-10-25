--
--
--

function get_conky_parse()

    local config = get_config()


    -- 'gw_ip' can be obtained after a few seconds booting
    -- and if you run this conky_purse multiple times, it will fail the second time or more ?
    --     conky_parse('${execi 600 ip r | head -n 1 | cut -f 5 -d " "}'),  # NIC
    --     conky_parse('${execi 600 ip r | head -n 1 | cut -f 3 -d " "}'),  # Gateway
    --     conky_parse('${execi 600 ip r | head -n 1 | cut -f 9 -d " "}')   # IP Address
    local tmp_conky_parse_iface = triming(conky_parse('${iface}'))


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
            name = triming(conky_parse('${execi 600 lscpu | grep "Model name:" | cut -c37-}')),
        },

        hostnamectl = {
            hardware_vendor  = triming(conky_parse('${execi 600 hostnamectl | grep "Hardware Vendor:"  | cut -c19-}')),
            hardware_model   = triming(conky_parse('${execi 600 hostnamectl | grep "Hardware Model:"   | cut -c19-}')),
            operating_system = triming(conky_parse('${execi 600 hostnamectl | grep "Operating System:" | cut -c19-}')),
            kernel           = triming(conky_parse('${execi 600 hostnamectl | grep "Kernel:"           | cut -c19-}')),
            architecture     = triming(conky_parse('${execi 600 hostnamectl | grep "Architecture:"     | cut -c19-}')),
        },

        uptime       = triming(conky_parse('${execi 600 uptime -p | cut -c 4-}')),
        full_date    = conky_parse('${time %A, %B %-d, %Y}'),

        whoami       = triming(conky_parse('${execi 600 whoami}')),
        hostname     = triming(conky_parse('${execi 600 hostname}')),

        checkupdates = tonumber(conky_parse('${execi 600 checkupdates | wc -l}')),
        packman_Q    = tonumber(conky_parse('${execi 600 pacman -Q | wc -l}')),

        iface        = tmp_conky_parse_iface,
        gw_ip        = conky_parse('${gw_ip ' .. tmp_conky_parse_iface .. '}'),
        addrs        = conky_parse('${addrs ' .. tmp_conky_parse_iface .. '}'),
        upspeedf     = tonumber(conky_parse('${upspeedf ' .. tmp_conky_parse_iface .. '}')),
        downspeedf   = tonumber(conky_parse('${downspeedf ' .. tmp_conky_parse_iface .. '}')),

        -- Global IP Address
        global_ip    = triming(conky_parse('${execi 600 wget -q -O - http://checkip.amazonaws.com/}')),

        mem          = conky_parse('${mem}'),
        memmax       = conky_parse('${memmax}'),
        memperc      = conky_parse('${memperc}'),

        ibm_temps_0  = conky_parse('${ibm_temps 0}'),
        ibm_fan      = conky_parse('${ibm_fan}'),

        fs_free      = conky_parse('${fs_free ' .. config.filesystem.filesystem .. '}'),
        fs_free_perc = conky_parse('${fs_free_perc ' .. config.filesystem.filesystem .. '}'),
        fs_used      = conky_parse('${fs_used ' .. config.filesystem.filesystem .. '}'),

        diskio_write = conky_parse('${diskio_write '.. config.filesystem.device .. '}'),
        diskio_read  = conky_parse('${diskio_read '.. config.filesystem.device .. '}'),

        top = {
            name1    = conky_parse("${top name 1}"),
            name2    = conky_parse("${top name 2}"),
            name3    = conky_parse("${top name 3}"),
            name4    = conky_parse("${top name 4}"),
            name5    = conky_parse("${top name 5}"),
            name6    = conky_parse("${top name 6}"),

            cpu1     = conky_parse("${top cpu 1}"),
            cpu2     = conky_parse("${top cpu 2}"),
            cpu3     = conky_parse("${top cpu 3}"),
            cpu4     = conky_parse("${top cpu 4}"),
            cpu5     = conky_parse("${top cpu 5}"),
            cpu6     = conky_parse("${top cpu 6}"),
        },

        conky_version = triming(conky_parse('${conky_version}')),
    }
end
