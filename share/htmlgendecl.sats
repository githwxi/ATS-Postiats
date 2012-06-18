(*
** htmlgen_decl:
** For generating html file describing declarations
*)

(* ****** ****** *)

staload "libatsdoc/SATS/libatsdoc_text.sats"

(* ****** ****** *)

datatype
declitem =
  | DITMname of string
  | DITMsynopsis of ()
  | DITMdescript of string
  | DITMexample of string
// end of [declitem]

(* ****** ****** *)

fun decltitle (x: string): atext
fun theDecltitle_get (): string
fun theDecltitle_set (x: string): void

(* ****** ****** *)

fun declpreamble (x: string): atext
fun theDeclpreamble_get (): string
fun theDeclpreamble_set (x: string): void

(* ****** ****** *)

fun declname (x: string): atext
//
// HX: for the current declname
//
fun declsynopsis ((*auto*)): atext
fun declsynopsis_manu (x: string): atext
//
fun decldescript (x: string): atext
//
fun declexample (x: string): atext // HX: optional

fun theDeclname_get (): string
fun theDeclname_set (x: string): void

fun theDeclnameLst_add (x: string): void
fun theDeclnameLst_get (): List_vt (string)

fun theDeclitemLst_add (x: declitem): void
fun theDeclitemLst_get (): List_vt (declitem)

(* ****** ****** *)

fun declname_find_synopsis
  (x: string): string = "ext#declname_find_synopsis"
// end of [declname_find_synopsis]

(* ****** ****** *)

fun theDeclnameLst_make_menu (): atext
fun theDeclitemLst_make_content (): atext

(* ****** ****** *)

(* end of [htmlgen_decl.sats] *)
