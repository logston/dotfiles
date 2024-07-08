---
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd

-- map arrow keys to pane shifts
map("n", "<Up>", "C-w><C-k>", { noremap = true })
map("n", "<Down>", "C-w><C-k>", { noremap = true })
map("n", "<Left>", "C-w><C-h>", { noremap = true })
map("n", "<Right>", "C-w><C-l>", { noremap = true })

-- avoid mistyping write/quit
cmd("command WQ wq")
cmd("command Wq wq")
cmd("command W w")
cmd("command Q q")

-- using Meta/Alt can result in <Esc> being interpreted as Meta/Alt, which
-- makes for odd behaviors when quickely pressing <Esc> sometimes, so disable
-- Meta chords.
-- https://github.com/neovim/neovim/issues/20064
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")

-- Paul's custom bindings
map("n", "<C-l>", "<cmd>bn<cr>", { noremap = true })
map("n", "<C-k>", "<cmd>bp<cr>", { noremap = true })
map("n", "<localleader>q", "<cmd>bd<cr>", { noremap = true })

map("n", "<C-g>", "viw<cmd>'<,'> rg<cr>", { noremap = true })
