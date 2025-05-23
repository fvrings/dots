(import-macros {: append! : set! : nmap!} :macros)

(set! {:list true
       :ruler false
       :equalalways false
       :wildignorecase true
       :swapfile false
       :writebackup false
       :ignorecase true
       :smartcase true
       :cursorline false
       :linebreak true
       :expandtab true
       :smartindent true
       :breakindent true
       :confirm true
       :title true
       :splitbelow true
       :splitright true
       :termguicolors true
       :showmode false
       ; :signcolumn "yes:4"
       :completeopt "menuone,noselect"
       :numberwidth 4
       :scrolloff 99
       :softtabstop 2
       :tabstop 4
       :shiftwidth 2
       :conceallevel 2
       :whichwrap "h,l"
       :cmdheight 0
       :virtualedit :block
       :timeoutlen 500
       :timeout true
       :foldlevel 99
       :foldlevelstart 99
       :splitkeep :screen
       :foldcolumn :1
       :jumpoptions :stack
       :foldmethod :expr
       :foldexpr "nvim_treesitter#foldexpr"
       :showbreak "  󰘍"
       :shell :nu
       :shellcmdflag :-c
       :updatetime 300
       :shellredir "| save %s"
       :mouse :a
       :listchars {:tab "» " :nbsp "␣" :trail "•"}
       :guicursor "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20"
       :fillchars {:vert "║"
                   :horiz "═"
                   :horizup "╩"
                   :horizdown "╦"
                   :vertleft "╣"
                   :vertright "╠"
                   :verthoriz "╬"
                   :foldopen ""
                   :foldclose ""}
       :undofile true})

; (if vim.env.SSH_TTY
;     (do
;       (nmap! :<leader>y "\"+y" :copy-by-OSC52)
;       (nmap! :<leader>P "\"+p" :paste-by-OSC52))
;     (set! {:clipboard :unnamedplus}))

(append! {:formatoptions :r
          :shortmess {:I true :r true}
          :diffopt "linematch:60"})

