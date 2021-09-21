local wezterm = require 'wezterm';
return {
  window_padding = {
    left = 2,
    -- This will become the scrollbar width if you have enabled the scrollbar!
    right = 2,

    top = 0,
    bottom = 0,
  },

  -- font = wezterm.font("FantasqueSansMono Nerd Font Mono"),
  -- font_size=16,
  -- font = wezterm.font("FiraCode Nerd Font Mono"),
  -- font_size=13.5,

  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  font_size=13.5,

  -- font = wezterm.font("Iosevka Nerd Font Mono"),
  -- font_size=13,
  -- line_height = 0.95,

  -- font = wezterm.font("Menlo"),

  -- font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
  -- font_size=14,

  -- font = wezterm.font("Monoid Nerd Font Mono"),
  -- font_size=13,

  -- color_scheme = "MaterialOcean",
  -- color_scheme = "Obsidian",
  -- color_scheme = "OceanicMaterial",
  -- color_scheme = "Overnight Slumber",
  -- color_scheme = "Tinacious Design (Dark)",
  -- color_scheme = "Ubuntu",

  keys = {
    {key='1',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;49~'}},
    {key='2',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;50~'}},
    {key='3',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;51~'}},
    {key='4',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;52~'}},
    {key='5',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;53~'}},
    {key='6',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;54~'}},
    {key='7',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;55~'}},
    {key='8',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;56~'}},
    {key='9',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;57~'}},
    {key='0',   mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;48~'}},
    {key='Tab', mods='CTRL',          action=wezterm.action{SendString='\x1b[27;5;9~'}},
  },


  -- https://github.com/wez/wezterm/tree/main/assets/colors
  -- color_scheme = "Tomorrow Night",
  -- The color scheme below is based on the Tomorrow Night theme. The background
  -- color is customized to make it a bit brighter.
  colors = {
    background = "#242629",
    -- background = "#18191b",
    foreground = "#c5c8c6",

    cursor_bg = "#c5c8c6",
    cursor_border = "#c5c8c6",
    cursor_fg = "#1d1f21",
    selection_bg = "#373b41",
    selection_fg = "#c5c8c6",

    -- ansi black is customized to #1d1f21
    -- ansi = {"#1d1f21","#cc6666","#b5bd68","#f0c674","#81a2be","#b294bb","#8abeb7","#ffffff"},
    -- brights = {"#666666","#cc6666","#b5bd68","#f0c674","#81a2be","#b294bb","#8abeb7","#ffffff"},
    ansi = {"#1d1f21","#cc6666","#b5bd68","#e6c547","#81a2be","#b294bb","#70c0ba","#373b41"},
    brights = {"#666666","#ff3334","#9ec400","#f0c674","#81a2be","#b77ee0","#54ced6","#282a2e"},
  },

  -- term = "wezterm",
  term = "xterm-256color",
}

