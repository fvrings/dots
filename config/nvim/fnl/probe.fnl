(import-macros {: set! : setg! : number?} :macros)

(let [version (. (vim.uv.os_uname) :version)
      release (. (vim.uv.os_uname) :release)
      iswin (string.find version :Windows)
      iswsl (string.find release :WSL)]
  (if (number? iswin)
      (set vim.g.iswin true))
  (if (number? iswsl)
      (set vim.g.iswsl true)))

(let [f (vim.fn.filereadable :/etc/nixos/configuration.nix)]
  (if (= f 1)
      (set vim.g.isnixos true)))

(when vim.g.neovide
  (setg! {:neovide_transparency 0.8
          :neovide_floating_blur_amount_x 2
          :neovide_floating_blur_amount_y 2
          :neovide_fullscreen true
          :neovide_cursor_animation_length 0.1
          :neovide_cursor_vfx_mode :ripple})
  (if vim.g.iswin
      (set! {:guifont "MartianMono_Nerd_Font"})
      (set! {:guifont "monospace,emoji"}))
  (set! {:scrolloff 0}))

