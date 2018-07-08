(* ****** ****** *)
(*
** For implementing a DSL
** that supports ATS and OpenSCAD co-programming
*)
(* ****** ****** *)

#staload "./OpenSCAD.sats"

(* ****** ****** *)
//
datatype
vector2 =
VECTOR2 of (double, double)
datatype
vector3 =
VECTOR3 of (double, double, double)
//
(* ****** ****** *)
//
typedef p2d = point2
typedef p3d = point3
//
typedef v2d = vector2
typedef v3d = vector3
//
(* ****** ****** *)
//
fun
point2vector_2d(point2): v2d
fun
vector2point_2d(vector2): p2d
//
fun
point2vector_3d(point3): v3d
fun
vector2point_3d(vector3): p3d
//
(* ****** ****** *)
//
overload
p2v2d with point2vector_2d
overload
v2p2d with vector2point_2d
//
overload
p2v3d with point2vector_3d
overload
v2p3d with vector2point_3d
//
(* ****** ****** *)
//
fun
length_v2d(vector2): double
fun
length_v3d(vector3): double
//
overload length with length_v2d
overload length with length_v3d
//
(* ****** ****** *)
//
fun
distance_p2d_p2d
  (point2, point2): double
fun
distance_p3d_p3d
  (point3, point3): double
//
overload
distance with distance_p2d_p2d
overload
distance with distance_p3d_p3d
//
(* ****** ****** *)
//
fun
add_p3d_v3d
  : (p3d, v3d) -> p3d
fun
sub_p3d_v3d
  : (p3d, v3d) -> p3d
fun
sub_p3d_p3d
  : (p3d, p3d) -> v3d
//
overload + with add_p3d_v3d
overload - with sub_p3d_v3d
overload - with sub_p3d_p3d
//
(* ****** ****** *)
//
fun
add_v3d_v3d
  : (v3d, v3d) -> v3d
fun
sub_v3d_v3d
  : (v3d, v3d) -> v3d
//
overload + with add_v3d_v3d
overload - with sub_v3d_v3d
//
(* ****** ****** *)
fun
mul_int_v3d : (int, v3d) -> v3d
fun
div_v3d_int : (v3d, int) -> v3d
fun
mul_float_v3d : (double, v3d) -> v3d
fun
div_v3d_float : (v3d, double) -> v3d
//
overload * with mul_int_v3d
overload * with mul_float_v3d
overload / with div_v3d_int
overload / with div_v3d_float
//
(* ****** ****** *)

(* end of [OpenSCAD_util.sats] *)
