.DEFAULT_GOAL := all

#PLATFORM = ENABLE_x86_64
PLATFORM = 686

#Support variables
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_LOG = $(ROOT_DIR)/build.log
SOURCES_C = $(shell ls src/**/*.c)
SOURCES_ASM = $(shell ls src/**/*.S)
#SOURCES_ASM = $(shell ls src/**/*.s)
OBJECTS_C = $(patsubst %.c, build/%.o, $(shell ls src/**/*.c | xargs -n 1 basename))
OBJECTS_ASM = $(patsubst %.S, build/%.o, $(shell ls src/**/*.S | xargs -n 1 basename))

#Compile programs and flags
ifeq ($(PLATFORM),ENABLE_x86_64)
	CC = /usr/local/osdev/bin/x86_64-elf-gcc
	LD = /usr/local/osdev/bin/x86_64-elf-ld
	ASM = /usr/local/osdev/bin/x86_64-elf-as

	CFLAGS = $(DEFINES) \
	-ffreestanding \
	-fno-omit-frame-pointer \
	-O2 \
	-g \
	-nostdlib \
	-static-libgcc \
	-lgcc \
	-I$(ROOT_DIR)/include \
	-Wno-write-strings \
	-std=c11             \
    -fno-stack-protector \
    -fno-stack-check     \
    -fno-lto             \
    -fno-pie             \
    -fno-pic             \
    -m64                 \
    -march=x86-64        \
    -mabi=sysv           \
    -mno-mmx             \
    -mno-sse2            \
    -mno-red-zone        \
    -mcmodel=kernel      \
    -MMD                 \
	-DENABLE_x86_64
else
	CC = /usr/local/osdev/bin/i686-elf-gcc
	LD = /usr/local/osdev/bin/i686-elf-ld
	ASM = /usr/local/osdev/bin/i686-elf-as

	CFLAGS = $(DEFINES) \
	-ffreestanding \
	-fno-omit-frame-pointer \
	-O2 \
	-g \
	-nostdlib \
	-static-libgcc \
	-lgcc \
	-I$(ROOT_DIR)/include \
	-Wno-write-strings \
	-std=c11             \
    -fno-stack-protector \
    -fno-stack-check     \
    -fno-lto             \
    -fno-pie             \
    -fno-pic             \
    -mabi=sysv           \
    -mno-mmx             \
    -mno-sse2            \
    -mno-red-zone        \
    -MMD                 
endif

           
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

build/%.o: src/*/%.S
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
