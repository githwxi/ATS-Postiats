(*
** htmlgendecl:
** For generating html file describing declarations
*)

(* ****** ****** *)

staload
LSYN = "libatsyntax/SATS/libatsyntax.sats"
typedef declreplst = $LSYN.declreplst

(* ****** ****** *)

staload
LDOC = "libatsdoc/SATS/libatsdoc_atext.sats"
typedef atext = $LDOC.atext
typedef atextlst = $LDOC.atextlst

(* ****** ****** *)

datatype
declitem =
  | DITMname of (string)
  | DITMsynopsis of ()
  | DITMsynopsis2 of (string)
  | DITMnamesynop of (string) // its combines DITMname and DITMsynopsis
  | DITMdescript of (string)
  | DITMexample of (string)
// end of [declitem]

(* ****** ****** *)

fun theDecltitle_get (): string
fun theDecltitle_set (x: string): void
fun decltitle (x: string): atext

(* ****** ****** *)

fun theDeclpreamble_get (): string
fun theDeclpreamble_set (x: string): void
fun declpreamble (x: string): atext

(* ****** ****** *)

fun theDeclname_get (): string
fun theDeclname_set (x: string): void

fun theDeclnameLst_add (x: string): void
fun theDeclnameLst_get (): List_vt (string)

fun theDeclitemLst_add (x: declitem): void
fun theDeclitemLst_get (): List_vt (declitem)

fun declname (x: string): atext
//
// HX: for the current declname
//
fun declsynopsis ((*auto*)): atext
fun declsynopsis2 (x: string): atext
//
fun declnamesynop (x: string): atext
//
fun decldescript (x: string): atext
//
fun declexample (x: string): atext // HX: optional

(* ****** ****** *)

fun theDeclrepLst_get (): declreplst
fun theDeclrepLst_set (xs: declreplst): void

fun declname_find_synopsis (stadyn: int, x: string): strptr1

(* ****** ****** *)

fun theDeclnameLst_make_menu (): atext
fun theDeclitemLst_make_content (): atext

(* ****** ****** *)

(* end of [htmlgendecl.sats] *)
