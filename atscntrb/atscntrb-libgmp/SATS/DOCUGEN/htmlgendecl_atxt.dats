(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1(line=1, offs=1) -- 1666(line=70, offs=3)
*)

//
dynload "libatsdoc/dynloadall.dats"
//
dynload "utils/libatsynmark/dynloadall.dats"
staload "utils/libatsynmark/SATS/libatsynmark.sats"
//
#include "utils/atsdoc/HATS/pats2xhtmlatxt.hats"
//
dynload "declatext.dats"
staload "declatext.sats"
dynload "htmlgendecl.dats"
staload "htmlgendecl.sats"
//
staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"
//
extern
fun
theDeclrepLst_initize (fil: FILEref): void
implement
theDeclrepLst_initize
  (filr) = let
  val cs = char_list_vt_make_file (filr)
  val replst = charlst_declitemize (0(*sta*), cs)
in
  theDeclrepLst_set (replst)
end // end of [theDeclrepLst]
//
extern
fun srcfilename_get (): string
//
extern
fun htmlgendecl_initize (): void
//
val () = htmlgendecl_initize ()
//
#include "htmlgendecl_data_atxt.dats"
//
#ifndef
IMPLEMENT_HTMLGENDECL_INITIZE
//
implement
htmlgendecl_initize () = let
//
val name = srcfilename_get ()
val filr =
  open_file_exn (name, file_mode_r)
val () = libatsynmark_filename_set_current (name)
val () = theDeclrepLst_initize (filr)
val () = close_file_exn (filr)
//
in
  // nothing
end // end of [htmlgendecl_initize]
//
#endif // [IMPLEMENT_HTMLGENDECL_INITIZE]
//
val theDecltitle = theDecltitle_get ()
val theDeclpreamble = theDeclpreamble_get ()
val theDeclpostamble = theDeclpostamble_get ()
//
val theDeclnameLst_menu = theDeclnameLst_make_menu ()
val theDeclitemLst_content = theDeclitemLst_make_content ()
//
val () = theAtextMap_insert_str ("theDeclnameLst_menu", theDeclnameLst_menu)
val () = theAtextMap_insert_str ("theDeclitemLst_content", theDeclitemLst_content)
//

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1698(line=74, offs=2) -- 1717(line=74, offs=21)
*)
val __tok1 = title(theDecltitle)
val () = theAtextMap_insert_str ("__tok1", __tok1)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1787(line=76, offs=2) -- 1804(line=76, offs=19)
*)
val __tok2 = patsyntax_style()
val () = theAtextMap_insert_str ("__tok2", __tok2)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1806(line=77, offs=2) -- 1830(line=77, offs=26)
*)
val __tok3 = patscode_jquery_min_js()
val () = theAtextMap_insert_str ("__tok3", __tok3)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1832(line=78, offs=2) -- 1860(line=78, offs=30)
*)
val __tok4 = patscode_tryit_bind_all_js()
val () = theAtextMap_insert_str ("__tok4", __tok4)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1878(line=82, offs=2) -- 1894(line=82, offs=18)
*)
val __tok5 = H1(theDecltitle)
val () = theAtextMap_insert_str ("__tok5", __tok5)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1897(line=84, offs=2) -- 1926(line=84, offs=31)
*)
val __tok6 = atext_strsub(theDeclpreamble)
val () = theAtextMap_insert_str ("__tok6", __tok6)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1929(line=86, offs=2) -- 1934(line=86, offs=7)
*)
val __tok7 = HR(2)
val () = theAtextMap_insert_str ("__tok7", __tok7)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1937(line=88, offs=2) -- 1975(line=88, offs=40)
*)
val __tok8 = atext_strsub("#theDeclnameLst_menu$")
val () = theAtextMap_insert_str ("__tok8", __tok8)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1978(line=90, offs=2) -- 1983(line=90, offs=7)
*)
val __tok9 = HR(2)
val () = theAtextMap_insert_str ("__tok9", __tok9)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 1986(line=92, offs=2) -- 2027(line=92, offs=43)
*)
val __tok10 = atext_strsub("#theDeclitemLst_content$")
val () = theAtextMap_insert_str ("__tok10", __tok10)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 2030(line=94, offs=2) -- 2035(line=94, offs=7)
*)
val __tok11 = HR(2)
val () = theAtextMap_insert_str ("__tok11", __tok11)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 2038(line=96, offs=2) -- 2077(line=96, offs=41)
*)
val __tok12 = atext_filepath("theDeclpostamble.html")
val () = theAtextMap_insert_str ("__tok12", __tok12)

(*
/home/hwxi/Research/ATS-Postiats/share/DOCUGEN/htmlgendecl.atxt: 2096(line=101, offs=1) -- 2172(line=103, offs=3)
*)

implement main () = fprint_filsub (stdout_ref, "htmlgendecl_atxt.txt")

