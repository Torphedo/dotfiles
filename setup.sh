#!/bin/bash
clean_local_make_install() {
    make install PREFIX=${HOME}/local
    make clean
}

command_missing() {
if command -v $1 > /dev/null; then
  return 1
else
  return 0
fi
}

cd src
# Install missing dependencies locally from source
if command_missing vim; then
    git clone https://github.com/vim/vim
    cd vim
    make
    make install prefix=${HOME}/local
    cd .. 
fi

if command_missing tmux; then
    git clone https://github.com/tmux/tmux
    cd tmux
    sh autogen.sh
    ./configure --prefix=${HOME}/local
    make install
    cd .. 
fi

if command_missing nvim; then
    git clone https://github.com/neovim/neovim
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=${HOME}/local
    make install
    cd .. 
fi

# Build & install suckless programs locally
cd st
clean_local_make_install
cd ..

cd dmenu
clean_local_make_install

# Back to repo root
cd ../..

