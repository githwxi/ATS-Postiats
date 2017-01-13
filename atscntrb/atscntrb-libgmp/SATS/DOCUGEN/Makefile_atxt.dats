(*
Makefile.atxt: 1(line=1, offs=1) -- 176(line=11, offs=3)
*)

//
staload
STDIO = "libc/SATS/stdio.sats"
staload TIME = "libc/SATS/time.sats"
//
dynload "libatsdoc/dynloadall.dats"
//
staload "libatsdoc/SATS/libatsdoc_atext.sats"
//

(*
Makefile.atxt: 178(line=12, offs=1) -- 1029(line=42, offs=3)
*)


fun comment
  (x: string): atext = atext_nil ()
// end of [comment]

fun make_entry
  (nm: string): atext = let
//
val ent = sprintf ("\
all_html:: HTML/%s.html\n\
HTML/%s.html: \
  %s_atxt.exe ; ./$< > $@
%s_atxt.txt: %s.atxt ; $(CAT) $< | \
  $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
%s_atxt.exe: htmlgendecl_atxt.dats \
  %s_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ; \
  $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $< \
    $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_%s:: ; \
  scp HTML/%s.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libgmp/SATS/DOCUGEN/HTML
clean:: ; $(RMF) %s_atxt.exe
cleanall:: ; $(RMF) HTML/%s.html
", @(nm, nm, nm, nm, nm, nm, nm, nm, nm, nm, nm)
) // end of [val]
//
in
  atext_strptr (ent)
end // end of [make_entry]


(*
Makefile.atxt: 2279(line=117, offs=2) -- 2296(line=117, offs=19)
*)
val __tok1 = make_entry("gmp")
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
Makefile.atxt: 2623(line=140, offs=1) -- 2696(line=142, offs=3)
*)

implement main () = fprint_filsub (stdout_ref, "Makefile_atxt.txt")

