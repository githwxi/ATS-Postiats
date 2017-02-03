#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"

######

SHAREDOCU=$(PATSHOMEQ)/share/DOCUGEN

######

LDPATH :=
LDPATH += -L$(PATSHOME)/ccomp/atslib/lib

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(SHAREDOCU) -IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

CAT=cat

######

all:: all_html

######

DECLATEXT=   declatext_sats.o   declatext_dats.o 
declatext_sats.o: ;   $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/declatext.sats
declatext_dats.o: ;   $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/declatext.dats

######

HTMLGENDECL=   htmlgendecl_sats.o   htmlgendecl_dats.o 
htmlgendecl_sats.o: ;   $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/htmlgendecl.sats
htmlgendecl_dats.o: ;   $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/htmlgendecl.dats

htmlgendecl_atxt.dats: ;   $(ATSDOC) --outcode $@ -i $(SHAREDOCU)/htmlgendecl.atxt > htmlgendecl_atxt.txt

######

all_html::

######

all_html:: HTML/SDL.html
HTML/SDL.html:   SDL_atxt.exe ; ./$< > $@
SDL_atxt.txt: SDL.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_atxt.exe: htmlgendecl_atxt.dats   SDL_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL:: ;   scp HTML/SDL.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_atxt.exe
cleanall:: ; $(RMF) HTML/SDL.html

all_html:: HTML/mybasis.html
HTML/mybasis.html:   mybasis_atxt.exe ; ./$< > $@
mybasis_atxt.txt: mybasis.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
mybasis_atxt.exe: htmlgendecl_atxt.dats   mybasis_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_mybasis:: ;   scp HTML/mybasis.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) mybasis_atxt.exe
cleanall:: ; $(RMF) HTML/mybasis.html

all_html:: HTML/SDL_error.html
HTML/SDL_error.html:   SDL_error_atxt.exe ; ./$< > $@
SDL_error_atxt.txt: SDL_error.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_error_atxt.exe: htmlgendecl_atxt.dats   SDL_error_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_error:: ;   scp HTML/SDL_error.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_error_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_error.html

all_html:: HTML/SDL_events.html
HTML/SDL_events.html:   SDL_events_atxt.exe ; ./$< > $@
SDL_events_atxt.txt: SDL_events.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_events_atxt.exe: htmlgendecl_atxt.dats   SDL_events_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_events:: ;   scp HTML/SDL_events.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_events_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_events.html

all_html:: HTML/SDL_render.html
HTML/SDL_render.html:   SDL_render_atxt.exe ; ./$< > $@
SDL_render_atxt.txt: SDL_render.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_render_atxt.exe: htmlgendecl_atxt.dats   SDL_render_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_render:: ;   scp HTML/SDL_render.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_render_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_render.html

all_html:: HTML/SDL_surface.html
HTML/SDL_surface.html:   SDL_surface_atxt.exe ; ./$< > $@
SDL_surface_atxt.txt: SDL_surface.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_surface_atxt.exe: htmlgendecl_atxt.dats   SDL_surface_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_surface:: ;   scp HTML/SDL_surface.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_surface_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_surface.html

all_html:: HTML/SDL_timer.html
HTML/SDL_timer.html:   SDL_timer_atxt.exe ; ./$< > $@
SDL_timer_atxt.txt: SDL_timer.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_timer_atxt.exe: htmlgendecl_atxt.dats   SDL_timer_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_timer:: ;   scp HTML/SDL_timer.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_timer_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_timer.html

all_html:: HTML/SDL_version.html
HTML/SDL_version.html:   SDL_version_atxt.exe ; ./$< > $@
SDL_version_atxt.txt: SDL_version.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_version_atxt.exe: htmlgendecl_atxt.dats   SDL_version_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_version:: ;   scp HTML/SDL_version.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_version_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_version.html

all_html:: HTML/SDL_video.html
HTML/SDL_video.html:   SDL_video_atxt.exe ; ./$< > $@
SDL_video_atxt.txt: SDL_video.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
SDL_video_atxt.exe: htmlgendecl_atxt.dats   SDL_video_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_SDL_video:: ;   scp HTML/SDL_video.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) SDL_video_atxt.exe
cleanall:: ; $(RMF) HTML/SDL_video.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/SDL2/SATS/DOCUGEN/HTML/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
