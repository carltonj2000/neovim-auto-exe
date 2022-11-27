local attach_to_buffer = function(bufnr, command, pattern, prepend)
  local append_data = function(_, data)
    if data then
      vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
    end
  end

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("CjsCoolTutorial", { clear = true }),
    pattern = pattern,
    callback = function()
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { prepend() })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

vim.api.nvim_create_user_command("Cjrun", function()
  print("Cjrun starts now ...")

  local prepend = function(script)
    return function()
      return "Output of: " .. script .. " at " .. os.date("%I:%M:%S%p - %d%b%y")
    end
  end

  local bufnr = 3
  local interpr = "node"
  local script = "script.js"
  local command = { interpr, script }
  local pattern = "*.js"

  local dflts = vim.fn.input("Use defaults(y/n): ")

  if dflts == "n" then
    bufnr = vim.fn.input("Buffer Number: ") + 0
    pattern = vim.fn.input("Pattern: ")
    command = vim.split(vim.fn.input("Command: "), " ")
    script = command[#command]
  else
  end
  attach_to_buffer(bufnr, command, pattern, prepend(script))
end, {})
