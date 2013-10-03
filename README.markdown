Requires Vim 7.3, compiled with

    ./configure --with-features=big --enable-pythoninterp

Otherwise we get problems with python mode and gundo (at least). If
using some sort of virtualenv python e.g. Enthought add

    --with-python-config-dir=/path/to/python/python2.7/config

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


Compiling Vim:
==============

I want to compile against Enthought Canopy python. Canopy uses a
virtualenv to contain itself. This virtualenv must be activated
before compiling, e.g.

    source /path/to/canopy/Enthought/Canopy_64bit/User/bin/activate

Then we compile. `python-config` is convenient but not essential:
you can just use whatever the path to the python install is instead.

    # vim git mirror
    git clone git://github.com/b4winckler/vim.git
    cd vim
    PREFIX=`python-config --prefix`
    PYTHON_CONFIG=$PREFIX/lib/python2.7/config
    export vi_cv_path_python=$PREFIX/bin/python
    ./configure --prefix=$HOME/.local \
        --with-features=huge \
        --enable-pythoninterp=yes \
        # CFLAGS="`python-config --cflags`" \
        # LDFLAGS="-L$PYTHON_CONFIG"
    make
    make install

and we need to alias vim to source the right libraries before
starting:

    alias vim='LD_LIBRARY_PATH=${PREFIX}/lib:${LD_LIBRARY_PATH} vim'
