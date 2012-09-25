Installation:
=============

    git clone git://bitbucket.org/aaaren/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

Upgrading individual plugins:

    cd ~/.vim/bundle/someplugin
    git pull origin master

Upgrading all plugins:

    git submodule foreach git pull origin master

Install a new submodule:

    cd ~/.vim
    git submodule add http://path.to.submod.git bundle/submodulename
    git add .
    git commit -m "install submodulename"

Remove a submodule:
    - Remove line from .gitmodules
    - Delete section from .git/config
    - Run `git rm --cached path_to_submodule`
    - Commit, delete submodule files

See [vimcasts][] for more info.

[vimcasts]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
