return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			-- Copy GitHub permalink for current line/selection
			{
				"<leader>gy",
				function()
					Snacks.gitbrowse({
						what = "permalink",
						open = function(url)
							vim.fn.setreg("+", url)
							Snacks.notify.info("Copied permalink to clipboard")
						end,
					})
				end,
				desc = "Copy Git permalink",
				mode = { "n", "v" },
			},
			-- Open GitHub permalink in browser (capital Y)
			{
				"<leader>gY",
				function()
					Snacks.gitbrowse({ what = "permalink" })
				end,
				desc = "Open Git permalink",
				mode = { "n", "v" },
			},
		},
	},
}
