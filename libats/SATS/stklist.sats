(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
** An list-based stack implementation
**
*)

(* ****** ****** *)

(*
**
** Author: Hongwei Xi
** Start time: March, 2017
** Authoremail: gmhwxiATgmailDOTcom
**
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.stklist"
//
// HX-2017-03-28:
#define // prefix for external
ATS_EXTERN_PREFIX "atslib_" // names
//
(* ****** ****** *)
//
absvtype
stklist_vtype
  (a: vt@ype+, n: int) = ptr
//
(* ****** ****** *)
//
stadef
stklist = stklist_vtype
//
vtypedef
stklist
(
  a:vt0p
) = [n:int] stklist_vtype(a, n)
//
(* ****** ****** *)
//
praxi
lemma_stklist_param
  {a:vt0p}{n:int}
  (stk: !stklist(INV(a), n)): [n >= 0] void
// end of [lemma_stklist_param]
//
(* ****** ****** *)
//
fun{}
stklist_make_nil
  {a:vt0p}((*void*)):<!wrt> stklist(a, 0)
//
(* ****** ****** *)
//
fun{}
stklist_getfree
  {a:vt0p}{n:int}
  (stk: stklist(INV(a), n)):<!wrt> list_vt(a, n)
//
(* ****** ****** *)
//
fun{}
stklist_is_nil
  {a:vt0p}{n:int}
  (stk: !stklist(INV(a), n)):<> bool(n==0)
fun{}
stklist_isnot_nil
  {a:vt0p}{n:int}
  (stk: !stklist(INV(a), n)):<> bool(n > 0)
//
(* ****** ****** *)

fun
{a:vt0p}
stklist_insert
  {n:int}
(
  stk: !stklist(INV(a), n) >> stklist(a, n+1), x0: a
) :<!wrt> void // endfun

(* ****** ****** *)
//
fun
{a:vt0p}
stklist_takeout
  {n:int | n > 0}
(
  stk: !stklist(INV(a), n) >> stklist(a, n-1)
) :<!wrt> (a) // endfun
//
fun
{a:vt0p}
stklist_takeout_opt
  (stk: !stklist(INV(a)) >> _):<!wrt> Option_vt(a)
// end of [stklist_takeout_opt]
//
(* ****** ****** *)

(* end of [stklist.sats] *)
