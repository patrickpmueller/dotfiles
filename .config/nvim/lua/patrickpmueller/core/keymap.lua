---------------------------
-- Keymaps Configuration --
---------------------------
local opts = {silent = true, noremap = true}

-------------------
-- Terminal mode --
-------------------
opts.desc = "Exit terminal mode"
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)


---------------------------
-- Normal & visual modes --
---------------------------

-- Improved clipboard
opts.desc = "Copy into system clipboard"
vim.keymap.set({"n", "x"}, "gy", '"+y', opts)

opts.desc = "Cut into system clipboard"
vim.keymap.set({"n", "x"}, "gd", '"+d', opts)

opts.desc = "Paste from system clipboard"
vim.keymap.set({"n", "x"}, "gp", '"+p', opts)

opts.desc = "Delete char without cutting"
vim.keymap.set({"n", "x"}, "x", '"_x', opts)

opts.desc = "Delete selection without cutting"
vim.keymap.set({"n", "x"}, "X", '"_d', opts)

-- Better window navigation
opts.desc = "Move window focus left"
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)

opts.desc = "Move window focus down"
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)

opts.desc = "Move window focus up"
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)

opts.desc = "Move window focus right"
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)


-- Resize with arrows
-- delta: 2 lines
opts.desc = "Resize window smaller vertically"
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)

opts.desc = "Resize window larger vertically"
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)


opts.desc = "Resize window smaller horizontally"
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)

opts.desc = "Resize window larger horizontally"
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)


-----------------
-- Normal mode --
-----------------

-- Buffer movement
opts.desc = "Delete buffer"
vim.keymap.set({"n"}, "<leader>bq", ":bdelete<CR>", opts)
vim.keymap.set({"n"}, "<leader>bd", ":bdelete<CR>", opts)

-- Hide highlight after <Esc> pressed
opts.desc = "Stop higlighting search"
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Ex mode
opts.desc = "[P]re[V]ious"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, opts)
