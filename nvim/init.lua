-- =========================================================
-- User Configuration
-- =========================================================

require('config.options')  -- global options (loaded before plugins)
require('config.keymaps')  -- global key mappings

-- Create default auto group
vim.api.nvim_create_augroup('init', {})

-- Adjust format options on every buffer
vim.api.nvim_create_autocmd('bufenter', {
  group = 'init',
  pattern = {'*'},
  callback = function()
    vim.opt_local.formatoptions:remove('or')
    vim.opt_local.formatoptions:append('Mj')
  end,
})

-- ======== Autocmd =======
-- Fix: back to original cursor shape on some terminal
local term = vim.env.TERM
if term == "foot" or term == "alacritty" or term == "wezterm" then
  vim.api.nvim_create_autocmd("VimLeave", {
    callback = function ()
      vim.opt.guicursor = ""
      vim.fn.chansend(vim.v.stderr, "\x1b[ q")
    end
  })
end

-- =========================================================
-- Plugin
-- =========================================================

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugin config
require('lazy').setup({ { import = 'plugins' } })  -- all package settings with lazy.nvim
require('config.autolcd')  -- automatically change local working directory for buffers
require('config.quick-closer')  -- quickly close tiny buffers by pressing `q` in normal mode

-- vim: set sw=2 et
