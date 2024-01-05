
-- Terminal settings
vim.api.nvim_command("autocmd TermOpen * startinsert")             -- starts in insert mode
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")       -- no numbers
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column
-- You can also press <C-w><esc> to go to normal mode
vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>") -- make <C-w> work in terminal mode
-- Colors
vim.api.nvim_command("hi IblIndent guifg=#505050") -- 
vim.api.nvim_command("hi IblScope guifg=#909090") -- 
-- Disable middle click paste
vim.keymap.set('n', '<MiddleMouse>', '<Nop>')
vim.keymap.set('n', '<1-MiddleMouse>', '<Nop>')
vim.keymap.set('n', '<2-MiddleMouse>', '<Nop>')
vim.keymap.set('n', '<3-MiddleMouse>', '<Nop>')
vim.keymap.set('n', '<4-MiddleMouse>', '<Nop>')
-- split new terminal with alt+enter
vim.keymap.set('n', '<M-CR>', ':split +term<CR>')

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
      {
        "willothy/flatten.nvim",
        config = true,
        -- or pass configuration with
        -- opts = {  }
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
      },
    { 'nvim-telescope/telescope.nvim',
      tag = '0.1.4',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ['<C-j>'] = function(fallback)
              if cmp.visible() then cmp.select_next_item() else fallback() end
            end,
            ['<C-k>'] = function(fallback)
              if cmp.visible() then cmp.select_prev_item() else fallback() end
            end,
            ['<Tab>'] = function(fallback)
              if cmp.visible() then cmp.select_next_item() else fallback() end
            end,
            ['<S-Tab>'] = function(fallback)
              if cmp.visible() then cmp.select_prev_item() else fallback() end
            end,
            ['<C-l>'] = function(fallback)
              if cmp.visible() then cmp.select_next_item({ count = 15}) else fallback() end
            end,
            ['<C-h>'] = function(fallback)
              if cmp.visible() then cmp.select_prev_item({ count = 15}) else fallback() end
            end,
            ['<C-S-k>'] = function(fallback)
              if cmp.visible() then cmp.scroll_docs(-20) else fallback() end
            end,
            ['<C-S-j>'] = function(fallback)
              if cmp.visible() then cmp.scroll_docs(-20) else fallback() end
            end,
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = {
            { name = "codeium" },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }
        })
      end
    },
    { "sudormrfbin/cheatsheet.nvim",
      config = function()
        require("cheatsheet").setup({
          -- Whether to show bundled cheatsheets

          -- For generic cheatsheets like default, unicode, nerd-fonts, etc
          -- bundled_cheatsheets = {
          --     enabled = {},
          --     disabled = {},
          -- },
          bundled_cheatsheets = true,

          -- For plugin specific cheatsheets
          -- bundled_plugin_cheatsheets = {
          --     enabled = {},
          --     disabled = {},
          -- }
          bundled_plugin_cheatsheets = true,

          -- For bundled plugin cheatsheets, do not show a sheet if you
          -- don't have the plugin installed (searches runtimepath for
          -- same directory name)
          include_only_installed_plugins = true,

          -- Key mappings bound inside the telescope window
          telescope_mappings = {
            ['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
            ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
            ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
            ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
          }
        })
      end
    },
    { "lewis6991/gitsigns.nvim",
      config = function()
        require('gitsigns').setup {
          signs = {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '-' },
            topdelete    = { text = '^' },
            changedelete = { text = '~' },
            untracked    = { text = '+' },
          },
          numhl = true
        }
      end
    },
    { "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
      config = function()
        require("ibl").setup({
          indent = { char = "▏" }, 
        })
      end
    },
    { "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    "williamboman/mason.nvim",
    { "williamboman/mason-lspconfig.nvim", lazy = false },
    "rust-lang/rust.vim",
    "hrsh7th/cmp-nvim-lsp",
    { "folke/trouble.nvim",
      opts = { icons = false },
    },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    { "nvim-treesitter/nvim-treesitter", lazy = false },
    { "neovim/nvim-lspconfig", lazy = false },
    {
      "amrbashir/nvim-docs-view",
      lazy = true,
      cmd = "DocsViewToggle",
      opts = {
        position = "right",
        width = 60
      }
    },
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
  end,
  ["rust_analyzer"] = function ()
    local lspconfig = require('lspconfig')
    lspconfig.rust_analyzer.setup({
      root_dir = lspconfig.util.root_pattern('Cargo.toml'),
    })
  end
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Load ~/.vimrc, for all vanilla vim-compatible configuration
vim.cmd("source ~/.vimrc")
