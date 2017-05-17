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

(* end of [OpenSCAD_util.dats] *)
