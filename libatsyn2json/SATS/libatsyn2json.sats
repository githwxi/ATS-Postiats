(* ****** ****** *)
(*
**
** Some utility functions
** for turning ATS2 syntax trees into JSON format
**
*)
(* ****** ****** *)
(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
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

fun
jsonize_position (out: FILEref, pos: position): void
fun
jsonize_location (out: FILEref, loc: location): void

(* ****** ****** *)
//
staload
S2E = "src/pats_staexp2.sats"
//
typedef s2exp = $S2E.s2exp
typedef s2explst = $S2E.s2explst
//
(* ****** ****** *)
//
staload
D2E = "src/pats_dynexp2.sats"
//
typedef d2var = $D2E.d2var
typedef d2cst = $D2E.d2cst
//
typedef p2at = $D2E.p2at
typedef p2atlst = $D2E.p2atlst
typedef d2exp = $D2E.d2exp
typedef d2explst = $D2E.d2explst
typedef d2ecl = $D2E.d2ecl
typedef d2eclist = $D2E.d2eclist
//
(* ****** ****** *)

fun
jsonize_d2var (out: FILEref, d2v: d2var): void
fun
jsonize_d2cst (out: FILEref, d2c: d2cst): void

(* ****** ****** *)

fun jsonize_p2at (out: FILEref, p2t: p2at): void

(* ****** ****** *)

fun jsonize_d2exp (out: FILEref, d2e: d2exp): void

(* ****** ****** *)

fun jsonize_d2ecl (out: FILEref, d2c: d2ecl): void
fun jsonize_d2eclist (out: FILEref, d2cs: d2eclist): void

(* ****** ****** *)

(* end of [libatsyn2json.sats] *)
