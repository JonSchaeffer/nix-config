return {
	{
		"gbprod/yanky.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			ring = {
				history_length = 100,
				storage = "shada",
				sync_with_numbered_registers = true,
			},
			system_clipboard = {
				sync_with_ring = true,
			},
		},
		keys = {
			{
				"y",
				"<Plug>(YankyYank)",
				mode = { "n", "x" },
				desc = "Yank",
			},
			{
				"p",
				"<Plug>(YankyPutAfter)",
				mode = { "n", "x" },
				desc = "Put after",
			},
			{
				"P",
				"<Plug>(YankyPutBefore)",
				mode = { "n", "x" },
				desc = "Put before",
			},
			{
				"gp",
				"<Plug>(YankyGPutAfter)",
				mode = { "n", "x" },
				desc = "Put after and leave cursor",
			},
			{
				"gP",
				"<Plug>(YankyGPutBefore)",
				mode = { "n", "x" },
				desc = "Put before and leave cursor",
			},
			-- Cycle through yank history
			{ "<c-n>", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
			{ "<c-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
			-- Show yank history with Telescope
			{ "<leader>p", "<cmd>Telescope yank_history<cr>", desc = "Yank history" },
		},
	},
}
