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
** A list-based queue implementation
**
*)

(* ****** ****** *)

(*
**
** Author: Hongwei Xi
** Authoremail: hwxiATcsDOTbuDOTedu
** Time: July, 2010
** It is based on an earlier version done in October, 2008
**
*)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)

%{#
#include "libats/CATS/qlist.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.qlist"
//
(* ****** ****** *)
//
absvtype
qlist_vtype(a:vt@ype+, n:int) = ptr
//
vtypedef
qlist(a:vt0p, n:int) = qlist_vtype(a, n)
//
vtypedef
qlist(a:vt0p) = [n:int] qlist_vtype(a, n)
//
vtypedef
qlist0(a:vt0p) = [n:int | n >= 0] qlist(a, n)
//
(* ****** ****** *)

praxi
lemma_qlist_param
  {a:vt0p}{n:int}
  (q0: !qlist(INV(a), n)): [n >= 0] void
// end of [lemma_qlist_param]

(* ****** ****** *)
//
fun{}
qlist_make_nil{a:vt0p}():<!wrt> qlist(a, 0)
//
fun{}
qlist_free_nil{a:vt0p}(qlist(a, 0)):<!wrt> void
//
(* ****** ****** *)
//
fun
{a:vt0p}
qlist_length
  {n:int}(q0: !qlist(INV(a), n)):<> int(n)
//
(* ****** ****** *)
//
fun{a:vt0p}
qlist_is_nil
  {n:int}(q0: !qlist(a, n)):<> bool(n == 0)
fun{a:vt0p}
qlist_isnot_nil
  {n:int}(q0: !qlist(INV(a), n)):<> bool(n > 0)
//
(* ****** ****** *)
//
fun{}
fprint_qlist$sep
  (out: FILEref): void
//
fun{a:vt0p}
fprint_qlist
(
  out: FILEref, que: !qlist(INV(a))
) : void // end of [fprint_qlist]
fun{a:vt0p}
fprint_qlist_sep
(
  out: FILEref, que: !qlist(INV(a)), sep: string
) : void // end of [fprint_qlist_sep]
//
(* ****** ****** *)

fun{a:vt0p}
qlist_insert{n:int}
(
  que:
  !qlist(INV(a), n) >> qlist(a, n+1)
, elt: a
) :<!wrt> void // end of [qlist_insert]

(* ****** ****** *)
//
fun{a:vt0p}
qlist_takeout{n:pos}
(
  q0: !qlist(INV(a), n) >> qlist(a, n-1)
) :<!wrt> (a) // end-of-function
//
fun{a:vt0p}
qlist_takeout_opt
  (q0: !qlist(INV(a)) >> _):<!wrt> Option_vt(a)
//
(* ****** ****** *)
//
(*
** HX: this operation is O(1)
*)
//
fun{}
qlist_takeout_list{a:vt0p}{n:int}
  (q0: !qlist(INV(a), n) >> qlist(a, 0)):<!wrt> list_vt(a, n)
// end of [qlist_takeout_list]
//
(* ****** ****** *)
//
fun
{a:vt0p}
qlist_foreach(q0: !qlist(INV(a))): void
fun
{a:vt0p}
{env:vt0p}
qlist_foreach_env
  (q0: !qlist(INV(a)), env: &(env) >> _): void
//
fun
{a:vt0p}
{env:vt0p}
qlist_foreach$cont(x0: &a, env: &env): bool
fun
{a:vt0p}
{env:vt0p}
qlist_foreach$fwork(x0: &a >> _, env: &(env) >> _): void
//
(* ****** ****** *)
//
abst@ype
qstruct_tsize =
$extype"atslib_qlist_struct"
absvt@ype
qstruct_vt0ype
  (a:vt@ype+, n:int) = qstruct_tsize
//
stadef
qstruct = qstruct_vt0ype
//
stadef
qstruct = qstruct_tsize // HX: order significant
//
viewtypedef
qstruct(a:vt0p) = [n:int] qstruct(a, n)
viewtypedef
qstruct0(a:vt0p) = [n:nat] qstruct(a, n)
//
(* ****** ****** *)
//
fun{}
qstruct_initize
  {a:vt0p}
  (q0: &qstruct? >> qstruct(a, 0)):<!wrt> void
// end of [qstruct_initize]
//
praxi
qstruct_uninitize
  {a:vt0p}
  ( q0: &qstruct(a, 0) >> qstruct? ):<prf> void
// end of [qstruct_uninitize]
//
(* ****** ****** *)

praxi
qstruct_objfize
  {a:vt0p}
  {l:addr}{n:int}
(
  pf:
  qstruct
  (INV(a), n) @ l | p0: !ptrlin(l) >> qlist(a, n)
) :<prf> mfree_ngc_v(l) // end of [qstruct_objfize]

praxi
qstruct_unobjfize
  {a:vt0p}
  {l:addr}{n:int}
(
  pf: mfree_ngc_v(l) | p0: ptr(l), q0: !qlist(INV(a), n) >> ptrlin(l)
) :<prf> qstruct(a, n) @ l // end of [qstruct_unobjfize]

(* ****** ****** *)
//
fun{a:vt0p}
qstruct_insert{n:int}
(
  q0: &qstruct(INV(a), n) >> qstruct(a, n+1), x0: a
) :<!wrt> void // end of [qstruct_insert]
//
(* ****** ****** *)
//
fun{a:vt0p}
qstruct_takeout{n:pos}
  (q0: &qstruct(INV(a), n) >> qstruct(a, n-1)):<!wrt> (a)
//
(* ****** ****** *)
//
(*
** HX: this operation is O(1)
*)
//
fun{}
qstruct_takeout_list{a:vt0p}{n:int}
  (q0: &qstruct(INV(a), n) >> qstruct(a, 0)):<!wrt> list_vt(a, n)
// end of [qstruct_takeout_list]
//
(* ****** ****** *)
//
// HX: ngc-functions do not make use of malloc/free
//
(* ****** ****** *)

absvtype
qlist_node_vtype(a:vt@ype+, l:addr) = ptr

(* ****** ****** *)
//
stadef
mynode = qlist_node_vtype
//
vtypedef
mynode(a) = [l:addr] mynode(a, l)
vtypedef
mynode0(a) = [l:addr | l >= null] mynode(a, l)
vtypedef
mynode1(a) = [l:addr | l >  null] mynode(a, l)
//
(* ****** ****** *)

castfn
mynode2ptr
  {a:vt0p}
  {l:addr}
  (nx: !mynode(INV(a), l)):<> ptr(l)
// end of [mynode2ptr]

(* ****** ****** *)
//
fun{}
mynode_null{a:vt0p}(): mynode(a, null)
//
praxi
mynode_free_null{a:vt0p}(nx: mynode(a, null)): void
//
(* ****** ****** *)
//
fun{a:vt0p}
mynode_make_elt(x: a):<!wrt> mynode1(a)
//
fun{a:vt0p}
mynode_getref_elt(nx: !mynode1(INV(a))):<> cPtr1(a)
//
fun{a:vt0p}
mynode_free_elt
  (nx: mynode1(INV(a)), res: &(a?) >> a):<!wrt> void
// end of [mynode_free_elt]
//
fun{a:vt0p}
mynode_getfree_elt(node: mynode1(INV(a))):<!wrt> (a)
//
(* ****** ****** *)

fun{a:vt0p}
qlist_insert_ngc (*last*)
  {n:int}
(
  q0: !qlist(INV(a), n) >> qlist(a, n+1), nx: mynode1(a)
) :<!wrt> void // end of [qlist_insert_ngc]

(* ****** ****** *)

fun{a:vt0p}
qlist_takeout_ngc (*first*)
  {n:int | n > 0}
  (q0: !qlist(INV(a), n) >> qlist(a, n-1)):<!wrt> mynode1(a)
// end of [qlist_takeout_ngc]

(* ****** ****** *)
//
// overloading for certain symbols
//
(* ****** ****** *)
//
overload iseqz with qlist_is_nil
overload isneqz with qlist_isnot_nil
//
overload length with qlist_length
//
overload fprint with fprint_qlist
overload fprint with fprint_qlist_sep
//
(* ****** ****** *)

(* end of [qlist.sats] *)
