######
#
# A Simple Makefile
#
######

CPF=cp -f
RMF=rm -f
MAKE=make

######

copy:: ; \
$(CPF) mylib_dats.atxt BUILD/.
copy:: ; \
$(CPF) mylib_html.atxt BUILD/.
copy:: ; \
$(CPF) mylib_atexting.dats BUILD/.

######

build:: ; \
$(MAKE) \
-C BUILD -f ../Makefile_build regress

######

update:: ; \
$(CPF) BUILD/mylib_atxt.dats ./../.
update:: ; \
$(CPF) BUILD/mylib_atxt.html ./../../../HTML/.

######
#
clean:: ; $(RMF) ./BUILD/*.o
clean:: ; $(RMF) ./BUILD/*.c
clean:: ; $(RMF) ./BUILD/*.atxt
clean:: ; $(RMF) ./BUILD/*_atxt.dats
clean:: ; $(RMF) ./BUILD/*_atxt.html
clean:: ; $(RMF) ./BUILD/mylib_atexting
#
######
#
cleanall:: clean
#
######

###### end of [Makefile] ######
