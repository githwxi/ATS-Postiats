######

PATSCC=patscc

######

INCLUDE_ATS :=
INCLUDE_ATS += -I${PATSHOME}
INCLUDE_ATS += -I${PATSHOME}/ccomp/runtime 
INCLUDE_ATS += -I${PATSHOMERELOC}/contrib

######

CFLAGS_ATS :=
CFLAGS_ATS += -D_ATS_CCOMP_PRELUDE_NONE
CFLAGS_ATS += -D_ATS_CCOMP_PRELUDE_USER=\"kernel_prelude.cats\"
CFLAGS_ATS += -D_ATS_CCOMP_EXCEPTION_NONE
CFLAGS_ATS += -D_ATS_CCOMP_RUNTIME_NONE

######

CC=arm-linux-gnueabi-gcc
LD=arm-linux-gnueabi-ld

CFLAGS=-fPIC -fno-stack-protector -march=armv6 -msoft-float -mapcs-frame -marm
LDFLAGS=-N -Ttext=0x10000

######

all:: kernel_dats.elf

######

%_dats.c: %.dats ; $(PATSCC) -ccats - $@ $<
%_dats.s: %_dats.c ; \
  $(CC) $(INCLUDE_ATS) $(CFLAGS) $(CFLAGS_ATS) -O2 -S -o $@ $<
%_dats.o: %_dats.s ; $(CC) -O2 -c -o $@ $<

######

kernel_dats.elf: \
  bootstrap.o \
  kernel_dats.o \
  syscall.o \
  syscall_fork.o \
  context_switch.o \
  kernel_task_dats.o \
  kernel_bwputs_dats.o \

######

testing: kernel_dats.elf ; \
qemu-system-arm -M versatilepb -cpu arm1176 -nographic -kernel kernel_dats.elf

######

RMF=rm -f

######

.PHONY: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *.o

######

clean:: ; $(RMF) *_dats.c
clean:: ; $(RMF) *_dats.s

######

cleanall:: clean
cleanall:: ; $(RMF) *.elf

######

.SUFFIXES: .s .o .elf

.s.o: ; $(CC) $(CFLAGS) -o $@ -c $^

.o.elf: ; $(LD) $(LDFLAGS) -o $@ $^

###### end of [Makefile] ######
