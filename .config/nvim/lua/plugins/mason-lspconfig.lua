return {
	"mason-org/mason-lspconfig.nvim",
	opts = { ensure_installed = { "lua_ls", "rust_analyzer" } },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason-lspconfig").setup()
		vim.diagnostic.config({
			-- virtual_lines = true,
			virtual_text = true,
		})
	end,
}
