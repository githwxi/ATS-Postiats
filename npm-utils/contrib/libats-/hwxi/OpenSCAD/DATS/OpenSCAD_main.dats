(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: May, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
(*
** For implementing
** a DSL that supports
** ATS and OpenSCAD co-programming
*)
(* ****** ****** *)
//
#staload "./../SATS/OpenSCAD.sats"
//
(* ****** ****** *)
//
implement
fprint_val<scadarg> = fprint_scadarg
implement
fprint_val<scadexp> = fprint_scadexp
//
(* ****** ****** *)

(* end of [OpenSCAD_main.dats] *)
