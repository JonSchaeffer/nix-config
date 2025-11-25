return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim", -- fixed the org name
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "html", "gopls" },
			})
		end,
	},
	-- Nvim LSP Config
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Setup on_attach for keybindings
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end

			-- New vim.lsp.config API (nvim 0.11+)
			vim.lsp.config("*", {
				on_attach = on_attach,
				capabilities = capabilities, -- uncomment when you add nvim-cmp
			})

			-- Enable servers
			vim.lsp.enable("html")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("gopls")
		end,
	},
}
