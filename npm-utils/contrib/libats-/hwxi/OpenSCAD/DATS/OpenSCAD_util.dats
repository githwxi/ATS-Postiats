(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: May, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
(*
** For supporting in ATS a form
** of meta-programming for OpenSCAD 
*)
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
MATH =
"libats/libc/SATS/math.sats"
//
(* ****** ****** *)
//
#staload
"./../SATS/OpenSCAD.sats"
#staload
"./../SATS/OpenSCAD_util.sats"
//
(* ****** ****** *)
//
implement
point2_make_int2
  (x, y) =
(
POINT2
  (g0i2f(x), g0i2f(y))
)
//
implement
point2_make_float2
  (x, y) = POINT2(x, y)
//
(* ****** ****** *)
//
implement
point3_make_int3
  (x, y, z) =
(
POINT3
  (g0i2f(x), g0i2f(y), g0i2f(z))
)
//
implement
point3_make_float3
  (x, y, z) = POINT3(x, y, z)
//
(* ****** ****** *)
//
// HX:
// POINT2 and VECTOR2 must
// have the same representation!!!
//
implement
point2vector_2d(p2d) = $UN.cast(p2d)
implement
vector2point_2d(v2d) = $UN.cast(v2d)
//
(* ****** ****** *)
//
// HX:
// POINT3 and VECTOR3 must
// have the same representation!!!
//
implement
point2vector_3d(p3d) = $UN.cast(p3d)
implement
vector2point_3d(v3d) = $UN.cast(v3d)
//
(* ****** ****** *)

macdef sqrt = $MATH.sqrt_double

(* ****** ****** *)
//
implement
length_v2d(v2d) = let
  val+VECTOR2(x, y) = v2d in sqrt(x*x+y*y)
end // end of [length_v2d]
//
implement
length_v3d(v3d) = let
  val+VECTOR3(x, y, z) = v3d in sqrt(x*x+y*y+z*z)
end // end of [length_v3d]
//
(* ****** ****** *)

implement
distance_p2d_p2d
  (p1, p2) = let
//
val+POINT2(x1, y1) = p1
val+POINT2(x2, y2) = p2
//
val x12 = x2 - x1 and y12 = y2 - y1
//
in
  sqrt(x12*x12 + y12*y12)
end // end of [distance_p2d_p2d]

(* ****** ****** *)

implement
distance_p3d_p3d
  (p1, p2) = let
//
val+POINT3(x1, y1, z1) = p1
val+POINT3(x2, y2, z2) = p2
//
val x12 = x2 - x1
and y12 = y2 - y1
and z12 = z2 - z1
//
in
  sqrt(x12*x12 + y12*y12 + z12*z12)
end // end of [distance_p3d_p3d]

(* ****** ****** *)

implement
add_p3d_v3d
  (p3d, v3d) = let
//
val POINT3(x, y, z) = p3d
val VECTOR3(vx, vy, vz) = v3d
//
in
  POINT3(x+vx, y+vy, z+vz)
end // end of [add_p3d_v3d]

(* ****** ****** *)

implement
sub_p3d_v3d
  (p3d, v3d) = let
//
val POINT3(x, y, z) = p3d
val VECTOR3(vx, vy, vz) = v3d
//
in
  POINT3(x-vx, y-vy, z-vz)
end // end of [sub_p3d_v3d]

implement
sub_p3d_p3d
  (p3d1, p3d2) = let
//
val POINT3(x1, y1, z1) = p3d1
val POINT3(x2, y2, z2) = p3d2
//
in
  VECTOR3(x1-x2, y1-y2, z1-z2)
end // end of [sub_p3d_p3d]

(* ****** ****** *)
//
implement
mul_int_v3d
  (c, v3d) = let
//
val VECTOR3(vx, vy, vz) = v3d
//
in
  VECTOR3(c * vx, c * vy,  c * vz)
end // end of [mul_int_v3d]
//
implement
mul_float_v3d
  (c, v3d) = let
//
val VECTOR3(vx, vy, vz) = v3d
//
in
  VECTOR3(c * vx, c * vy,  c * vz)
end // end of [mul_float_v3d]
//
(* ****** ****** *)
//
implement
div_v3d_int
  (v3d, c) = let
//
val VECTOR3(vx, vy, vz) = v3d
//
in
  VECTOR3(vx / c, vy / c,  vz / c)
end // end of [div_v3d_int]
//
implement
div_v3d_float
  (v3d, c) = let
//
val VECTOR3(vx, vy, vz) = v3d
//
in
  VECTOR3(vx / c, vy / c,  vz / c)
end // end of [div_v3d_float]
//
(* ****** ****** *)

(* end of [OpenSCAD_util.dats] *)
