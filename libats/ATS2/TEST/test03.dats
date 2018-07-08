(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload FC =
"libats/ATS2/SATS/fcntainer.sats"
//
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/main.dats"
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer/intrange.dats"
//
(* ****** ****** *)

typedef
intlr = $FC.intrange

(* ****** ****** *)
//
val xs =
$FC.intrange(0, 10)
//
val () =
$FC.foreach_cloref<intlr><int>(xs, lam(x) =<1> println!(x))
val () =
$FC.rforeach_cloref<intlr><int>(xs, lam(x) =<1> println!(x))
//
val () =
$FC.iforeach_cloref<intlr><int>(xs, lam(i, x) =<1> println!(i, "->", x))
//
val res =
$FC.foldleft_cloref<intlr><int><int>(xs, 0(*ini*), lam(res, x) => res + x)
val ((*void*)) =
println! ("foldleft(res) = ", res)
//
val res =
$FC.ifoldleft_cloref<intlr><int><int>(xs, 0(*ini*), lam(res, i, x) => res + i*x)
val ((*void*)) =
println! ("ifoldleft(res) = ", res)
//
(* ****** ****** *)

val res = $FC.listize<intlr><int>(xs)
val ((*void*)) = println! ("listize(xs) = ", res)
val res = $FC.rlistize<intlr><int>(xs)
val ((*void*)) = println! ("rlistize(xs) = ", res)

(* ****** ****** *)

val
zip_xs_xs =
$FC.listize<
$FC.zip(intlr,intlr)><(int,int)>($FC.ZIP(xs, xs))
val ((*void*)) = println! ("zip(xs, xs) = ", zip_xs_xs)

(* ****** ****** *)

val
cross_xs_xs =
$FC.listize<$FC.cross(intlr,intlr)><(int,int)>
  ($FC.CROSS(xs, xs))
val ((*void*)) = println! ("cross(xs, xs) = ", cross_xs_xs)

(* ****** ****** *)

val
cross_xs_zip_xs_xs =
$FC.listize<$FC.cross(intlr,$FC.zip(intlr,intlr))><(int,@(int,int))>
  ($FC.CROSS(xs, $FC.ZIP(xs, xs)))
val ((*void*)) = println! ("cross_xs_zip_xs_xs = ", cross_xs_zip_xs_xs)

(* ****** ****** *)

val
zip_xs_cross_xs_xs =
$FC.listize<$FC.zip(intlr,$FC.cross(intlr,intlr))><(int,@(int,int))>
  ($FC.ZIP(xs, $FC.CROSS(xs, xs)))
val ((*void*)) = println! ("zip_xs_cross_xs_xs = ", zip_xs_cross_xs_xs)

(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [test03.dats] *)
