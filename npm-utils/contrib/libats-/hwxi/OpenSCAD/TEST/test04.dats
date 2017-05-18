(* ****** ****** *)
(*
** An example of
** ATS and OpenSCAD co-programming
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload
"libats/libc/SATS/math.sats"
#staload _ =
"libats/libc/DATS/math.dats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $OpenSCAD // opening it!
#staload $OpenSCAD_util // opening it!
#staload $OpenSCAD_meta // opening it!
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)
(*
//
// HX-2047-05-17:
// For testing externally
//
#include
"$PATSHOMELOCS\
/atscntrb-hx-openscad/mylibies.hats"
//
#staload $OpenSCAD // opening it!
#staload $OpenSCAD_util // opening it!
#staload $OpenSCAD_meta // opening it!
//
#include
"$PATSHOMELOCS\
/atscntrb-hx-openscad/mylibies_link.hats"
//
*)
(* ****** ****** *)
//
(*
fun
mid
(
 p: p3d, q: p3d
) : p3d = let
  val POINT3(x0, x1, x2) = p
  val POINT3(y0, y1, y2) = q
in
  POINT3((x0+y0)/2, (x1+y1)/2, (x2+y2)/2)
end // end of [mid]
*)
//
fun
mid
(
 p: p3d, q: p3d
) : p3d = p + (q - p) / 2
//
(* ****** ****** *)

fun
seripinski_tetra
(
  n0: intGte(0)
, p0: p3d, p1: p3d, p2: p3d, p3: p3d
) : scadobj =
(
if
(n0 > 0)
then let
  val p01 = mid(p0, p1)
  val p02 = mid(p0, p2)
  val p03 = mid(p0, p3)
  val p12 = mid(p1, p2)
  val p23 = mid(p2, p3)
  val p31 = mid(p3, p1)
  val obj0 = seripinski_tetra(n0-1, p0, p01, p02, p03)
  val obj1 = seripinski_tetra(n0-1, p01, p1, p12, p31)
  val obj2 = seripinski_tetra(n0-1, p02, p2, p23, p12)
  val obj3 = seripinski_tetra(n0-1, p03, p31, p23, p3)
in
  obj0 \cup (obj1 \cup (obj2 \cup obj3))
end // end of [then]
else scadobj_tetrahedron(p0, p1, p2, p3) // end of [else]
)

(* ****** ****** *)

implement
main0() = () where
{
//
val p0 = point3(1.0, 0.0, 0.0)
val p1 = point3(~1.0/2, ~sqrt(3.0)/2, 0.0)
val p2 = point3(~1.0/2,  sqrt(3.0)/2, 0.0)
val p3 = point3(0.0, 0.0, sqrt(2.0))
//
val out = stdout_ref
//
val obj =
seripinski_tetra(3, p0, p1, p2, p3)
val obj = scadobj_scale(20, 20, 20, obj)
//
val () =
fprint!
( out, "\
/*
The code is automatically
generated from [test04.dats]
*/\n\n\
")
val () =
fprint!
(out, "$fa=0.1; $fs=0.1;\n\n")
//
val () =
scadobj_femit(out, 0(*nsp*), obj)
//
val () =
fprint!
(out, "\n/* end of [test04_dats.scad] */\n")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04.dats] *)
