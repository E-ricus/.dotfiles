# Install emacs with native comp:
https://www.emacswiki.org/emacs/GccEmacs
https://wiki.systemcrafters.net/emacs/try-gccemacs/
./autogen.sh
./configure --with-native-compilation --with-json
make -j5
make install

# Install doom emacs:
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# Disable vanilla emacs config
mv ~/.emacs.d/ ~/.emacs.d.bak/

# Add emacs client as desktop app:
https://www.emacswiki.org/emacs/EmacsClient

