(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload
MATH =
"libats/libc/SATS/math.sats"
//
staload _ =
"libats/libc/DATS/math.dats"
//
(* ****** ****** *)

#staload "./../SATS/andes_comp.sats"

(* ****** ****** *)

val xs =
$list{double}(1.0, 2.0, 3.0, 4.0, 5.0)

(* ****** ****** *)

implement
main0() = () where
{
//
val () = println! ("xs = ", xs)
//
val ys = list_smooth_bef(xs, 3)
val () = println! ("ys = ", list_vt2t(stream2list_vt(ys)))
//
val zs = list_smooth_aft(xs, 3)
val () = println! ("zs = ", list_vt2t(stream2list_vt(zs)))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test00.dats] *)
