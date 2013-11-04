all: n-body n-bodyc

n-body: n-body.dats
	patscc -g -fomit-frame-pointer -march=native -pipe -msse3 -mfpmath=sse -O3 -DATS_MEMALLOC_LIBC $< -o $@ -lm

n-bodyc: n-body.c
	gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3 $< -o $@ -lm

.phony: clean

clean: 
	rm n-body n-bodyc *_dats.c
