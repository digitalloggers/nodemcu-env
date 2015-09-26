#!/bin/sh
HERE=`dirname $0`
HERE=`realpath $HERE`

INTERNAL_FLASH_SECTOR_SIZE=4096
SYS_PARAM_SEC_NUM=4
LOG_PAGE_SIZE=256

OUTPUT="$1";shift
DIRECTORY="$1";shift
FLASH_SIZE="$1";shift
LAST_FILE_OFFSET="$1";shift
LAST_FILE="$1";shift

LAST_FILE_SIZE=`stat -c '%s' $LAST_FILE`
LAST_FILE_END=$(($LAST_FILE_SIZE+$LAST_FILE_OFFSET))

# See myspiffs_mount in spiffs.c
SPIFS_START_CHUNK=$((($LAST_FILE_END+4*$INTERNAL_FLASH_SECTOR_SIZE-1)/(4*$INTERNAL_FLASH_SECTOR_SIZE)))
SPIFS_START=$(($SPIFS_START_CHUNK*(4*$INTERNAL_FLASH_SECTOR_SIZE)))
SPIFS_SIZE=$(($FLASH_SIZE-$INTERNAL_FLASH_SECTOR_SIZE*$SYS_PARAM_SEC_NUM-$SPIFS_START))

$HERE/mkspiffs \
    --block  $INTERNAL_FLASH_SECTOR_SIZE \
    --page   $LOG_PAGE_SIZE              \
    --size   $SPIFS_SIZE                 \
    --no-format                          \
    --create "$DIRECTORY"                \
    "$OUTPUT"

echo $SPIFS_START
