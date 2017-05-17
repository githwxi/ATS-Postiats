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
val l0 =
  label_make("center")
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
val l0 =
  label_make("center")
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
val l0 =
  label_make("center")
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
val l0 =
  label_make("center")
//
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

implement
scadobj_cylinder1_int2
  (h, r) = let
//
val h = SCADEXPint(h)
and r = SCADEXPint(r)
//
val h_l = label_make("h")
val r_l = label_make("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val env = scadenv_nil((*void*))
//
val hr_a = $list{scadarg}(h_a, r_a)
//
in
  SCADOBJfapp("cube", env, hr_a)
end // end of [scadobj_cylinder1_int2]

implement
scadobj_cylinder1_int2_bool
  (h, r, ct) = let
//
val h = SCADEXPint(h)
and r = SCADEXPint(r)
//
val h_l = label_make("h")
val r_l = label_make("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val l0 =
  label_make("center")
val ct = SCADEXPbool(ct)
val env = scadenv_sing(l0, ct)
//
val hr_a = $list{scadarg}(h_a, r_a)
//
in
  SCADOBJfapp("cube", env, hr_a)
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
val h_l = label_make("h")
val r_l = label_make("r")
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
val h_l = label_make("h")
val r_l = label_make("r")
val h_a = SCADARGlabexp(h_l, h)
and r_a = SCADARGlabexp(r_l, r)
//
val l0 =
  label_make("center")
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

(* end of [OpenSCAD_meta.dats] *)
