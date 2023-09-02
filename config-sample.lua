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

        -- Whether or not to display clock seconds
        display_seconds = {
            wall_clock = true,
            ring_clock = true,
            text_clock = true,
        },

        -- Whether or not to display meaningless gimmicks
        display_top_right_gimmick = true,

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

        filesystem = {
            -- Directory to be checked for file size
            filesystem = '/',
            -- Device files subject to file writing/reading speeds
            device = '/dev/sda2',
        },
    }
end
