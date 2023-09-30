# Nushell Environment Config File
#
# version = 0.84

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

def create_left_prompt [] {
    mut home = ""
    try {
        if $nu.os-info.name == "windows" {
            $home = $env.USERPROFILE
        } else {
            $home = $env.HOME
        }
    }

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)/($path_color)"
}

use ~/.config/nushell/scripts/git-prompt.nu repo-styled

def create_right_prompt [] {
    let repo = repo-styled
    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $repo] | str join)
}

def create_starship_prompt [] {
    ^starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# TODO: Check if use this instead of starship
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { create_right_prompt }
# $env.PROMPT_COMMAND = { create_starship_prompt }
# $env.PROMPT_COMMAND_RIGHT = ""

# avoid same PROMPT_INDICATOR
$env.PROMPT_INDICATOR = { "" }
$env.PROMPT_INDICATOR_VI_INSERT = { " ❯ " }
$env.PROMPT_INDICATOR_VI_NORMAL = { " ❮ " }
$env.PROMPT_MULTILINE_INDICATOR = { " ::: " }

$env.EDITOR = nvim
$env.KUBE_EDITOR = nvim
$env.XDG_CONFIG_HOME = $env.HOME + /.config
$env.DOTFILES = $env.HOME + /.dotfiles

def-env add_to_path [route: string] {
    if (($route | path exists) and ($route not-in $env.PATH)) {
        $env.PATH = ($env.PATH | prepend $route)
    }
}

add_to_path $"($env.HOME)/.bin"
add_to_path $"($env.HOME)/.local/bin"
add_to_path $"($env.HOME)/Applications"
add_to_path '/opt/homebrew/bin/'
add_to_path $"($env.HOME)/.cargo/bin"
add_to_path $"($env.HOME)/zig"
add_to_path $"($env.HOME)/roc"
add_to_path $"($env.HOME)/.local/share/nvim/mason/bin"
add_to_path $"($env.HOME)/go/bin"
add_to_path $"($env.HOME)/google-cloud-sdk/bin"
add_to_path $"($env.XDG_CONFIG_HOME)/carapace/bin"
add_to_path $"($env.HOME)/.local/share/coursier/bin"
add_to_path $"($env.HOME)/.ghcup/bin"
add_to_path $"($env.HOME)/.cabal/bin"
add_to_path $"($env.HOME)/Odin"

if ( '/usr/local/go' | path exists) { 
    add_to_path '/usr/local/go/bin'
    go env -w GOPRIVATE=github.com/goflink
} 

$env.ASDF_NU_DIR = ($env.HOME | path join '.asdf')
