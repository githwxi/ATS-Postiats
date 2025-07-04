all: dirent.h packages

dirent.h:
	wget https://raw.githubusercontent.com/tronkko/dirent/4677a335cb1cf6f76b0a28d44fd5e1ae7c4728e1/include/dirent.h

packages:
	pacman -Syu mingw-w64-x86_64-dlfcn mingw-w64-x86_64-gc
