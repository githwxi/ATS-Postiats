CC=gcc

CFLAGS+=-I${PATSHOME}
CFLAGS+=-I${PATSHOME}/ccomp/runtime

hello: hello_dats.c ; $(CC) $(CFLAGS) -o $@ $<

RMF=rm -f

clean:: ; $(RMF) *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) hello
cleanall:: ; $(RMF) hello_dats.c
