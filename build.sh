#!/bin/sh
HERE=`dirname $0`
HERE=`realpath $HERE`
{
    cd $HERE/esp-open-sdk
    make
}
{
    cd $HERE/nodemcu-firmware
    PATH=$HERE/esp-open-sdk/xtensa-lx106-elf/bin:$PATH make
}
