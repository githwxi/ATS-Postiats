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
// HX-2017-06-21:
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

(*
//
// HX: it is in OpenSCAD_meta
//
fun
scadobj_sphere_at
(
  p: point3, r: double
) : scadobj = let
  val+POINT3(x, y, z) = p
in
  scadobj_tfmapp(scadtfm_translate(x, y, z), scadobj_sphere(r))
end // end of [scadobj_sphere_at]
*)

(* ****** ****** *)

fun
seripinski_pyramid
(
  n0: intGte(0)
, p0: p3d, p1: p3d, p2: p3d, p3: p3d, p4: p3d
) : scadobj =
(
if
(n0 > 0)
then let
  val p01 = mid(p0, p1)
  val p02 = mid(p0, p2)
  val p03 = mid(p0, p3)
  val p04 = mid(p0, p4)
  val p12 = mid(p1, p2)
  val p23 = mid(p2, p3)
  val p34 = mid(p3, p4)
  val p41 = mid(p4, p1)
  val pct = p12 + (p4-p1) / 2
  val obj0 = seripinski_pyramid(n0-1, p0, p01, p02, p03, p04)
  val obj1 = seripinski_pyramid(n0-1, p01, p1, p12, pct, p41)
  val obj2 = seripinski_pyramid(n0-1, p02, p12, p2, p23, pct)
  val obj3 = seripinski_pyramid(n0-1, p03, pct, p23, p3, p34)
  val obj4 = seripinski_pyramid(n0-1, p04, p41, pct, p34, p4)
  val POINT3(x, y, z) = p3
  val tfm = scadtfm_translate(x, y, z)
  val base = scadobj_tfmapp(tfm, scadobj_cube(distance(p3, p2), distance(p3, p4), 0.1))
in
  (obj0 \cup (obj1 \cup (obj2 \cup (obj3 \cup obj4)))) \cup base
end // end of [then]
else let
//
  val b1 =
  scadobj_sphere_at(p1, 1.0)
  val b2 =
  scadobj_sphere_at(p2, 1.0)
  val b3 =
  scadobj_sphere_at(p3, 1.0)
  val b4 =
  scadobj_sphere_at(p4, 1.0)
//
in
  scadobj_square_pyramid(p0, p1, p2, p3, p4) \cup (b1 \cup (b2 \cup (b3 \cup b4)))
end // end of [else]
)

(* ****** ****** *)

implement
main0() = () where
{
//
val a = 40.0
val p0 = point3(0.0, 0.0, a*sqrt(2.0))
val p1 = point3( a,  a, 0.0)
val p2 = point3(~a,  a, 0.0)
val p3 = point3(~a, ~a, 0.0)
val p4 = point3( a, ~a, 0.0)
//
val out = stdout_ref
//
val obj =
seripinski_pyramid(3, p0, p1, p2, p3, p4)
//
val () =
fprint!
( out, "\
/*
The code is automatically
generated from [test05.dats]
*/\n\n\
")
val () =
fprint!
(out, "$fa=2.0; $fs=2.0;\n\n")
//
val () =
scadobj_femit(out, 0(*nsp*), obj)
//
val () =
fprint!
(out, "\n/* end of [test05_dats.scad] */\n")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test05.dats] *)
