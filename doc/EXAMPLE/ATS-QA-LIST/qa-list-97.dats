(* ****** ****** *)
//
// HX-2013-10
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
// HX: foo (n, str) = sprintf ("%i:%s", n, str)
//
(* ****** ****** *)

fun foo
(
  n: int, str: string
) : Strptr1 = res where
{
  val x0 = g0int2string (n)
  val x1 = ":"
  val x2 = str
  val xs = $list_vt{string}($UN.strptr2string(x0), x1, x2)
  val res = stringlst_concat($UN.list_vt2t(xs))
  val () = strptr_free (x0)
  val () = list_vt_free (xs)
} (* end of [foo] *)

(* ****** ****** *)

implement
main0 () =
{
val res = foo (1000, "thousand")
val () = println! ("sprintf(\"%i:%s\", 1000, \"thousand\") = ", res)
val ((*void*)) = strptr_free (res)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-97.dats] *)
