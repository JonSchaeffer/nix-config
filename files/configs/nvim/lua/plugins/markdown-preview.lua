return {
	-- install with yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			-- Browser configuration - function that opens URL in Zen
			vim.g.mkdp_browserfunc = "g:OpenMarkdownPreview"
			-- Auto-close preview when switching buffers
			vim.g.mkdp_auto_close = 1
			-- Refresh on save or leave insert mode
			vim.g.mkdp_refresh_slow = 0
		end,
		config = function()
			-- Define the browser function
			vim.cmd([[
				function! g:OpenMarkdownPreview(url) abort
					execute "silent !open -a Zen " . shellescape(a:url)
				endfunction
			]])
		end,
		ft = { "markdown" },
		keys = {
			{
				"<leader>cp",
				"<cmd>MarkdownPreviewToggle<cr>",
				mode = { "n" },
				desc = "Markdown Preview",
			},
		},
	},
}
