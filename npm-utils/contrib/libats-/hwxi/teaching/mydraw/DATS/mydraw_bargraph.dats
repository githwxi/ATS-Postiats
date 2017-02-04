(*
** Displaying bar graphs
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: February, 2014
//
(* ****** ****** *)
//
// HX-2014-03: see some Algorianim examples
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/mydraw.sats"

(* ****** ****** *)
//
// HX: p1, p2, p3 and p4 are positioned CCW
//
extern
fun{
} mydraw_bargraph
(
  n: intGte(1)
, p1: point, p2: point, p3: point, p4: point
) : void // end of [mydraw_bargraph]
//
extern
fun{}
mydraw_bargraph$color (i: intGte(0)): color
extern
fun{}
mydraw_bargraph$height (i: intGte(0)): double
//
(* ****** ****** *)

implement{
} mydraw_bargraph
  (n, p1, p2, p3, p4) = let
//
val a = 1.0 / n
val v12 = a * (p2 - p1)
val v43 = a * (p3 - p4)
prval [n:int] EQINT () = eqint_make_gint (n)
//
fun loop
  {i:nat | i < n}
(
  i: int (i), p1: point, p4: point
) : void = let
//
val p1_new = p1 + v12
val p4_new = p4 + v43
val ht = mydraw_bargraph$height (i)
val ht =
(
  if ht <= 0.0
    then 0.0 else (if ht >= 1.0 then 1.0 else ht)
  // end of [if]
) : double // end of [val]
val () =
if ht > 0.0 then
{
  val ((*void*)) =
  mydraw_quadrilateral
    (p1, p1_new, p1_new+ht*(p4_new-p1_new), p1+ht*(p4-p1))
  val clr = mydraw_bargraph$color (i)
  val ((*void*)) = mydraw_fill_set_rgb (clr.r(), clr.g(), clr.b())
  val ((*void*)) = mydraw_fill ((*void*))
} (* end of [if] *)
//
val i1 = i + 1
//
in
  if i1 < n then loop (i1, p1_new, p4_new) else ()
end // end of [loop]
//
in
  loop (0, p1, p4)
end // end of [mydraw_bargraph]

(* ****** ****** *)

(* end of [mydraw_bargraph.dats] *)
