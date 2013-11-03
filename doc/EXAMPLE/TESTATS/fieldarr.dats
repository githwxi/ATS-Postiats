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

%{^
typedef
struct { double xyz[3] ; } point_t ;
%} // end of [%{^]
typedef point =
$extype_struct "point_t" of { xyz= @[double][3] }

(* ****** ****** *)

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
extern
fun point_make (double, double, double): point = "mac#"

(* ****** ****** *)

fun point_get_x (pt: &point): double = pt.xyz.[0]
fun point_get_y (pt: &point): double = pt.xyz.[1]
fun point_get_z (pt: &point): double = pt.xyz.[2]

(* ****** ****** *)

implement
main0 () =
{
var pt = point_make (0., 1., 2.)
//
val () = println! ("pt_x = ", point_get_x (pt))
val () = println! ("pt_y = ", point_get_y (pt))
val () = println! ("pt_z = ", point_get_z (pt))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fieldarr.dats] *)
