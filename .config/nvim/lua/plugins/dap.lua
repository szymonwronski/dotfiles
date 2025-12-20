return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- 1. Setup Mason and Mason-DAP
		require("mason").setup()
		require("mason-nvim-dap").setup({
			-- Install the C debugger automatically
			ensure_installed = { "codelldb" },
			handlers = {
				function(config)
					-- Keep original functionality
					require("mason-nvim-dap").default_setup(config)
				end,
				-- Custom handler for codelldb if needed (usually default is fine)
			},
		})

		-- 2. Setup UI
		dapui.setup()
		require("nvim-dap-virtual-text").setup()

		-- 3. Auto-open UI when debugging starts
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- 4. Configure C specific debug settings
		-- This "codelldb" configuration matches the adapter name setup by Mason
		dap.configurations.c = {
			{
				name = "Launch (Select Input File)",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,

				-- 🔴 DYNAMIC INPUT 🔴
				stdio = function()
					local input_file = vim.fn.input("Path to input file: ", vim.fn.getcwd() .. "/", "file")
					-- If user cancels or leaves empty, return nil (standard keyboard input)
					if input_file == "" then
						return nil
					end
					return { input_file, nil, nil }
				end,
			},
		}

		-- Link C++ and Rust to the same config (optional)
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c

		-- 5. Keymaps (Modern Neovim Style)
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint" })

		-- Toggle UI manually
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
	end,
}
