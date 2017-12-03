(* ****** ****** *)
(*
** William Blair's
** camera mount for quadcopter
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

#define :: list_cons

(* ****** ****** *)

overload
cube with scadobj_cube
overload
cylinder1 with scadobj_cylinder1

(* ****** ****** *)

overload
rotate with scadobj_rotate
overload
translate with scadobj_translate

(* ****** ****** *)

overload
union2 with scadobj_union2
overload
unionlst with scadobj_unionlst

overload
inter2 with scadobj_inter2
overload
interlst with scadobj_interlst

overload
differ with scadobj_differ
overload
differlst with scadobj_differlst

(* ****** ****** *)

fun
mount
(h: double): scadobj = let
//
val
cyl1 =
cylinder1
(h, 2.0(*r*), false(*center*))
val
cyl2 =
cylinder1
(3*h, 1.0(*r*), true(*center*))
//
in
  differ(cyl1, cyl2)
end // end of [mount]

(* ****** ****** *)

fun
sides
( h: double
, ofs: double): scadobj = let
  val cub1 =
  translate
  ( 0.0, 0.0, 2+ofs
  , cube(18, 18, 2, true))
  val cub2 =
  cube(14.0, 14.0, 10*h, true)
  val cyl3 = 
  translate
  (  8.0,  8.0, 0.0, cylinder1(10*h, 1.0, true))
  val cyl4 = 
  translate
  (  8.0, ~8.0, 0.0, cylinder1(10*h, 1.0, true))
  val cyl5 = 
  translate
  ( ~8.0,  8.0, 0.0, cylinder1(10*h, 1.0, true))
  val cyl6 = 
  translate
  ( ~8.0, ~8.0, 0.0, cylinder1(10*h, 1.0, true))
in
  differlst(cub1::cub2::cyl3::cyl4::cyl5::cyl6::nil())
end // end of [sides]

(* ****** ****** *)

fun
ziptie(): scadobj = let
//
val width=2.5 and depth=1.0
//
in

differ
(
cube(width+1, depth+1, 3.0, true)
,
cube(width+0, depth+0, 6.0, true)
) (* end of [differ] *)

end // end of [ziptie]

(* ****** ****** *)

fun
camsup(): scadobj =
differlst
(
translate
(~2.0, ~8.0, 3.25, cube(10.0, 10.0, 1.5, false))
::
rotate
( 0, 0, 45
, translate
  (~8.0, ~3.9, 0.0, cube(16.0, 16.0, 20.0, false)))
::
translate( 8.0, ~8.0, 0.0, cylinder1(10.0, 2.0, true))
::
list_nil((*void*))
) (* end of [camsup] *)

(* ****** ****** *)

fun
mount_base
((*void*)): scadobj = let
//
val h = 5.0
//
(*
(*
val sds = sides(2, 2)
*)
val env = scadenv_nil()
val arg1 = scadarg_int(2)
val arg2 = scadarg_int(2)
val args = arg1 :: arg2 :: nil()
val sds0 = scadobj_fapp("sides", env, args)
*)
//
val sds0 = sides(2.0, 2.0)
//
val mnt1 = translate( 8,  8, 0, mount(h))
val mnt2 = translate( 8, ~8, 0, mount(h))
val mnt3 = translate(~8,  8, 0, mount(h))
val mnt4 = translate(~8, ~8, 0, mount(h))
//
val zip5 = translate( 6.0,  6.0, 3.5, rotate(0.0, 0.0, ~45.0, ziptie()))
val zip6 = translate(~6.0, ~6.0, 3.5, rotate(0.0, 0.0, ~45.0, ziptie()))
//
val camsup = camsup()
//
in
  unionlst(sds0::mnt1::mnt2::mnt3::mnt4::camsup::zip5::zip6::nil())  
end // end of [mount_base]
                        
(* ****** ****** *)

implement
main0() = () where
{
//
val out = stdout_ref
//
val obj = mount_base()
//
val () =
fprintln!
(out, "\
/*
The code is automatically
generated from [pepperfish-camera.dats]
*/\n\
")
val () =
fprintln!
(out, "$fa=1.0; $fs=1.0;\n")
//
val () =
scadobj_femit(out, 0(*nsp*), obj)
//
val () =
fprint! (out, "\n")
val () =
fprintln!
(out, "/* end of [pepperfish-camera_dats.scad] */")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [pepperfish-camera.dats] *)
