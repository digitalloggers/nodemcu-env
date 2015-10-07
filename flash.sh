#!/bin/sh
set -e
HERE=`dirname $0`
HERE=`realpath $HERE`
$HERE/esp-open-sdk/esptool/esptool.py write_flash \
                         0x00000 $HERE/nodemcu-firmware/bin/0x00000.bin \
                         0x10000 $HERE/nodemcu-firmware/bin/0x10000.bin \
