--
--
--

function get_color()

    --
    -- Nord https://www.nordtheme.com/
    --

    local node = {
        -- Polar Night
        node00 = '#2E3440',
        node01 = '#3B4252',
        node02 = '#434C5E',
        node03 = '#4C566A',
        -- Snow Storm
        node04 = '#D8DEE9',
        node05 = '#E5E9F0',
        node06 = '#ECEFF4',
        -- Frost
        node07 = '#8FBCBB',
        node08 = '#88C0D0',
        node09 = '#81A1C1',
        node10 = '#5E81AC',
        -- Aurora
        node11 = '#BF616A',
        node12 = '#D08770',
        node13 = '#EBCB8B',
        node14 = '#A3BE8C',
        node15 = '#B48EAD',
    }

    return {

        wall_clock = {
            marks = {
                hour12          = setting_hex_to_rgba(node.node11, 0.4),
                hour24          = setting_hex_to_rgba(node.node11, 0.6),
                mins00          = setting_hex_to_rgba(node.node11, 0.8),
                mins15          = setting_hex_to_rgba(node.node11, 0.8),
                mins10          = setting_hex_to_rgba(node.node11, 0.8),
                mins01          = setting_hex_to_rgba(node.node11, 0.8),
            },
            number = {
                hour24          = setting_hex_to_rgba(node.node10, 0.6),
                mins10          = setting_hex_to_rgba(node.node10, 0.6),
            },
            hands ={
                hour12          = setting_hex_to_rgba(node.node11, 0.8),
                hour24          = setting_hex_to_rgba(node.node07, 0.6),
                mins            = setting_hex_to_rgba(node.node11, 0.8),
                secs            = setting_hex_to_rgba(node.node07, 0.8),
            },
        },

        background_tiles = {
            --
            -- `gradient` is not displayed neatly.
            -- For this reason, I think it is better so set
            -- `display_background_gradient` in `config-sample.lua/config.lua` to `false`.
            --
            top_left = {
                one             = setting_hex_to_rgba(node.node00, 0.6),
                gradient = {      -- Top to Bottom, Vertical
                                  setting_hex_to_rgba(node.node03, 0.3),
                                  setting_hex_to_rgba(node.node02, 0.6),
                                  setting_hex_to_rgba(node.node01, 0.3),
                                  setting_hex_to_rgba(node.node00, 1.0),
                },
            },
            bottom_left = {
                one             = setting_hex_to_rgba(node.node01, 0.9),
                gradient = {      -- Left to Right, Holizontal
                                  setting_hex_to_rgba(node.node03, 0.6),
                                  setting_hex_to_rgba(node.node02, 0.8),
                                  setting_hex_to_rgba(node.node01, 0.6),
                                  setting_hex_to_rgba(node.node00, 1.0),
                },
            },
            top_right = {
                one             = setting_hex_to_rgba(node.node00, 0.6),
                gradient = {     -- Left to Right, Holizontal
                                  setting_hex_to_rgba(node.node00, 0.8),
                                  setting_hex_to_rgba(node.node01, 0.3),
                                  setting_hex_to_rgba(node.node02, 0.8),
                                  setting_hex_to_rgba(node.node03, 0.3),
                },
            },
            bottom_right = {
                one             = setting_hex_to_rgba(node.node00, 0.6),
                gradient = {      -- Top to Bottom, Vertical
                                  setting_hex_to_rgba(node.node00, 0.8),
                                  setting_hex_to_rgba(node.node01, 0.3),
                                  setting_hex_to_rgba(node.node02, 0.8),
                                  setting_hex_to_rgba(node.node03, 0.3),
                },
            },
        },

        bar_more = {
            normal              = setting_hex_to_rgba(node.node07, 0.4),
            high                = setting_hex_to_rgba(node.node11, 0.4),
            caption             = setting_hex_to_rgba(node.node07, 1.0),
        },

        ring = {
            fg_normal           = setting_hex_to_rgba(node.node07, 0.4),
            fg_high             = setting_hex_to_rgba(node.node11, 0.4),
            bg                  = setting_hex_to_rgba(node.node07, 0.1),
            caption             = setting_hex_to_rgba(node.node07, 1.0),
        },

        graph_cpu = {
            normal_0            = setting_hex_to_rgba(node.node07, 0.9),
            normal_1            = setting_hex_to_rgba(node.node07, 0.6),
            normal_2            = setting_hex_to_rgba(node.node07, 0.4),
            high                = setting_hex_to_rgba(node.node11, 0.6),
            caption             = setting_hex_to_rgba(node.node07, 1.0),
        },

        graph_network = {
            normal              = setting_hex_to_rgba(node.node07, 0.9),
            caption             = setting_hex_to_rgba(node.node07, 1.0),
        },

        background_lines = {
            normal              = setting_hex_to_rgba(node.node11, 1.0),
            high                = setting_hex_to_rgba(node.node07, 1.0),
        },

        text_clock = {
            hour                = setting_hex_to_rgba(node.node11, 0.9),
            am_pm               = setting_hex_to_rgba(node.node11, 0.6),
            delimiter_1         = setting_hex_to_rgba(node.node07, 0.8),
            delimiter_2         = setting_hex_to_rgba(node.node11, 0.9),
            mins                = setting_hex_to_rgba(node.node11, 0.9),
            sec                 = setting_hex_to_rgba(node.node11, 0.6),
        },

        text_detail = {
            days_normal         = setting_hex_to_rgba(node.node11, 1.0),
            days_strike         = setting_hex_to_rgba(node.node09, 1.0),
            body_normal         = setting_hex_to_rgba(node.node09, 1.0),
            body_strike         = setting_hex_to_rgba(node.node11, 1.0),
        },

        text_top = {
            fg_1                = setting_hex_to_rgba(node.node09, 1.00),
            fg_2                = setting_hex_to_rgba(node.node09, 0.85),
            fg_3                = setting_hex_to_rgba(node.node09, 0.70),
            fg_4                = setting_hex_to_rgba(node.node09, 0.55),
            fg_5                = setting_hex_to_rgba(node.node09, 0.40),
            fg_6                = setting_hex_to_rgba(node.node09, 0.25),
        },

        debugging = {
                                  setting_hex_to_rgba('#ff0000', 1.0),
                                  setting_hex_to_rgba('#0000ff', 1.0),
        },
    }
end
