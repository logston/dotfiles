local opt = vim.opt
opt.hidden = true
opt.joinspaces = false

-- Disable LazyVim's defautl clipboard.
opt.clipboard = ""

-- Tab complete for cmd mode should autocomplete the first result immediately.
opt.wildmode = "full"

-- Disallow motions/highlighting via cursor.
opt.mouse = ""

-- Silence LazyHealth warnings.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- https://neovim.io./doc/user/spell.html
opt.spell = true
opt.spelllang = "en_us"
