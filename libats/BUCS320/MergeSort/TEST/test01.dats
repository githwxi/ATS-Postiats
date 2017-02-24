(* ****** ****** *)
(*
** DivideConquer:
** MergeSort_list
**
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

#staload TESTLIB = "./testlib.dats"

(* ****** ****** *)

implement
main0() =
{
//
val
xs0 =
g0ofg1
(
$list{int}
(
  8, 3, 2, 4, 6, 5, 1, 7, 0, 9
)
) (* end of [val] *)
//
//
val xs1 =
$TESTLIB.MergeSort_list_int(xs0)
//
val ((*void*)) = println! ("xs0 = ", xs0)
val ((*void*)) = println! ("xs1 = ", xs1)
//
val
xs0 =
g0ofg1
(
$list{double}
(
  8.8, 3.3, 2.2, 4.4, 6.6
, 5.5, 1.1, 7.7, 0.0, 9.9
)
) (* end of [val] *)
//
//
val xs1 =
$TESTLIB.MergeSort_list_double(xs0)
//
val ((*void*)) = println! ("xs0 = ", xs0)
val ((*void*)) = println! ("xs1 = ", xs1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
