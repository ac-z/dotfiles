
-- Load ~/.vimrc, for all vanilla vim-compatible configuration
vim.cmd("source ~/.vimrc")

--
-- Lazy.nvim bootstrap
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none","https://github.com/folke/lazy.nvim.git","--branch=stable",lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--
-- Lazy.nvim init
--
require("lazy").setup(
  -- Plugins table
  {
    -- Essential tools
    { "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    },
  },
  -- Opts table
  {}
)
