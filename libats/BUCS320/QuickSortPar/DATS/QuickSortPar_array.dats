(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Start time: February, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

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
AT = "libats/SATS/athread.sats"
//
(* ****** ****** *)
//
#include "./../mydepies.hats"
#include "./../mydepies_array.hats"
//
(* ****** ****** *)
//
#staload QS = $QuickSort_array
#staload DCP = $DivideConquerPar
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)
//
(*
abst@ype elt_t0ype
*)
typedef elt = $QuickSort_array.elt_t0ype
//
(* ****** ****** *)
//
extern
fun{}
QuickSortPar_array
  {n:int}
(
  fws: $FWS.fworkshop, A: arrayref(elt, n), n: int(n)
) : void // end of [QuickSortPar_array]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
QuickSortPar_array
  (fws, A, n) = let
//
val () = $tempenver(fws)
//
// HX:
// for bug circumvention
val fws_spn =
  $FWS.fworkshop_get_spin<>(fws)
// end of [val]
//
val () = $tempenver(fws_spn)
//
implement
$QS.QuickSort_array$randint<>
  (n) = res where
{
  val (pf | ()) = $AT.spin_lock(fws_spn)
//
  val res = randint(n)
//
  val ((*void*)) = $AT.spin_unlock(pf | fws_spn)
} (* end of [$QuickSort_array$randint] *)
//
implement
$DCP.DivideConquerPar$submit<>
  (fwork) =
{
//
val () =
$FWS.fworkshop_insert_lincloptr<>
( fws
, llam() => 0 where
  {
    val () = fwork()
    val () = // fwork needs to be freed
    cloptr_free($UNSAFE.castvwtp0{cloptr(void)}(fwork))
  } // end of [fworkshop_insert_lincloptr]
) (* end of [val] *)
//
} (* DivideConquerPar$submit] *)
//
in
  $QuickSort_array.QuickSort_array<>(A, n)
end // end of [QuickSortPar_array]
//
(* ****** ****** *)

(* end of [QuickSortPar_array.dats] *)
