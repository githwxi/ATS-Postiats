(*
** for testing [prelude/list_vt]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () =
{
val x0 = 0
val x1 = 1
val xs = nil_vt{int}()
val xs = cons_vt{int}(x0, cons_vt{int}(x1, xs))
val+~cons_vt (x, xs) = xs
val () = assertloc (x = x0)
val+~cons_vt (x, xs) = xs
val () = assertloc (x = x1)
val+~nil_vt () = xs
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val xs =
list_make_intrange (0, 10)
val xs = list_vt_cast{int}(xs)
val () = fprintln! (stdout_ref, "digits = ", xs)
val rxs = list_vt_reverse (xs)
val () = fprintln! (stdout_ref, "digits(rev) = ", rxs)
val () = list_vt_free (rxs)
} (* end of [val] *)

(* ****** ****** *)

val () =
{
typedef T = int
val xs1 = $list_vt{T}(1)
val xs2 = $list_vt{T}(2)
val xs3 = $list_vt{T}(3)
val xss = $list_vt{List_vt(T)}(xs1, xs2, xs3)
val xs123 = list_vt_concat (xss) // xs123 = [1, 2, 3]
//
val () = assertloc (length (xs123) = 3)
//
val () = assertloc (xs123[0] = 1)
val () = assertloc (xs123[1] = 2)
val () = assertloc (xs123[2] = 3)
//
val () = list_vt_free<T> (xs123)
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val N = 10
val out = stdout_ref
//
typedef T = int
val xs =
  $list_vt{T}(0, 9, 2, 7, 4, 5, 6, 3, 8, 1)
val () = fprint_list_vt_sep<T> (out, xs, "; ")
val () = fprint_newline (out)
//
implement
list_vt_mergesort$cmp<T> (x1, x2) = compare (x1, x2)
//
val ys =
  list_vt_mergesort<T> (xs)
val () = fprint_list_vt<T> (out, ys)
val () = fprint_newline (out)
val () = list_vt_free<T> (ys)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs1 = list_make_intrange (0, 5)
val xs2 = list_make_intrange (5, 10)
val xs12 = list_vt_append<int> (xs1, xs2)
//
val () = fprintln! (out, "xs12 = ", xs12)
//
val () = list_vt_free (xs12)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_list_vt.dats] *)
