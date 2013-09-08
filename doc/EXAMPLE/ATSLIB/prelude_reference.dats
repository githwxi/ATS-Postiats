(*
** for testing [prelude/reference]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () =
{
//
typedef T = int
//
val r = ref<T> (0)
val () = !r := !r + 1
val () = assertloc (!r = 1)
val () = !r := 2 * !r
val () = assertloc (!r = 2)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val r1 = ref<T> (1)
val r2 = ref<T> (2)
val () = assertloc (!r1 = 1)
val () = assertloc (!r2 = 2)
val () = !r1 :=: !r2
val () = assertloc (!r1 = 2)
val () = assertloc (!r2 = 1)
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T2 = @(int, double)
//
val r = ref<T2> @(1, 1.0)
val () = !r.0 := !r.0 + 1
val () = assertloc (!r.0 = 2)
val () = !r.1 := !r.1 + 1.0
val () = assertloc (!r.1 = 2.0)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val r = ref<int> (1)
val () = assert (ref_get_elt (r) = 1)
val () = ref_set_elt (r, 2)
val () = assert (ref_get_elt (r) = 2)
var x: int = 3
val () = ref_exch_elt (r, x)
val () = assert (x = 2)
val () = assert (ref_get_elt (r) = 3)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val r = ref<int> (1)
val () = ref_app_fun (r, lam x => x := 2 * x)
val () = assertloc (!r = 2)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_reference.dats] *)
