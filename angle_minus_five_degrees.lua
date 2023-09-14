--
-- this is a lua script for use in conky
--

require 'cairo'

-- It still works even if I turn it off...
-- package.path = os.getenv('HOME') .. '/.config/conky/angle_minus_five_degrees/?.lua'

require 'config'
require 'const'
require 'color'

require 'includes/functions'
require 'includes/conky_parse'

require 'config/wall_clock'
require 'modules/wall_clock'
require 'config/background_tiles'
require 'modules/background_tiles'
require 'config/bar_more'
require 'modules/bar_more'
require 'config/ring_cpu'
require 'modules/ring_cpu'
require 'config/ring_clock'
require 'modules/ring_clock'
require 'config/ring_more'
require 'modules/ring_more'
require 'config/graph_cpu'
require 'modules/graph_cpu'
require 'config/graph_network'
require 'modules/graph_network'
require 'config/background_lines'
require 'modules/background_lines'
require 'config/text_clock'
require 'modules/text_clock'
require 'config/text_top'
require 'modules/text_top'
require 'config/text_detail'
require 'modules/text_detail'
require 'config/debbug_lines'
require 'modules/debbug_lines'




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

    local global_config = get_config()
    local global_conky_parse_updates = tonumber(conky_parse('${updates}'))
    local global_conky_parse = get_conky_parse()
    local global_color = get_color()
    local global_const = get_const()


    -- The width of the left bottom panel is linked to width of the string of today's date (full).

    local TODAY_WIDTH = {
        FONT_SIZE = 64,
        FONT_FACE = global_const.FONT_FACE_2_1,
        FONT_WEIGHT = CAIRO_FONT_WEIGHT_NORMAL,
        MARGIN = 40,
    }

    TODAY_WIDTH['WIDTH'] = getting_text_width(cr_draw,
        TODAY_WIDTH.FONT_SIZE, global_conky_parse.full_date,
        TODAY_WIDTH.FONT_FACE, CAIRO_FONT_SLANT_NORMAL, TODAY_WIDTH.FONT_WEIGHT)




    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Wall Clock
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.wall_clock then
        local cfg = get_config_wall_clock(global_const, global_config)
        drawing_wall_clock(cr_draw,
            -- position
            cfg.center_x, cfg.center_y,
            -- 12 hour
            cfg.radius_hour12, cfg.width_hour12,
            -- 24 hour
            cfg.radius_hour24, cfg.width_hour24,
            -- minutes
            cfg.radius_mins, cfg.width_mins,
            -- seconds
            cfg.display_secs, cfg.radius_secs, cfg.width_secs,
            -- etc
            cfg.line_cap,
            -- color
            global_color.wall_clock)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Background (Tiles)
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.background_tiles then
        local cfg = get_config_background_tiles(global_const, global_config)
        drawing_background_tiles(cr_draw, global_const,
            -- position
            cfg.center_x, cfg.center_y,
            -- left bottom width
            TODAY_WIDTH.WIDTH, TODAY_WIDTH.MARGIN,
            -- gradient
            cfg.display_gradient, cfg.rect_step,
            -- color
            global_color.background)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Bar More
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.bar_more then
        local cfg = get_config_bar_more(global_const, global_config)
        drawing_bar_more(cr_draw, global_conky_parse_updates,
            -- value
            global_conky_parse.cpu.cpu0,
            global_conky_parse.memperc,
            global_conky_parse.fs_free_perc,
            global_const.USAGE_LIMIT,
            -- bar
            cfg.bar_position_x, cfg.bar_position_y, cfg.bar_gap_y,
            cfg.bar_line_width, cfg.bar_length,
            -- caption
            cfg.caption_position_x, cfg.caption_position_y, cfg.caption_gap_y,
            cfg.caption_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.bar_load_rate)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- CPU Load Average Ring
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.ring_cpu then
        local cfg = get_config_ring_cpu(global_const, global_config)
        drawing_ring_cpu(cr_draw, global_conky_parse_updates,
            -- value
            global_conky_parse.cpu,
            cfg.ring_cpu_usage_limit,
            -- position
            cfg.ring_position_x, cfg.ring_position_y,
            -- ring
            cfg.ring_angle_start, cfg.ring_angle_end,
            cfg.ring_radius, cfg.ring_width, cfg.ring_gap,
            -- caption
            cfg.caption_position_x, cfg.caption_position_y, cfg.caption_increment_y,
            cfg.caption_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.ring)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Ring Clock
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.ring_clock then
        local cfg = get_config_ring_clock(global_const, global_config)
        drawing_ring_clock(cr_draw, global_config,
            -- position
            cfg.ring_position_x, cfg.ring_position_y,
            -- etc
            cfg.display_secs,
            -- ring
            cfg.ring_angle_start, cfg.ring_angle_end,
            cfg.ring_radius, cfg.ring_width, cfg.ring_gap,
            -- caption
            cfg.caption_position_x, cfg.caption_position_y, cfg.caption_increment_y,
            cfg.aption_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.ring)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- More Ring
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.ring_more then
        local cfg = get_config_ring_more(global_const, global_config)
        drawing_ring_more(cr_draw, global_conky_parse_updates,
            -- values
            global_conky_parse.memperc,
            global_conky_parse.ibm_temps_0,
            -- position
            cfg.ring_center_x, cfg.ring_center_y,
            -- ring
            cfg.ring_angle_start, cfg.ring_angle_end,
            cfg.ring_radius, cfg.ring_width, cfg.ring_gap,
            -- caption
            cfg.caption_position_x, cfg.caption_position_y, cfg.caption_increment_y,
            cfg.caption_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.ring)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- CPU Load Average Graph
    --  Is this a buggy code?
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.graph_cpu then
        local cfg = get_config_graph_cpu(global_const, global_config)
        drawing_graph_cpu(cr_draw, global_conky_parse_updates,
            -- CPU load average
            global_conky_parse.cpu.cpu0,
            -- etc
            cfg.cpu_array_count, cfg.cpu_usage_limit,
            -- graph
            cfg.graprh_position_x, cfg.graprh_position_y,
            cfg.graph_width, cfg.graph_max_height,
            -- caption
            cfg.caption_position_x, cfg.caption_position_y,
            cfg.caption_position_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.graph_cpu)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Network Graph
    --  This is a buggy code!
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.graph_network then
        local cfg = get_config_graph_network(global_const, global_config)
        drawing_graph_network(cr_draw, global_conky_parse_updates,
            -- interval
            cfg.time_interval,
            -- network speed
            global_conky_parse.upspeedf, global_conky_parse.downspeedf,
            -- array's count
            cfg.network_array_count_upspeed, cfg.network_array_count_downspeed,
            -- graph
            cfg.graprh_position_x, cfg.graprh_position_y,
            cfg.graph_width, cfg.graph_max_height,
            -- caption
            cfg.caption_position_x,
            cfg.caption_position_y_upspeed, cfg.caption_position_y_downspeed,
            cfg.caption_position_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.graph_network)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Background (Lines)
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.background_lines then
        local cfg = get_config_background_lines(global_const, global_config)
        drawing_background_lines(cr_draw, global_conky_parse_updates, global_const,
            -- position
            cfg.center_x, cfg.center_y,
            -- left bottom width
            TODAY_WIDTH.WIDTH, TODAY_WIDTH.MARGIN,
            -- top right gimmick
            cfg.display_top_right_gimmick, cfg.highlight_length,
            -- etc
            cfg.line_cap,
            -- color
            global_color.line, global_color.debugging)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Clock Text
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.text_clock then
        local cfg = get_config_text_clock(global_const, global_config)
        drawing_text_clock(cr_draw, global_conky_parse_updates,
            -- position
            cfg.position_x, cfg.position_y,
            -- hours
            cfg.hour_adjust_x, cfg.hour_adjust_y,
            cfg.hour_font_align, cfg.hour_font_size, cfg.hour_font_face,
            -- delimiter
            cfg.delimiter_adjust_x, cfg.delimiter_adjust_y,
            cfg.delimiter_font_align, cfg.delimiter_font_size, cfg.delimiter_font_face,
            -- minutes
            cfg.min_adjust_x, cfg.min_adjust_y,
            cfg.min_font_align, cfg.min_font_size, cfg.min_font_face,
            -- seconds
            cfg.display_secs,
            cfg.sec_adjust_x, cfg.sec_adjust_y,
            cfg.sec_font_align, cfg.sec_font_size, cfg.sec_font_face,
            -- color
            global_color.text_clock)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Text Top
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.text_top then
        local cfg = get_config_text_top(global_const, global_config)
        drawing_text_top(cr_draw, global_conky_parse_updates, global_const,
            -- values
            global_conky_parse.top,
            -- Left side, ${top name n}
            cfg.position_x_name, cfg.position_y_name, cfg.adjust_x_name,
            -- Right size, ${top cpu n}
            cfg.position_x_cpu, cfg.position_y_cpu, cfg.adjust_x_cpu,
            -- location etc
            cfg.adjust_y, cfg.increment_y,
            -- font
            cfg.font_face, cfg.font_size, cfg.font_weight,
            -- color
            global_color.text_top)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Detail text
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.text_detail then
        local cfg = get_config_text_detail(global_const, global_config)
        drawing_text_detail(cr_draw, global_conky_parse_updates,
            -- values
            global_config.filesystem.device, global_conky_parse, global_const.USAGE_LIMIT,
            -- display global ip address
            cfg.display_global_ip_address,
            -- position
            cfg.position_x, cfg.position_y, cfg.position_align,
            -- large font
            cfg.adjust_x_large, cfg.adjust_y_large,
            TODAY_WIDTH.FONT_SIZE, TODAY_WIDTH.FONT_FACE, TODAY_WIDTH.FONT_WEIGHT,
            -- normal font
            cfg.adjust_x_normal, cfg.adjust_y_normal, cfg.gap_y_normal,
            cfg.font_size_normal, cfg.font_face_normal,
            -- color
            global_color.text_detail)
    end



    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Debug lines
    --  This is debug
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.debug_lines then
        local cfg = get_config_debug_lines()
        drawing_debug_lines(cs, base_angle, global_const, global_color.debugging)
    end





    cairo_destroy(cr_draw)
    cairo_surface_destroy(cs)
    cr = nil
end
