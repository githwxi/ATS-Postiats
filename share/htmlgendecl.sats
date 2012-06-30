(*
** htmlgendecl:
** For generating html file describing declarations
*)

(* ****** ****** *)

staload
LDOC = "libatsdoc/SATS/libatsdoc_atext.sats"
typedef atext = $LDOC.atext

(* ****** ****** *)

fun declname_find_synopsis (stadyn: int, x: string): strptr1

(* ****** ****** *)

fun theDeclnameLst_make_menu (): atext
fun theDeclitemLst_make_content (): atext

(* ****** ****** *)

(* end of [htmlgendecl.sats] *)
