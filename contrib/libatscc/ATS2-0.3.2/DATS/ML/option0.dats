(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
//
staload
"./../../SATS/ML/option0.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
{}(*tmp*)
option0_is_none
  (opt) =
(
case+ opt of
| None0() => true | Some0(_) => false
)
implement
{}(*tmp*)
option0_is_some
  (opt) =
(
case+ opt of
| Some0(_) => true | None0() => false
)
//
(* ****** ****** *)

(* end of [option0.dats] *)
