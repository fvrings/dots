let fish_completer = {|spans|
  fish --command $'complete "--do-complete=($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in | from tsv --flexible --no-infer
}

let zoxide_completer = {|spans|
  $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let multiple_completers = {|spans|
  match $spans.0 {
    z => $zoxide_completer
    zi => $zoxide_completer
      _ => $fish_completer
  } | do $in $spans
}
$env.config.history.isolation = false
$env.config.show_banner = false
$env.config.completions.external.enable = true
$env.config.completions.external.completer = $multiple_completers
$env.config.footer_mode = "auto"
$env.config.table.mode = "light"
$env.config.filesize.unit = "metric"
$env.config.hooks.pre_prompt = [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]
$env.config = {
  keybindings: [
  {
    name: enter_path_with_fzf
    modifier: CONTROL
    keycode: Char_f
    mode: emacs
    event:[
        { 
          edit: InsertString,
          value: "(fzf | decode utf-8 | str trim)"
        }
        { send: Enter }
      ]
  }
  ]
}



alias e = nvim
alias em = emacsclient -c
alias asd = lazygit
alias pa = paru --bottomup
alias se = sudoedit nvim
alias q = exit
alias la = ls -al
alias ll = ls -l
alias l = eza -T
alias ff = fastfetch
alias cdtmp = cd (mktemp -d)
alias zj = zellij
alias pc = proxychains -q
alias ca = cargo
alias n = prime-run neovide
alias s = kitten ssh
alias t = tmux
# alias mpv = prime-run mpv
alias activate-python-venv = overlay use .venv/bin/activate.nu

def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

if $nu.os-info.name == "windows" {
    # $env.PATH ++= ['~/go/bin/' '~/.cargo/bin' '~/.local/bin']
} else {
    $env.PATH =  ['~/.nix-profile/bin/' '~/.local/share/bob/nvim-bin'] ++ $env.PATH
    $env.PATH ++= ['~/go/bin/' ('~/.cargo/bin' |path expand) '~/.local/bin']
    $env.PATH ++= [ '/usr/share/bcc/tools/' ('~/Android/Sdk/platform-tools' |path expand)]
    $env.ANDROID_HOME = [$env.HOME "Android/Sdk/"] | path join
}

$env.ANDROID_HOME = [$env.HOME "Android/Sdk/"] | path join
$env.PATH = ($env.PATH | uniq)

$env.EDITOR = "nvim"
$env.GOPROXY = "https://goproxy.cn,direct"
$env.GO111MODULE = "on"
$env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.MANROFFOPT = "-c"
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
