(* ****** ****** *)
(*
** Category Theory
** for Programmers
** By Bartosz Milewski
*)
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
fun
idfun{a:type}(): cfun(a, a)
//
(* ****** ****** *)
//
fun
compose
{a,b,c:type}
(f: cfun(a, b), g: cfun(b, c)): cfun(a, c)
//
(* ****** ****** *)

(* end of [basics.sats] *)
