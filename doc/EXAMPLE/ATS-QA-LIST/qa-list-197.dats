(* ****** ****** *)
//
// HX-2014-02-16
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

fun
list_double
  {n:int}
(
  xs: list (int, n)
) : list (int, n) = let
//
var count: int = 0
//
implement
list_map$fopr<int><int> (x) = 2 * x
//
in
  list_vt2t(list_map<int><int> (xs))
end // end of [list_double]

(* ****** ****** *)

fun
list_double2
  {n:int}
(
  xs: list (int, n)
) : list (int, n) = let
//
var count: int = 0
//
implement
list_map$fopr<int><int>
  (x) = let
  val n = $UN.ptr0_get<int>(addr@count)
  val () = $UN.ptr0_set<int>(addr@count, n+1)
  val () = println! ("list_double2: n = ", n)
in
  2 * x
end // end of [list_map]
//
in
  list_vt2t(list_map<int><int> (xs))
end // end of [list_double2]

(* ****** ****** *)

implement
main0 () =
{
//
val xs =
  list_make_intrange(0, 10)
val xs = list_vt2t{int} (xs)
//
val ys1 = list_double (xs)
val ys2 = list_double2 (xs)
//
val () = println! ("xs = ", xs)
val () = println! ("ys1 = ", ys1)
val () = println! ("ys2 = ", ys2)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-197.dats] *)
