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
(* Start time: December, 2017 *)
(* Authoremail: hwxiATcsDOTbuDOTedu *)

(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
AT = "libats/SATS/athread.sats"
//
(* ****** ****** *)
//
#include "./../mydepies.hats"
//
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)
//
typedef fworkshop = $FWS.fworkshop
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
streampar_foreach
( fws: fworkshop
, xs0: stream(INV(a))): void
extern
fun
{a:t@ype}
streampar_foreach$fwork(x0: a): void
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
streampar_foreach_cloref
( fws: fworkshop
, xs0: stream(INV(a)), fwork: cfun(a, void)): void
//
(* ****** ****** *)

implement
{a}(*tmp*)
streampar_foreach
  (fws, xs0) = let
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
var nwork: int = 1
val p_nwork = addr@nwork
//
stadef spin = $AT.spin
stadef locked_v = $AT.locked_v
//
fun
freturn_spin_unlock
{l:agz}
( pf: locked_v(l)
| fws_spn: spin(l)): void = let
  val nwork = $UN.ptr0_get<int>(p_nwork)
  val ((*returned*)) = $AT.spin_unlock(pf | fws_spn)
in
  if nwork <= 0 then nwaiter_ticket_put($UN.castvwtp0(NWT))
end // end of [freturn_spin_unlock]
//
val fws_spn =
  $FWS.fworkshop_get_spin<>(fws)
//
fun
fwork2
(
xs: stream(a)
) : void = let
//
val
(locked|()) = $AT.spin_lock(fws_spn)
//
in
//
case+ !xs of
| stream_nil() => let
    val () =
    $UN.ptr0_subby<int>(p_nwork, 1)
  in
    freturn_spin_unlock(locked|fws_spn)
  end // end of [stream_nil]
| stream_cons(x0, xs) => let
    val () =
    $UN.ptr0_addby<int>(p_nwork, 1)
    val () =
    $AT.spin_unlock(locked | fws_spn)
    val () =
    $FWS.fworkshop_insert_lincloptr<>
    ( fws
    , lam() =<lincloptr1> 0 where {val()=fwork2(xs)}
    ) (* end of [val] *)
  in
    let
    val () =
    streampar_foreach$fwork<a>(x0)
    val
    (locked | ()) =
    $AT.spin_lock(fws_spn)
    val ((*void*)) =
    $UN.ptr0_subby<int>(p_nwork, 1) in freturn_spin_unlock(locked|fws_spn)
    end // end of [let]
  end // end of [stream_cons]
//
end // end of [fwork2]
//
val () =
$FWS.fworkshop_insert_lincloptr<>(fws, lam() =<lincloptr1> (fwork2(xs0); 0))
//
in
{
  val () = nwaiter_waitfor(NW)
  val () = nwaiter_destroy(NW)
}
end // end of [streampar_foreach]

(* ****** ****** *)

implement
{a}(*tmp*)
streampar_foreach_cloref
(
fws, xs0, fwork
) =
streampar_foreach<a>(fws, xs0) where
{
implement
streampar_foreach$fwork<a>(x0) = fwork(x0)
} (* end of [streampar_foreach_cloref] *)

(* ****** ****** *)

(* end of [StreamPar.dats] *)
