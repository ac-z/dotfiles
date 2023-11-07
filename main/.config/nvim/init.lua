
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
    { 'nvim-telescope/telescope.nvim',
      tag = '0.1.4',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "hrsh7th/nvim-cmp",
      config = function()
	local cmp = require("cmp")
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = {
            { name = "codeium" },
          }
        })
      end
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- Extra features
    { 'chomosuke/term-edit.nvim',
      lazy = false,
      version = '1.3',
      config = function()
        require 'term-edit'.setup({ prompt_end = ' > ' })
      end
    },
    { "Exafunction/codeium.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
      config = function()
        require("codeium").setup({})
      end
    },
  },
  -- Opts table
  {}
)

--
-- LSP init
--
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  -- auto handler for all installed Mason LSPs
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- manual LSP handlers
  ["lua_ls"] = function ()
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          -- Get the language server to recognize the `vim` global
          diagnostics = { globals = { 'vim','require' } },
          -- Make the server aware of Neovim runtime files
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = { enable = false },
        },
      },
    }
  end
}

--
-- Other stuff
--

-- Terminal settings
vim.api.nvim_command("autocmd TermOpen * startinsert")             -- starts in insert mode
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")       -- no numbers
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column
vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>") -- make <C-w> work in terminal mode
-- You can also press <C-w><esc> to go to normal mode

-- Load ~/.vimrc, for all vanilla vim-compatible configuration
vim.cmd("source ~/.vimrc")
