(*
**
** Some utility functions
** for turning ATS2 syntax trees into JSON format
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
**
** Start Time: November, 2013
**
*)

(* ****** ****** *)
//
staload
ERR = "src/pats_error.sats"
//
(* ****** ****** *)
//
staload
SYM = "src/pats_symbol.sats"
//
typedef symbol = $SYM.symbol
//
(* ****** ****** *)
//
staload
LOC = "src/pats_location.sats"
//
typedef position = $LOC.position
typedef location = $LOC.location
//
(* ****** ****** *)

fun fprint_position (out: FILEref, x: position): void
fun fprint_location (out: FILEref, x: location): void

(* ****** ****** *)

(* end of [libatsyn2json.sats] *)
