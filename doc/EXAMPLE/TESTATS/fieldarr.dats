//
// A simple example of
// array-as-a-field-in-a-struct
//
// Author: Hongwei Xi (Nov, 2013)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
typedef point = @{ xyz= @[double][3] }
*)

(* ****** ****** *)
//
%{^
typedef
struct { double xyz[3] ; } point_t ;
%} // end of [%{^]
//
typedef point =
$extype_struct "point_t" of { xyz= @[double][3] }
//
(* ****** ****** *)
//
%{^
ATSinline()
point_t
point_make
(
  double x
, double y
, double z
) {
  point_t pt ;
  pt.xyz[0] = x ; pt.xyz[1] = y ; pt.xyz[2] = z ;
  return pt ;
} // end of [point_make]
%} // end of [%{^]
//
extern
fun
point_make
  (double, double, double): point = "mac#"
//
(* ****** ****** *)
//
fun point_get_x (pt: &point): double = pt.xyz.[0]
fun point_get_y (pt: &point): double = pt.xyz.[1]
fun point_get_z (pt: &point): double = pt.xyz.[2]
//
(* ****** ****** *)
//
fun
point_set_x
  (pt: &point, x0: double): void = pt.xyz.[0] := x0
//
fun
point_set_y
  (pt: &point, y0: double): void = pt.xyz.[1] := y0
//
fun
point_set_z
  (pt: &point, z0: double): void = pt.xyz.[2] := z0
//
(* ****** ****** *)
//
overload .x with point_get_x
overload .x with point_set_x
//
overload .y with point_get_y
overload .y with point_set_y
//
overload .z with point_get_z
overload .z with point_set_z
//
(* ****** ****** *)

implement
main0 () =
{
var pt = point_make (0., 1., 2.)
//
val () = println! ("pt.x = ", pt.x())
val () = assertloc (0. = pt.x()) 
val () = println! ("pt.y = ", pt.y())
val () = assertloc (1. = pt.y())
val () = println! ("pt.z = ", pt.z())
val () = assertloc (2. = pt.z())
//
val () = pt.x(2*pt.x())
val () = pt.y(2*pt.y())
val () = pt.z(2*pt.z())
//
val () = println! ("pt.x = ", pt.x())
val () = assertloc (0. = pt.x())
val () = println! ("pt.y = ", pt.y())
val () = assertloc (2. = pt.y())
val () = println! ("pt.z = ", pt.z())
val () = assertloc (4. = pt.z())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fieldarr.dats] *)
