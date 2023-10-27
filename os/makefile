build/swift.img: build/swift.bin
	cp build/swift.bin build/swift.img

build/swift.bin: build/main.bin build/kernel.bin
	cat build/main.bin build/kernel.bin > build/swift.bin

build/kernel.bin: src/kernel/kernel.asm
	nasm src/kernel/kernel.asm -f bin -o build/kernel.bin

build/main.bin: src/boot/main.asm
	nasm src/boot/main.asm -f bin -o build/main.bin


#	truncate -s 1440k main/swift.img
