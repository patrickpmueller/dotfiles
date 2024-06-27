--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 17

vim.opt.termguicolors = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Tabstop settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})

-- Set relative line numbers when in insert mode
vim.cmd([[
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber 
]])

-- Improved clipboard
vim.keymap.set({"n", "x"}, "gy", '"+y')
vim.keymap.set({"n", "x"}, "gd", '"+d')
vim.keymap.set({"n", "x"}, "gp", '"+p')
vim.keymap.set({"n", "x"}, "x", '"_x')
vim.keymap.set({"n", "x"}, "X", '"_d')

-- buffer movement
vim.keymap.set({"n"}, "<leader>bl", ":bnext<CR>")
vim.keymap.set({"n"}, "<leader>bh", ":bprevious<CR>")
vim.keymap.set({"n"}, "<leader>bq", ":bdelete<CR>")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}),
        callback = function()
            vim.highlight.on_yank()
        end
    }
)

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup(
    {
        -- Top info bar
        {
            "akinsho/bufferline.nvim",
            version = "*",
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require("bufferline").setup()
            end
        },
        {
            "mattn/emmet-vim",
            config = function()
                vim.cmd [[
        let g:user_emmet_mode='a'
        let g:user_emmet_leader_key='<C-E>'
        let g:user_emmet_install_global = 0
        autocmd FileType html,css EmmetInstall
      ]]
            end
        },
        -- Trouble error menu
        {
            "folke/trouble.nvim",
            config = function()
                -- Trouble LSP
                local trouble_config = {
                    auto_close = false, -- auto close when there are no items
                    auto_open = false, -- auto open when there are items
                    auto_preview = true, -- automatically open preview when on an item
                    auto_refresh = true, -- auto refresh when open
                    focus = false, -- Focus the window when opened
                    restore = true, -- restores the last location in the list when opening
                    follow = true, -- Follow the current item
                    indent_guides = true, -- show indent guides
                    max_items = 200, -- limit number of items that can be displayed per section
                    multiline = true, -- render multi-line messages
                    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
                    ---@type trouble.Window.opts
                    win = {}, -- window options for the results window. Can be a split or a floating window.
                    -- Window options for the preview window. Can be a split, floating window,
                    -- or `main` to show the preview in the main editor window.
                    ---@type trouble.Window.opts
                    preview = {type = "main"},
                    -- Throttle/Debounce settings. Should usually not be changed.
                    ---@type table<string, number|{ms:number, debounce?:boolean}>
                    throttle = {
                        refresh = 20, -- fetches new data when needed
                        update = 10, -- updates the window
                        render = 10, -- renders the window
                        follow = 10, -- follows the current item
                        preview = {ms = 100, debounce = true} -- shows the preview for the current item
                    },
                    -- Key mappings can be set to the name of a builtin action,
                    -- or you can define your own custom action.
                    ---@type table<string, string|trouble.Action>
                    keys = {
                        ["?"] = "help",
                        r = "refresh",
                        R = "toggle_refresh",
                        q = "close",
                        o = "jump_close",
                        ["<esc>"] = "cancel",
                        ["<cr>"] = "jump",
                        ["<2-leftmouse>"] = "jump",
                        ["<c-s>"] = "jump_split",
                        ["<c-v>"] = "jump_vsplit",
                        -- go down to next item (accepts count)
                        -- j = "next",
                        ["}"] = "next",
                        ["]]"] = "next",
                        -- go up to prev item (accepts count)
                        -- k = "prev",
                        ["{"] = "prev",
                        ["[["] = "prev",
                        i = "inspect",
                        p = "preview",
                        P = "toggle_preview",
                        zo = "fold_open",
                        zO = "fold_open_recursive",
                        zc = "fold_close",
                        zC = "fold_close_recursive",
                        za = "fold_toggle",
                        zA = "fold_toggle_recursive",
                        zm = "fold_more",
                        zM = "fold_close_all",
                        zr = "fold_reduce",
                        zR = "fold_open_all",
                        zx = "fold_update",
                        zX = "fold_update_all",
                        zn = "fold_disable",
                        zN = "fold_enable",
                        zi = "fold_toggle_enable"
                    },
                    ---@type table<string, trouble.Mode>
                    modes = {
                        symbols = {
                            desc = "document symbols",
                            mode = "lsp_document_symbols",
                            focus = false,
                            win = {position = "right"},
                            filter = {
                                -- remove Package since luals uses it for control flow structures
                                ["not"] = {ft = "lua", kind = "Package"},
                                any = {
                                    -- all symbol kinds for help / markdown files
                                    ft = {"help", "markdown"},
                                    -- default set of symbol kinds
                                    kind = {
                                        "Class",
                                        "Constructor",
                                        "Enum",
                                        "Field",
                                        "Function",
                                        "Interface",
                                        "Method",
                                        "Module",
                                        "Namespace",
                                        "Package",
                                        "Property",
                                        "Struct",
                                        "Trait"
                                    }
                                }
                            }
                        }
                    },
                    -- stylua: ignore
                    icons = {
                        ---@type trouble.Indent.symbols
                        indent = {
                            top = "│ ",
                            middle = "├╴",
                            last = "└╴",
                            -- last          = "-╴",
                            -- last       = "╰╴", -- rounded
                            fold_open = " ",
                            fold_closed = " ",
                            ws = "  "
                        },
                        folder_closed = " ",
                        folder_open = " ",
                        kinds = {
                            Array = " ",
                            Boolean = "󰨙 ",
                            Class = " ",
                            Constant = "󰏿 ",
                            Constructor = " ",
                            Enum = " ",
                            EnumMember = " ",
                            Event = " ",
                            Field = " ",
                            File = " ",
                            Function = "󰊕 ",
                            Interface = "",
                            Key = " ",
                            Method = "󰊕 ",
                            Module = " ",
                            Namespace = "󰦮 ",
                            Null = "󰟢 ",
                            Number = "󰎠 ",
                            Object = " ",
                            Operator = " ",
                            Package = " ",
                            Property = " ",
                            String = " ",
                            Struct = " ",
                            TypeParameter = " ",
                            Variable = "󰀫 "
                        }
                    }
                }
                require("trouble").setup(trouble_config)
            end
        },
        -- vertical tab lines
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {},
            config = function()
                require("ibl").setup()
            end
        },
        -- CoC - autocompletion
        {
            "neoclide/coc.nvim",
            branch = "release",
            config = function()
                -- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

                -- Some servers have issues with backup files, see #649
                vim.opt.backup = false
                vim.opt.writebackup = false

                -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
                -- delays and poor user experience
                vim.opt.updatetime = 300

                -- Always show the signcolumn, otherwise it would shift the text each time
                -- diagnostics appeared/became resolved
                vim.opt.signcolumn = "yes"

                local keyset = vim.keymap.set
                -- Autocomplete
                function _G.check_back_space()
                    local col = vim.fn.col(".") - 1
                    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
                end

                -- Use Tab for trigger completion with characters ahead and navigate
                -- NOTE: There's always a completion item selected by default, you may want to enable
                -- no select by setting `"suggest.noselect": true` in your configuration file
                -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
                -- other plugins before putting this into your config
                local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
                keyset(
                    "i",
                    "<TAB>",
                    'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
                    opts
                )
                keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

                -- Make <CR> to accept selected completion item or notify coc.nvim to format
                -- <C-g>u breaks current undo, please make your own choice
                keyset(
                    "i",
                    "<cr>",
                    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
                    opts
                )

                -- Use <c-j> to trigger snippets
                keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
                -- Use <c-space> to trigger completion
                keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

                -- Use `[g` and `]g` to navigate diagnostics
                -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
                keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
                keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

                -- GoTo code navigation
                keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
                keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
                keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
                keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

                -- Use K to show documentation in preview window
                function _G.show_docs()
                    local cw = vim.fn.expand("<cword>")
                    if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
                        vim.api.nvim_command("h " .. cw)
                    elseif vim.api.nvim_eval("coc#rpc#ready()") then
                        vim.fn.CocActionAsync("doHover")
                    else
                        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
                    end
                end
                keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", {silent = true})

                -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
                vim.api.nvim_create_augroup("CocGroup", {})
                vim.api.nvim_create_autocmd(
                    "CursorHold",
                    {
                        group = "CocGroup",
                        command = "silent call CocActionAsync('highlight')",
                        desc = "Highlight symbol under cursor on CursorHold"
                    }
                )

                -- Symbol renaming
                keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

                -- Formatting selected code
                keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
                keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

                -- Setup formatexpr specified filetype(s)
                vim.api.nvim_create_autocmd(
                    "FileType",
                    {
                        group = "CocGroup",
                        pattern = "typescript,json",
                        command = "setl formatexpr=CocAction('formatSelected')",
                        desc = "Setup formatexpr specified filetype(s)."
                    }
                )

                -- Update signature help on jump placeholder
                vim.api.nvim_create_autocmd(
                    "User",
                    {
                        group = "CocGroup",
                        pattern = "CocJumpPlaceholder",
                        command = "call CocActionAsync('showSignatureHelp')",
                        desc = "Update signature help on jump placeholder"
                    }
                )

                -- Apply codeAction to the selected region
                -- Example: `<leader>aap` for current paragraph
                local opts = {silent = true, nowait = true}
                keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
                keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

                -- Remap keys for apply code actions at the cursor position.
                keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
                -- Remap keys for apply source code actions for current file.
                keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
                -- Apply the most preferred quickfix action on the current line.
                keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

                -- Remap keys for apply refactor code actions.
                keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", {silent = true})
                keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", {silent = true})
                keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", {silent = true})

                -- Run the Code Lens actions on the current line
                keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

                -- Map function and class text objects
                -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
                keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
                keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
                keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
                keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
                keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
                keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
                keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
                keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

                -- Remap <C-f> and <C-b> to scroll float windows/popups
                ---@diagnostic disable-next-line: redefined-local
                local opts = {silent = true, nowait = true, expr = true}
                keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
                keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
                keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
                keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
                keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
                keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

                -- Use CTRL-S for selections ranges
                -- Requires 'textDocument/selectionRange' support of language server
                keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
                keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

                -- Add `:Format` command to format current buffer
                vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

                -- " Add `:Fold` command to fold current buffer
                vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = "?"})

                -- Add `:OR` command for organize imports of the current buffer
                vim.api.nvim_create_user_command(
                    "OR",
                    "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
                    {}
                )

                -- Add (Neo)Vim's native statusline support
                -- NOTE: Please see `:h coc-status` for integrations with external plugins that
                -- provide custom statusline: lightline.vim, vim-airline
                vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

                -- Mappings for CoCList
                -- code actions and coc stuff
                ---@diagnostic disable-next-line: redefined-local
                local opts = {silent = true, nowait = true}
                -- Show all diagnostics
                keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
                -- Manage extensions
                keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
                -- Show commands
                keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
                -- Find symbol of current document
                keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
                -- Search workspace symbols
                keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
                -- Do default action for next item
                keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
                -- Do default action for previous item
                keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
                -- Resume latest coc list
                keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
            end
        },
        -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
        "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
        -- NOTE: Plugins can also be added by using a table,
        -- with the first argument being the link and the following
        -- keys can be used to configure plugin behavior/loading/etc.
        --
        -- Use `opts = {}` to force a plugin to be loaded.
        --
        --  This is equivalent to:
        --    require('Comment').setup({})

        -- "gc" to comment visual regions/lines
        {"numToStr/Comment.nvim", opts = {}},
        -- Here is a more advanced example where we pass configuration
        -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
        --    require('gitsigns').setup({ ... })
        --
        -- See `:help gitsigns` to understand what the configuration keys do
        {
            -- Adds git related signs to the gutter, as well as utilities for managing changes
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = {text = "+"},
                    change = {text = "~"},
                    delete = {text = "_"},
                    topdelete = {text = "‾"},
                    changedelete = {text = "~"}
                }
            }
        },
        -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
        --
        -- This is often very useful to both group configuration, as well as handle
        -- lazy loading plugins that don't need to be loaded immediately at startup.
        --
        -- For example, in the following configuration, we use:
        --  event = 'VimEnter'
        --
        -- which loads which-key before all the UI elements are loaded. Events can be
        -- normal autocommands events (`:help autocmd-events`).
        --
        -- Then, because we use the `config` key, the configuration only runs
        -- after the plugin has been loaded:
        --  config = function() ... end

        {
            -- Useful plugin to show you pending keybinds.
            "folke/which-key.nvim",
            event = "VimEnter", -- Sets the loading event to 'VimEnter'
            config = function()
                -- This is the function that runs, AFTER loading
                require("which-key").setup()

                -- Document existing key chains
                require("which-key").register(
                    {
                        ["<leader>c"] = {name = "[C]ode", _ = "which_key_ignore"},
                        ["<leader>d"] = {name = "[D]ocument", _ = "which_key_ignore"},
                        ["<leader>r"] = {name = "[R]ename", _ = "which_key_ignore"},
                        ["<leader>s"] = {name = "[S]earch", _ = "which_key_ignore"},
                        ["<leader>w"] = {name = "[W]orkspace", _ = "which_key_ignore"},
                        ["<leader>t"] = {name = "[T]oggle", _ = "which_key_ignore"},
                        ["<leader>h"] = {name = "Git [H]unk", _ = "which_key_ignore"}
                    }
                )
                -- visual mode
                require("which-key").register(
                    {
                        ["<leader>h"] = {"Git [H]unk"}
                    },
                    {mode = "v"}
                )
            end
        },
        -- NOTE: Plugins can specify dependencies.
        --
        -- The dependencies are proper plugin specifications as well - anything
        -- you do for a plugin at the top level, you can do for a dependency.
        --
        -- Use the `dependencies` key to specify the dependencies of a particular plugin

        {
            -- Fuzzy Finder (files, lsp, etc)
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    -- If encountering errors, see telescope-fzf-native README for installation instructions
                    "nvim-telescope/telescope-fzf-native.nvim",
                    -- `build` is used to run some command when the plugin is installed/updated.
                    -- This is only run then, not every time Neovim starts up.
                    build = "make",
                    -- `cond` is a condition used to determine whether this plugin should be
                    -- installed and loaded.
                    cond = function()
                        return vim.fn.executable("make") == 1
                    end
                },
                {"nvim-telescope/telescope-ui-select.nvim"},
                -- Useful for getting pretty icons, but requires a Nerd Font.
                {"nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font}
            },
            config = function()
                -- Telescope is a fuzzy finder that comes with a lot of different things that
                -- it can fuzzy find! It's more than just a "file finder", it can search
                -- many different aspects of Neovim, your workspace, LSP, and more!
                --
                -- The easiest way to use Telescope, is to start by doing something like:
                --  :Telescope help_tags
                --
                -- After running this command, a window will open up and you're able to
                -- type in the prompt window. You'll see a list of `help_tags` options and
                -- a corresponding preview of the help.
                --
                -- Two important keymaps to use while in Telescope are:
                --  - Insert mode: <c-/>
                --  - Normal mode: ?
                --
                -- This opens a window that shows you all of the keymaps for the current
                -- Telescope picker. This is really useful to discover what Telescope can
                -- do as well as how to actually do it!

                -- [[ Configure Telescope ]]
                -- See `:help telescope` and `:help telescope.setup()`
                require("telescope").setup(
                    {
                        -- You can put your default mappings / updates / etc. in here
                        --  All the info you're looking for is in `:help telescope.setup()`
                        --
                        -- defaults = {
                        --   mappings = {
                        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                        --   },
                        -- },
                        -- pickers = {}
                        extensions = {
                            ["ui-select"] = {
                                require("telescope.themes").get_dropdown()
                            }
                        }
                    }
                )

                -- Enable Telescope extensions if they are installed
                pcall(require("telescope").load_extension, "fzf")
                pcall(require("telescope").load_extension, "ui-select")

                -- See `:help telescope.builtin`
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>sh", builtin.help_tags, {desc = "[S]earch [H]elp"})
                vim.keymap.set("n", "<leader>sk", builtin.keymaps, {desc = "[S]earch [K]eymaps"})
                vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "[S]earch [F]iles"})
                vim.keymap.set("n", "<leader>ss", builtin.builtin, {desc = "[S]earch [S]elect Telescope"})
                vim.keymap.set("n", "<leader>sw", builtin.grep_string, {desc = "[S]earch current [W]ord"})
                vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "[S]earch by [G]rep"})
                vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {desc = "[S]earch [D]iagnostics"})
                vim.keymap.set("n", "<leader>sr", builtin.resume, {desc = "[S]earch [R]esume"})
                vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {desc = '[S]earch Recent Files ("." for repeat)'})
                vim.keymap.set("n", "<leader><leader>", builtin.buffers, {desc = "[ ] Find existing buffers"})
                vim.keymap.set("n", "<leader>ba", builtin.find_files, {desc = "Add new buffer"})

                -- Slightly advanced example of overriding default behavior and theme
                vim.keymap.set(
                    "n",
                    "<leader>/",
                    function()
                        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                        builtin.current_buffer_fuzzy_find(
                            require("telescope.themes").get_dropdown(
                                {
                                    winblend = 10,
                                    previewer = false
                                }
                            )
                        )
                    end,
                    {desc = "[/] Fuzzily search in current buffer"}
                )

                -- It's also possible to pass additional configuration options.
                --  See `:help telescope.builtin.live_grep()` for information about particular keys
                vim.keymap.set(
                    "n",
                    "<leader>s/",
                    function()
                        builtin.live_grep(
                            {
                                grep_open_files = true,
                                prompt_title = "Live Grep in Open Files"
                            }
                        )
                    end,
                    {desc = "[S]earch [/] in Open Files"}
                )

                -- Shortcut for searching your Neovim configuration files
                vim.keymap.set(
                    "n",
                    "<leader>sn",
                    function()
                        builtin.find_files({cwd = vim.fn.stdpath("config")})
                    end,
                    {desc = "[S]earch [N]eovim files"}
                )
            end
        },
        {
            -- You can easily change to a different colorscheme.
            -- Change the name of the colorscheme plugin below, and then
            -- change the command in the config to whatever the name of that colorscheme is.
            --
            -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
            "shaunsingh/nord.nvim",
            priority = 1000, -- Make sure to load this before all the other start plugins.
            init = function()
                -- Load the colorscheme here.
                -- Like many other themes, this one has different styles, and you could load
                -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
                vim.cmd.colorscheme("nord")
            end
        },
        -- Highlight todo, notes, etc in comments
        {
            "folke/todo-comments.nvim",
            event = "VimEnter",
            dependencies = {"nvim-lua/plenary.nvim"},
            opts = {signs = false}
        },
        {
            -- Collection of various small independent plugins/modules
            "echasnovski/mini.nvim",
            config = function()
                -- Better Around/Inside textobjects
                --
                -- Examples:
                --  - va)  - [V]isually select [A]round [)]paren
                --  - yinq - [Y]ank [I]nside [N]ext [']quote
                --  - ci'  - [C]hange [I]nside [']quote
                require("mini.ai").setup({n_lines = 500})

                -- Add/delete/replace surroundings (brackets, quotes, etc.)
                --
                -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
                -- - sd'   - [S]urround [D]elete [']quotes
                -- - sr)'  - [S]urround [R]eplace [)] [']
                require("mini.surround").setup()

                -- Simple and easy statusline.
                --  You could remove this setup call if you don't like it,
                --  and try some other statusline plugin
                local statusline = require("mini.statusline")
                -- set use_icons to true if you have a Nerd Font
                statusline.setup({use_icons = vim.g.have_nerd_font})

                -- You can configure sections in the statusline by overriding their
                -- default behavior. For example, here we set the section for
                -- cursor location to LINE:COLUMN
                ---@diagnostic disable-next-line: duplicate-set-field
                statusline.section_location = function()
                    return "%2l:%-2v"
                end

                -- ... and there is more!
                --  Check out: https://github.com/echasnovski/mini.nvim
            end
        },
        {
            -- Highlight, edit, and navigate code
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc"},
                -- Autoinstall languages that are not installed
                auto_install = true,
                highlight = {
                    enable = true,
                    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                    --  If you are experiencing weird indenting issues, add the language to
                    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                    additional_vim_regex_highlighting = {"ruby"}
                },
                indent = {enable = true, disable = {"ruby"}}
            },
            config = function(_, opts)
                -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

                -- Prefer git instead of curl in order to improve connectivity in some environments
                require("nvim-treesitter.install").prefer_git = true
                ---@diagnostic disable-next-line: missing-fields
                require("nvim-treesitter.configs").setup(opts)

                -- There are additional nvim-treesitter modules that you can use to interact
                -- with nvim-treesitter. You should go explore a few and see what interests you:
                --
                --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
                --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
                --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            end
        }

        -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
        -- init.lua. If you want these files, they are in the repository, so you can just download them and
        -- place them in the correct locations.

        -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
        --
        --  Here are some example plugins that I've included in the Kickstart repository.
        --  Uncomment any of the lines below to enable them (you will need to restart nvim).
        --
        -- require 'kickstart.plugins.debug',
        -- require 'kickstart.plugins.indent_line',
        -- require 'kickstart.plugins.lint',
        -- require 'kickstart.plugins.autopairs',
        -- require 'kickstart.plugins.neo-tree',
        -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

        -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
        --    This is the easiest way to modularize your config.
        --
        --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
        --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
        -- { import = 'custom.plugins' },
    },
    {
        ui = {
            -- If you are using a Nerd Font: set icons to an empty table which will use the
            -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
            icons = vim.g.have_nerd_font and {} or
                {
                    cmd = "⌘",
                    config = "🛠",
                    event = "📅",
                    ft = "📂",
                    init = "⚙",
                    keys = "🗝",
                    plugin = "🔌",
                    runtime = "💻",
                    require = "🌙",
                    source = "📄",
                    start = "🚀",
                    task = "📌",
                    lazy = "💤 "
                }
        }
    }
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
