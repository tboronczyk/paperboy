#! /bin/bash

set -e

ORIG="Paperboy (USA).nes"
ROM="paperboy-eo.nes"
IPS="paperboy-eo.ips"
FLIPS="wine /opt/floating/flips.exe"

echo "Assembling ROM..."
cd src
/opt/asm6f/asm6f Paperboy.asm paperboy.nes
cp paperboy.nes ../$ROM
cd ..

echo "Updating CHR..."
dd if=chr/alphabet.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9220))
dd if=chr/heroldo-1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9420))
dd if=chr/heroldo-2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9570))
dd if=chr/alpha-gx.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9710))

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
