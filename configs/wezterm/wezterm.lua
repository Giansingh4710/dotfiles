local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "Catppuccin" -- or choose a scheme like 'NightFox', 'Dracula', etc.
config.macos_window_background_blur = 50
config.window_background_opacity = 0.7
config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
config.enable_kitty_graphics = true

local function adjust_blur(window, delta)
  local overrides = window:get_config_overrides() or {}
  local current_blur = overrides.macos_window_background_blur or config.macos_window_background_blur

  local new_blur = current_blur + delta
  if new_blur < 0 then
    new_blur = 0
  elseif new_blur > 100 then
    new_blur = 100
  end

  overrides.macos_window_background_blur = new_blur
  window:set_config_overrides(overrides)
end

local function toggle_transparence(window)
  local overrides = window:get_config_overrides() or {}
  local current_blur = overrides.macos_window_background_blur or config.macos_window_background_blur

  local blur_on = current_blur > 50
  local new_blur = 100
  if blur_on then
    new_blur = 0
  end

  overrides.macos_window_background_blur = new_blur
  window:set_config_overrides(overrides)
end


-- wezterm.on('window-focus-changed', function(window, pane) window:toast_notification('Changed', 'window focus', nil, 40000) end)
config.keys = {
  -- { key = "n", mods = "CMD|SHIFT", action = wezterm.action_callback(function(window, pane) end), },
  -- Toggle blur with CMD+Shift+T
  {
    key = "t",
    mods = "CMD|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      toggle_transparence(window)
    end),
  },

  -- Increase blur with CMD+Shift+Up
  {
    key = "UpArrow",
    mods = "CMD|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      adjust_blur(window, 5)
    end),
  },

  -- Decrease blur with CMD+Shift+Down
  {
    key = "DownArrow",
    mods = "CMD|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      adjust_blur(window, -5)
    end),
  },

  -- Show a pop-up notification with the keybindings (CMD+Shift+K)
  {
    key = "K",
    mods = "CMD|SHIFT",
    action = wezterm.action_callback(function(window, pane)
      window:toast_notification(
        "wezterm",
        "Reminder: CMD+Shift+Up to increase blur, CMD+Shift+Down to decrease blur",
        nil,
        4000
      )
    end),
  },
}

return config
