--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
  "vue",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { exe = "black", filetypes = { "python" } },
--   { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

--------------------------------------------------------------------------------
--------------------- MY OWN CONFIGS SECTION -----------------------------------
--------------------------------------------------------------------------------

-- use Shift+q to format a paragraph to do wrapping at 80 chars
vim.opt.tw = 80
vim.opt.colorcolumn = "+1" -- highlight the 81st column

-- Increase timeoutlen to fix issue that causes some keybindings don't work
-- timeoutlen is the time to wait for a mapped sequence to complete (in milliseconds)
-- Default value in Vim is 1000; default value in LunarVim is 100 https://github.com/LunarVim/LunarVim/blob/68cdb62f87/lua/lvim/config/settings.lua#L28
-- To check the current value, run `:set timeoutlen?`
-- Ref: https://github.com/LunarVim/LunarVim/issues/1979
vim.opt.timeoutlen = 500

vim.cmd([[
  nnoremap <M-h> :vertical resize -5<cr>
  nnoremap <M-j> :resize +5<cr>
  nnoremap <M-k> :resize -5<cr>
  nnoremap <M-l> :vertical resize +5<cr>
  noremap <F6> :setlocal spell! spelllang=en_us<CR>
  nnoremap Q gqip

  " Each time you open a git object using fugitive it creates a new buffer. This
  " means that your buffer listing can quickly become swamped with fugitive buffers.
  " Here’s an autocommand that prevents this from becomming an issue:
  " http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
  if has("autocmd")
      autocmd BufReadPost fugitive://* set bufhidden=delete
  end

  " work around recent key binding changes
  " https://github.com/tpope/vim-fugitive/issues/1221
  " https://github.com/tpope/vim-fugitive/commit/a510b3aadf3f39711c113371c18adc48ad54e6ee#commitcomment-35424504
  autocmd FileType fugitiveblame nmap <buffer> q gq
  autocmd FileType fugitiveblame nmap <buffer> D dd
  autocmd FileType fugitive nmap <buffer> q gq
  autocmd FileType fugitive nmap <buffer> D dd



  "===============================================================================
  "--- begin vim-dadbod {{{

  " let g:dbs = {
  " \  'dev': 'mysql://user:password@host:3306'
  " \ }

  " Setup vim-dadbod-completion https://github.com/kristijanhusak/vim-dadbod-completion
  " For hrsh7th/nvim-cmp
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

  " Source is automatically added, you just need to include it in the chain complete list
  let g:completion_chain_complete_list = {
      \   'sql': [
      \    {'complete_items': ['vim-dadbod-completion']},
      \   ],
      \ }
  " Make sure `substring` is part of this list. Other items are optional for this completion source
  let g:completion_matching_strategy_list = ['exact', 'substring']
  " Useful if there's a lot of camel case items
  let g:completion_matching_ignore_case = 1

  let g:db_ui_use_nerd_fonts = 1

  "--- end vim-dadbod }}}
  "===============================================================================
]])

lvim.keys.term_mode["<C-h>"] = false -- disable C-h mapping so that it erases left char instead of hiding the term
lvim.keys.term_mode["<C-[><C-[>"] = "<C-\\><C-N>" -- press C-[ two times to switch to move mod in terminal

lvim.keys.normal_mode["<C-]>"] = ":Telescope lsp_definitions<CR>"

-- use Ctrl + l to redraw the screen and remove any search highlighs
lvim.keys.normal_mode["<C-l>"] = ":nohl<CR>"

lvim.keys.normal_mode["<leader>r"] = ":RustRunnables<CR>"

-- LunarVim find buffers: <leader>bf
lvim.keys.normal_mode[",b"] = ":Telescope buffers<CR>"

-- LunarVim open recent files: <leader>sr
lvim.keys.normal_mode[",m"] = ":Telescope oldfiles<CR>"

-- LunarVim search text in current project: <leader>st
lvim.keys.normal_mode[",s"] = ":Telescope live_grep<CR>"

lvim.keys.normal_mode[",f"] = ":Telescope find_files<CR>"

-- TODO: to remove this once https://github.com/LunarVim/LunarVim/pull/2089 is merged or there is a better solution
lvim.keys.normal_mode[",F"] = ":Telescope git_files<CR>"

lvim.keys.normal_mode[",c"] = ":BufferClose<CR>"

-- LunarVim switch to previous buffer: <leader>bb
lvim.keys.normal_mode[",<TAB>"] = ":b#<CR>"


-- To view the log, press `<Space>Lld` <Cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<CR>
-- The log file location: ~/.cache/nvim/lvim.log
local Log = require "lvim.core.log"
Log:debug("----------------- Hello world -------------")


-- copy from `lvim.builtin.which_key.opts` https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/which-key.lua
local which_key_opts = {
      mode = "n", -- NORMAL mode
      prefix = ",",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }
local which_key_mappings = {
  g = {
    name = "fugitive",

    -- fugitive: see previous revisions of the current buffer (git history)
    -- https://www.reddit.com/r/vim/comments/eu71r9/fugitivevim_how_to_see_previous_revisions_of_the/
    h = { "<cmd>0Gclog<CR>", "History (previous revisions)" },

    p = { "<cmd>Git push<CR>", "Git push" },
    e = { "<cmd>Gedit<CR>", "Edit a fugitive-object" },

    -- <c-w>K is to move the status window to the top
    s = { "<cmd>Git<cr><c-w>K:exec 'resize' . string(&lines * 0.3)<cr>", "Git status" },
  },
}

-- make use of the `on_config_done` callback to register additional keys
-- mappings while using a different prefix
lvim.builtin.which_key.on_config_done = function(which_key)
  which_key.register(which_key_mappings, which_key_opts)
end


lvim.builtin.dap.active = true
lvim.plugins = {
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,

          hover_actions = {
            -- whether the hover action window gets automatically focused
            auto_focus = true
          },
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
        })
    end,
    ft = { "rust", "rs" },
  },
  { "mfussenegger/nvim-jdtls" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" }, -- GitHub extension for fugitive.vim
  { "tpope/vim-dadbod" }, -- interacting with databases
  { "kristijanhusak/vim-dadbod-ui" }, -- UI for tpope/vim-dadbod
  { "kristijanhusak/vim-dadbod-completion" } -- Database autocompletion for vim-dadbod
}


vim.list_extend(lvim.lsp.override, { "java", "jdtls" })

-- disable auto_resize to prevent the file tree window size reset after
-- a new file is opened. Ref: https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/nvimtree.lua
lvim.builtin.nvimtree.setup.view.auto_resize = false



-- https://github.com/nvim-lualine/lualine.nvim
-- no need to set style = "lvim"
local components = require("lvim.core.lualine.components")
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_c = { {"filename", path = 2} } -- show full path to current file
lvim.builtin.lualine.sections.lualine_y = {
  components.spaces,
  components.location
}

-- disable default auto spell on markdown files. Ref: https://github.com/LunarVim/LunarVim/blob/5663c925ebef0d48732e8794c2335c118ee61e55/lua/lvim/core/autocmds.lua#L49-L52
lvim.autocommands._markdown = { { "FileType", "markdown", "setlocal wrap" } }

