#!/bin/bash

OS=Unix
if [[ $(uname -r) == *Microsoft ]]
then # WSL
    OS=Windows
fi
if [[ $(uname) == MINGW* ]]
then
    OS=Windows
fi
echo $OS
