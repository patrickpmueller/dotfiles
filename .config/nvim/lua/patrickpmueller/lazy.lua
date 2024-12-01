vim.keymap.set({ "n" }, "<leader>bh", ":bprevious<CR>", opts)
-- Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--    :Lazy
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup(
  {
    -- Git wrapper
    {
      "tpope/vim-fugitive",
      config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
      end
    },

    -- Undo Tree
    {
      "mbbill/undotree",
      config = function()
        vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle, { desc = "Open undo tree" })
      end
    },

    -- Emmet functionality
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

    -- vertical tab lines
    {
      "lukas-reineke/indent-blankline.nvim",
      opts = {},
      main = "ibl",
      config = function()
        require("ibl").setup()
      end
    },

    -- Auto tab width
    {
      "tpope/vim-sleuth"
    },

    -- Toggle comment
    {
      "numToStr/Comment.nvim",
      opts = {
        toggler = {
          -- Line-comment toggle keymap
          line = 'gcc',
          -- Block-comment toggle keymap
          block = 'gbc',
        },
      }
    },

    {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" }
        }
      }
    },

    -- Show key menu
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        delay = 400,
        preset = "modern",
        spec = {
          { "<leader>b", group = "[B]uffer" },
          { "<leader>s", group = "[S]earch" },
          { "<leader>p", group = "[P]re" },
          { "<leader>h", group = "[H]arpoon" },
          { "<leader>g", group = "[G]it" },
        },
      },
      keys = {
        {
          "<leader>?",
          function()
            local wk = require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },

    {
      -- Fuzzy Finder (files, lsp, etc)
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          cond = function()
            return vim.fn.executable("make") == 1
          end
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font }
      },
      config = function()
        -- Two important keymaps to use while in Telescope are:
        --  - Insert mode: <c-/>
        --  - Normal mode: ?
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
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>ba", builtin.find_files, { desc = "Add new buffer" })
        vim.keymap.set("n", "<leader>sp", builtin.git_files, { desc = "[S]earch git files in [P]roject" })

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
          { desc = "[/] Fuzzily search in current buffer" }
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
          { desc = "[S]earch [/] in Open Files" }
        )

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set(
          "n",
          "<leader>sn",
          function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
          end,
          { desc = "[S]earch [N]eovim files" }
        )
      end
    },

    {
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
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false }
    },

    -- Collection of various small independent plugins/modules
    {
      "echasnovski/mini.nvim",
      config = function()
        -- Better Around/Inside textobjects, eg:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.), eg:
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Simple and easy statusline.
        require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })

        -- Simple and easy tabline
        require("mini.tabline").setup()

        -- Setup operators, e.g:
        --  - 2gm - [M]ultiply twice
        --  - g= - Evaluate [=] text and replace with output
        --  - gmip - [M]ultiply the current [I]nner [P]aragraph once
        --  - gs - [S]ort text
        require("mini.operators").setup()

        -- Add pairs when brackets etc are typed
        require("mini.pairs").setup()

        -- Add icons to Nvim
        require("mini.icons").setup()

        -- Notifications
        require("mini.notify").setup()

        -- Move around using square brackets, eg:
        --  - ]c - go to next comment block
        --  - 2[b - go two buffers back
        --  - [I - go to first indent
        --  - ]T - go to last treesitter node
        --  - [u - redo
        --  - ]u - undo
        require("mini.bracketed").setup()

        -- Jump encoding thingy
        require("mini.jump2d").setup()

        -- Trailing Whitespace
        require("mini.trailspace").setup()
      end
    },

    -- Highlight, edit, and navigate code
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
        ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "rust", "javascript", "typescript", "java" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = { enable = true }
      },
      config = function(_, opts)
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.configs").setup(opts)
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      end
    },

    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon: [A]dd file" })
        vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
          { desc = "[H]arpoon: toggle quick [M]enu" })

        vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end,
          { desc = "[H]arpoon: select element [H] 1" })
        vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(2) end,
          { desc = "[H]arpoon: select element [J] 2" })
        vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(3) end,
          { desc = "[H]arpoon: select element [K] 3" })
        vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(4) end,
          { desc = "[H]arpoon: select element [L] 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
          { desc = "[H]arpoon: select [P]revious element" })
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
          { desc = "[H]arpoon: select [N]ext element" })
      end
    },

    {
      'williamboman/mason.nvim',
      lazy = false,
      opts = {},
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = function()
        local cmp = require('cmp')
        -- local cmp_select = { behaviour = cmp.SelectBehaviour.Select}

        cmp.setup({
          sources = {
            { name = 'nvim_lsp' },
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
          }),
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
        })
      end
    },

    -- LSP
    {
      'neovim/nvim-lspconfig',
      cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
      },
      init = function()
        -- Reserve a space in the gutter
        -- This will avoid an annoying layout shift in the screen
        vim.opt.signcolumn = 'yes'
      end,
      config = function()
        local lspconfig = require('lspconfig')
        local lsp_defaults = lspconfig.util.default_config

        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        }

        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        -- This should be executed before you configure any language server
        lsp_defaults.capabilities = vim.tbl_deep_extend(
          'force',
          lsp_defaults.capabilities,
          require('cmp_nvim_lsp').default_capabilities()
        )

        -- LspAttach is where you enable features that only work
        -- if there is a language server active in the file
        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function(event)
            local opts = { buffer = event.buf }

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          end,
        })

        require('mason-lspconfig').setup({
          ensure_installed = {},
          handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
              require('lspconfig')[server_name].setup({})
            end,
          }
        })
      end
    }

  },
  {
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or
          {
            cmd = " ",
            config = "",
            event = " ",
            favorite = " ",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            require = "󰢱 ",
            source = " ",
            start = " ",
            task = "✔ ",
            list = {
              "●",
              "➜",
              "★",
              "‒",
            },
          }
    }
  }
)
