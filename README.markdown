Installation:

    git clone git://bitbucket.org/aaaren/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

See [vimcasts][] for more info.

[vimcasts]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
