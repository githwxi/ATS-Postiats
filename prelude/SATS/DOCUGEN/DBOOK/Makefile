##
## dbookgendecl:
## For generating docbook files describing declarations
##

######

all:: all_html

######

all_html:: HTML/bool.html
all_html:: HTML/char.html
all_html:: HTML/filebas.html
all_html:: HTML/float.html
all_html:: HTML/integer.html
all_html:: HTML/intrange.html
all_html:: HTML/pointer.html
all_html:: HTML/reference.html
all_html:: HTML/string.html
all_html:: HTML/strptr.html

all_html:: HTML/array.html
all_html:: HTML/array_prf.html
all_html:: HTML/arrayptr.html
all_html:: HTML/arrayref.html

all_html:: HTML/list.html
all_html:: HTML/list_vt.html

all_html:: HTML/option.html
all_html:: HTML/option_vt.html

all_html:: HTML/unsafe.html

all_html:: HTML/iterator.html

######

HTML/%.html: %.dbk ; jw --backend html -u --output HTML/ $<

######

uploadall:: ; scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/prelude

######

RMF=rm -f

######

clean:: ; $(RMF) *~

cleanall:: clean
cleanall:: ; $(RMF) HTML/*.html

###### end of [Makefile] ######
