(import-macros {: ftadd! : autocmd! : map!} :macros)

(ftadd! {:lock :json :mdx :mdx :mpp :cpp :http :http})

(vim.filetype.add {:pattern {".*/templates/.*/.*%.html" :htmldjango}})

(autocmd! :TextYankPost "*"
          #(vim.highlight.on_yank {:higroup :WildMenu :timeout 400}))

(autocmd! :FileType :lazy #(vim.diagnostic.enable false {:bufnr 0}))

(autocmd! :BufEnter :*.md #(set vim.wo.wrap false))

(autocmd! :BufLeave :*.md #(set vim.wo.wrap true))

(autocmd! :FileType [:help
                     :grug-far*
                     :qf
                     :lspinfo
                     :man
                     :query
                     :checkhealth
                     :Neogit*
                     :norg*
                     :org*
                     :markdown
                     :spectre*
                     :octo
                     :text]
          #(do
             (map! nb :q vim.cmd.q)
             (map! nb :gq :q)))

(let [change-on-disk (vim.api.nvim_create_augroup :ChangeOnDisk [])]
  (autocmd! [:FocusGained :BufEnter :CursorHold :CursorHoldI] "*"
            #(if (= vim.fn.mode :c)
                 (vim.cmd.checktime)) change-on-disk)
  (autocmd! :FileChangedShellPost "*"
            #(vim.notify :File-changed-reloaded vim.log.levels.INFO)
            change-on-disk))

