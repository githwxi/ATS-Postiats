(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2011 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(* Author: Hanwen Wu *)
(* Authoremail: hwwu AT cs DOT bu DOT edu *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: November, 2011 *)

(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

staload "libats/SATS/linheap_fibonacci.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

abstype node (a:vt0p+, l:addr)
typedef node0 (a:vt0p) = [l:addr | l >= null] node (a, l) // nullable
typedef node1 (a:vt0p) = [l:addr | l >  null] node (a, l) // non-null

(* ****** ****** *)

abstype nodelst (a:vt0p+, n:int)
typedef nodelst (a:vt0p) = [n:nat] nodelst (a, n)

(* ****** ****** *)

extern
fun{a:t0p} node_getref_elt (nx: !node1 (a)):<> a
extern
fun{a:vt0p} node_getref_elt (nx: !node1 (a)):<> Ptr1

extern
fun{a:vt0p} node_get_degree (nx: !node1 (a)):<> int
extern
fun{a:vt0p} node_get_marked (nx: !node1 (a)):<> bool

extern
fun{a:vt0p} node_get_parent (nx: !node1 (a)):<> node0 (a)

extern
fun{a:vt0p} node_get_left (nx: !node1 (a)):<> node0 (a)
extern
fun{a:vt0p} node_get_right (nx: !node1 (a)):<> node0 (a)

extern
fun{a:vt0p} node_get_children (nx: !node1 (a)):<> nodelst (a)

(* ****** ****** *)

extern
fun{a:vt0p}
nodelst_insert {n:int}
  (nxs: nodelst (a, n), nx: node1 (a)): nodlst (a, n+1)
// end of [nodelst_insert]

//
// HX: [nodelst_union] is expected to be O(1)
//
extern
fun{a:vt0p}
nodelst_union {n1,n2:int}
  (nxs1: nodelst (a, n1), nxs2: nodelst (a, n2)): nodelst (a, n1+n2)
// end of [nodelst_union]

(* ****** ****** *)

#define MAX_DEGREE 45

(* ****** ****** *)

dataviewtype
FIBHEAP (a:viewtype+) =
  FIBHEAPcon (a) of (nodelst (a), int(*size*))
// end of [FIBHEAP]

(* ****** ****** *)

assume heap_viewtype (a) = FIBHEAP (a)

(* ****** ****** *)

(* linheap_fibonacci.dats *)
