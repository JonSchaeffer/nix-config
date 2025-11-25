vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

--
local opt = vim.opt

opt.ignorecase = true

-- scrolling
opt.number = true
opt.relativenumber = false
opt.scrolloff = 8
opt.linebreak = true

-- Use system clipboard
opt.clipboard = "unnamedplus"
