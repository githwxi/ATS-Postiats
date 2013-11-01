all: n-body

n-body: n-body.dats
	patscc -msse2 -mfpmath=sse -O3 n-body.dats -o n-body -lm

.phony: clean

clean: 
	rm n-body *_dats.c
