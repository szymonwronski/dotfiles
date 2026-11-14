local lspconfig = require("lspconfig")

lspconfig.sourcekit.setup({
	cmd = { "xcrun", "sourcekit-lsp" },
	filetypes = { "swift", "objective-c", "objective-cpp" },
	-- Optional: customize the root directory detection
	root_dir = lspconfig.util.root_pattern(".git", "Package.swift", "compile_commands.json"),
})
