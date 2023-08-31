--
-- this is a lua script for use in conky
--

require 'cairo'

package.path = os.getenv('HOME') .. '/.config/conky/angle_minus_five_degrees/?.lua'

require 'includes/const'
require 'includes/functions'
require 'includes/conky_parse'
require 'includes/color'

require 'modules/wall_clock'
require 'modules/background_tiles'
require 'modules/background_lines'
require 'modules/bar_more'
require 'modules/ring_clock'
require 'modules/ring_cpu'
require 'modules/ring_more'
require 'modules/text_clock'
require 'modules/graph_cpu'
require 'modules/graph_network'
require 'modules/text_detail'
require 'modules/text_top'



--
--
--
function conky_main()

    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create(
        conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height
    )

    local cr_draw = cairo_create(cs)

    local base_angle = -5 * (math.pi / 180)
    cairo_rotate(cr_draw, base_angle)



    --
    -- Variable, Const like global scope
    --

    local global_conky_parse_updates = tonumber(conky_parse('${updates}'))
    local global_conky_parse = get_conky_parse()
    local global_color = get_color()
    local global_const = get_const()


    -- The width of the lower left panel is linked to width of the string of today's date (full).

    local TODAY_WIDTH = {
        FONT_SIZE = 84,
        FONT_FACE = global_const.FONT_FACE_2_2,
        FONT_WEIGHT = CAIRO_FONT_WEIGHT_NORMAL,
        MARGIN = 50
    }

    TODAY_WIDTH['WIDTH'] = getting_text_width(cr_draw,
        TODAY_WIDTH.FONT_SIZE, global_conky_parse.full_date, TODAY_WIDTH.FONT_FACE, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)





    --
    -- Wall Clock
    --

    local base_wall_clock_radius_hour12 = 300
    local base_wall_clock_width_hour12 = 30

    local base_wall_clock_radius_hour24 = global_const.CENTER_POSITION.THEME.X / 2
    local base_wall_clock_width_hour24 = 8

    local base_wall_clock_radius_mins = 500
    local base_wall_clock_width_mins = 20

    local base_wall_clock_enabled_secs = true
    local base_wall_clock_radius_secs = 400
    local base_wall_clock_width_secs = 6

    drawing_wall_clock(cr_draw,
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        -- 12 hour
        base_wall_clock_radius_hour12, base_wall_clock_width_hour12,
        -- 24 hour
        base_wall_clock_radius_hour24, base_wall_clock_width_hour24,
        -- minutes
        base_wall_clock_radius_mins, base_wall_clock_width_mins,
        -- seconds
        base_wall_clock_radius_secs, base_wall_clock_width_secs, base_wall_clock_enabled_secs,
        -- etc
        CAIRO_LINE_CAP_ROUND, global_color.wall_clock)



    --
    -- Background (Tiles)
    --

    drawing_background_tiles(cr_draw, global_const,
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        TODAY_WIDTH.WIDTH, TODAY_WIDTH.MARGIN,
        global_color.background)



    --
    -- Bar More
    --

    local base_bar_more_position_x = global_const.CENTER_POSITION.THEME.X
    local base_bar_more_position_y = global_const.CENTER_POSITION.THEME.Y - global_const.LINE_LENGTH.HEIGHT.TOP_RIGHT
    local base_bar_more_bar_gap_y = 12
    local base_bar_more_bar_line_width = 3
    local base_bar_more_bar_length = global_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT

    local base_bar_more_caption_position_x = global_const.CENTER_POSITION.THEME.X + 4
    local base_bar_more_caption_position_y = global_const.CENTER_POSITION.THEME.Y - global_const.LINE_LENGTH.HEIGHT.TOP_RIGHT + 16
    local base_bar_more_caption_gap_y = 12
    local base_bar_more_caption_font_size = 12

    drawing_bar_more(cr_draw, global_conky_parse_updates,
        -- value
        global_conky_parse.cpu.cpu0,
        global_conky_parse.memperc,
        global_conky_parse.fs_free_perc,
        global_const.USAGE_LIMIT,
        -- bar
        base_bar_more_position_x, base_bar_more_position_y, base_bar_more_bar_gap_y,
        base_bar_more_bar_line_width, base_bar_more_bar_length,
        -- caption
        base_bar_more_caption_position_x, base_bar_more_caption_position_y, base_bar_more_caption_gap_y,
        global_const.ALIGN.LEFT, global_const.FONT_FACE_2_1, base_bar_more_caption_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- color
        global_color.bar_load_rate)



    --
    -- CPU Load Average Ring
    --

    local base_ring_cpu_radius = 200
    local base_ring_cpu_angle_start = 00
    local base_ring_cpu_angle_end = 89
    local base_ring_cpu_width = 20
    local base_ring_cpu_gap = 5

    local base_ring_cpu_caption_position_x = global_const.CENTER_POSITION.THEME.X + 4
    local base_ring_cpu_caption_position_y = global_const.CENTER_POSITION.THEME.Y - base_ring_cpu_radius + 8
    local base_ring_cpu_caption_increment_y = 25
    local base_ring_cpu_caption_font_size = 14

    drawing_ring_cpu(cr_draw, global_conky_parse_updates,
        -- values
        global_conky_parse.cpu,
        -- position
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        -- ring
        base_ring_cpu_angle_start, base_ring_cpu_angle_end,
        base_ring_cpu_radius, base_ring_cpu_width, base_ring_cpu_gap,
        global_const.USAGE_LIMIT.CPU,
        -- caption
        base_ring_cpu_caption_position_x, base_ring_cpu_caption_position_y, base_ring_cpu_caption_increment_y,
        global_const.ALIGN.LEFT, global_const.FONT_FACE_2_1, base_ring_cpu_caption_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- color
        global_color.ring)



    --
    -- Ring Clock - Month, day, hour 24, hour 12, days, seconds
    --

    local base_ring_clock_radius = 200
    local base_ring_clock_angle_start = 90
    local base_ring_clock_angle_end = 179
    local base_ring_clock_width = 20
    local base_ring_clock_gap = 5

    local base_ring_clock_caption_position_x = global_const.CENTER_POSITION.THEME.X + 8
    local base_ring_clock_caption_position_y = global_const.CENTER_POSITION.THEME.Y + base_ring_clock_radius + 7
    local base_ring_clock_caption_increment_y = 25
    local base_ring_clock_caption_font_size = 12

    local base_ring_clock_enabled_secs = true

    drawing_ring_clock(cr_draw,
        -- position
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        -- ring
        base_ring_clock_angle_start, base_ring_clock_angle_end,
        base_ring_clock_radius, base_ring_clock_width, base_ring_clock_gap,
        base_ring_clock_enabled_secs,
        -- caption
        base_ring_clock_caption_position_x, base_ring_clock_caption_position_y, base_ring_clock_caption_increment_y,
        global_const.ALIGN.LEFT, global_const.FONT_FACE_2_1, base_ring_clock_caption_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- color
        global_color.ring)



    --
    -- More Ring
    --

    local base_more_ring_radius = 200
    local base_more_ring_angle_start = 270
    local base_more_ring_angle_end = 359
    local base_more_ring_width = 20
    local base_more_ring_gap = 5

    local base_more_ring_caption_start_x = global_const.CENTER_POSITION.THEME.X - 8
    local base_more_ring_caption_start_y = global_const.CENTER_POSITION.THEME.Y - base_more_ring_radius + 6
    local base_more_ring_caption_increment_y = 25
    local base_more_ring_caption_font_size = 12

    drawing_ring_more(cr_draw, global_conky_parse_updates,
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        -- values
        global_conky_parse.memperc,
        -- ring
        base_more_ring_angle_start, base_more_ring_angle_end,
        base_more_ring_radius, base_more_ring_width, base_more_ring_gap,
        -- caption
        base_more_ring_caption_start_x, base_more_ring_caption_start_y, base_more_ring_caption_increment_y,
        global_const.ALIGN.RIGHT, global_const.FONT_FACE_2_1, base_more_ring_caption_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- color
        global_color.ring)



    --
    -- CPU Load Average Graph
    --

    local cpu_array_count = global_const.CPU_LOAD_AVERAGE.LENGTH
    local base_graph_cpu_position_x = global_const.CENTER_POSITION.THEME.X - cpu_array_count
    local base_graph_cpu_position_y = global_const.CENTER_POSITION.THEME.Y
    local base_graph_cpu_width = 1

    local base_graph_cpu_caption_position_x = global_const.CENTER_POSITION.THEME.X - global_const.CPU_LOAD_AVERAGE.LENGTH + 2
    local base_graph_cpu_caption_position_y = global_const.CENTER_POSITION.THEME.Y - 4
    local base_graph_cpu_caption_font_size = 12

    drawing_graph_cpu(cr_draw, global_conky_parse_updates,
        -- CPU load average
        global_conky_parse.cpu.cpu0, cpu_array_count, global_const.USAGE_LIMIT.CPU,
        -- graph
        base_graph_cpu_position_x, base_graph_cpu_position_y,
        base_graph_cpu_width, global_const.CPU_LOAD_AVERAGE.HEIGHT,
        -- caption
        base_graph_cpu_caption_position_x, base_graph_cpu_caption_position_y,
        global_const.ALIGN.LEFT, global_const.FONT_FACE_2_1, base_graph_cpu_caption_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- color
        global_color.graph_cpu)



    --
    -- Network Graph
    --

    --
    -- This is a buggy code!
    --

    local base_graph_network_time_interval = 1

    local base_graph_network_array_count_upspeed = global_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT
    local base_graph_network_array_count_downspeed = global_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT
    local base_graph_network_graph_width = 1
    local base_graph_network_graph_max_height = 50

    local base_graph_network_caption_position_x = global_const.CENTER_POSITION.THEME.X + global_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT - 2
    local base_graph_network_caption_position_y_upspeed = global_const.CENTER_POSITION.THEME.Y - 4
    local base_graph_network_caption_position_y_downspeed = global_const.CENTER_POSITION.THEME.Y + 14
    local base_graph_network_font_size = 12

    drawing_graph_network(cr_draw, global_conky_parse_updates, base_graph_network_time_interval,
        -- network speed
        global_conky_parse.upspeedf, global_conky_parse.downspeedf,
        -- array's count
        base_graph_network_array_count_upspeed, base_graph_network_array_count_downspeed,
        -- graph
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        base_graph_network_graph_width, base_graph_network_graph_max_height,
        -- caption
        base_graph_network_caption_position_x,
        base_graph_network_caption_position_y_upspeed, base_graph_network_caption_position_y_downspeed,
        global_const.ALIGN.RIGHT, global_const.FONT_FACE_2_1, base_graph_network_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- color
        global_color.graph_network)



    --
    -- Background (Lines)
    --

    local base_background_lines_highlight_length = 4

    drawing_background_lines(cr_draw, global_conky_parse_updates, global_const,
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        TODAY_WIDTH.WIDTH, TODAY_WIDTH.MARGIN,
        base_background_lines_highlight_length,
        CAIRO_LINE_CAP_BUTT,
        global_color.line, global_color.debugging)



    --
    -- Time(HH:MM:SS) -- Text
    --

    local base_text_clock_hour_adjust_x, base_text_clock_hour_adjust_y = -25, -60
    local base_text_clock_hour_font_size = 450
    local base_text_clock_hour_font_face = global_const.FONT_FACE_2_1
    local base_text_clock_hour_font_align = global_const.ALIGN.RIGHT

    local base_text_clock_delimiter_adjust_x, base_text_clock_delimiter_adjust_y = -25, 8
    local base_text_clock_delimiter_font_size = 300
    local base_text_clock_delimiter_font_face = global_const.FONT_FACE_1
    local base_text_clock_delimiter_font_align = global_const.ALIGN.LEFT

    local base_text_clock_min_adjust_x, base_text_clock_min_adjust_y = 0, 150
    local base_text_clock_min_font_size = 400
    local base_text_clock_min_font_face = global_const.FONT_FACE_2_1
    local base_text_clock_min_font_align = global_const.ALIGN.LEFT

    local base_text_clock_sec_enabled = true
    local base_text_clock_sec_adjust_x = global_const.LINE_LENGTH.CENTER_TO.RIGHT - 5
    local base_text_clock_sec_adjust_y = -5
    local base_text_clock_sec_font_size = 250
    local base_text_clock_sec_font_face = global_const.FONT_FACE_2_1
    local base_text_clock_sec_font_align = global_const.ALIGN.RIGHT

    drawing_text_clock(cr_draw, global_conky_parse_updates,
        -- position
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        -- hours
        base_text_clock_hour_adjust_x, base_text_clock_hour_adjust_y,
        base_text_clock_hour_font_align, base_text_clock_hour_font_size, base_text_clock_hour_font_face,
        -- delimiter
        base_text_clock_delimiter_adjust_x, base_text_clock_delimiter_adjust_y,
        base_text_clock_delimiter_font_align, base_text_clock_delimiter_font_size, base_text_clock_delimiter_font_face,
        -- minutes
        base_text_clock_min_adjust_x, base_text_clock_min_adjust_y,
        base_text_clock_min_font_align, base_text_clock_min_font_size, base_text_clock_min_font_face,
        -- seconds
        base_text_clock_sec_adjust_x, base_text_clock_sec_adjust_y,
        base_text_clock_sec_font_align, base_text_clock_sec_font_size, base_text_clock_sec_font_face, base_text_clock_sec_enabled,
        -- color
        global_color.text_time)



    --
    -- Detail text
    --

    local base_detail_text_adjust_x_large, base_detail_text_adjust_y_large = -10, 70
    local base_detail_text_font_size_large = TODAY_WIDTH.FONT_SIZE
    local base_detail_text_font_face_large = TODAY_WIDTH.FONT_FACE
    local base_detail_text_font_weight = TODAY_WIDTH.FONT_WEIGHT

    local base_detail_text_adjust_x_normal, base_detail_text_adjust_y_normal = -10, 115
    local base_detail_text_gap_y_normal = 26
    local base_detail_text_font_size_normal = 24
    local base_detail_text_font_face_normal = global_const.FONT_FACE_1

    drawing_text_detail(cr_draw, global_conky_parse_updates, global_const.ALIGN.RIGHT,
        -- position
        global_const.CENTER_POSITION.THEME.X, global_const.CENTER_POSITION.THEME.Y,
        -- values
        global_const.DISK_DEVICE, global_conky_parse, global_const.USAGE_LIMIT,
        -- large size
        base_detail_text_adjust_x_large, base_detail_text_adjust_y_large,
        base_detail_text_font_size_large, base_detail_text_font_face_large, base_detail_text_font_weight,
        -- normal size
        base_detail_text_adjust_x_normal, base_detail_text_adjust_y_normal, base_detail_text_gap_y_normal,
        base_detail_text_font_size_normal, base_detail_text_font_face_normal,
        -- color
        global_color.text_detail)



    --
    -- Text Top
    --

    local base_text_top_position_x_name = global_const.CENTER_POSITION.THEME.X
    local base_text_top_position_y_name = global_const.CENTER_POSITION.THEME.Y + global_const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT
    local base_text_top_adjust_x_name = 10

    local base_text_top_position_x_cpu = global_const.CENTER_POSITION.THEME.X + global_const.LINE_LENGTH.WIDTH.BOTTOM_RIGHT
    local base_text_top_position_y_cpu = global_const.CENTER_POSITION.THEME.Y + global_const.LINE_LENGTH.HEIGHT.BOTTOM_LEFT
    local base_text_top_adjust_x_cpu = -10

    local base_text_top_adjust_y = 28
    local base_text_increment_y = 20

    local base_text_font_face = global_const.FONT_FACE_2_2
    local base_text_font_size = 18

    drawing_text_top(cr_draw, global_conky_parse_updates, global_const,
        -- Left side, ${top name n}
        base_text_top_position_x_name, base_text_top_position_y_name, base_text_top_adjust_x_name,
        -- Right size, ${top cpu n}
        base_text_top_position_x_cpu, base_text_top_position_y_cpu, base_text_top_adjust_x_cpu,
        -- location etc
        base_text_top_adjust_y, base_text_increment_y,
        -- font
        base_text_font_face, base_text_font_size, CAIRO_FONT_WEIGHT_BOLD,
        -- values
        global_conky_parse.top,
        -- color
        global_color.text_top)





    --
    -- This is debug, do not delete!
    --

    if 0 > global_conky_parse_updates then
        local cr_debug0 = cairo_create(cs)
        local cr_debug5 = cairo_create(cs)

        cairo_rotate(cr_debug0, 0)
        cairo_rotate(cr_debug5, base_angle)

        local tmp_objects = { cr_debug0, cr_debug5 }
        for ii = 1, 2 do
            -- Ring
            drawing_ring(tmp_objects[ii],
                global_const.CENTER_POSITION.SCREEN.X, global_const.CENTER_POSITION.SCREEN.Y,
                500, changing_angle_to_radian(0), changing_angle_to_radian(320), 1,
                CAIRO_LINE_CAP_BUTT, global_color.debugging)
            -- Holizental line
            drawing_line(tmp_objects[ii],
                global_const.CENTER_POSITION.SCREEN.X - 200, global_const.CENTER_POSITION.SCREEN.Y,
                global_const.CENTER_POSITION.SCREEN.Y + 200, global_const.CENTER_POSITION.SCREEN.Y,
                1, CAIRO_LINE_CAP_BUTT, global_color.debugging)
            -- Vertical line
            drawing_line(tmp_objects[ii],
                global_const.CENTER_POSITION.SCREEN.X, global_const.CENTER_POSITION.SCREEN.Y - 100,
                global_const.CENTER_POSITION.SCREEN.X, global_const.CENTER_POSITION.SCREEN.Y + 100,
                1, CAIRO_LINE_CAP_BUTT, global_color.debugging)
        end

        cairo_destroy(cr_debug0)
        cairo_destroy(cr_debug5)
    end




    cairo_destroy(cr_draw)
    cairo_surface_destroy(cs)
    cr = nil
end
