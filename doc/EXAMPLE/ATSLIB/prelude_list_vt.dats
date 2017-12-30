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
//
fun
nil() = $list_vt{T}()
//
val xs1 = $list_vt{T}(1)
val xs2 = $list_vt{T}(2)
val xs3 = $list_vt{T}(3)
//
val xss =
$list_vt{List_vt(T)}
(xs1, nil(), xs2, nil(), xs3)
//
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
typedef T = int
//
val out = stdout_ref
//
val xs =
  $list_vt{T}(0, 9, 2, 7, 4, 5, 6, 3, 8, 1)
val ys =
  $list_vt{T}(0, 9, 2, 7, 4, 5, 6, 3, 8, 1)
//
val xys = list_vt_append (xs, ys)
//
implement
list_vt_mergesort$cmp<T> (x, y) = compare (x, y)
//
val xys =
  list_vt_mergesort<T> (xys)
val () = fprint_list_vt<T> (out, xys)
val () = fprint_newline (out)
val () = list_vt_free<T> (xys)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_list_vt.dats] *)
