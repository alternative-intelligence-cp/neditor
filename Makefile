.PHONY: all build test clean

all: build

build:
	/home/randy/Workspace/REPOS/nitpick-build/build/npkbld build

test:
	/home/randy/Workspace/REPOS/nitpick-build/build/npkbld test
	./.nitpick_make/build/test-neditor

clean:
	rm -rf .nitpick_make
