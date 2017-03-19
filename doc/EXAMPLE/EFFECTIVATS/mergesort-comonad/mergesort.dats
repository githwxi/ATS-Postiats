(* ****** ****** *)
(*
** Co-monadic Mergesort
*)
(* ****** ****** *)

(*
//
Co-monad laws in Haskell syntax:
//
extend extract      = id
extract . extend f  = f
extend f . extend g = extend (f . extend g)
//
f: w(b) -> c
g: w(a) -> b
//
extract: w(a) -> a
//
extend(f): w(b) -> w(c)
extend(g): w(a) -> w(b)
f . extend(g): w(a) -> c
extend(f . extend(g)): w(a) -> w(c)
//
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

typedef
CM(a:t@ype) = list0(a)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
extract(CM(a)): a
//
extern
fun
{a:t@ype}
{b:t@ype}
extend(CM(a), CM(a) -<cloref1> b): CM(b)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
merge_two(xss: list0(list0(a))): list0(a)
extern
fun
{a:t@ype}
merge_all(xss: list0(list0(a))): list0(a)
//
(* ****** ****** *)
(*
implement
(a)(*tmp*)
extract<list0(a)>(xss) = merge_all<a>(xss)
*)
(* ****** ****** *)
(*
implement
(a,b)(*tmp*)
extend<list0(a)><b>(xss, fopr) = list0_nil()
*)
(* ****** ****** *)

extern
fun
{a:t@ype}
mergesort(list0(a)): list0(a)
extern
fun
{a:t@ype}
merge_ungroup(list0(a)): list0(list0(a))

(* ****** ****** *)

implement
{a}(*tmp*)
mergesort(xs) = let
//
val xss = merge_ungroup(xs)
fun merge_all(xss: CM(list0(a))): list0(a) =
  case+ xss of
  | list0_nil() => list0_nil()
  | list0_cons(xs, list0_nil()) => xs
  | list0_cons(_, list0_cons(_, _)) => merge_all(extend(xss, lam(xss) => merge_two(xss)))
in
  merge_all(xss)
end // end of [mergesort]
  

(* ****** ****** *)

(* end of [mergesort.dats] *)
