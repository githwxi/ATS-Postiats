//
// Some code involving refas-patterns
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: June, 2013
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun ftest1
  (xs: List (int)): int = let
  val-cons
  (
    y1, ys2 as cons (y2, _)
  ) = xs
in
  y1 + y2
end // end of [ftest1]

val () =
{
val xs = cons{int}(1, cons{int}(2, nil))
val () = assertloc (ftest1 (xs) = 1 + 2)
} (* end of [val] *)

(* ****** ****** *)

fun ftest2
  (xs: !List_vt (int)): int = let
  val-@cons_vt (x1, xs2 as cons_vt (x2, _)) = xs
  val x1_old = x1
  val () = x1 := x1_old
  prval () = fold@(xs)
in
  x1_old + x2
end // end of [ftest2]

val () =
{
val xs =
cons_vt{int}(1, cons_vt{int}(2, nil_vt))
val () = assertloc (ftest2 (xs) = 1 + 2)
prval () = $UN.cast2void (xs) // HX: leak!
} (* end of [val] *)

(* ****** ****** *)

fun ftest3
  (xs: !List_vt (int)): int = let
  val-@cons_vt
  (
    y1 as y1_old, ys2 as cons_vt (y2, _)
  ) = xs
  val () = y1 := y1_old
  prval () = fold@(xs)
in
  y1_old + y2
end // end of [ftest3]

val () =
{
val xs =
cons_vt{int}(1, cons_vt{int}(2, nil_vt))
val () = assertloc (ftest3 (xs) = 1 + 2)
prval () = $UN.cast2void (xs) // HX: leak!
} (* end of [val] *)

(* ****** ****** *)
//
// HX-2013-06-20:
// pattern matching of case-expressions is handled
// quite differently from that of val-declarations
//
(* ****** ****** *)

fun ftest4
  (xs: !List_vt (int)): int = let
in
//
case- xs of
| @cons_vt (
    y1 as y1_old, ys2 as cons_vt (y2, _)
  ) => let
    val () = y1 := y1_old
    prval () = fold@( xs )
  in
    y1_old + y2
  end // end of [ftest4]
//
end // end of [ftest4]

val () =
{
val xs =
cons_vt{int}(1, cons_vt{int}(2, nil_vt))
val () = assertloc (ftest4 (xs) = 1 + 2)
prval () = $UN.cast2void (xs) // HX: leak!
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [patrefas.dats] *)
