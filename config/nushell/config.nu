let fish_completer = {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
      let value = $row.value
      let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
      if ($need_quote and ($value | path exists)) {
        let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
        $'"($expanded_path | str replace --all "\"" "\\\"")"'
      } else {$value}
    }
}

def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let zoxide_completer = {|spans|
  $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
      z => $zoxide_completer
      zi => $zoxide_completer
      _ => $fish_completer
      # _ => $carapace_completer
    } | do $in $spans
}


$env.config.history.isolation = false
$env.config.show_banner = false
$env.config.completions.external.enable = true
$env.config.completions.external.completer = $external_completer
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
    name: open_yazi
    modifier: ALT
    keycode: Char_e
    mode: emacs
    event:[
        { edit: Clear }
        { edit: InsertString,
          value: "yy" }
        { send: Enter }
      ]
  }
  {
    name: fuzzy_history
    modifier: control
    keycode: char_r
    mode: emacs
    event: {
      send: executehostcommand
      cmd: "commandline edit (history | get command | reverse | uniq | to text | fzf --scheme history --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
    }
  }
  {
    name: enter_path_with_fzf
    modifier: CONTROL
    keycode: Char_t
    mode: emacs
    event:[
        {
          send: executehostcommand,
          cmd: "commandline edit --insert (fzf -m --layout=reverse)"
        }
      ]
  }
  ]
}



alias e = nvim
alias em = with-env { TERM: "xterm-kitty" } { emacsclient -c }
alias asd = lazygit
alias pa = paru --bottomup
# alias se = sudoedit nvim
alias q = exit
alias la = ls -al
alias ll = ls -l
alias l = eza -T
alias ff = fastfetch
alias cdtmp = cd (mktemp -d)
# alias zj = zellij
# alias pc = proxychains -q
alias ca = cargo
alias s = kitten ssh
alias t = tmux
# alias mpv = prime-run mpv
alias pyv = overlay use .venv/bin/activate.nu

if $nu.os-info.name == "windows" {
    # $env.PATH ++= ['~/go/bin/' '~/.cargo/bin' '~/.local/bin']
} else {
    $env.PATH =  ['~/.nix-profile/bin/' '~/.moon/bin/'] ++ $env.PATH
    $env.PATH ++= ['~/go/bin/' ('~/.cargo/bin' |path expand) '~/.local/bin']
    $env.PATH ++= [  ('~/Android/Sdk/platform-tools' |path expand)]
}

$env.ANDROID_HOME = [$env.HOME "Android/Sdk/"] | path join
$env.PATH = ($env.PATH | uniq)

$env.FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix"
$env.FZF_DEFAULT_OPTS = "--color=fg:#ffffff,bg:#161616,hl:#ee5396 --color=fg+:#f2f4f8,bg+:#262626,hl+:#ff7eb6 --color=info:#78a9ff,prompt:#33b1ff,pointer:#be95ff --color=marker:#08bdba,spinner:#3ddbd9,header:#42be65"
$env.EDITOR = "nvim"
$env.GOPROXY = "https://goproxy.cn,direct"
$env.GO111MODULE = "on"
$env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.MANROFFOPT = "-c"

# Check if the /etc/specialisation file exists
if ("/etc/specialisation" | path exists) {
    # If it exists, read its content and trim whitespace
    let file_content = (open /etc/specialisation | str trim)

    if ($file_content == "oxocarbon-dark") {
        $env.LS_COLORS = (vivid generate dracula)
    } else if ($file_content == "gruvbox-material-light-soft") {
        $env.LS_COLORS = (vivid generate gruvbox-light-soft)
    } else if ($file_content == "catppuccin-latte") {
        $env.LS_COLORS = (vivid generate catppuccin-latte)
    }
} else {
    $env.LS_COLORS = (vivid generate rose-pine-moon)
}

let starship_config_cache_file = ($nu.temp-path | path join "starship_config_path.tmp")

# NOTE:https://github.com/nix-community/home-manager/issues/7297
if ((sys host | get name) == "NixOS") {
  if ($starship_config_cache_file | path exists) {
    $env.STARSHIP_CONFIG = (open $starship_config_cache_file | str trim)
  } else {
    let config_path = (cat /etc/bashrc | grep STARSHIP_CONFIG | awk -F'=' '{print $2}' | lines | get 1 | str trim)

    $env.STARSHIP_CONFIG = $config_path
    $config_path | save $starship_config_cache_file
  }
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
