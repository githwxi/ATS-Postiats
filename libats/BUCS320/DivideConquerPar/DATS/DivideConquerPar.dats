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
#define
ATS_PACKNAME
"ATSLIB.libats\
.BUCS320.DivideConquerPar"
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/list0.sats"
//
#staload
"prelude/DATS/list_vt.dats"
#staload
"libats/ML/SATS/atspre.sats"
//
(* ****** ****** *)
//
#include "./../mydepies.hats"
//
(* ****** ****** *)
//
typedef
input = $DivideConquer.input
typedef
output = $DivideConquer.output
//
(* ****** ****** *)
//
vtypedef
fwork = () -<lincloptr1> void
vtypedef fworklst = List0_vt_(fwork)
//
typedef
spinref = $SPINREF.spinref(int)
//
(* ****** ****** *)
//
extern
fun{}
DivideConquerPar$submit
  (fwork): void
extern
fun{}
DivideConquerPar$submit2
  (x0: input, fwork): void
//
(* ****** ****** *)
//
datatype
fworkshop =
| FWORKSHOP_chanlst of
  $FWORKSHOP_chanlst.fworkshop
| FWORKSHOP_channel of
  $FWORKSHOP_channel.fworkshop
//
extern
fun{}
DivideConquerPar$fworkshop(): fworkshop
//
(* ****** ****** *)

implement
{}(*tmp*)
DivideConquerPar$submit
  (fwork) = let
//
val
fworkshop =
DivideConquerPar$fworkshop<>
  ((*void*))
//
in
//
case+
fworkshop
of (*case+*)
| FWORKSHOP_chanlst(fws) =>
  {
    val () =
    $FWORKSHOP_chanlst.fworkshop_insert_lincloptr
    ( fws
    , llam() => 0 where
      {
        val () = fwork()
        val () = // fwork needs to be freed
        cloptr_free($UN.castvwtp0{cloptr(void)}(fwork))
      } // end of [fworkshop_insert_lincloptr]
    )
  } (* FWORKSHOP_chanlst *)
| FWORKSHOP_channel(fws) =>
  {
    val () =
    $FWORKSHOP_channel.fworkshop_insert_lincloptr
    ( fws
    , llam() => 0 where
      {
        val () = fwork()
        val () = // fwork needs to be freed
        cloptr_free($UN.castvwtp0{cloptr(void)}(fwork))
      } // end of [fworkshop_insert_lincloptr]
    )
  } (* FWORKSHOP_channel *)
//
end // end of [DivideConquerPar$submit]

(* ****** ****** *)
//
implement
{}(*tmp*)
DivideConquerPar$submit2
  (x0, fwork) =
(
  DivideConquerPar$submit<>(fwork)
)
//
(* ****** ****** *)
//
#staload
DC = $DivideConquer
#staload
DC_cont = $DivideConquer_cont
//
(* ****** ****** *)

implement
{}(*tmp*)
$DC.DivideConquer$solve
  (x0) = let
//
#staload $NWAITER
//
val NW =
  nwaiter_create_exn()
val NWT =
  nwaiter_initiate(NW)
val NWT =
  $UN.castvwtp0{ptr}(NWT)
//
var res: output
//
val ((*void*)) =
$DC_cont.DivideConquer_cont$solve<>
( x0
, lam(r0) =>
  nwaiter_ticket_put(NWT) where
  {
    val () =
    $UN.ptr0_set<output>(addr@res, r0)
    val NWT =
    $UN.castvwtp0{nwaiter_ticket}(NWT)
  } (* end of [lam] *)
) (* end of [val] *)
//
val () = nwaiter_waitfor(NW)
val () = nwaiter_destroy(NW)
//
in
  $UN.ptr0_get<output>(addr@res)
end // end of [DivideConquer$solve]

(* ****** ****** *)

implement
{}(*tmp*)
$DC_cont.DivideConquer_cont$conquer
  (_, xs, k0) = let
//
#staload
$SPINREF // opening it
//
fun
spinref_decget
  (spnr: spinref) : int = let
//
var env: int = 0
typedef tenv = int
//
implement
spinref_process$fwork<int><tenv>
  (x, env) =
  let val () = (x := x - 1) in env := x end
//
in
//
let val () =
  spinref_process_env<int><tenv>(spnr, env) in env
end // end of [let]
//
end // end of [spinref_decget]
//
fun
loop2
{n:nat}
(
  x0: input
, xs: list(input, n)
, rs: !list_vt(output, n+1)
, spnr: spinref, res: list0(output)
) : void = let
  val+
  @list_vt_cons
    (r0, rs1) = rs
  // list_vt_cons
  val addr_r0 = addr@(r0)
  val () =
  DivideConquerPar$submit2<>
  ( x0
  , llam() =>
    (
    $DC_cont.DivideConquer_cont$solve
    ( x0
    , lam(r0) => let
        val () =
        $UN.ptr0_set<output>
          (addr_r0, r0)
        // end of [$UN.ptr0_set]
        val c0 = spinref_decget(spnr)
      in
        if (c0 > 0)
          then (
            // unfinished
          ) (* end of [then] *)
          else k0(res) where
          {
            val () =
            $SPINVAR.spinvar_destroy($UN.castvwtp0(spnr))
          } (* end of [else] *)
      end // end of [let] // end of [lam]
    )
    ) (* llam *)
  ) (* end of [val] *)
//
in
//
case+ xs of
| list_nil() => () where
  {
    prval ((*folded*)) = fold@(rs)
  }
| list_cons(x1, xs) => () where
  {
    val () =
    loop2(x1, xs, rs1, spnr, res)
    prval ((*folded*)) = fold@(rs)
  }
end (* end of [loop2] *)
//
val xs = g1ofg0(xs); val n0 = length(xs)
//
in (* in-of-let *)
//
ifcase
| n0 = 0 =>
  k0(list0_nil())
| n0 = 1 => let
    val+list_sing(x0) = xs
  in
    $DC_cont.DivideConquer_cont$solve(x0, lam(r0) => k0(list0_sing(r0)))
  end // end of [n0 = 1]
| _(* n0 >= 2 *) => let
//
    val rs =
    list_map_cloref<input><output>
    (
      xs, lam _ => _
    ) (* end of [val] *)
    val res =
    $UN.castvwtp1{list0(output)}(rs)
//
    val+list_cons(x, xs) = xs
    val ((*void*)) = loop2(x, xs, rs, spinref_create_exn<int>(n0), res)
    prval ((*void*)) = $UN.cast2void(rs)
//
  in
    // nothing
  end // end of [n0 >= 2]
//
end // end of [DivideConquer_cont$conquer]

(* ****** ****** *)

(* end of [DivideConquerPar.dats] *)
