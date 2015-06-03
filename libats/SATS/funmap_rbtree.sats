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
** A red-black tree implementation
**
** The insertion operation is based on the algorithm in the following
** paper by Chris Okasaki:
**
** Red-Black Trees in a Functional Setting (Functional Pearls)
**
** J. of Functional Programming, vol. 9 (4), pp. 471-477, January, 1993
**
** The removal operation, which seems novel in its implementation, is by
** Hongwei Xi
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011 // based on a version done in October, 2008
*)

(* ****** ****** *)
//
// HX-2015-06:
// It is ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.funmap_rbtree"
//
(* ****** ****** *)

#include "./SHARE/funmap.hats"

(* ****** ****** *)
//
// HX: for the purpose of gathering statics
//
fun{
key:t0p;itm:t0p
} funmap_rbtree_height (map: map (key, itm)):<> intGte(0)
//
fun{
key:t0p;itm:t0p
} funmap_rbtree_bheight (map: map (key, itm)):<> intGte(0)
//
(* ****** ****** *)

(* end of [funmap_avltree.sats] *)
