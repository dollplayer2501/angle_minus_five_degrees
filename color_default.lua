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

        wall_clock = {
            marks = {
                hour12          = setting_hex_to_rgba('#7f3fbf', 0.4),
                hour24          = setting_hex_to_rgba('#7f7fff', 0.6),
                mins00          = setting_hex_to_rgba('#7f3fbf', 0.8),
                mins15          = setting_hex_to_rgba('#7f3fbf', 0.8),
                mins10          = setting_hex_to_rgba('#7f3fbf', 0.8),
                mins01          = setting_hex_to_rgba('#7f3fbf', 0.8),
            },
            number = {
                hour24          = setting_hex_to_rgba('#7f3fbf', 0.8),
                mins10          = setting_hex_to_rgba('#7f3fbf', 0.8),
            },
            hands ={
                hour12          = setting_hex_to_rgba('#7f3fbf', 0.8),
                hour24          = setting_hex_to_rgba('#7f7fff', 0.8),
                mins            = setting_hex_to_rgba('#7f3fbf', 0.8),
                secs            = setting_hex_to_rgba('#ff7fff', 0.6),
            },
        },

        background_tiles = {
            top_left = {
                one             = setting_hex_to_rgba('#685878', 0.3),
                gradient = {      -- Top to Bottom, Vertical
                                  setting_hex_to_rgba('#7f3fbf', 0.10),
                                  setting_hex_to_rgba('#7f3fbf', 0.30),
                                  setting_hex_to_rgba('#7f3fbf', 0.10),
                                  setting_hex_to_rgba('#7f7fff', 0.20),
                                  setting_hex_to_rgba('#ff7fff', 0.30),
                                  setting_hex_to_rgba('#7f3fbf', 0.60),
                  },
            },
            bottom_left = {
                one             = setting_hex_to_rgba('#685878', 0.9),
                gradient = {      -- Left to Right, Holizontal
                                  setting_hex_to_rgba('#7f3fbf', 0.20),
                                  setting_hex_to_rgba('#7f7fff', 0.20),
                                  setting_hex_to_rgba('#ff7fff', 0.20),
                                  setting_hex_to_rgba('#7f7fff', 0.30),
                                  setting_hex_to_rgba('#ff7fff', 0.30),
                                  setting_hex_to_rgba('#7f3fbf', 0.60),
                },
            },
            top_right = {
                one             = setting_hex_to_rgba('#685878', 0.5),
                gradient = {     -- Left to Right, Holizontal
                                  setting_hex_to_rgba('#7f3fbf', 0.50),
                                  setting_hex_to_rgba('#ff7fff', 0.20),
                                  setting_hex_to_rgba('#7f7fff', 0.20),
                                  setting_hex_to_rgba('#ff7fff', 0.20),
                                  setting_hex_to_rgba('#7f3fbf', 0.40),
                },
            },
            bottom_right = {
                one             = setting_hex_to_rgba('#685878', 0.4),
                gradient = {      -- Top to Bottom, Vertical
                                  setting_hex_to_rgba('#7f3fbf', 0.50),
                                  setting_hex_to_rgba('#ff7fff', 0.30),
                                  setting_hex_to_rgba('#7f7fff', 0.20),
                                  setting_hex_to_rgba('#7f3fbf', 0.30),
                                  setting_hex_to_rgba('#ff7fff', 0.20),
                                  setting_hex_to_rgba('#7f3fbf', 0.10),
                },
            },
        },

        bar_more = {
            normal              = setting_hex_to_rgba('#7f7fff', 0.6),
            high                = setting_hex_to_rgba('#ff7fff', 0.6),
            caption             = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        ring = {
            fg_normal           = setting_hex_to_rgba('#7f7fff', 0.8),
            fg_high             = setting_hex_to_rgba('#ff7fff', 0.4),
            bg                  = setting_hex_to_rgba('#7f7fff', 0.2),
            caption             = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        graph_cpu = {
            normal_0            = setting_hex_to_rgba('#7f7fff', 0.9),
            normal_1            = setting_hex_to_rgba('#7f7fff', 0.6),
            normal_2            = setting_hex_to_rgba('#7f7fff', 0.4),
            high                = setting_hex_to_rgba('#ff7fff', 0.6),
            caption             = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        graph_network = {
            normal              = setting_hex_to_rgba('#7f7fff', 0.9),
            caption             = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        background_lines = {
            normal              = setting_hex_to_rgba('#7f3fbf', 1.0),
            high                = setting_hex_to_rgba('#ff7fff', 1.0),
        },

        text_clock = {
            hour                = setting_hex_to_rgba('#ff7fff', 0.8),
            am_pm               = setting_hex_to_rgba('#ff7fff', 0.6),
            delimiter_1         = setting_hex_to_rgba('#7f7fff', 0.6),
            delimiter_2         = setting_hex_to_rgba('#ff7fff', 0.6),
            mins                = setting_hex_to_rgba('#ff7fff', 0.8),
            sec                 = setting_hex_to_rgba('#ff7fff', 0.6),
        },

        text_detail = {
            days_normal         = setting_hex_to_rgba('#ff7fff', 0.8),
            days_strike         = setting_hex_to_rgba('#7f7fff', 1.0),
            body_normal         = setting_hex_to_rgba('#7f7fff', 1.0),
            body_strike         = setting_hex_to_rgba('#ff7fff', 0.8),
        },

        text_top = {
            fg_1                = setting_hex_to_rgba('#7f7fff', 1.00),
            fg_2                = setting_hex_to_rgba('#7f7fff', 0.85),
            fg_3                = setting_hex_to_rgba('#7f7fff', 0.70),
            fg_4                = setting_hex_to_rgba('#7f7fff', 0.55),
            fg_5                = setting_hex_to_rgba('#7f7fff', 0.40),
            fg_6                = setting_hex_to_rgba('#7f7fff', 0.25),
        },

        debugging = {
                                  setting_hex_to_rgba('#ff0000', 1.0),
                                  setting_hex_to_rgba('#0000ff', 1.0),
        },
    }
end
