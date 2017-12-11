(* ****** ****** *)
(*
** Category Theory
** for Programmers
** By Bartosz Milewski
*)
(* ****** ****** *)
//
#staload "./../SATS/basics.sats"
//
(* ****** ****** *)

implement
idfun() = lam(x) => x

(* ****** ****** *)
//
implement
compose(f, g) = lam(x) => g(f(x))
//
(* ****** ****** *)

(* end of [basics.dats] *)
