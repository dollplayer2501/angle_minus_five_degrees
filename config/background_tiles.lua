--
-- Background (Tiles)
--

function get_config_background_tiles(_const, _config)
    return {
        -- position
        center_x = _const.CENTER_POSITION.THEME.X,
        center_y = _const.CENTER_POSITION.THEME.Y,

        -- gradient
        display_gradient = _config.display_background_gradient,
        rect_step = _const.BACKGROUND.TILES.RECT_STEP,
    }
end
