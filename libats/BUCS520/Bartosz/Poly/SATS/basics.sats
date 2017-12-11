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
( f: cfun(a, b)
, g: cfun(b, c)): cfun(a, c)
//
(* ****** ****** *)

abstype Monoid(a:type)

(* ****** ****** *)
//
fun
Monoid_mempty
{a:type}(Monoid(a)): a
fun
Monoid_mappend
{a:type}(Monoid(a)): cfun(a, a, a)
//
(* ****** ****** *)

sortdef ftype = type -> type

(* ****** ****** *)

abstype Functor(f: ftype)

fun
Functor_fmap
{f:ftype}
(Functor(f)):
{a,b:type}
cfun(cfun(a, b), cfun(f(a), f(b)))

(* ****** ****** *)

(* end of [basics.sats] *)
