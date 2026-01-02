vim.cmd('source ~/.config/nvim/legacy.vim')

vim.lsp.config['nextflow'] = {
  cmd = { 'java', '-jar', '/home/shl/opt/nfls/language-server-all.jar' },
  filetypes = { 'nextflow', 'nf', 'groovy', 'config' },
  root_markers = { 'nextflow.config', '.git' },
  settings = {
    nextflow = {
      files = {
        exclude = { '.git', '.nf-test', 'work' },
      }
    }
  }
}

vim.lsp.enable('nextflow')

-- LSP keymap bindings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find References' })

vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.open_float(0, { scope = 'line' })
end)

vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.setqflist()
  vim.cmd('copen')
end, { desc = 'List LSP diagnostics' })
