(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)

abstype location

fun fprint_location (out: FILEref, x: location): void

(* ****** ****** *)

abstype token
typedef tokenlst = List (token)
viewtypedef tokenlst_vt = List_vt (token)

(* ****** ****** *)

fun token_get_loc (x: token): location

fun fprint_token (out: FILEref, x: token): void

(* ****** ****** *)

fun token_is_eof (x: token): bool

(* ****** ****** *)

fun fileref_get_tokenlst (inp: FILEref): tokenlst_vt

(* ****** ****** *)

(* end of [libatsyntax.sats] *)
