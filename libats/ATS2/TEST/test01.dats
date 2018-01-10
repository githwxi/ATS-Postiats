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
"libats/ATS2/DATS/fcntainer/list0.dats"
//
(* ****** ****** *)
//
val xs =
list0_tuple<int>(0, 1, 2, 3, 4)
//
val () =
$FC.foreach_cloref<list0(int)><int>(xs, lam(x) =<1> println!(x))
val () =
$FC.rforeach_cloref<list0(int)><int>(xs, lam(x) =<1> println!(x))
//
val () =
$FC.iforeach_cloref<list0(int)><int>(xs, lam(i, x) =<1> println!(i, "->", x))
//
val res =
$FC.foldleft_cloref<list0(int)><int><int>(xs, 0(*ini*), lam(res, x) => res + x)
val ((*void*)) =
println! ("foldleft(res) = ", res)
//
val res =
$FC.ifoldleft_cloref<list0(int)><int><int>(xs, 0(*ini*), lam(res, i, x) => res + i*x)
val ((*void*)) =
println! ("ifoldleft(res) = ", res)
//
(* ****** ****** *)

val res = $FC.listize<list0(int)><int>(xs)
val ((*void*)) = println! ("listize(xs) = ", res)
val res = $FC.rlistize<list0(int)><int>(xs)
val ((*void*)) = println! ("rlistize(xs) = ", res)

(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [test01.dats] *)
