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
#include "./../mydepies.hats"
#include "./../mydepies_list.hats"
//
(* ****** ****** *)
//
#staload DCP = $DivideConquerPar
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)
//
(*
abst@ype elt_t0ype
*)
typedef elt = $MergeSort_list.elt_t0ype
//
(* ****** ****** *)
//
extern
fun{}
MergeSortPar_list
  ($FWS.fworkshop, xs: list0(elt)): list0(elt)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
MergeSortPar_list
  (fws, xs) = let
//
// HX:
// for bug circumvention
val () = $tempenver(fws)
//
implement
$DCP.DivideConquerPar$submit<>
  (fwork) =
{
//
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
//
} (* DivideConquerPar$submit] *)
//
in
  $MergeSort_list.MergeSort_list<>(xs)
end // end of [MergeSortPar_list]
//
(* ****** ****** *)

(* end of [MergeSortPar_list.dats] *)
