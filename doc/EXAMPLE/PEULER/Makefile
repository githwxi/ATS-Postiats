#
# A Makefile for PEULER problems
#

######

CCOMP=gcc -O2 -D_XOPEN_SOURCE

######
#
export \
PATSHOMERELOCS=$(PATSHOME)/contrib
#
######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######
#
CFLAGS :=
#
CFLAGS += -DATS_MEMALLOC_LIBC
#
CFLAGS += -I$(PATSHOMEQ)
CFLAGS += -I$(PATSHOMEQ)/ccomp/runtime
#
CFLAGS += -I$(PATSHOMEQ)/contrib/atscntrb
#
######
#
all:: P1
#
P1:: \
problem1-hwxi.exe
problem1-hwxi.exe:: \
problem1-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem1-hwxi_dats.c :: P1/problem1-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem1-hwxi.exe ; ./$<
cleanall:: ; $(RMF) problem1-hwxi.exe
#
P1:: \
problem1-hwxi2.exe
problem1-hwxi2.exe:: \
problem1-hwxi2_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem1-hwxi2_dats.c:: P1/problem1-hwxi2.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem1-hwxi2.exe ; ./$<
#
cleanall:: ; $(RMF) problem1-hwxi2.exe
#
######
#
all:: P2
#
P2:: \
problem2-hwxi.exe
problem2-hwxi.exe:: \
problem2-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $< -lgmp
problem2-hwxi_dats.c:: P2/problem2-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem2-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem2-hwxi.exe
#
#
P2:: \
problem2-hwxi2.exe
problem2-hwxi2.exe:: \
problem2-hwxi2_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $< -lgmp
problem2-hwxi2_dats.c:: P2/problem2-hwxi2.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem2-hwxi2.exe ; ./$<
#
cleanall:: ; $(RMF) problem2-hwxi2.exe
#
######
#
all:: P3
#
P3:: \
problem3-hwxi.exe
problem3-hwxi.exe:: \
problem3-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $< -lgmp
problem3-hwxi_dats.c:: P3/problem3-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem3-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem3-hwxi.exe
#
######
#
all:: P4
#
P4:: \
problem4-hwxi.exe
problem4-hwxi.exe:: \
problem4-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem4-hwxi_dats.c:: P4/problem4-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem4-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem4-hwxi.exe
#
######
#
all:: P6
#
P6:: \
problem6-hwxi.exe
problem6-hwxi.exe:: \
problem6-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem6-hwxi_dats.c:: P6/problem6-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem6-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem6-hwxi.exe
#
######
#
all:: P8
#
P8:: \
problem8-hwxi.exe
problem8-hwxi.exe:: \
problem8-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem8-hwxi_dats.c:: P8/problem8-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem8-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem8-hwxi.exe
#
######
#
all:: P10
#
P10:: \
problem10-hwxi.exe
problem10-hwxi.exe:: \
problem10-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem10-hwxi_dats.c:: P10/problem10-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem10-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem10-hwxi.exe
#
######
#
all:: P12
#
P12:: \
problem12-hwxi.exe
problem12-hwxi.exe:: \
problem12-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem12-hwxi_dats.c:: P12/problem12-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem12-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem12-hwxi.exe
#
######
#
all:: P14
#
P14:: \
problem14-hwxi.exe
problem14-hwxi.exe:: \
problem14-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $< -lgmp
problem14-hwxi_dats.c:: P14/problem14-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem14-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem14-hwxi.exe
#
######
#
all:: P16
#
P16:: \
problem16-hwxi.exe
problem16-hwxi.exe:: \
problem16-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $< -lgmp
problem16-hwxi_dats.c:: P16/problem16-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem16-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem16-hwxi.exe
#
######
#
all:: P100
#
P100:: \
problem100-hwxi.exe
problem100-hwxi.exe:: \
problem100-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $< -lm
problem100-hwxi_dats.c:: P100/problem100-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
regress:: problem100-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem100-hwxi.exe
#
######
#
all:: P301
#
P301:: \
problem301-hwxi.exe
problem301-hwxi.exe:: \
problem301-hwxi_dats.c ; $(CCOMP) $(CFLAGS) -o $@ $<
problem301-hwxi_dats.c:: P301/problem301-hwxi.dats ; $(PATSOPT) -o $@ -d $<
#
# HX: too time-consuming ...
# regress:: problem301-hwxi.exe ; ./$<
#
cleanall:: ; $(RMF) problem301-hwxi.exe
#
######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
