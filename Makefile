FILES = ./build/kernel.o
INCLUDES = -I./src
FLAGS = -g -ffreestanding -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -Wall -O0 -Iinc

all: ./build/kernel.o ./build/boot.o
	rm -f ./bin/myos.bin
	i686-elf-gcc -T linker.ld -o ./bin/myos.bin $(FLAGS) ./build/boot.o ./build/kernel.o -lgcc
	cp -f ./bin/myos.bin isodir/boot/
	grub-mkrescue -o myos.iso isodir

./build/boot.o: ./src/boot/boot.s
	i686-elf-as  ./src/boot/boot.s -o ./build/boot.o

./build/kernel.o: ./src/kernel.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c ./src/kernel.c -o ./build/kernel.o

clean:
	rm -rf ./bin/*
	rm -rf ./build/*
	rm -rf ./isodir/boot/myos.bin
