(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

extern
fun{a:t@ype} eq_elt_elt (x: a, y: a): bool

implement eq_elt_elt<int> (x, y) = g0int_eq (x, y)
implement eq_elt_elt<double> (x, y) = g0float_eq (x, y)

implement eq_elt_elt<int> (x, y) = (x = y)
implement eq_elt_elt<double> (x, y) = (x = y)

(* ****** ****** *)

fun{a:t@ype}
listeq (xs: list0 a, ys: list0 a): bool =
  case+ (xs, ys) of
  | (list0_cons (x, xs), list0_cons (y, ys)) => 
      if eq_elt_elt<a> (x, y) then listeq (xs, ys) else false
  | (list0_nil (), list0_nil ()) => true
  | (_, _) => false
// end of [listeq]

(* ****** ****** *)

fun{a:t@ype}
listeqf (
  xs: list0 a, ys: list0 a, eq: (a, a) -> bool
) : bool =
  case+ (xs, ys) of
  | (list0_cons (x, xs), list0_cons (y, ys)) => 
      if eq (x, y) then listeqf (xs, ys, eq) else false
  | (list0_nil (), list0_nil ()) => true
  | (_, _) => false
// end of [listeqf]

(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val xs = (list0)$arrpsz{int}(1, 2, 3)
//
val iseq = listeq<int> (xs, xs)
val ((*void*)) = assertloc (iseq)
val iseqf = listeqf<int> (xs, xs, lam (x, y) => x = y)
val ((*void*)) = assertloc (iseqf)
//
val () = println! ("[listeq] is tested successfully!")
//
} // end of [main]

(* ****** ****** *)

(* end of [listeq.dats] *)
