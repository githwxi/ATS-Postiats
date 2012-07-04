(*
** declatext:
** For documenting declarations
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
  | DITMsynop of () | DITMsynop2 of (string)
  | DITMdescrpt of (string)
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

fun theDeclpostamble_get (): string
fun theDeclpostamble_set (x: string): void
fun declpostamble (x: string): atext

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
fun declsynop ((*auto*)): atext
fun declsynopsis ((*auto*)): atext
//
fun declsynop2 (x: string): atext
fun declsynopsis2 (x: string): atext
//
fun declnamesynop (x: string): atext
//
fun decldescrpt (x: string): atext
//
fun declexample (x: string): atext // HX: optional

(* ****** ****** *)

fun theDeclrepLst_get (): declreplst
fun theDeclrepLst_set (xs: declreplst): void

(* ****** ****** *)

(* end of [declatext.sats] *)
