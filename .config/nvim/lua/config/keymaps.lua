vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move selection down" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Yank to EOL to system clipboard" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste (keep register value)" })

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })

vim.keymap.set("n", "<leader>vt", function()
	local current_value = vim.diagnostic.config().virtual_text
	if current_value then
		vim.diagnostic.config({ virtual_text = false })
		print("Virtual Text: OFF")
	else
		vim.diagnostic.config({ virtual_text = true })
		print("Virtual Text: ON")
	end
end, { desc = "Toggle LSP Virtual Text" })
