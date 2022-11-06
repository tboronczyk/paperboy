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

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
