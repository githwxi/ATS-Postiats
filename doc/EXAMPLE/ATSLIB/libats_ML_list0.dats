(*
** for testing [libats/ML/list0]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/list0.dats"
//
(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs = list0_make_intrange (0, 10)
val () = assertloc (xs[0] = 0)
val () = assertloc (xs[5] = 5)
val () = assertloc (xs[9] = 9)
val () = assertloc (list0_head_exn(xs) = 0)
val () = assertloc (list0_head_exn(list0_tail_exn(xs)) = 1)
//
val xs = list0_make_intrange (0, 30, 3)
val () = assertloc (xs[0] = 0)
val () = assertloc (xs[5] = 15)
val () = assertloc (xs[9] = 27)
val () = assertloc (list0_head_exn(xs) = 0)
val () = assertloc (list0_head_exn(list0_tail_exn(xs)) = 3)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
val xs = (list0)$arrpsz{string}("a", "b", "c", "d", "e")
val () = assertloc (xs[0] = "a")
val () = assertloc (xs[1] = "b")
val () = assertloc (xs[2] = "c")
val () = assertloc (xs[3] = "d")
val () = assertloc (xs[4] = "e")
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
val xs = (list0)$arrpsz{string}("a", "b", "c", "d", "e")
val xsxs = list0_append (xs, xs)
val () = assertloc (length (xsxs) = 2 * length (xs))
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
#define N 10
//
val i = N / 2
val xs = list0_make_intrange (0, N)
val ys = list0_insert_at_exn (list0_remove_at_exn (xs, i), i, xs[i])
val iseq = list0_equal<int> (xs, ys, lam (x, y) => x = y)
val () = assertloc (iseq)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val xs = list0_of_list($list{int}(0, 2, 4, 6, 8))
//
val isevn = list0_forall<int> (xs, lam (x) => x mod 2 = 0)
val () = assertloc ( isevn)
//
val isodd = list0_exists<int> (xs, lam (x) => x mod 2 != 0)
val () = assertloc (~isodd)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs = list0_make_intrange (0, 10)
val () = fprintln! (out, "xs = ", xs)
//
val ys =
list0_map<int><int> (xs, lam x => x + x)
val () = fprintln! (out, "ys = ", ys)
//
val ys_odd =
list0_filter<int> (xs, lam x => x mod 2 != 0)
val () = fprintln! (out, "ys_odd = ", ys_odd)
//
val ys_evn =
list0_mapopt<int><int> (
  xs, lam x => if x mod 2 = 0 then Some_vt{int}(x) else None_vt()
) (* end of [val] *)
val () = fprintln! (out, "ys_evn = ", ys_evn)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val out = stdout_ref
val xs = list0_make_intrange (10, 0, ~1)
val () = fprintln! (out, "xs = ", xs)
val xs_sorted = list0_mergesort (xs, lam (x, y) => compare (x, y))
val () = fprintln! (out, "xs_sorted = ", xs_sorted)
val xs_sorted = list0_quicksort (xs, lam (x, y) => compare (x, y))
val () = fprintln! (out, "xs_sorted = ", xs_sorted)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_list0.dats] *)
