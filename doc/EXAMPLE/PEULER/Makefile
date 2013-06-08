#
#
#

CCOPT=gcc -O2
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::
all:: P1
all:: P2
all:: P3
all:: P4
all:: P6
all:: P10
all:: P12
all:: P14
all:: P16

######

cleanall::

######

P1:: problem1-hwxi
problem1-hwxi:: \
  P1/problem1-hwxi.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem1-hwxi:: problem1-hwxi_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem1-hwxi:: problem1-hwxi.exe ; ./$<

P1:: problem1-hwxi2
problem1-hwxi2:: \
  P1/problem1-hwxi2.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem1-hwxi2:: problem1-hwxi2_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem1-hwxi2:: problem1-hwxi2.exe ; ./$<

######

P2:: problem2-hwxi
problem2-hwxi:: \
  P2/problem2-hwxi.dats ; $(PATSOPT) -IATS${PATSHOME}/contrib -o $@_dats.c -d $<
problem2-hwxi:: \
  problem2-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC \
  -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I${PATSHOME}/contrib -o $@.exe $@_dats.c -lgmp
problem2-hwxi:: problem2-hwxi.exe ; ./$<

P2:: problem2-hwxi2
problem2-hwxi2:: \
  P2/problem2-hwxi2.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem2-hwxi2:: problem2-hwxi2_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem2-hwxi2:: problem2-hwxi2.exe ; ./$<

######

P3:: problem3-hwxi
problem3-hwxi:: \
  P3/problem3-hwxi.dats ; $(PATSOPT) -IATS${PATSHOME}/contrib -o $@_dats.c -d $<
problem3-hwxi:: \
  problem3-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC \
  -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I${PATSHOME}/contrib -o $@.exe $@_dats.c -lgmp
problem3-hwxi:: problem3-hwxi.exe ; ./$<

######

P4:: problem4-hwxi
problem4-hwxi:: \
  P4/problem4-hwxi.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem4-hwxi:: problem4-hwxi_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem4-hwxi:: problem4-hwxi.exe ; ./$<

######

P6:: problem6-hwxi
problem6-hwxi:: \
  P6/problem6-hwxi.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem6-hwxi:: problem6-hwxi_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem6-hwxi:: problem6-hwxi.exe ; ./$<

######

P10:: problem10-hwxi
problem10-hwxi:: \
  P10/problem10-hwxi.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem10-hwxi:: problem10-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem10-hwxi:: problem10-hwxi.exe ; ./$<

######

P12:: problem12-hwxi
problem12-hwxi:: \
  P12/problem12-hwxi.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem12-hwxi:: problem12-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem12-hwxi:: problem12-hwxi.exe ; ./$<

######

P14:: problem14-hwxi
problem14-hwxi:: \
  P14/problem14-hwxi.dats ; $(PATSOPT) -IATS${PATSHOME}/contrib -o $@_dats.c -d $<
problem14-hwxi:: \
  problem14-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC \
  -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I${PATSHOME}/contrib -o $@.exe $@_dats.c -lgmp
problem14-hwxi:: problem14-hwxi.exe ; ./$<

######

P16:: problem16-hwxi
problem16-hwxi:: \
  P16/problem16-hwxi.dats ; $(PATSOPT) -IATS${PATSHOME}/contrib -o $@_dats.c -d $<
problem16-hwxi:: \
  problem16-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC \
  -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I${PATSHOME}/contrib -o $@.exe $@_dats.c -lgmp
problem16-hwxi:: problem16-hwxi.exe ; ./$<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) */*~
clean:: ; $(RMF) *_dats.c
cleanall:: clean
cleanall:: ; $(RMF) *.exe

######
