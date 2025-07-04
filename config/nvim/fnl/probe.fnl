(import-macros {: set! : number?} :macros)

(let [version (. (vim.uv.os_uname) :version)
      release (. (vim.uv.os_uname) :release)
      iswin (string.find version :Windows)
      iswsl (string.find release :WSL)]
  (if iswin
      (set! g iswin true))
  (if iswsl
      (set! g iswsl true)))

(let [f (vim.fn.filereadable :/etc/nixos/keys.txt)]
  (if (= f 1)
      (set! g isnixos true)))

(when vim.g.neovide
  (set! g neovide_transparency 0.8)
  (set! g neovide_floating_blur_amount_x 2)
  (set! g floating_blur_amount_y 2)
  (set! g neovide_fullscreen true)
  (set! g neovide_cursor_animation_length 0.1)
  (set! g neovide_cursor_vfx_mode :ripple)
  (if vim.g.iswin
      (set! o guifont :MartianMono_Nerd_Font)
      (set! o guifont "monospace:b"))
  (set! o scrolloff 0))

(when vim.g.iswsl
  (set! g clipboard
        {:cache_enabled 0
         :copy {:* :/mnt/c/Windows/System32/clip.exe
                :+ :/mnt/c/Windows/System32/clip.exe}
         :name :WslClipboard
         :paste {:* "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))"
                 :+ "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))"}}))
