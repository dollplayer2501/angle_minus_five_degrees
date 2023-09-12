--
--
--

function get_const()

    local tmp_center_x, tmp_center_y = 1920, 1080
    local tmp_adjust_x, tmp_adjust_y = 350, 200

    return {

        -- from Conky's configuration file
        --    local resolution_x = 1920
        --    local resolution_y = 1080
        --    gap_x = -1 * (resolution_x / 2),
        --    gap_y = -1 * (resolution_y / 2),
        --    minimum_height = resolution_y * 2,
        --    minimum_width = resolution_x * 2,
        --    maximum_width = resolution_x * 2,
        CENTER_POSITION = {
            SCREEN = {
                X = tmp_center_x,
                Y = tmp_center_y,
            },
            THEME = {
                X = tmp_center_x + tmp_adjust_x,
                Y = tmp_center_y + tmp_adjust_y,
            },
        },


        FONT_FACE_1 = 'GeosansLight',
        FONT_FACE_2_1 = 'Raleway Light',
        FONT_FACE_2_2 = 'Raleway Thin',


        -- Text align
        ALIGN = {
            LEFT = 'left',
            RIGHT = 'right',
        },


        DIRECTION = {
            HORIZONTAL = 'horizontal',
            VERTICAL = 'vertical',
        },


        USAGE_LIMIT = {
            CPU = 30,
            MEMORY = 60,
            FAN = 0,  -- tentative, provisional
        },

        CPU_LOAD_AVERAGE = {
            LENGTH = 400, -- length, count of CPU Load Average Graph
            HEIGHT = 200,
        },


        BACKGROUND = {

            TILES = {
                RECT_STEP = 5,
            },

            LINES = {

                WIDTH = {
                    NORMAL = 2,
                    BOLD = 4,
                    BOLDER = 6,
                },

                LENGTH = {
                    --[[
                                    |----d----|
                                    1         1
                                    |         |
                                    +         +---------+-----+2 -
                                    |         |               |  |
                                    |         |               |  a
                                    |         |               |  |
                    - 4+----------+---------Z---------+-------+2 -
                    |  |                    |         |
                    c  |                    |         |
                    |  |                    |         |
                    - 4+----------+---------+         +
                                            |         |
                                            |         |
                                            3         3
                                            |----b----|

                        Z: CENTER_POSITION.THEME.X,Y
                        1: center to top
                        2: center to right
                        3: center to bottom
                        4: center to left
                        a: top right height
                        b: bottom right width
                        c: bottom left height
                        d: top left height
                    ]]

                    CENTER_TO = {
                        TOP = (tmp_center_y / 2) + tmp_adjust_y, -- tentative, provisional
                        RIGHT = 450,
                        BOTTOM = (tmp_center_y / 2) + tmp_adjust_y, -- tentative, provisional
                        LEFT = nil, -- Get automatically, today's width
                    },

                    ADDITION = {
                        LARGE = 40,
                        NORMAL = 20,
                        SMALL = 10,
                    },

                    WIDTH = {
                        TOP_LEFT = nil, -- same value, CPU_LOAD_AVERAGE_LENGTH
                        BOTTOM_LEFT = nil, -- Today's width
                        TOP_RIGHT = nil, -- same value, LINE_LENGTH.CENTER_TO.RIGHT
                        BOTTOM_RIGHT = 350,
                    },

                    HEIGHT = {
                        TOP_LEFT = nil, -- same value, LINE_LENGTH.CNTER_TO.TOP
                        BOTTOM_LEFT = 350,
                        TOP_RIGHT = 350,
                        BOTTOM_RIGHT = nil, -- same value, LINE_LENGTH.CNTER_TO.BOTTOM
                    },
                },
            },
        },
    }
end
