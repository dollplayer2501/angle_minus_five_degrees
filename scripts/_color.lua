--
--
--

function get_color()

    return {

        -- from "Colour palette? - Lounge - EndeavourOS"
        --   https://forum.endeavouros.com/t/colour-palette/3480
        --
        -- # purple: #7f3fbf #be9ede #685878
        -- # blue:   #7f7fff #bebeff #8a8aaa
        -- # pink:   #ff7fff #ffbebe #bc9c9c

        line                    = setting_hex_to_rgba('#7f3fbf', 1.0),

        background = {
            top_left            = setting_hex_to_rgba('#685878', 0.5),
            bottom_left         = setting_hex_to_rgba('#685878', 0.9),
            top_right           = setting_hex_to_rgba('#685878', 0.7),
            bottom_right        = setting_hex_to_rgba('#685878', 0.6),
        },

        text_detail = {
            days                = setting_hex_to_rgba('#ff7fff', 0.8),
            body_normal         = setting_hex_to_rgba('#7f7fff', 1.0),
            body_strike         = setting_hex_to_rgba('#ff7fff', 0.8),
        },

        text_time = {
            hour                = setting_hex_to_rgba('#ff7fff', 0.9),
            delimiter_1         = setting_hex_to_rgba('#7f7fff', 0.8),
            delimiter_2         = setting_hex_to_rgba('#ff7fff', 0.8),
            mins                = setting_hex_to_rgba('#ff7fff', 0.9),
        },

        graph = {
            normal_1            = setting_hex_to_rgba('#7f7fff', 0.6),
            normal_2            = setting_hex_to_rgba('#7f7fff', 0.2),
            high                = setting_hex_to_rgba('#ff7fff', 0.6),
            caption             = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        ring = {
            fg_normal           = setting_hex_to_rgba('#7f7fff', 0.9),
            fg_high             = setting_hex_to_rgba('#ff7fff', 0.4),
            bg                  = setting_hex_to_rgba('#7f7fff', 0.2),
            caption             = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        wall_clock = {
            hour12              = setting_hex_to_rgba('#7f3fbf', 0.9),
            hour24              = setting_hex_to_rgba('#7f3fbf', 0.9),
            mins                = setting_hex_to_rgba('#7f3fbf', 0.9),
        },

        bar_load_rate = {
            normal              = setting_hex_to_rgba('#7f7fff', 0.9),
            high                = setting_hex_to_rgba('#ff7fff', 0.9),
        },
        text_top = {
            fg1                 = setting_hex_to_rgba('#7f7fff', 1.00),
            fg2                 = setting_hex_to_rgba('#7f7fff', 0.85),
            fg3                 = setting_hex_to_rgba('#7f7fff', 0.70),
            fg4                 = setting_hex_to_rgba('#7f7fff', 0.55),
            fg5                 = setting_hex_to_rgba('#7f7fff', 0.40),
            fg6                 = setting_hex_to_rgba('#7f7fff', 0.25),
        },

        debugging               = setting_hex_to_rgba('#ff0000', 1.0),
    }
end