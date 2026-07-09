# AssilBIOS

AssilBIOS is a custom, Algeria's first clean-room developed x86 Legacy BIOS project designed for learning systems programming and low-level hardware initialization without using CoreBoot/SeaBIOS or proprietary BIOS codes (Pheonix, insydeH2O, AMI)

## License

AssilBIOS is released under the **AssilOS Public License (APL) v1.0**, a permissive
open-source license with attribution and branding protection.

- [Full license text](LICENSE)

This license allows you to use, modify, and distribute the code freely, provided
you retain the copyright notice and do not use the "AssilOS" name without permission.

## ⚠️ CRITICAL DISCLAIMER - READ BEFORE USE
**THIS SOFTWARE IS EXPERIMENTAL FIRMWARE.** - **NO WARRANTY:** This project is provided "as is." Using this code on bare-metal hardware (actual motherboards) carries a risk of "bricking" your motherboard if flashed to an SPI flash chip.
- **FOR EMULATION ONLY:** It is strongly recommended to run this project **EXCLUSIVELY within emulators** like QEMU or Bochs. 
- **DO NOT FLASH:** Do not attempt to flash this binary onto any physical computer hardware. The author assumes no responsibility for hardware damage, data loss, or system instability resulting from the use of this code.

## Getting Started
AssilBIOS is written in x86 Assembly (NASM syntax) and is intended to be executed as a raw binary image.

### Prerequisites
- [NASM Assembler](https://www.nasm.us/)
- [QEMU](https://www.qemu.org/) or [Bochs](http://bochs.sourceforge.net/)

### How to Build
1. Open your terminal in the project directory.
2. Run the assembler:
   ```bash
   nasm -f bin bios.asm -o bios.bin
