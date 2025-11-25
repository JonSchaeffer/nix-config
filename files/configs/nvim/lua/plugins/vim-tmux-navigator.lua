return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false, -- Load immediately for tmux integration to work
		init = function()
			-- Disable default mappings (we'll set them ourselves)
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			-- Set up keymaps manually after plugin loads
			vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Navigate Left" })
			vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Navigate Down" })
			vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Navigate Up" })
			vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Navigate Right" })
			vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true, desc = "Navigate Previous" })
		end,
	},
}
