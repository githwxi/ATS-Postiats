(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
staload "./../../basics.sats"
*)

(* ****** ****** *)
//
fun{}
option0_is_none
  {a:t0p}(xs: option0(INV(a))): bool
fun{}
option0_is_some
  {a:t0p}(xs: option0(INV(a))): bool
//
overload iseqz with option0_is_none of 100
overload isneqz with option0_is_some of 100
//
(* ****** ****** *)

(* end of [option0.sats] *)
