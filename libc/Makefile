.DEFAULT_GOAL := all

#Support variables
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_LOG = $(ROOT_DIR)/build.log
SOURCES_C = $(shell ls src/**/*.c)
SOURCES_ASM = $(shell ls src/**/*.s)
#SOURCES_ASM = $(shell ls src/**/*.s)
OBJECTS_C = $(patsubst %.c, build/%.o, $(shell ls src/**/*.c | xargs -n 1 basename))
OBJECTS_ASM = $(patsubst %.s, build/%.o, $(shell ls src/**/*.s | xargs -n 1 basename))

#Compile programs and flags
CC = /usr/local/osdev/bin/x86_64-elf-gcc
LD = /usr/local/osdev/bin/x86_64-elf-ld
ASM = /usr/local/osdev/bin/x86_64-elf-as

CFLAGS = -ffreestanding -fno-omit-frame-pointer -O2 -nostdlib -static-libgcc -lgcc -g -I$(ROOT_DIR)/include $(C_OPTS) 
ALAGS = $(C_OPTS) -I$(ROOT_DIR)/src/include

#Support program and flags
OBJDUMP = /usr/local/osdev/bin/x86_64-elf-objdump

export

all: install

build/vvlibc.o: $(SOURCES_ASM) $(OBJECTS_C) $(OBJECTS_ASM)
	$(LD) -g -I$(ROOT_DIR)/include -nostdlib -r $(OBJECTS_C) $(OBJECTS_ASM) -o vvlibc.o
	objdump -x -d vvlibc.o > vvlibc_objdump.txt

build/%.o: src/*/%.c
	$(eval OBJNAME := $(shell basename $@))
	$(CC) $(CFLAGS) -c $< -o build/$(OBJNAME)

build/%.o: src/*/%.s
	$(eval OBJNAME := $(shell basename $@))
	$(CC) $(CFLAGS) -c $< -o build/$(OBJNAME)


install: build/vvlibc.o
	cp -f vvlibc.o ../vvlibc.o
  	#cp build/versionv.bin -f hd_mount_dir/boot/versionv.bin >> $(BUILD_LOG)

clean:
	rm -rf vvlibc.o
	rm -rf build.log
	rm -rf build/*.o
	rm -rf build/*.bin 
	rm -rf vvlibc_objdump.txt