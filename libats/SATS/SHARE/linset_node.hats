(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: December, 2012 *)

(* ****** ****** *)
//
// HX: shared by linset_avltree
// HX: shared by linset_listord (* ordered list *)
//
(* ****** ****** *)

absvtype
linset_node_vtype (a:t@ype+, l:addr)

(* ****** ****** *)
//
stadef mynode = linset_node_vtype // HX: local shorthand
//
vtypedef
mynode (a:t0p) = [l:addr] mynode (a, l)
vtypedef
mynode0 (a:t0p) = [l:addr | l >= null] mynode (a, l)
vtypedef
mynode1 (a:t0p) = [l:addr | l >  null] mynode (a, l)
//
(* ****** ****** *)

castfn
mynode2ptr
  {a:t0p}{l:addr} (nx: !mynode (INV(a), l)):<> ptr (l)
// end of [mynode2ptr]

(* ****** ****** *)
//
fun{a:t0p}
mynode_null (): mynode (a, null)
//
praxi
mynode_free_null {a:t0p} (nx: mynode (a, null)): void
//
(* ****** ****** *)

(* end of [linset_node.hats] *)
