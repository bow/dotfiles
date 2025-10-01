local ftpatterns = {
  { 'asciidoc',     patterns = { '*.adoc', '*.asciidoc' } },
  { 'bash',         patterns = { '*.bash', '.envrc', '.envrc-*' } },
  { 'cython',       patterns = { '*.pyx' } },
  { 'haskell',      patterns = { '*.hs' } },
  { 'http',         patterns = { '*.http' } },
  { 'jdl',          patterns = { '*.jdl' } },
  { 'json',         patterns = { '*.json', '*.jsonl' } },
  { 'latex',        patterns = { '*.tex' } },
  { 'ledger',       patterns = { '*.lgr' } },
  { 'lox',          patterns = { '*.lox' } },
  { 'make',         patterns = { '*.mk', '*.mak', '*.make', 'Makefile', 'Makefile.*' } },
  { 'markdown',     patterns = { '*.md' } },
  { 'rst',          patterns = { '*.rst' } },
  { 'ruby',         patterns = { '*.rb', 'Vagrantfile' } },
  { 'scala',        patterns = { '*.scala', '*.sc' } },
  { 'toml',         patterns = { '*.toml', 'uv.lock', 'poetry.lock' } },
  { 'tsv',          patterns = { '*.tsv' } },
  { 'typescript',   patterns = { '*.ts' } },

  -- Bioinformatics.
  { 'bed',          patterns = { '*.bed' } },
  { 'gff',          patterns = { '*.gff' } },
  { 'gtf',          patterns = { '*.gtf' } },
  { 'groovy',       patterns = { '*.nf', 'nextflow.config' } },
  { 'refFlat',      patterns = { '*.refFlat' } },
  { 'sam',          patterns = { '*.sam' } },
  { 'snakemake',    patterns = { 'Snakefile', 'Snakefile.*', '*.snakefile' } },
  { 'wdl',          patterns = { '*.wdl' } },
  { 'yaml.ansible', patterns = { 'roles/*/*.yml', 'roles/*/*.yaml', 'playbooks/*.yml', 'playbooks/*.yaml' } },
  { 'yaml',         patterns = { '*.yml', '*.yaml' } },
}

for _, entry in ipairs(ftpatterns) do
  local ft = entry[1]
  local patterns = entry.patterns

  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = patterns,
    callback = function()
      vim.bo.filetype = ft
    end,
  })
end
