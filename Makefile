.PHONY: all build test clean

all: build

build:
	/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build

test:
	/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build test-buffer test-file-io test-neditor test-plugin
	.nitpick_make/build/test-buffer
	.nitpick_make/build/test-file-io
	.nitpick_make/build/test-plugin

clean:
	rm -rf .nitpick_make
