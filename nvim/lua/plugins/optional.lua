-- markdown preview (only when `deno` is available)
if vim.fn.executable('deno') == 0 then
  return {}
end

return {
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    lazy = true,
    cmd = 'PeekOpen',
    -- filetype = 'markdown',
    config = function ()
      require('peek').setup({
        auto_load = true,
        close_on_bdelete = true,
        syntax = true,
        theme = 'dark',
        update_on_change = true,

        -- relevant if update_on_change is true
        throttle_at = 200000,     -- start throttling when file exceeds this
                                  -- amount of bytes in size
        throttle_time = 'auto',   -- minimum amount of time in milliseconds
                                  -- that has to pass before starting new render
      })

      -- add command
      vim.api.nvim_create_user_command('PeekOpen', function()
        require('peek').open()
      end, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
}