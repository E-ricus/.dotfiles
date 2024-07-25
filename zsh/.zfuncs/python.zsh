# Conda init
function condainit() {
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        fi
    fi
    unset __conda_setup
}

# Activate mojo
function activate_mojo() {
    if [[ ! -d "$HOME/.modular" ]]; then
        echo "Modular not installed"
        return 1
    fi

    eval "conda activate mojo"

    if [ ! $? -eq 0 ]; then
        eval "conda create -n mojo python=3.10 -y && conda activate mojo"
    fi

    if [[ ! -d "$MODULAR_HOME/pkg/packages.modular.com_mojo/" ]]; then
        echo "Installing mojo"
        eval "modular install mojo"
    fi

    # Fedora Only (mojo not fully supported natively) Workaround:
    # https://github.com/modularml/mojo/issues/855#issuecomment-2116834443
    # export LD_LIBRARY_PATH=/opt/missing-mojo-deps/lib/x86_64-linux-gnu:/opt/missing-mojo-deps/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
    add_to_path "$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"
}

# Activate mojo nightly
function activate_mojo_nightly () {
    if [[ ! -d "$HOME/.modular" ]]; then
        echo "Modular not installed"
        return 1
    fi

    eval "conda activate mojo-nightly"

    if [ ! $? -eq 0 ]; then
        eval "conda create -n mojo-nightly python=3.10 -y && conda activate mojo-nightly"
    fi

    if [[ ! -d "$MODULAR_HOME/pkg/packages.modular.com_nightly_mojo/" ]]; then
        echo "Installing mojo nightly"
        eval "modular install nightly/mojo"
    fi

    # Fedora Only (mojo not fully supported natively) Workaround:
    # https://github.com/modularml/mojo/issues/855#issuecomment-2116834443
    # export LD_LIBRARY_PATH=/opt/missing-mojo-deps/lib/x86_64-linux-gnu:/opt/missing-mojo-deps/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
    add_to_path "$MODULAR_HOME/pkg/packages.modular.com_nightly_mojo/bin"
}
