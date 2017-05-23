(* ****** ****** *)
//
// Enumerate all of
// the permutations of a list
//
// Author: Hongwei Xi (February, 2014)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
staload UN = $UNSAFE // aliasing
//
(* ****** ****** *)

extern
fun{
a:t@ype
} listpermute{n:int} (list (a, n)): List0 (list(a, n))

(* ****** ****** *)

extern
fun{a:t@ype}
list_mcons{n:nat}
  (x0: a, xss: List (list(a, n))): List0_vt(list(a, n+1))

(* ****** ****** *)

implement
{a}(*tmp*)
list_mcons (x0, xss) =
(
case+ xss of
| list_nil () => nil_vt ()
| list_cons (xs, xss) => cons_vt (cons (x0, xs), list_mcons<a> (x0, xss))
)

(* ****** ****** *)

implement
{a}(*tmp*)
listpermute
  {n}(xs) = let
//
val n = length (xs)
prval () = lemma_list_param (xs)
vtypedef res = List0_vt (list(a, n))
//
fn fopr (i: natLt(n)): res = let
  var x: a
  val xs1 = list_takeout_at<a> (xs, i, x)
in
  list_mcons<a> (x, listpermute<a> (xs1))
end // end of [fopr]
//
implement(res)
list_tabulate$fopr<res>
  (i) = let
  val () = ignoret (xs) // HX: bug?
in
  $UN.castvwtp0{res}(fopr($UN.cast{natLt(n)}(i)))
end // end of [list_tabulate$fopr]
//
in
//
if n = 0
  then cons (nil, nil)
  else list_vt2t(list_vt_concat<list(a,n)>(list_tabulate<res>(n)))
//
end // end of [listpermute]

(* ****** ****** *)

implement
main0 () =
{
//
val xs =
  list_make_intrange (0, 4)
//
val xs = list_vt2t{int} (xs)
//
val xss = listpermute<int> (xs)
//
val () = print! ("permute(", xs, ") =\n")
val () = list_foreach_cloref<List(int)> (xss, lam xs =<1> fprintln!(stdout_ref, xs))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [listpermute.dats] *)
