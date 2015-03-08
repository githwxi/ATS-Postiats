(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)
//
// Function templates vs.
// Higher-order functions
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

val xs =
$list{int}(0,1,2,3,4,5,6,7,8,9)
val ((*void*)) = println! ("xs = ", xs)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list_map_fun{n:nat}
  (xs: list(a, n), f: a -> b): list_vt(b, n)
//
implement
{a}{b}
list_map_fun (xs, f) = let
//
fun
aux{n:nat}
  (xs: list(a, n)): list_vt(b, n) =
(
case+ xs of
| list_nil () => list_vt_nil ()
| list_cons (x, xs) => list_vt_cons (f(x), aux(xs))
) (* end of [aux] *)
//
in
  aux(xs)
end // end of [list_map_fun]

(* ****** ****** *)
  
val xs2 =
list_map_fun<int><int>(xs, lam x => x*x)
val ((*void*)) = println! ("xs2 = ", xs2)
  
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list_map_cloref{n:nat}
  (xs: list(a, n), f: a -<cloref1> b): list_vt(b, n)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{b:t@ype}
list_map{n:nat}
  (xs: list(a, n)): list_vt(b, n)
//
extern
fun
{a:t@ype}{b:t@ype} list_map$fopr(x: a): b
//
implement
{a}{b}
list_map (xs) = let
//
fun
aux{n:nat}
  (xs: list(a, n)): list_vt(b, n) =
(
case+ xs of
| list_nil () => list_vt_nil ()
| list_cons (x, xs) => list_vt_cons (list_map$fopr<a><b>(x), aux(xs))
) (* end of [aux] *)
//
in
  aux(xs)
end // end of [list_map]
//
(* ****** ****** *)

implement
{a}{b}
list_map_fun(xs, f) = let
//
implement list_map$fopr<a><b> (x) = f(x)
//
in
  list_map<a><b> (xs)
end // end of [list_map_fun]

implement
{a}{b}
list_map_cloref(xs, f) = let
//
implement list_map$fopr<a><b> (x) = f(x)
//
in
  list_map<a><b> (xs)
end // end of [list_map_cloref]

(* ****** ****** *)
//
val xs2 =
list_map_fun<int><int>(xs, lam x => x*x)
val ((*void*)) = println! ("xs2 = ", xs2)
//
val xs3 =
list_map_cloref<int><int>(xs, lam x => x*x)
val ((*void*)) = println! ("xs3 = ", xs3)
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [list_map.dats] *)
