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
#staload $OpenSCAD_meta // opening it!
//
#include
"$PATSHOMELOCS\
/atscntrb-hx-openscad/mylibies_link.hats"
//
*)
(* ****** ****** *)
//
extern
fun
five_balls
  (rad: double): scadobj
//
(* ****** ****** *)

implement
five_balls
  (rad) = let
//
val
ball = scadobj_sphere(1.0)
//
val ball1 = scadobj_translate( 1.0,  1.0, 1.0, ball)
val ball2 = scadobj_translate(~1.0,  1.0, 1.0, ball)
val ball3 = scadobj_translate( 1.0, ~1.0, 1.0, ball)
val ball4 = scadobj_translate(~1.0, ~1.0, 1.0, ball)
val ball5 = scadobj_translate( 0.0,  0.0, 1+sqrt(2.0), ball)
//
in
  scadobj_scale(rad, rad, rad, ((ball1 \cup ball2) \cup (ball3 \cup ball4)) \cup ball5)
end // end of [five_balls]

(* ****** ****** *)

implement
main0() = () where
{
//
val out = stdout_ref
//
val obj = five_balls(5.0)
//
val () =
fprintln!
(out, "\
/*
The code is automatically
generated from [test02.dats]
*/\n\
")
val () =
fprintln!
(out, "$fa=0.1; $fs=0.1;\n")
//
val () =
scadobj_femit(out, 0(*nsp*), obj)
//
val () =
fprint! (out, "\n")
val () =
fprintln!
(out, "/* end of [test02_dats.scad] */")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
