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
Makefile.atxt: 178(line=12, offs=1) -- 684(line=34, offs=3)
*)


fun make_entry
  (nm: string): atext = let
//
val ent = sprintf ("\
all:: %s.cats\n\
%s.cats: %s_atxt.exe ; ./$< > $@\n\
%s_atxt.exe: %s_atxt.dats\n\
	$(ATSCC) $(GCFLAG) -o $@ %s_atxt.dats -latsdoc\n\
%s_atxt.dats: %s.atxt\n\
	$(ATSDOC) --outcode $@ -i %s.atxt > %s_atxt.txt\n\
clean:: ; $(RMF) %s_atxt.exe\n\
cleanall:: ; $(RMF) %s.cats\n\
", @(nm, nm, nm, nm, nm, nm, nm, nm, nm, nm, nm, nm)
) // end of [val]
//
val ent = string_of_strptr (ent)
in
  atext_strcst (ent)
end // end of [make_entry]


(*
Makefile.atxt: 910(line=63, offs=2) -- 928(line=63, offs=20)
*)
val __tok1 = make_entry("mman")
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
Makefile.atxt: 930(line=64, offs=2) -- 948(line=64, offs=20)
*)
val __tok2 = make_entry("stat")
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
Makefile.atxt: 950(line=65, offs=2) -- 968(line=65, offs=20)
*)
val __tok3 = make_entry("time")
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
Makefile.atxt: 970(line=66, offs=2) -- 989(line=66, offs=21)
*)
val __tok4 = make_entry("types")
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
Makefile.atxt: 991(line=67, offs=2) -- 1009(line=67, offs=20)
*)
val __tok5 = make_entry("wait")
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
Makefile.atxt: 1011(line=68, offs=2) -- 1031(line=68, offs=22)
*)
val __tok6 = make_entry("socket")
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
Makefile.atxt: 1033(line=69, offs=2) -- 1056(line=69, offs=25)
*)
val __tok7 = make_entry("socket_in")
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
Makefile.atxt: 1280(line=87, offs=1) -- 1363(line=90, offs=3)
*)

implement
main (argc, argv) = fprint_filsub (stdout_ref, "Makefile_atxt.txt")

