# Contents
- Overview
- Set up
- Run

## Overview
The swift.img file comes with a bootloader and kernel. <br>
The bootloader loads the kernel into memory which features a currently unoperational CLI.

## Set Up
1. Clone this repository to a Linux machine
2. Install __NASM__ (Netwide Assembler)
   <br>`sudo apt install nasm` 
3. Install __QEMU__ (Emulator)
   <br>`sudo apt install qemu-system-x86`

## Run
1. Run `cd os` to make sure you are in the __os__ directory
2. Run `make` to prepare __build__
3. Run `qemu-system-i386 -nographic -fda build/swift.img` to start emulation

You will see a prompt asking you to press ENTER key.<br>
If kernel has successfully loaded, you will see a `?` symbol.
<br>
Press ENTER key again to interact with CLI
