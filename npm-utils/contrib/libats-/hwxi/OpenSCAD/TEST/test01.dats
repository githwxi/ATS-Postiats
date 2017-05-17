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
#staload $OpenSCAD_meta // opening it!
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)
//
extern
fun
muglike
(
x0: double, y0: double, z0: double
) : scadobj
//
(* ****** ****** *)

implement
muglike
  (x0, y0, z0) = let
//
val h = 1.0 and r = 0.5
//
val ball = 
  scadobj_sphere(sqrt(2.0)*r)
//
val cube = scadobj_cube(h, true)
//
(*
//
val red =
  scadxyz_color_name("red", 1.0)
val blue =
  scadxyz_color_name("blue", 1.0)
//
val ball = SCADOBJxyzobj(red, ball)
val cube = SCADOBJxyzobj(blue, cube)
//
*)
val
cylinder =
scadobj_cylinder1(h, 0.9*r, true)
val
tfm_trans =
scadtfm_translate(0.0, 0.0, 0.1)
val
cylinder =
SCADOBJtfmapp(tfm_trans, list_sing(cylinder))
//
val
mug = (ball \cap cube) \diff cylinder
val
tfm_trans =
scadtfm_translate(0.0, 0.0, 0.5)
//
val
mug = 
SCADOBJtfmapp(tfm_trans, list_sing(mug))
//
val
tfm_scale = scadtfm_scale(x0, y0, z0)
//
val
mug =
SCADOBJtfmapp(tfm_scale, list_sing(mug))
//
in
//
  mug
//
end // end of [muglike]

(* ****** ****** *)

implement
main0() = () where
{
//
val out = stdout_ref
//
val obj =
muglike(10.0, 10.0, 17.5)
//
val () =
fprintln!
(out, "\
/*
The code is automatically
generated from [test01.dats]
*/\n\
")
val () =
fprintln!
(out, "$fa=0.1; $fs=0.1;")
//
val () =
scadobj_femit(out, 0(*nsp*), obj)
//
val () =
fprint! (out, "\n")
val () =
fprintln!
(out, "/* end of [test01_dats.scad] */")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
