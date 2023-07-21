--
--
--

function get_const()

    return {

        FILESYSTEM = '/',
        DISK_DEVICE = '/dev/sda2',


        FONT_FACE_1 = 'GeosansLight',
        FONT_FACE_2 = 'Raleway Thin',

        -- Text align
        ALIGN_LEFT = 'left',
        ALIGN_RIGHT = 'right',

        USAGE_LIMIT = {
            CPU = 30,
            MEMORY = 60,
            FAN = 0, -- This value is fairly arbitrary
        },

        CPU_LOAD_AVERAGE = {
            LENGTH = 400, -- length/count of CPU Load Average Graph
            HEIGHT = 200,
        },


        LINE_WIDTH = 2,

        LINE_LENGTH = {
            CENTER_TO = {
                TOP = 2000,
                RIGHT = 450, -- Bar
                BOTTOM = 2000,
                LEFT = -1, -- Today's width
            },
            ADDITION = {
                LARGE = 40,
                NORMAL = 20,
                SMALL = 10,
            },
            WIDTH = {
                TOP_LEFT = -1, -- same value, CPU_LOAD_AVERAGE_LENGTH
                BOTTOM_LEFT = -1, -- Today's width
                TOP_RIGHT = 450, -- same value, LINE_LENGTH.CENTER_TO_RIGHT
                BOTTOM_RIGHT = 350,
            },
            HEIGHT = {
                TOP_LEFT = 2000,
                BOTTOM_LEFT = 350,
                TOP_RIGHT = 350,
                BOTTOM_RIGHT = 2000,
            },
        },
    }
end
