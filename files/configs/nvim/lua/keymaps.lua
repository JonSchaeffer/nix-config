-- Core keymaps that need to be set early (before plugins load)
-- Most keybindings are now managed by which-key.lua

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Window navigation is handled by vim-tmux-navigator plugin
-- (see lua/plugins/vim-tmux-navigator.lua for <C-h/j/k/l> mappings)

-- Better up/down (wrap-aware movement)
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Escape clears search highlight
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })