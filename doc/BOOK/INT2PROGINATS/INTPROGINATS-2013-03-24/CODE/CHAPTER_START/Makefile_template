##
##
## A Makefile template for compiling ATS programs
##
##

######

ATSUSRQ="$(ATSHOME)"
ifeq ($(ATSUSRQ),"")
ATSUSRQ="/usr"
endif # end of [ifeq]

######

ATSCC=$(ATSUSRQ)/bin/atscc
ATSOPT=$(ATSUSRQ)/bin/atsopt

######

#
# HX: Please uncomment the one you want, or skip it entirely
#
ATSCCFLAGS=
#ATSCCFLAGS=-O2
#
# '-flto' enables link-time optimization such as inlining lib functions
#
#ATSCCFLAGS=-O2 -flto

######

#
# HX: Please uncomment it if you need to run GC at run-time
#
ATSGCFLAG=
#ATSGCFLAG=-D_ATS_GCATS

######

distclean::

######

# Please uncomment the following three lines and replace the name [foo]
# with the name of the file you want to compile

# foo: foo.dats
# 	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
# distclean:: ; $(RMF) foo

######
#
# HX: these are rules you may use
#

# %_sats.o: %.sats
# 	$(ATSCC) $(ATSCCFLAGS) -c $< || touch $@

# %_dats.o: %.dats
# 	$(ATSCC) $(ATSCCFLAGS) -c $< || touch $@

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

distclean:: clean

###### end of [Makefile] ######
