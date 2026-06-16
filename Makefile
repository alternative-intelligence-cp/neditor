.PHONY: all build test clean

all: build

build: shim/libsys_shim.a
	/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build

shim/libsys_shim.a: src/sys_shim.c
	mkdir -p shim
	cc -O2 -c src/sys_shim.c -o shim/sys_shim.o
	ar rcs shim/libsys_shim.a shim/sys_shim.o

test: shim/libsys_shim.a
	/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build test-buffer test-file-io test-neditor test-plugin
	.nitpick_make/build/test-buffer
	.nitpick_make/build/test-file-io
	.nitpick_make/build/test-plugin

clean:
	rm -rf .nitpick_make shim
