#!/bin/sh
set -e
HERE=`dirname $0`
HERE=`realpath $HERE`
if [ $# -ge 1 ]; then
    LUA="$1";shift
else
    LUA=lua
fi
{
    cd $HERE/esp-open-sdk
    make VENDOR_SDK=1.4.0
}
{
    cd $HERE/mkspiffs
    make
}
{
    cd $HERE/nodemcu-firmware
    for D in include ld lib; do
        rm -rf $D
        ln -s $HERE/esp-open-sdk/sdk/$D $D
    done
    PATH=$HERE/esp-open-sdk/xtensa-lx106-elf/bin:$PATH make
    PATH=$HERE/esp-open-sdk/xtensa-lx106-elf/bin:$PATH $LUA tools/cross-lua.lua
}
