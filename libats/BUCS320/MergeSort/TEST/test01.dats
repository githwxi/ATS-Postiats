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
//
local
//
#include
"./../mydepies.hats"
#staload
"./../DATS/MergeSort_list.dats"
//
assume elt_t0ype = double
//
in
//
implement
gcompare_val_val<elt>
  (x, y) = compare(x, y)
//
fun
MyMergeSort_list
(
xs: list0(double)
) : list0(double) = MergeSort_list<>(xs)
//
end // end of [local]

(* ****** ****** *)

implement
main0() =
{
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
val xs1 = MyMergeSort_list(xs0)
//
val ((*void*)) = println! ("xs0 = ", xs0)
val ((*void*)) = println! ("xs1 = ", xs1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
