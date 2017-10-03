(*
** For writing ATS code
** that translates into R(stat)
*)

(* ****** ****** *)
//
// HX-2014-09-09
//
(* ****** ****** *)
//
#staload "./basics_r34.sats"
(*
#staload _ = "./DATS/basics.dats"
*)
//
(* ****** ****** *)
//
#staload "./SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./SATS/bool.sats"
#staload "./SATS/float.sats"
#staload "./SATS/string.sats"
//
(* ****** ****** *)
//
#staload "./SATS/print.sats" // HX: printing to the console
//
(* ****** ****** *)
//
#staload "./SATS/R34vector.sats"
#staload _ = "./DATS/R34vector.dats"
//
(* ****** ****** *)
//
#staload "./SATS/R34dframe.sats"
#staload _ = "./DATS/R34dframe.dats"
//
(* ****** ****** *)

(* end of [mylibies.hats] *)
