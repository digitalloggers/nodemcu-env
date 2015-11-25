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
    ln -fs $HERE/esp-open-sdk/sdk sdk/sdk
    PATH=$HERE/esp-open-sdk/xtensa-lx106-elf/bin:$PATH make
    PATH=$HERE/esp-open-sdk/xtensa-lx106-elf/bin:$PATH $LUA tools/cross-lua.lua
}
