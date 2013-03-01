(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the  terms of the  GNU General Public License as published by the Free
** Software Foundation; either version 2.1, or (at your option) any later
** version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
** Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(*
**
** A list-based queue implementation
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: July, 2010 // based on a version done in October, 2008
**
*)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

%{#
#include "libats/CATS/qlist.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atslib_"

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

absvtype
qlist_vtype (a:vt@ype+, n:int)
stadef qlist = qlist_vtype // local shorthand

(* ****** ****** *)

praxi lemma_qlist_param
  {a:vt0p}{n:int} (q: !qlist (INV(a), n)): [n>=0] void
// end of [lemma_qlist_param]

(* ****** ****** *)

fun{a:vt0p}
qlist_make (): qlist (a, 0)

fun{a:vt0p}
qlist_free (q: qlist (a, 0)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
qlist_is_nil
  {n:int} (q: !qlist (a, n)):<> bool (n == 0)
// end of [qlist_is_nil]

fun{a:vt0p}
qlist_isnot_nil
  {n:nat} (q: !qlist (INV(a), n)):<> bool (n > 0)
// end of [qlist_isnot_nil]

(* ****** ****** *)

fun{a:vt0p}
qlist_size {n:int} (q: !qlist (INV(a), n)):<> size_t (n)

(* ****** ****** *)

fun{a:vt0p}
qlist_insert (*last*)
  {n:int} (
  q: !qlist (INV(a), n) >> qlist (a, n+1), x: a
) :<!wrt> void // end of [qlist_insert]

(* ****** ****** *)

fun{a:vt0p}
qlist_takeout (*first*)
  {n:int | n > 0} (q: !qlist (INV(a), n) >> qlist (a, n-1)):<!wrt> (a)
// end of [qlist_takeout]

fun{a:vt0p}
qlist_takeout_list
  {n:int} (q: !qlist (INV(a), n) >> qlist (a, 0)):<!wrt> list_vt (a, n)
// end of [qlist_takeout_list]

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} qlist_foreach$cont (x: &a, env: &env): void
fun{
a:vt0p}{env:vt0p
} qlist_foreach$fwork (x: &a, env: &(env) >> _): void
fun{
a:vt0p
} qlist_foreach {n:int} (q: !qlist (INV(a), n)): void
fun{
a:vt0p}{env:vt0p
} qlist_foreach_env {n:int} (q: !qlist (INV(a), n), env: &(env) >> _): void

(* ****** ****** *)
//
abst@ype
qstruct_tsz =
  $extype "atslib_qlist_qstruct"
absviewt@ype
qstruct_vt0ype (a:viewt@ype+, n:int) = qstruct_tsz
//
stadef qstruct = qstruct_vt0ype
stadef qstruct = qstruct_tsz // HX: order significant
//
viewtypedef
Qstruct (a:vt0p) = [n:nat] qstruct (a, n)
//
(* ****** ****** *)

fun{a:vt0p}
qstruct_initize
  (q: &qstruct? >> qstruct (a, 0)):<!wrt> void
fun{a:vt0p}
qstruct_uninitize
  (q: &qstruct (a, 0) >> qstruct?):<!wrt> void

(* ****** ****** *)

praxi
qstruct_objfize
  {a:vt0p}{l:addr}{n:int} (
  pf: qstruct (INV(a), n) @ l | p: !ptrlin l >> qlist (a, n)
) :<> free_ngc_v (l) // endfun

praxi
qstruct_unobjfize
  {a:vt0p}{l:addr}{n:int} (
  pf: free_ngc_v l | p: ptr l, q: !qlist (INV(a), n) >> ptrlin l
) :<> qstruct (a, n) @ l // endfun

(* ****** ****** *)

fun{a:vt0p}
qstruct_insert (*last*)
  {n:int} (q: &qstruct (INV(a), n) >> qstruct (a, n+1), x: a):<!wrt> void
// end of [qstruct_insert]

fun{a:vt0p}
qstruct_takeout (*first*)
  {n:int | n > 0} (q: &qstruct (INV(a), n) >> qstruct (a, n-1)):<!wrt> (a)
// end of [qstruct_takeout]

fun{a:vt0p}
qstruct_takeout_list
  {n:int} (q: &qstruct (INV(a), n) >> qstruct (a, 0)):<!wrt> list_vt (a, n)
// end of [qstruct_takeout_list]

(* ****** ****** *)
//
// HX: ngc-functions do not make use of malloc/free
//
(* ****** ****** *)

absvtype qlist_node_vtype (a:vt@ype+, l:addr)

(* ****** ****** *)

stadef mynode = qlist_node_vtype
vtypedef mynode (a) = [l:addr] mynode (a, l)
vtypedef mynode0 (a) = [l:addr | l >= null] mynode (a, l)
vtypedef mynode1 (a) = [l:addr | l >  null] mynode (a, l)

(* ****** ****** *)

castfn
mynode2ptr
  {a:vt0p}{l:addr} (nx: !mynode (INV(a), l)):<> ptr (l)
// end of [mynode2ptr]

(* ****** ****** *)
//
fun{a:vt0p}
mynode_null (): mynode (a, null)
//
praxi
mynode_free_null {a:vt0p} (nx: mynode (a, null)): void
//
(* ****** ****** *)

fun{a:vt0p}
mynode_make_elt (x: a):<!wrt> mynode1 (a)
fun{a:vt0p}
mynode_getref_elt (nx: mynode1 (INV(a))):<> Ptr1
fun{a:vt0p}
mynode_free_elt (nx: mynode1 (INV(a)), res: &(a?) >> a):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
qlist_insert_ngc (*last*)
  {n:int} (
  q: !qlist (INV(a), n) >> qlist (a, n+1), nx: mynode1 (a)
) :<!wrt> void // end of [qlist_insert_ngc]

(* ****** ****** *)

fun{a:vt0p}
qlist_takeout_ngc (*first*)
  {n:int | n > 0}
  (q: !qlist (INV(a), n) >> qlist (a, n-1)):<!wrt> mynode1 (a)
// end of [qlist_takeout_ngc]

(* ****** ****** *)

(* end of [qlist.sats] *)
