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
// HX-2017-05-17:
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
  (obj0 \cup (obj1 \cup (obj2 \cup obj3)))
end // end of [then]
else let
//
  val b1 =
  scadobj_sphere_at(p1, 2.0)
  val b2 =
  scadobj_sphere_at(p2, 2.0)
  val b3 =
  scadobj_sphere_at(p3, 2.0)
//
in
  scadobj_tetrahedron(p0, p1, p2, p3) \cup (b1 \cup (b2 \cup b3))
end // end of [else]
)

(* ****** ****** *)

implement
main0() = () where
{
//
val a = 60.0
val p0 = point3( 0.0,            0.0, a*sqrt(2.0))
val p1 = point3(   a,            0.0,         0.0)
val p2 = point3(~a/2, ~a*sqrt(3.0)/2,         0.0)
val p3 = point3(~a/2,  a*sqrt(3.0)/2,         0.0)
//
val out = stdout_ref
//
val obj =
seripinski_tetra(3, p0, p1, p2, p3)
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
(out, "$fa=0.5; $fs=0.5;\n\n")
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
