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
intrange = $FC.intrange

(* ****** ****** *)
//
val xs =
$FC.INTRANGE(0, 6)
//
val () =
$FC.foreach_cloref<intrange><int>(xs, lam(x) =<1> println!(x))
val () =
$FC.rforeach_cloref<intrange><int>(xs, lam(x) =<1> println!(x))
//
val () =
$FC.iforeach_cloref<intrange><int>(xs, lam(i, x) =<1> println!(i, "->", x))
//
val res =
$FC.foldleft_cloref<int><intrange><int>(xs, 0(*ini*), lam(res, x) => res + x)
val ((*void*)) =
println! ("foldleft(res) = ", res)
//
val res =
$FC.ifoldleft_cloref<int><intrange><int>(xs, 0(*ini*), lam(res, i, x) => res + i*x)
val ((*void*)) =
println! ("ifoldleft(res) = ", res)
//
(* ****** ****** *)

val res = $FC.listize<intrange><int>(xs)
val ((*void*)) = println! ("listize(xs) = ", res)
val res = $FC.rlistize<intrange><int>(xs)
val ((*void*)) = println! ("rlistize(xs) = ", res)

(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [test03.dats] *)
