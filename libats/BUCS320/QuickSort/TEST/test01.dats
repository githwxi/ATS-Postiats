(* ****** ****** *)
(*
** DivideConquer:
** QuickSort_array
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
//
#define QUICKSORT_ARRAY
//
#include "./../mydepies.hats"
#include "./../mylibies.hats"
//
#staload DC = $DivideConquer
//
implement
$DC.DivideConquer$base_test<>
  (nxs) = let
//
(*
assume
$DC.input_t0ype =
[n:int](int(n), arrayref($QuickSort_array.elt, n))
*)
//
reassume $DC.input_t0ype
//
val CUTOFF = 2
//
in
  if nxs.0 >= CUTOFF then false else true
end // end of [DivideConquer$base_test]
//
(* ****** ****** *)

implement
main0() =
{
//
val
xs0 =
arrayref
(
$arrpsz{int}
(
  8, 3, 2, 4, 6, 5, 1, 7, 0, 9
)
) (* end of [val] *)
//
val () =
fprint!(stdout_ref, "xs0 = ")
val () =
fprint_arrayref(stdout_ref, xs0, i2sz(10))
// end of [val]
val ((*void*)) = fprint_newline(stdout_ref)
//
val () =
$TESTLIB.QuickSort_array_int(xs0, 10)
//
val xs1 = xs0
//
val () =
fprint!(stdout_ref, "xs1 = ")
val () =
fprint_arrayref(stdout_ref, xs1, i2sz(10))
// end of [val]
val ((*void*)) = fprint_newline(stdout_ref)
//
(* ****** ****** *)
//
val
xs0 =
arrayref
(
$arrpsz{double}
(
  8.8, 3.3, 2.2, 4.4, 6.6
, 5.5, 1.1, 7.7, 0.0, 9.9
)
) (* end of [val] *)
//
val () =
fprint!(stdout_ref, "xs0 = ")
val () =
fprint_arrayref(stdout_ref, xs0, i2sz(10))
// end of [val]
val ((*void*)) = fprint_newline(stdout_ref)
//
val () =
$TESTLIB.QuickSort_array_double(xs0, 10)
//
val xs1 = xs0
//
val () =
fprint!(stdout_ref, "xs1 = ")
val () =
fprint_arrayref(stdout_ref, xs1, i2sz(10))
// end of [val]
val ((*void*)) = fprint_newline(stdout_ref)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
