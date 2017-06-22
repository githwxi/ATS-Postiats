(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: May, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
(*
** For implementing
** a DSL that supports
** ATS and OpenSCAD co-programming
*)
(* ****** ****** *)
//
#staload "./../SATS/OpenSCAD.sats"
#staload "./../SATS/OpenSCAD_meta.sats"
//
(* ****** ****** *)

implement
scadobj_cube_int1
  (x) = let
//
val x = SCADEXPint(x)
val x = SCADARGexp(x)
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("cube", env, list_sing(x))
end // end of [scadobj_cube_int1]

implement
scadobj_cube_int1_bool
  (x, ct) = let
//
val x = SCADEXPint(x)
val x = SCADARGexp(x)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
in
  SCADOBJfapp("cube", env, list_sing(x))
end // end of [scadobj_cube_int1]

(* ****** ****** *)

implement
scadobj_cube_float1
  (x) = let
//
val x =
  SCADEXPfloat(x)
//
val x = SCADARGexp(x)
//
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("cube", env, list_sing(x))
end // end of [scadobj_cube_float1]

implement
scadobj_cube_float1_bool
  (x, ct) = let
//
val x =
  SCADEXPfloat(x)
//
val x = SCADARGexp(x)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
in
  SCADOBJfapp("cube", env, list_sing(x))
end // end of [scadobj_cube_float1]

(* ****** ****** *)

implement
scadobj_cube_int3
  (x, y, z) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
and z = SCADEXPint(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADOBJfapp("cube", env, xyz)
end // end of [scadobj_cube_int3]

implement
scadobj_cube_int3_bool
  (x, y, z, ct) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
and z = SCADEXPint(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADOBJfapp("cube", env, xyz)
end // end of [scadobj_cube_int3_bool]

(* ****** ****** *)

implement
scadobj_cube_float3
  (x, y, z) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
and z = SCADEXPfloat(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADOBJfapp("cube", env, xyz)
end // end of [scadobj_cube_float3]

implement
scadobj_cube_float3_bool
  (x, y, z, ct) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
and z = SCADEXPfloat(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADOBJfapp("cube", env, xyz)
end // end of [scadobj_cube_float3_bool]

(* ****** ****** *)

implement
scadobj_square_int1
  (x) = let
//
val x = SCADEXPint(x)
val x = SCADARGexp(x)
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("square", env, list_sing(x))
end // end of [scadobj_square_int1]

implement
scadobj_square_int1_bool
  (x, ct) = let
//
val x = SCADEXPint(x)
val x = SCADARGexp(x)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
in
  SCADOBJfapp("square", env, list_sing(x))
end // end of [scadobj_square_int1]

(* ****** ****** *)

implement
scadobj_square_float1
  (x) = let
//
val x =
  SCADEXPfloat(x)
//
val x = SCADARGexp(x)
//
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("square", env, list_sing(x))
end // end of [scadobj_square_float1]

implement
scadobj_square_float1_bool
  (x, ct) = let
//
val x =
  SCADEXPfloat(x)
//
val x = SCADARGexp(x)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
in
  SCADOBJfapp("square", env, list_sing(x))
end // end of [scadobj_square_float1]

(* ****** ****** *)

implement
scadobj_square_int2
  (x, y) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
//
val xy =
  $list{scadexp}(x, y)
val xy = SCADEXPvec(xy)
//
val env = scadenv_nil((*void*))
//
val xy =
  $list{scadarg}(SCADARGexp(xy))
//
in
  SCADOBJfapp("square", env, xy)
end // end of [scadobj_square_int2]

implement
scadobj_square_int2_bool
  (x, y, ct) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
//
val xy =
  $list{scadexp}(x, y)
val xy = SCADEXPvec(xy)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
val xy =
  $list{scadarg}(SCADARGexp(xy))
//
in
  SCADOBJfapp("square", env, xy)
end // end of [scadobj_square_int2_bool]

(* ****** ****** *)

implement
scadobj_square_float2
  (x, y) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
//
val xy =
  $list{scadexp}(x, y)
val xy = SCADEXPvec(xy)
//
val env = scadenv_nil((*void*))
//
val xy =
  $list{scadarg}(SCADARGexp(xy))
//
in
  SCADOBJfapp("square", env, xy)
end // end of [scadobj_square_float2]

implement
scadobj_square_float2_bool
  (x, y, ct) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
//
val xy =
  $list{scadexp}(x, y)
val xy = SCADEXPvec(xy)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
//
val env = scadenv_sing(l0, ct)
//
val xy =
  $list{scadarg}(SCADARGexp(xy))
//
in
  SCADOBJfapp("square", env, xy)
end // end of [scadobj_square_float2_bool]

(* ****** ****** *)

implement
scadobj_circle_int1
  (rad) = let
//
val rad = SCADEXPint(rad)
val rad = SCADARGexp(rad)
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("circle", env, list_sing(rad))
end // end of [scadobj_circle_int1]

implement
scadobj_circle_float1
  (rad) = let
//
val rad =
  SCADEXPfloat(rad)
//
val rad = SCADARGexp(rad)
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("circle", env, list_sing(rad))
end // end of [scadobj_circle_float1]

(* ****** ****** *)

implement
scadobj_sphere_int1
  (rad) = let
//
val rad = SCADEXPint(rad)
val rad = SCADARGexp(rad)
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("sphere", env, list_sing(rad))
end // end of [scadobj_sphere_int1]

implement
scadobj_sphere_float1
  (rad) = let
//
val rad =
  SCADEXPfloat(rad)
//
val rad = SCADARGexp(rad)
//
val env = scadenv_nil((*void*))
//
in
  SCADOBJfapp("sphere", env, list_sing(rad))
end // end of [scadobj_sphere_float1]

(* ****** ****** *)
//
implement
scadobj_sphere_at
(
  cntr, rad
) : scadobj = let
  val+POINT3(x, y, z) = cntr
in
  scadobj_tfmapp(scadtfm_translate(x, y, z), scadobj_sphere(rad))
end // end of [scadobj_sphere_at]
//      
(* ****** ****** *)

implement
scadobj_cylinder1_int2
  (h, r) = let
//
val h = SCADEXPint(h)
and r = SCADEXPint(r)
//
val h_l = label("h")
val r_l = label("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val env = scadenv_nil((*void*))
//
val hr_a = $list{scadarg}(h_a, r_a)
//
in
  SCADOBJfapp("cylinder", env, hr_a)
end // end of [scadobj_cylinder1_int2]

implement
scadobj_cylinder1_int2_bool
  (h, r, ct) = let
//
val h = SCADEXPint(h)
and r = SCADEXPint(r)
//
val h_l = label("h")
val r_l = label("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
val env = scadenv_sing(l0, ct)
//
val hr_a = $list{scadarg}(h_a, r_a)
//
in
  SCADOBJfapp("cylinder", env, hr_a)
end // end of [scadobj_cylinder1_int2_bool]

(* ****** ****** *)

implement
scadobj_cylinder1_float2
  (h, r) = let
//
val h =
  SCADEXPfloat(h)
and r =
  SCADEXPfloat(r)
//
val h_l = label("h")
val r_l = label("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val env = scadenv_nil((*void*))
//
val hr_a = $list{scadarg}(h_a, r_a)
//
in
  SCADOBJfapp("cylinder", env, hr_a)
end // end of [scadobj_cylinder1_float2]

implement
scadobj_cylinder1_float2_bool
  (h, r, ct) = let
//
val h =
  SCADEXPfloat(h)
and r =
  SCADEXPfloat(r)
//
val h_l = label("h")
val r_l = label("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val l0 = label("center")
val ct = SCADEXPbool(ct)
val env = scadenv_sing(l0, ct)
//
val hr_a = $list{scadarg}(h_a, r_a)
//
in
  SCADOBJfapp("cylinder", env, hr_a)
end // end of [scadobj_cylinder1_float2_bool]

(* ****** ****** *)

implement
scadobj_union2
  (obj1, obj2) = let
//
val objs =
  $list{scadobj}(obj1, obj2)
//
in
  SCADOBJmapp("union", objs)
end // end of [scadobj_union2]

(* ****** ****** *)

implement
scadobj_inter2
  (obj1, obj2) = let
//
val objs =
  $list{scadobj}(obj1, obj2)
//
in
  SCADOBJmapp("intersection", objs)
end // end of [scadobj_inter2]

(* ****** ****** *)

implement
scadobj_differ
  (obj1, obj2) = let
//
val objs =
  $list{scadobj}(obj1, obj2)
//
in
  SCADOBJmapp("difference", objs)
end // end of [scadobj_differ]

(* ****** ****** *)
//
implement
scadobj_tfmapp_one
  (tfm, obj) =
(
SCADOBJtfmapp(tfm, list_sing(obj))
)
implement
scadobj_tfmapp_list
  (tfm, objs) = SCADOBJtfmapp(tfm, objs)
//
(* ****** ****** *)

implement
scadtfm_scale_int3
  (x, y, z) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
and z = SCADEXPint(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADTFMextmcall("scale", env, xyz)
end // end of [scadtfm_scale_int3]

implement
scadtfm_scale_float3
  (x, y, z) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
and z = SCADEXPfloat(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADTFMextmcall("scale", env, xyz)
end // end of [scadtfm_scale_float3]

(* ****** ****** *)

implement
scadtfm_rotate_int3
  (x, y, z) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
and z = SCADEXPint(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADTFMextmcall("rotate", env, xyz)
end // end of [scadtfm_rotate_int3]

implement
scadtfm_rotate_float3
  (x, y, z) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
and z = SCADEXPfloat(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADTFMextmcall("rotate", env, xyz)
end // end of [scadtfm_rotate_float3]

(* ****** ****** *)

implement
scadtfm_translate_int3
  (x, y, z) = let
//
val x = SCADEXPint(x)
and y = SCADEXPint(y)
and z = SCADEXPint(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADTFMextmcall("translate", env, xyz)
end // end of [scadtfm_translate_int3]

implement
scadtfm_translate_float3
  (x, y, z) = let
//
val x = SCADEXPfloat(x)
and y = SCADEXPfloat(y)
and z = SCADEXPfloat(z)
//
val xyz =
  $list{scadexp}(x, y, z)
val xyz = SCADEXPvec(xyz)
//
val env = scadenv_nil((*void*))
//
val xyz =
  $list{scadarg}(SCADARGexp(xyz))
//
in
  SCADTFMextmcall("translate", env, xyz)
end // end of [scadtfm_translate_float3]

(* ****** ****** *)

implement
scadtfm_color_name(name) = let
//
val env = scadenv_nil((*void*))
//
val name = SCADEXPstring(name)
val name =
  $list{scadarg}(SCADARGexp(name))
//
in
  SCADTFMextmcall("color", env, name)
end // end of [scadtfm_color_name]

(* ****** ****** *)

implement
scadtfm_color_rgba
  (r, g, b, a) = let
//
val r = SCADEXPfloat(r)
val g = SCADEXPfloat(g)
val b = SCADEXPfloat(b)
val a = SCADEXPfloat(a)
//
val rgba =
  SCADEXPvec($list{scadexp}(r, g, b, a))
//
val env = scadenv_nil((*void*))
//
val rgba = SCADARGexp(rgba)
val rgba = $list{scadarg}(rgba)
//
in
  SCADTFMextmcall("color", env, rgba)
end // end of [scadtfm_color_rgba]

(* ****** ****** *)
//
implement
scadtfm_compose
  (tfm1, tfm2) = SCADTFMcompose(tfm1, tfm2)
//
(* ****** ****** *)

implement
scadobj_scale_int3
  (x, y, z, obj) =
(
scadobj_tfmapp(scadtfm_scale_int3(x, y, z), obj)
) (* scadobj_scale_int3 *)
implement
scadobj_scale_float3
  (x, y, z, obj) =
(
scadobj_tfmapp(scadtfm_scale_float3(x, y, z), obj)
) (* scadobj_scale_float3 *)

(* ****** ****** *)

implement
scadobj_rotate_int3
  (x, y, z, obj) =
(
scadobj_tfmapp(scadtfm_rotate_int3(x, y, z), obj)
) (* scadobj_rotate_int3 *)
implement
scadobj_rotate_float3
  (x, y, z, obj) =
(
scadobj_tfmapp(scadtfm_rotate_float3(x, y, z), obj)
) (* scadobj_rotate_float3 *)

(* ****** ****** *)

implement
scadobj_translate_int3
  (x, y, z, obj) =
(
scadobj_tfmapp(scadtfm_translate_int3(x, y, z), obj)
) (* scadobj_translate_int3 *)
implement
scadobj_translate_float3
  (x, y, z, obj) =
(
scadobj_tfmapp(scadtfm_translate_float3(x, y, z), obj)
) (* scadobj_translate_float3 *)

(* ****** ****** *)

implement
scadobj_polyhedron
  (pts, faces, N) = let
//
macdef
SEfloat(a) = SCADEXPfloat(,(a))
//
local
val
fpt =
lam
(
pt: point3
) : scadexp => let
//
val POINT3(x, y, z) = pt
//
in
//
SCADEXPvec
(
$list{scadexp}
(
  SEfloat(x), SEfloat(y), SEfloat(z)
)
) (* SCADEXPvec *)
//
end // end of [let]
in (*in-of-local*)
val
pts =
SCADEXPvec
(
list_vt2t
  (list_map_fun<point3><scadexp>(pts, fpt))
)
end // end of [local]
//
local
//
val
fface =
lam (
ns: List0(int)
) : scadexp =>
  SCADEXPvec
  (
    list_vt2t
    (
      list_map_fun<int><scadexp>
        (ns, lam(n) => SCADEXPint(n))
      // list_map_fun
    )
  ) (* SCADEXPvec *)
//
in (* in-of-local *)
val
faces =
SCADEXPvec
(
list_vt2t
(
list_map_fun<List0(int)><scadexp>(faces, fface)
)
// list_vt2t
) (* SCADEXPvec *)
end // end of [local]
//
val
pts =
SCADARGlabexp(label"points", pts)
//
val
faces =
SCADARGlabexp( label"faces", faces )
//
val N =
  SCADEXPint(N)
val N =
  SCADARGlabexp(label"convexity", N)
//
val
env = scadenv_nil((*void*))
val
arglst = $list{scadarg}(pts, faces, N)
//
in
  SCADOBJfapp("polyhedron", env, arglst)
end // end of [scadobj_polyhedron]

(* ****** ****** *)

implement
scadobj_tetrahedron
  (p0, p1, p2, p3) = let
//
val pts =
$list{point3}(p0, p1, p2, p3)
//
val f0 = $list(0, 1, 2)
val f1 = $list(0, 2, 3)
val f2 = $list(0, 3, 1)
val f3 = $list(1, 3, 2)
val faces = $list(f0, f1, f2, f3)
//
in
  scadobj_polyhedron(pts, faces, 2(*N*))
end // end of [scadobj_tetrahedron]

(* ****** ****** *)

implement
scadobj_square_pyramid
  (p0, p1, p2, p3, p4) = let
//
val pts =
$list{point3}(p0, p1, p2, p3, p4)
//
val f0 = $list(0, 1, 2)
val f1 = $list(0, 2, 3)
val f2 = $list(0, 3, 4)
val f3 = $list(0, 4, 1)
val f4 = $list(1, 4, 3, 2)
val faces = $list(f0, f1, f2, f3, f4)
//
in
  scadobj_polyhedron(pts, faces, 2(*N*))
end // end of [scadobj_square_pyramid]

(* ****** ****** *)

(* end of [OpenSCAD_meta.dats] *)
