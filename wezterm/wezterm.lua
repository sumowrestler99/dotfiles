local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder and wezterm.config_builder() or {}

-- ─── Font ─────────────────────────────────────────────────────────────────────
config.font = wezterm.font('IosevkaTerm Nerd Font Mono')
config.font_size = 14
config.line_height = 1.1
config.cell_width = 1.0
config.freetype_load_flags = 'NO_HINTING'

-- ─── Colour scheme (Catppuccin Mocha) ────────────────────────────────────────
config.colors = {
  foreground    = '#cdd6f4',
  background    = '#1e1e2e',
  cursor_bg     = '#f5e0dc',
  cursor_fg     = '#cdd6f4',
  cursor_border = '#f5e0dc',
  selection_fg  = '#cdd6f4',
  selection_bg  = '#585b70',
  ansi = {
    '#45475a',  -- black
    '#f38ba8',  -- red
    '#a6e3a1',  -- green
    '#f9e2af',  -- yellow
    '#89b4fa',  -- blue
    '#f5c2e7',  -- magenta
    '#94e2d5',  -- cyan
    '#bac2de',  -- white
  },
  brights = {
    '#585b70',  -- bright black
    '#f38ba8',  -- bright red
    '#a6e3a1',  -- bright green
    '#f9e2af',  -- bright yellow
    '#89b4fa',  -- bright blue
    '#f5c2e7',  -- bright magenta
    '#94e2d5',  -- bright cyan
    '#a6adc8',  -- bright white
  },
  tab_bar = {
    background = '#181825',
    active_tab = {
      bg_color  = '#89b4fa',
      fg_color  = '#1e1e2e',
      intensity = 'Normal',
    },
    inactive_tab = {
      bg_color  = '#181825',
      fg_color  = '#6c7086',
    },
    inactive_tab_hover = {
      bg_color  = '#313244',
      fg_color  = '#cdd6f4',
    },
    new_tab = {
      bg_color  = '#181825',
      fg_color  = '#6c7086',
    },
    new_tab_hover = {
      bg_color  = '#313244',
      fg_color  = '#cdd6f4',
    },
  },
}

-- ─── Rendering ────────────────────────────────────────────────────────────────
config.front_end               = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- ─── Window size ──────────────────────────────────────────────────────────────
config.initial_cols = 200
config.initial_rows = 30

-- ─── Window appearance ────────────────────────────────────────────────────────
config.window_background_opacity = 0.85
config.win32_system_backdrop     = 'Mica'
config.window_decorations        = 'TITLE|RESIZE'

config.window_padding = {
  left   = 8,
  right  = 8,
  top    = 4,
  bottom = 4,
}

config.window_frame = {
  active_titlebar_bg   = '#181825',
  inactive_titlebar_bg = '#11111b',
  border_bottom_color  = '#313244',
  border_bottom_height = '1px',
  border_left_color    = '#313244',
  border_left_width    = '1px',
  border_right_color   = '#313244',
  border_right_width   = '1px',
  border_top_height    = '0px',
  font                 = wezterm.font('IosevkaTerm Nerd Font Mono'),
  font_size            = 12,
}

-- ─── Tab bar ──────────────────────────────────────────────────────────────────
config.use_fancy_tab_bar              = false
config.tab_bar_at_bottom              = false
config.hide_tab_bar_if_only_one_tab   = true
config.tab_max_width                  = 32
config.show_new_tab_button_in_tab_bar = false

-- ─── Scrollback ───────────────────────────────────────────────────────────────
config.scrollback_lines  = 10000
config.enable_scroll_bar = false

-- ─── Bell ─────────────────────────────────────────────────────────────────────
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms  = 0,
  fade_out_duration_ms = 0,
}

-- ─── Behaviour ────────────────────────────────────────────────────────────────
config.window_close_confirmation = 'NeverPrompt'
config.skip_close_confirmation_for_processes_named = {
  'bash', 'sh', 'zsh', 'fish', 'tmux',
}
config.exit_behavior                              = 'Close'
config.adjust_window_size_when_changing_font_size = false
config.check_for_updates                          = false

-- ─── Hyperlinks ───────────────────────────────────────────────────────────────
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex  = [[[^\s]+:\d+]],
  format = '$0',
})

config.set_environment_variables = {
  BROWSER = 'wez-open',
}

-- ─── Mouse ────────────────────────────────────────────────────────────────────
config.mouse_bindings = {
  {
    event  = { Down = { streak = 1, button = 'Right' } },
    mods   = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ''
      if has_selection then
        window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.PasteFrom 'Clipboard', pane)
      end
    end),
  },
  {
    event  = { Up = { streak = 1, button = 'Left' } },
    mods   = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- ─── Keys ─────────────────────────────────────────────────────────────────────
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1500 }
config.keys = {

  -- ── Pane splitting ────────────────────────────────────────────────────────
  { key = '-',  mods = 'LEADER', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
  { key = '\\', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- ── Pane navigation ───────────────────────────────────────────────────────
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left'  },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down'  },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up'    },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- ── Tabs ──────────────────────────────────────────────────────────────────
  { key = 'c', mods = 'LEADER',       action = act.SpawnTab 'CurrentPaneDomain'  },
  { key = 'n', mods = 'LEADER',       action = act.ActivateTabRelative(1)        },
  { key = 'p', mods = 'LEADER',       action = act.ActivateTabRelative(-1)       },
  { key = 'p', mods = 'LEADER|SHIFT', action = act.SpawnCommandInNewTab {
      args = { 'pwsh.exe' }, domain = { DomainName = 'local' },
  }},
  { key = 'c', mods = 'LEADER|SHIFT', action = act.SpawnCommandInNewTab {
      args = { 'cmd.exe' }, domain = { DomainName = 'local' },
  }},

  -- ── Copy mode ─────────────────────────────────────────────────────────────
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

  -- ── Font size ─────────────────────────────────────────────────────────────
  { key = '=', mods = 'CTRL',   action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL',   action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL',   action = act.ResetFontSize    },

  -- ── Paste ─────────────────────────────────────────────────────────────────
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'CTRL',       action = act.PasteFrom 'Clipboard' },

  -- ── iTerm2: word navigation ───────────────────────────────────────────────
  { key = 'LeftArrow',  mods = 'ALT', action = act.SendString '\x1bb' },
  { key = 'RightArrow', mods = 'ALT', action = act.SendString '\x1bf' },

  -- ── iTerm2: word deletion ─────────────────────────────────────────────────
  { key = 'Backspace', mods = 'ALT',  action = act.SendString '\x1b\x7f' },
  { key = 'Delete',    mods = 'ALT',  action = act.SendString '\x1bd'    },

  -- ── iTerm2: kill to line start ────────────────────────────────────────────
  { key = 'Backspace', mods = 'CTRL', action = act.SendString '\x15' },

  -- ── iTerm2: forward delete ────────────────────────────────────────────────
  { key = 'Delete', mods = 'NONE', action = act.SendString '\x04' },

  -- ── iTerm2: Ctrl+_ ────────────────────────────────────────────────────────
  { key = '-', mods = 'CTRL|SHIFT', action = act.SendString '\x1f' },

  -- ── iTerm2: Ctrl+number control codes ────────────────────────────────────
  { key = '2', mods = 'CTRL', action = act.SendString '\x00' },
  { key = '3', mods = 'CTRL', action = act.SendString '\x1b' },
  { key = '4', mods = 'CTRL', action = act.SendString '\x1c' },
  { key = '5', mods = 'CTRL', action = act.SendString '\x1d' },
  { key = '6', mods = 'CTRL', action = act.SendString '\x1e' },
  { key = '7', mods = 'CTRL', action = act.SendString '\x1f' },
  { key = '8', mods = 'CTRL', action = act.SendString '\x7f' },
}

-- ─── Tab styling ──────────────────────────────────────────────────────────────
local LEFT  = '\u{E0B6}'
local RIGHT = '\u{E0B4}'
local SEP   = '\u{E0B5}'

local GLYPH_MAP = {
  ['bash']       = ' ',
  ['zsh']        = ' ',
  ['fish']       = '\u{F02D8} ',
  ['sh']         = ' ',
  ['nvim']       = ' ',
  ['vim']        = ' ',
  ['nano']       = ' ',
  ['hx']         = ' ',
  ['python']     = ' ',
  ['python3']    = ' ',
  ['node']       = ' ',
  ['lua']        = ' ',
  ['ruby']       = ' ',
  ['go']         = ' ',
  ['cargo']      = ' ',
  ['git']        = ' ',
  ['lazygit']    = ' ',
  ['docker']     = ' ',
  ['kubectl']    = '\u{F0CBE} ',
  ['htop']       = ' ',
  ['btop']       = ' ',
  ['top']        = ' ',
  ['ssh']        = '\u{F08C0} ',
  ['tmux']       = ' ',
  ['make']       = ' ',
  ['curl']       = ' ',
  ['wget']       = ' ',
  ['wsl']        = ' ',
  ['powershell'] = '\u{F0A22} ',
  ['pwsh']       = '\u{F0A22} ',
  ['cmd']        = ' ',
  ['default']    = ' ',
}

local function get_glyph(process)
  local name = process:match('([^/\\]+)$') or process
  name = name:lower():gsub('%.exe$', '')
  return GLYPH_MAP[name] or GLYPH_MAP['default']
end

wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
  local active_bg   = '#89b4fa'  -- Catppuccin blue
  local active_fg   = '#1e1e2e'  -- base
  local inactive_bg = '#181825'  -- mantle
  local inactive_fg = '#6c7086'  -- overlay0
  local bar_bg      = '#181825'  -- mantle
  local sep_fg      = '#45475a'  -- surface1

  local process = tab.active_pane.foreground_process_name
  local glyph   = get_glyph(process)
  local index   = string.format('%d', tab.tab_index + 1)

  -- Use current directory, fall back to pane title
  local cwd_uri = tab.active_pane.current_working_dir
  local title
  if cwd_uri then
    local cwd = cwd_uri.file_path
    -- Show only the last component (basename)
    title = cwd:match('([^/]+)/?$') or cwd
  else
    title = tab.active_pane.title
  end
  if #title > max_width - 6 then
    title = wezterm.truncate_right(title, max_width - 6) .. '…'
  end

  local bg = tab.is_active and active_bg or inactive_bg
  local fg = tab.is_active and active_fg or inactive_fg

  local next_tab = tabs[tab.tab_index + 2]
  local next_bg  = bar_bg
  if next_tab then
    next_bg = next_tab.is_active and active_bg or inactive_bg
  end

  local right_sep, right_sep_bg, right_sep_fg
  if not tab.is_active and (not next_tab or not next_tab.is_active) then
    right_sep    = SEP
    right_sep_fg = sep_fg
    right_sep_bg = inactive_bg
  else
    right_sep    = RIGHT
    right_sep_fg = bg
    right_sep_bg = next_bg
  end

  return {
    { Background = { Color = bar_bg } },
    { Foreground = { Color = bg     } },
    { Text = LEFT                     },
    { Background = { Color = bg     } },
    { Foreground = { Color = fg     } },
    { Attribute = { Intensity = tab.is_active and 'Bold' or 'Normal' } },
    { Text = ' ' .. index .. ' ' .. glyph .. title .. ' ' },
    { Background = { Color = right_sep_bg } },
    { Foreground = { Color = right_sep_fg } },
    { Text = right_sep                      },
  }
end)

return config
