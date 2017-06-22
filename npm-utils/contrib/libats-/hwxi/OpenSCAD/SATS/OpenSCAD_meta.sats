(* ****** ****** *)
(*
** For implementing a DSL
** that supports ATS and OpenSCAD co-programming
*)
(* ****** ****** *)

#staload "./OpenSCAD.sats"

(* ****** ****** *)
//
fun
scadexp_v2d_int2
  (x: int, y: int): scadexp
fun
scadexp_v2d_float2
  (x: double, y: double): scadexp
//
fun
scadexp_v3d_int3
  (x: int, y: int, z: int): scadexp
fun
scadexp_v3d_float3
  (x: double, y: double, z: double): scadexp
//
symintr scadexp_v2d
symintr scadexp_v3d
overload scadexp_v2d with scadexp_v2d_int2
overload scadexp_v2d with scadexp_v2d_float2
overload scadexp_v3d with scadexp_v3d_int3
overload scadexp_v3d with scadexp_v3d_float3
//
(* ****** ****** *)
//
fun
scadobj_cube_int1
  (x: int): scadobj
fun
scadobj_cube_int1_bool
  (x: int, ct: bool): scadobj
//
fun
scadobj_cube_float1
  (x: double): scadobj
fun
scadobj_cube_float1_bool
  (x: double, ct: bool): scadobj
//
(* ****** ****** *)
//
fun
scadobj_cube_int3
  (x: int, y: int, z: int): scadobj
fun
scadobj_cube_int3_bool
  (x: int, y: int, z: int, ct: bool): scadobj
//
fun
scadobj_cube_float3
  (x: double, y: double, z: double): scadobj
fun
scadobj_cube_float3_bool
  (x: double, y: double, z: double, ct: bool): scadobj
//
(* ****** ****** *)
//
symintr
scadobj_cube
//
overload
scadobj_cube with scadobj_cube_int1
overload
scadobj_cube with scadobj_cube_int1_bool
//
overload
scadobj_cube with scadobj_cube_float1
overload
scadobj_cube with scadobj_cube_float1_bool
//
overload
scadobj_cube with scadobj_cube_int3
overload
scadobj_cube with scadobj_cube_int3_bool
//
overload
scadobj_cube with scadobj_cube_float3
overload
scadobj_cube with scadobj_cube_float3_bool
//
(* ****** ****** *)
//
fun
scadobj_square_int1
  (x: int): scadobj
fun
scadobj_square_int1_bool
  (x: int, ct: bool): scadobj
//
fun
scadobj_square_float1
  (x: double): scadobj
fun
scadobj_square_float1_bool
  (x: double, ct: bool): scadobj
//
(* ****** ****** *)
//
fun
scadobj_square_int2
  (x: int, y: int): scadobj
fun
scadobj_square_int2_bool
  (x: int, y: int, ct: bool): scadobj
//
fun
scadobj_square_float2
  (x: double, y: double): scadobj
fun
scadobj_square_float2_bool
  (x: double, y: double, ct: bool): scadobj
//
(* ****** ****** *)
//
symintr
scadobj_square
//
overload
scadobj_square with scadobj_square_int1
overload
scadobj_square with scadobj_square_int1_bool
overload
scadobj_square with scadobj_square_float1
overload
scadobj_square with scadobj_square_float1_bool
//
overload
scadobj_square with scadobj_square_int2
overload
scadobj_square with scadobj_square_int2_bool
overload
scadobj_square with scadobj_square_float2
overload
scadobj_square with scadobj_square_float2_bool
//
(* ****** ****** *)
//
fun
scadobj_circle_int1(rad: int): scadobj
fun
scadobj_circle_float1(rad: double): scadobj
//
symintr
scadobj_circle
overload
scadobj_circle with scadobj_circle_int1
overload
scadobj_circle with scadobj_circle_float1
//
(* ****** ****** *)
//
fun
scadobj_sphere_int1(rad: int): scadobj
fun
scadobj_sphere_float1(rad: double): scadobj
//
symintr
scadobj_sphere
overload
scadobj_sphere with scadobj_sphere_int1
overload
scadobj_sphere with scadobj_sphere_float1
//
(* ****** ****** *)
//
fun
scadobj_sphere_at
  (center: point3, radius: double): scadobj
//
(* ****** ****** *)
//
fun
scadobj_cylinder1_int2
  (h: int, r: int): scadobj
fun
scadobj_cylinder1_int2_bool
  (h: int, r: int, ct: bool): scadobj
//
fun
scadobj_cylinder1_float2
  (h: double, r: double): scadobj
fun
scadobj_cylinder1_float2_bool
  (h: double, r: double, ct: bool): scadobj
//
(* ****** ****** *)
//
symintr
scadobj_cylinder1
//
overload
scadobj_cylinder1 with scadobj_cylinder1_int2
overload
scadobj_cylinder1 with scadobj_cylinder1_int2_bool
//
overload
scadobj_cylinder1 with scadobj_cylinder1_float2
overload
scadobj_cylinder1 with scadobj_cylinder1_float2_bool
//
(* ****** ****** *)
//
fun
scadobj_union2
  (obj1: scadobj, obj1: scadobj): scadobj
//
fun
scadobj_inter2
  (obj1: scadobj, obj1: scadobj): scadobj
//
fun
scadobj_differ
  (obj1: scadobj, obj1: scadobj): scadobj
//
(* ****** ****** *)
//
symintr cap cup diff
//
overload cap with scadobj_inter2
overload cup with scadobj_union2
overload diff with scadobj_differ
//
(* ****** ****** *)
//
fun
scadtfm_scale_int3
  (x: int, y: int, z: int): scadtfm
fun
scadtfm_scale_float3
  (x: double, y: double, z: double): scadtfm
//
symintr
scadtfm_scale
overload
scadtfm_scale with scadtfm_scale_int3
overload
scadtfm_scale with scadtfm_scale_float3
//
(* ****** ****** *)
//
fun
scadtfm_rotate_int3
  (x: int, y: int, z: int): scadtfm
fun
scadtfm_rotate_float3
  (x: double, y: double, z: double): scadtfm
//
symintr
scadtfm_rotate
overload
scadtfm_rotate with scadtfm_rotate_int3
overload
scadtfm_rotate with scadtfm_rotate_float3
//
(* ****** ****** *)
//
fun
scadtfm_translate_int3
  (x: int, y: int, z: int): scadtfm
fun
scadtfm_translate_float3
  (x: double, y: double, z: double): scadtfm
//
symintr
scadtfm_translate
overload
scadtfm_translate with scadtfm_translate_int3
overload
scadtfm_translate with scadtfm_translate_float3
//
(* ****** ****** *)
//
fun
scadtfm_color_name
  (name: string): scadtfm
fun
scadtfm_color_rgba
(
  r: double, g: double, b: double, a: double
): scadtfm // end-of-function
//
(* ****** ****** *)
//
fun
scadtfm_compose(scadtfm, scadtfm): scadtfm
//
(* ****** ****** *)
//
fun
scadobj_tfmapp_one
  (tfm: scadtfm, x0: scadobj): scadobj
fun
scadobj_tfmapp_list
  (tfm: scadtfm, xs: scadobjlst): scadobj
//
(* ****** ****** *)
//
symintr scadobj_tfmapp
//
overload scadobj_tfmapp with scadobj_tfmapp_one
overload scadobj_tfmapp with scadobj_tfmapp_list
//
(* ****** ****** *)
//
fun
scadobj_scale_int3
  (x: int, y: int, z: int, obj: scadobj): scadobj
fun
scadobj_scale_float3
  (x: double, y: double, z: double, obj: scadobj): scadobj
//
(* ****** ****** *)
//
symintr
scadobj_scale
overload
scadobj_scale with scadobj_scale_int3
overload
scadobj_scale with scadobj_scale_float3
//
(* ****** ****** *)
//
fun
scadobj_rotate_int3
  (x: int, y: int, z: int, obj: scadobj): scadobj
fun
scadobj_rotate_float3
  (x: double, y: double, z: double, obj: scadobj): scadobj
//
(* ****** ****** *)
//
symintr
scadobj_rotate
overload
scadobj_rotate with scadobj_rotate_int3
overload
scadobj_rotate with scadobj_rotate_float3
//
(* ****** ****** *)
//
fun
scadobj_translate_int3
  (x: int, y: int, z: int, obj: scadobj): scadobj
fun
scadobj_translate_float3
  (x: double, y: double, z: double, obj: scadobj): scadobj
//
(* ****** ****** *)
//
symintr
scadobj_translate
overload
scadobj_translate with scadobj_translate_int3
overload
scadobj_translate with scadobj_translate_float3
//
(* ****** ****** *)

fun
scadobj_polyhedron
  {n:int | n >= 4}
(
  pts: list(point3, n)
, faces: List0(listGte(natLt(n), 3))
, convexity: intGte(0)
) : scadobj // end-of-function

(* ****** ****** *)

fun
scadobj_tetrahedron
(
p0: point3, p1: point3, p2: point3, p3: point3
) : scadobj // end-of-function

(* ****** ****** *)

fun
scadobj_square_pyramid
(
p0: point3, p1: point3, p2: point3, p3: point3, p4: point3
) : scadobj // end-of-function

(* ****** ****** *)

(* end of [OpenSCAD_meta.sats] *)
