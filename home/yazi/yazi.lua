-- local catppuccin_theme = require('yatline-catppuccin'):setup 'mocha' -- or "latte" | "frappe" | "macchiato"
require('git'):setup()
require('starship'):setup()
require('bunny'):setup {
  hops = {
    { key = '/', path = '/' },
    { key = 't', path = '/tmp' },
    { key = 'n', path = '/nix/store', desc = 'Nix store' },
    { key = 'h', path = '~', desc = 'Home' },
    { key = 'm', path = '~/Music', desc = 'Music' },
    { key = 'd', path = '~/Downloads', desc = 'Downloads' },
    { key = 'D', path = '~/Documents', desc = 'Documents' },
    { key = 'c', path = '~/.config', desc = 'Config files' },
    { key = { 'l', 's' }, path = '~/.local/share', desc = 'Local share' },
    { key = { 'l', 'b' }, path = '~/.local/bin', desc = 'Local bin' },
    { key = { 'l', 't' }, path = '~/.local/state', desc = 'Local state' },
    -- key and path attributes are required, desc is optional
  },
  desc_strategy = 'path', -- If desc isn't present, use "path" or "filename", default is "path"
  ephemeral = true, -- Enable ephemeral hops, default is true
  tabs = true, -- Enable tab hops, default is true
  notify = false, -- Notify after hopping, default is false
  fuzzy_cmd = 'fzf', -- Fuzzy searching command, default is "fzf"
}
--TODO:https://github.com/imsi32/yatline.yazi/issues/59
-- require('yatline'):setup {
--   show_background = false,
--
--   theme = catppuccin_theme,
--
--   status_line = {
--     left = {
--       section_a = {
--         { type = 'string', custom = false, name = 'tab_mode' },
--       },
--       section_b = {
--         { type = 'string', custom = false, name = 'hovered_size' },
--       },
--       section_c = {
--         { type = 'string', custom = false, name = 'hovered_path' },
--         { type = 'coloreds', custom = false, name = 'count' },
--       },
--     },
--     right = {
--       section_a = {
--         { type = 'string', custom = false, name = 'cursor_position' },
--       },
--       section_b = {
--         { type = 'string', custom = false, name = 'cursor_percentage' },
--       },
--       section_c = {
--         { type = 'string', custom = false, name = 'hovered_file_extension', params = { true } },
--         { type = 'coloreds', custom = false, name = 'permissions' },
--       },
--     },
--   },
-- }
