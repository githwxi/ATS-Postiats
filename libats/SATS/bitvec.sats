(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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

(*
**
** A standard bit-vector implementation
**
*)

(* ****** ****** *)
//
// HX-2014-12:
// ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.bitvec"
//
(* ****** ****** *)
//
abst@ype
bitvec_t0ype(n:int)
//
typedef bitvec (n:int) = bitvec_t0ype(n)
//
(* ****** ****** *)

typedef bit = natLt(2)

(* ****** ****** *)
//
absvtype
bitvecptr_vtype(l:addr, n:int)
vtypedef
bitvecptr (l:addr, n:int) = bitvecptr_vtype(l, n)
//
(* ****** ****** *)
//
vtypedef bitvecptr (n:int) = [l:addr] bitvecptr(l, n)
//
(* ****** ****** *)
//
castfn
bitvecptr2ptr
  {l:addr}{n:int}
  (vec: !bitvecptr(l, n)):<> ptr(l)
//
overload ptrcast with bitvecptr2ptr
//
(* ****** ****** *)
//
fun{}
bitvec_get_wordsize ():<> intGt(0)
fun{}
bitvec_get_wordsize_log ():<> intGte(0)
//
(* ****** ****** *)
//
fun{}
bitvecptr_make_none
  {n:nat}(n: int(n)):<!wrt> bitvecptr(n) = "mac#%"
fun{}
bitvecptr_make_full
  {n:nat}(n: int(n)):<!wrt> bitvecptr(n) = "mac#%"
//
(* ****** ****** *)

fun{}
bitvecptr_free{n:int}(bitvecptr(n)):<!wrt> void = "mac#%"

(* ****** ****** *)
//
fun
bitvec_get_at{n:int}
  (x: &bitvec(n), i: natLt(n)): bit = "mac#%"
fun
bitvec_set_at{n:int}
  (x: &bitvec(n) >> _, i: natLt(n), bit): void = "mac#%"
//
(* ****** ****** *)

overload [] with bitvec_get_at
overload [] with bitvec_set_at

(* ****** ****** *)
//
fun{}
bitvec_is_none
  {n:int}(&bitvec(n), int(n)):<> bool = "mac#%"
fun{}
bitvec_is_full
  {n:int}(&bitvec(n), int(n)):<> bool = "mac#%"
//  
(* ****** ****** *)
//
fun{}
bitvec_equal{n:int}
  (&bitvec(n), &bitvec(n), int(n)):<> bool = "mac#%"
fun{}
bitvec_notequal{n:int}
  (&bitvec(n), &bitvec(n), int(n)):<> bool = "mac#%"
//
(* ****** ****** *)
//
fun{}
bitvec_copy{n:int}
  (x1: &bitvec(n) >> _, x2: &bitvec(n), int(n)):<!wrt> void = "mac#%"
//
(* ****** ****** *)
//
fun{}
bitvec_neg{n:int}
  (x: &bitvec(n) >> _, int(n)):<!wrt> void = "mac#%"
//
fun{}
bitvec_lor{n:int}
  (x1: &bitvec(n) >> _, x2: &bitvec(n), int(n)):<!wrt> void = "mac#%"
fun{}
bitvec_lxor{n:int}
  (x1: &bitvec(n) >> _, x2: &bitvec(n), int(n)):<!wrt> void = "mac#%"
fun{}
bitvec_land{n:int}
  (x1: &bitvec(n) >> _, x2: &bitvec(n), int(n)):<!wrt> void = "mac#%"
//
(* ****** ****** *)

(* end of [bitvec.sats] *)
