local bufnr = 31

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("CjsCoolTutorial", { clear = true }),
	pattern = "*.js",
	callback = function()
		local script = "script.js"
		local out = "Output of: " .. script
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { out })
		vim.fn.jobstart({ "node", script }, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
				end
			end,
			on_stderr = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
				end
			end,
		})
	end,
})
