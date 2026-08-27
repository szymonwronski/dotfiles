local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "Recording @" .. recording_register
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "snacks_picker_input" },
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = false,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
				refresh_time = 16, -- ~60fps
				events = {
					"WinEnter",
					"BufEnter",
					"BufWritePost",
					"SessionLoadPost",
					"FileChangedShellPost",
					"VimResized",
					"Filetype",
					"CursorMoved",
					"CursorMovedI",
					"ModeChanged",
				},
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { "filename", separator = "|" }, { "macro_recording", fmt = show_macro_recording } },
			lualine_x = { "lsp_status" },
			lualine_y = { "filetype" },
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {
			"lazy",
			"mason",
			"oil",
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)

		-- Force refresh lualine as soon as entering recording state
		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				require("lualine").refresh({
					place = { "statusline" },
				})
			end,
		})
		-- Refresh lualine after leaving recording state
		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				-- This is going to seem really weird!
				-- Instead of just calling refresh we need to wait a moment because of the nature of
				-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
				-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
				-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
				-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
				local timer = vim.loop.new_timer()
				timer:start(
					50,
					0,
					vim.schedule_wrap(function()
						require("lualine").refresh({
							place = { "statusline" },
						})
					end)
				)
			end,
		})
	end,
}
