(import-macros {: set!} :macros)
; :signcolumn "yes:4"
(set! o clipboard :unnamedplus)
(set! o completeopt "menuone,noselect")
(set! o numberwidth 4)
(set! o laststatus 3)
(set! o scrolloff 99)
(set! o softtabstop 2)
(set! o tabstop 4)
(set! o shiftwidth 2)
(set! o conceallevel 2)
(set! o whichwrap "h,l")
(set! o cmdheight 0)
(set! o virtualedit :block)
(set! o timeoutlen 500)
(set! o foldlevel 99)
(set! o foldlevelstart 99)
(set! o splitkeep :screen)
(set! o foldcolumn :1)
(set! o jumpoptions :stack)
(set! o foldmethod :expr)
(set! o foldexpr "nvim_treesitter#foldexpr")
(set! o showbreak "  󰘍")
(set! o shell :nu)
(set! o shellcmdflag :-c)
(set! o updatetime 300)
(set! o shellredir "| save %s")
(set! o mouse :a)
(set! o listchars {:tab "» " :nbsp "␣" :trail "•"})
(set! o guicursor "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20")
(set! o fillchars {:vert "║"
                   :horiz "═"
                   :horizup "╩"
                   :horizdown "╦"
                   :vertleft "╣"
                   :vertright "╠"
                   :verthoriz "╬"
                   :foldopen ""
                   :foldclose ""})

; (if vim.env.SSH_TTY
;     (do
;       (nmap! :<leader>y "\"+y" :copy-by-OSC52)
;       (nmap! :<leader>P "\"+p" :paste-by-OSC52))
;     (set! {:clipboard :unnamedplus}))
(set! o +formatoptions :r)
(set! o +shortmess {:I true :r true})
(set! o +diffopt "linematch:60")

(set! o undofile)
(set! o list)
(set! o wildignorecase)
(set! o ignorecase)
(set! o smartcase)
(set! o linebreak)
(set! o expandtab)
(set! o smartindent)
(set! o breakindent)
(set! o confirm)
(set! o title)
(set! o splitbelow)
(set! o splitright)
(set! o termguicolors)
(set! o timeout)

(set! o noruler)
(set! o noequalalways)
(set! o noswapfile)
(set! o nowritebackup)
(set! o nocursorline)
(set! o noshowmode)

