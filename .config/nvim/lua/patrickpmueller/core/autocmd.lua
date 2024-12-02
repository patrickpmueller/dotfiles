-- Set absolute line numbers when in insert mode
vim.api.nvim_create_autocmd(
  "InsertEnter",
  {
    command = "set norelativenumber",
    pattern = "*",
  }
)
vim.api.nvim_create_autocmd(
  "InsertLeave",
  {
    command = "set relativenumber",
    pattern = "*",
  }
)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}),
    callback = function()
      vim.highlight.on_yank()
    end
  }
)

-- On write format
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    -- make sure there is at least one client with formatting capabilities
    if client.supports_method('textDocument/formatting') then
      local bufnr = event.buf
      local group = 'lsp_autoformat'
      vim.api.nvim_create_augroup(group, {clear = false})
      vim.api.nvim_clear_autocmds({group = group, buffer = bufnr})

      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        desc = 'LSP format on save',
        callback = function()
          -- note: do not enable async formatting
          vim.lsp.buf.format({async = false, timeout_ms = 1000})
        end,
      })
    end

  end
})

-- On write trailing whitespace removal
vim.api.nvim_create_autocmd(
  "BufWritePre",
  {
    pattern = "*",
    callback = function()
      MiniTrailspace.trim()
      MiniTrailspace.trim_last_lines()
    end
  }
)
