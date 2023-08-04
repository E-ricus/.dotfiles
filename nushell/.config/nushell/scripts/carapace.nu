# $env.PATH = ($env.PATH | prepend "/home/ericus/.config/carapace/bin")
add_to_path $"($env.XDG_CONFIG_HOME)/carapace/bin"

let carapace_completer = {|spans| 
  carapace $spans.0 nushell $spans | from json
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external 
    | default true enable
    | default $carapace_completer completer)

$env.config = $current
    
