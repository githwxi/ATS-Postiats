(* ****** ****** *)
(*
** DivideConquer:
** MergeSortPar_array
**
*)
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
%{^
//
#include <pthread.h>
//
%} // end of [%{^]
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload "./testlib.dats"

(* ****** ****** *)
//
local
#define
MERGESORTPAR_ARRAY
in
#include "./../mylibies.hats"
end // end of [local]
//
(* ****** ****** *)
//
#include "./../mydepies.hats"
#include "./../mydepies_array.hats"
//
#staload DCP = $DivideConquerPar
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)
//
#staload MSP_array = $MergeSortPar_array
//
(* ****** ****** *)
//
assume
$MergeSort_array.elt_t0ype = int
//
implement
gcompare_val_val<int>(x, y) = compare(x, y)
//
implement
MergeSortPar_array_int
  (fws, A, n) = let
//
val () = $tempenver(fws)
//
implement
$DCP.DivideConquerPar$submit<>
  (fwork) =
{
val () =
$FWS.fworkshop_insert_lincloptr
( fws
, llam() => 0 where
  {
    val () = fwork()
    val () = // fwork needs to be freed
    cloptr_free($UNSAFE.castvwtp0{cloptr(void)}(fwork))
  } // end of [fworkshop_insert_lincloptr]
) (* end of [val] *)
}
//
in
  $MSP_array.MergeSortPar_array<>(A, n)
end // end of [MergeSortPar_array_int]
//
(* ****** ****** *)

(* end of [MergeSortPar_array_int.dats] *)
