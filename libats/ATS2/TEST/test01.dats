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
"libats/ATS2/SATS/fcntainer2.sats"
//
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer2.dats"
#staload _(*FC*) =
"libats/ATS2/DATS/fcntainer2_list0.dats"
//
(* ****** ****** *)
//
val xs =
list0_tuple<int>(0, 1, 2, 3, 4, 5)
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
$FC.foldleft_cloref<int><list0(int)><int>(xs, 0(*ini*), lam(res, x) => res + x)
val ((*void*)) =
println! ("foldleft(res) = ", res)
//
val res =
$FC.ifoldleft_cloref<int><list0(int)><int>(xs, 0(*ini*), lam(res, i, x) => res + i*x)
val ((*void*)) =
println! ("ifoldleft(res) = ", res)
//
(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [test01.dats] *)
