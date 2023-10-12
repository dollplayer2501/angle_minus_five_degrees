--
-- configuration angle_minus_five_degrees
--
-- ###########################################################################
-- # YOU MUST COPY AND RENAME THIS FILE, `config-sample.lua` TO `config.lua` #
-- ###########################################################################
--
--    Other settings are...
--    - ./includes/color.lua
--    - ./includes/const.lua
--    - ./angle_minus_five_degrees.lua
--

function get_config()

    return {

        --
        -- The existance of this file is not checked within the scripts.
        --
        color_scheme = 'color_default.lua',  -- or 'color_node.lua',

        -- Whether or not to display gradient color of background
        -- Caution!
        -- Adopting this function may case moiré effect.
        -- This tendency becomes especially strong when the alpha value approaches 1.00.
        -- When the screen is set to 0 degrees, this moire does not occur.
        display_background_gradient = true,

        -- Whether or not to display meaningless gimmicks
        display_top_right_gimmick = true,


        -- Update interval time, network upspeed and down
        graph_network_time_interval = 1,

        -- Whether or not to display Global IP address
        -- (if not to display, enable to display dummy strings)
        display_global_ip_address = {
            --
            --                | dummy_ip_address
            --                | with string | no string
            -- ---------------+-------------+--------------
            -- display  true  | don't refer | don't refer
            --          false | display     | don't display
            --
            display = false,
            dummy_ip_address = '123.456.789.012',
        },


        -- Whether or not to display clock seconds
        display_seconds = {
            wall_clock = true,
            ring_clock = true,
            text_clock = true,
        },

        --
        -- Wall clock
        --
        wall_clock = {
            display_marks_minutes00 = false,
            display_marks_minutes01 = true,
            display_marks_minutes15 = false,
            display_number_display = true,
            display_number_hour24 = true,
            -- It's especially annoying that the minute hand updates
            -- at `update_interval`(of conky's config) intervals
            -- This value must be greater than or equal 1 and less than or equal to 59 (seconds)
            update_interval_minutes = 15,
        },

        --
        -- 12 hour system or 24 hour system
        --
        text_clock = {
            display_24_hour = true,
            -- This takes effect if display_24_hour is true
            -- This may be redundant
            -- ex) 08:01 am => 8:01 am
            suppression_hour_zero = false,
        },

        -- Whether or not to display 12pm or 0am
        -- This setting only affects the 12 hour circle of the ring clock
        --
        --    24 hour system   | Global   | Japan
        --   ------------------+----------+---------
        --    0:00 / midnight  | 12:00 pm | 0:00 am
        --   12:00 / afternoon | 12:00 am | 0:00 pm
        --
        -- I think in many countries it is expressed as '12:00pm' and '12:00am',
        -- but this expression left strange to me...
        --
        display_hour12_japanese_style = false,


        --
        -- Whether or not to display each modules
        --
        display_module = {
            wall_clock_hours24 = true,
            wall_clock_hours12 = true,
            background_tiles = true,
            bar_more = true,
            ring_cpu = true,
            ring_clock = true,
            ring_more = true,
            graph_cpu = true,
            graph_network = true,
            background_lines = true,
            text_clock = true,
            text_top = true,
            text_detail = true,
            debug_lines = false,
        },


        --
        -- Filesystem
        --
        filesystem = {
            -- Directory to be checked for file size
            filesystem = '/',
            -- Device files subject to file writing/reading speeds
            device = '/dev/sda2',
        },
    }
end
