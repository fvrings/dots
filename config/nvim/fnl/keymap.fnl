(import-macros {: nmap! : vmap!} :macros)

;; move
(nmap! :j :gj)
(nmap! :k :gk)
(nmap! :<rightmouse> vim.lsp.buf.hover)
;BUG: forget about it
;check https://github.com/neovim/neovim/issues/28022
; (nmap! :<c-i> :<c-i>)
; (nmap! :<tab> "%")
(nmap! :gw :*N :Search-word-under-cursor)
(nmap! :<c-s> vim.cmd.w :write)
(nmap! :<esc> :<esc><cmd>noh<cr>)
(vmap! "<" :<gv)
(vmap! ">" :>gv)
(vmap! :J :5j)
(vmap! :K :5k)

;; window management
(nmap! :<leader>ws :<c-w>s :split-window)
(nmap! :<leader>wo :<c-w>o :only-this-window)
(nmap! :<leader>wv :<c-w>v :vertical-split-window)
(nmap! "=" :<c-w>>)
(nmap! "-" :<c-w><)
(nmap! "+" :<c-w>+)
(nmap! "_" :<c-w>-)

;; utils
;(nmap! :<leader>si :<cmd>InspectTree<CR> :open-treesitter-tree)
(nmap! :<leader>q vim.cmd.q :quit)
(nmap! :<leader>L vim.cmd.Lazy :open-lazy)

(vim.keymap.set :n :<c-n>
                (fn []
                  (let [bufs (vim.api.nvim_list_bufs)
                        has-trouble (: (vim.iter bufs) :any
                                       (fn [buf]
                                         (= :trouble
                                            (vim.api.nvim_get_option_value :filetype
                                                                           {: buf}))))
                        has-qf (: (vim.iter bufs) :any
                                  (fn [buf]
                                    (= :qf
                                       (vim.api.nvim_get_option_value :filetype
                                                                      {: buf}))))]
                    (if has-trouble
                        (vim.cmd "Trouble diagnostics next focus=true")
                        has-qf
                        (vim.cmd.cnext)
                        (vim.notify "no qf or trouble found"
                                    vim.log.levels.WARN)))))

(vim.keymap.set :n :<c-p>
                (fn []
                  (let [bufs (vim.api.nvim_list_bufs)
                        has-trouble (: (vim.iter bufs) :any
                                       (fn [buf]
                                         (= :trouble
                                            (vim.api.nvim_get_option_value :filetype
                                                                           {: buf}))))
                        has-qf (: (vim.iter bufs) :any
                                  (fn [buf]
                                    (= :qf
                                       (vim.api.nvim_get_option_value :filetype
                                                                      {: buf}))))]
                    (if has-trouble
                        (vim.cmd "Trouble diagnostics prev focus=true")
                        has-qf
                        (vim.cmd.cprevious)
                        (vim.notify "no qf or trouble found"
                                    vim.log.levels.WARN)))))

(vim.keymap.set :n :K
                (fn []
                  (let [winid ((. (require :ufo) :peekFoldedLinesUnderCursor))]
                    (when (not winid)
                      (if (next (vim.lsp.get_clients {:bufnr 0}))
                          (vim.lsp.buf.hover)
                          (let [word (vim.fn.expand :<cword>)]
                            (vim.cmd (.. "Man " word)))))))
                {:desc "magic K"})

