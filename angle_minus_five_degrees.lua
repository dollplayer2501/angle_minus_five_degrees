--
-- this is a lua script for use in conky
--

require 'cairo'

-- It still works even if I turn it off...
-- package.path = os.getenv('HOME') .. '/.config/conky/angle_minus_five_degrees/?.lua'

require 'config'
require 'const'

require 'includes/functions'
require 'includes/conky_parse'



function _load_modules(_id)
    --
    -- This way of writing is not possible with `require`.
    --
    dofile('config/' .. _id .. '.lua')
    dofile('modules/' .. _id .. '.lua')
end


_load_modules('wall_clock_hours24')
_load_modules('wall_clock_hours12')
_load_modules('background_tiles')
_load_modules('bar_more')
_load_modules('ring_cpu')
_load_modules('ring_clock')
_load_modules('ring_more')
_load_modules('graph_cpu')
_load_modules('graph_network')
_load_modules('background_lines')
_load_modules('text_clock')
_load_modules('text_top')
_load_modules('text_detail')
_load_modules('debbug_lines')





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
    local global_const = get_const()

    -- load and set color scheme
    dofile(global_config.color_scheme)
    local global_color = get_color()





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
    -- Wall Clock - hours 24
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.wall_clock_hours24 then
        local cfg = get_config_wall_clock_hours24(global_const, global_config, TODAY_WIDTH)
        drawing_wall_clock_hours24(cr_draw,
            -- position
            cfg.center_x, cfg.center_y,
            -- Clock hands - 24 hour
            cfg.hands_radius_hour24, cfg.hands_width_hour24, cfg.hands_back_length_rate_hour24,
            -- Clock marks - 24 hour - main hand
            cfg.marks_radius_from_hour24_main, cfg.marks_radius_to_hour24_main, cfg.marks_width_hour24_main,
            -- Clock marks - 24 hour - sub hand - short (10 min)
            cfg.marks_radius_from_hour24_sub_short, cfg.marks_radius_to_hour24_sub_short, cfg.marks_width_hour24_sub_short,
            -- Clock marks - 24 hour - sub hand - long (30min)
            cfg.marks_radius_from_hour24_sub_long, cfg.marks_radius_to_hour24_sub_long, cfg.marks_width_hour24_sub_long,
            -- Clock number - 24 hour
            cfg.number_display_hour24,
            cfg.number_adjust_x_hour24, cfg.number_adjust_y_hour24,
            cfg.number_font_align_hour24, cfg.number_font_size_hour24, cfg.number_font_face_hour24, cfg.number_font_weight_hour24,
            -- etc
            cfg.hands_update_interval_mins,
            cfg.hands_hour24_fix_degree,
            cfg.hands_line_cap, cfg.marks_line_cap,
            -- color
            global_color.wall_clock)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Wall Clock - hours 12
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.wall_clock_hours12 then
        local cfg = get_config_wall_clock_hours12(global_const, global_config, TODAY_WIDTH)
        drawing_wall_clock_hours12(cr_draw,
            -- position
            cfg.center_x, cfg.center_y,
            -- Clock hands - 12 hour
            cfg.hands_radius_hour12, cfg.hands_width_hour12, cfg.hands_back_length_rate_hour12,
            -- Clock hands - minutes
            cfg.hands_radius_mins, cfg.hands_width_mins, cfg.hands_back_length_rate_mins,
            -- Clock hands - seconds
            cfg.hands_display_secs, cfg.hands_radius_secs, cfg.hands_width_secs, cfg.hands_back_length_rate_secs,
            -- Clock marks - 12 o'clock, top
            cfg.marks_display_mins00, cfg.marks_radius_from_mins00, cfg.marks_radius_to_mins00, cfg.marks_width_mins00,
            -- Clock marks - 15 minutes without 12 o'clock
            cfg.marks_display_mins15, cfg.marks_radius_from_mins15, cfg.marks_radius_to_mins15, cfg.marks_width_mins15,
            -- Clock marks - 10 minutes
            cfg.marks_radius_from_mins10, cfg.marks_radius_to_mins10, cfg.marks_width_mins10,
            -- Clock marks - 1 minute
            cfg.marks_display_mins01,
            cfg.marks_radius_from_mins, cfg.marks_radius_to_mins, cfg.marks_width_mins,
            -- Clock number - 24 hour
            cfg.number_display_mins10,
            cfg.number_adjust_x_mins10, cfg.number_adjust_y_mins10,
            cfg.number_font_align_x_mins10, cfg.number_font_size_mins10, cfg.number_font_face_mins10, cfg.number_font_weight_mins10,
            -- etc
            cfg.hands_update_interval_mins,
            cfg.hands_line_cap, cfg.marks_line_cap,
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
            global_color.background_tiles)
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
            global_const.USAGE_LIMIT.CPU,
            global_const.USAGE_LIMIT.MEMORY,
            -- bar
            cfg.bar_position_x, cfg.bar_position_y, cfg.bar_gap_y,
            cfg.bar_line_width, cfg.bar_length,
            -- caption
            cfg.caption_position_x, cfg.caption_position_y, cfg.caption_gap_y,
            cfg.caption_align, cfg.caption_font_face, cfg.caption_font_size, cfg.caption_font_weight,
            -- color
            global_color.bar_more)
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
            cfg.display_hour12_japanese_style,
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
            global_const.USAGE_LIMIT.MEMORY,
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
            global_color.background_lines, global_color.debugging)
    end


    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    -- Clock Text
    ---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    if true == global_config.display_module.text_clock then
        local cfg = get_config_text_clock(global_const, global_config)
        drawing_text_clock(cr_draw, global_conky_parse_updates, global_config,
            -- position
            cfg.position_x, cfg.position_y,
            -- hours
            cfg.hour_adjust_x, cfg.hour_adjust_y,
            cfg.hour_font_align, cfg.hour_font_size, cfg.hour_font_face,
            -- am/pm when 12 hour system is in effect
            cfg.am_pm_adjust_x, cfg.am_pm_adjust_y,
            cfg.am_pm_font_align, cfg.am_pm_font_size, cfg.am_pm_font_face,
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
            -- etc
            cfg.display_24_hour,
            cfg.display_hour12_japanese_style,
            cfg.suppression_hour_zero,
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
