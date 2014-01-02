(*
** htmlgendecl:
** For generating html files describing declarations
*)

(* ****** ****** *)

staload
LDOC = "libatsdoc/SATS/libatsdoc_atext.sats"
typedef atext = $LDOC.atext

(* ****** ****** *)

fun myatscodelink
  (codepath: string, linkname: string): atext
// end of [myatscodelink]

(* ****** ****** *)

fun declname_find_synoplst (stadyn: int, x: string): List_vt (strptr1)

(* ****** ****** *)

fun theDeclnameLst_make_menu (): atext
fun theDeclitemLst_make_content (): atext

(* ****** ****** *)

(* end of [htmlgendecl.sats] *)
