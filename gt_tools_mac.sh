#!/bin/sh

if ! command -v brew &> /dev/null
then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install git node gcc sdl2

read -p "Enter your git repos folder name (default ~/repos): " reposFolder

reposFolder=${reposFolder:-~/repos}

cd $reposFolder

git clone https://github.com/cc65/cc65.git

cd cc65

make -C src

shellName=$(basename $SHELL)

echo "export PATH=`pwd`:$PATH" > ~/."$shellName"rc 

cd $reposFolder

curl http://www.ibaug.de/vasm/vasm6502.zip -o /tmp/vasm6502.zip

unzip /tmp/vasm6502.zip

cd vasm6502_oldstyle/mac

echo "export PATH=`pwd`:$PATH" > ~/."$shellName"rc

cd $reposFolder

git clone https://github.com/clydeshaffer/GameTankEmulator.git

cd GameTankEmulator

make
