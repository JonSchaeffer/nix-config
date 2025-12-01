return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false, -- Load immediately for tmux integration to work
		init = function()
			-- Disable default C-h/j/k/l mappings (seems to conflict with something)
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			-- Use Alt+h/j/k/l for tmux-aware navigation instead of Ctrl
			vim.keymap.set("n", "<M-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Navigate Left" })
			vim.keymap.set("n", "<M-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Navigate Down" })
			vim.keymap.set("n", "<M-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Navigate Up" })
			vim.keymap.set("n", "<M-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Navigate Right" })
			vim.keymap.set("n", "<M-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true, desc = "Navigate Previous" })

			-- Also keep C-h/j/k/l for basic window navigation (non-tmux aware)
			vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Go to Left Window" })
			vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Go to Lower Window" })
			vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Go to Upper Window" })
			vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Go to Right Window" })
		end,
	},
}
