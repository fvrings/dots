(import-macros {: map!} :macros)

;; move
(map! n :j :gj)
(map! n :k :gk)
(map! n :<rightmouse> vim.lsp.buf.hover)
(map! n :gw :*N {:desc :Search-word-under-cursor})
(map! n :<c-s> vim.cmd.w {:desc :write})
(map! n :<c-p> :<cmd>t.<CR> {:desc :paste-current-line})
(map! n :<esc> :<esc><cmd>noh<cr>)
(map! v "<" :<gv)
(map! v ">" :>gv)
(map! v :J :5j)
(map! v :K :5k)

;; window management
(map! n :<leader>ws :<c-w>s {:desc :split-window})
(map! n :<leader>wo :<c-w>o {:desc :only-this-window})
(map! n :<leader>wv :<c-w>v {:desc :vertical-split-window})
(map! n "=" :<c-w>>)
(map! n "-" :<c-w><)
(map! n "+" :<c-w>+)
(map! n "_" :<c-w>-)
; (map! n :<a-j> :<c-w>j)
; (map! n :<a-k> :<c-w>k)
; (map! n :<a-h> :<c-w>h)
; (map! n :<a-l> :<c-w>l)
; (map! t :<a-j> "<c-\\><c-n><c-w>j")
; (map! t :<a-k> "<c-\\><c-n><c-w>k")
; (map! t :<a-h> "<c-\\><c-n><c-w>h")
; (map! t :<a-l> "<c-\\><c-n><c-w>l")

;; utils
;(nmap! :<leader>si :<cmd>InspectTree<CR> :open-treesitter-tree)
(map! n :<leader>q vim.cmd.q {:desc :quit})
(map! n :<leader>L vim.cmd.Lazy {:desc :open-lazy})

; (map! n :<c-n>
;       (fn []
;         (let [bufs (vim.api.nvim_list_bufs)
;               has-trouble (: (vim.iter bufs) :any
;                              (fn [buf]
;                                (= :trouble
;                                   (vim.api.nvim_get_option_value :filetype
;                                                                  {: buf}))))
;               has-qf (: (vim.iter bufs) :any
;                         (fn [buf]
;                           (= :qf
;                              (vim.api.nvim_get_option_value :filetype {: buf}))))]
;           (if has-trouble
;               (vim.cmd "Trouble diagnostics next focus=true")
;               has-qf
;               (vim.cmd.cnext)
;               (vim.notify "no qf or trouble found" vim.log.levels.WARN)))))
;
; (map! n :<c-p>
;       (fn []
;         (let [bufs (vim.api.nvim_list_bufs)
;               has-trouble (: (vim.iter bufs) :any
;                              (fn [buf]
;                                (= :trouble
;                                   (vim.api.nvim_get_option_value :filetype
;                                                                  {: buf}))))
;               has-qf (: (vim.iter bufs) :any
;                         (fn [buf]
;                           (= :qf
;                              (vim.api.nvim_get_option_value :filetype {: buf}))))]
;           (if has-trouble
;               (vim.cmd "Trouble diagnostics prev focus=true")
;               has-qf
;               (vim.cmd.cprevious)
;               (vim.notify "no qf or trouble found" vim.log.levels.WARN)))))

(map! n :K (fn []
             (let [winid ((. (require :ufo) :peekFoldedLinesUnderCursor))]
               (when (not winid)
                 (if (next (vim.lsp.get_clients {:bufnr 0}))
                     (vim.lsp.buf.hover)
                     (let [word (vim.fn.expand :<cword>)]
                       (vim.cmd (.. "Man " word)))))))
      {:desc "magic K"})

