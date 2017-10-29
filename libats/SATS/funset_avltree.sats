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
** A functional set
** implementation based on AVL trees
**
** Contributed by
** Hongwei Xi (hwxiATcsDOTbuDOTedu)
** Time: May, 2011 // based on a version done in October, 2008
**
*)

(* ****** ****** *)
//
// HX-2012-12:
// it is ported
// to ATS/Postitats
// from ATS/Anairiats
//
(* ****** ****** *)

#define
ATS_PACKNAME
"ATSLIB.libats.funset_avltree"

(* ****** ****** *)

#include "./SHARE/funset.hats"

(* ****** ****** *)

fun{a:t0p}
funset_avltree_height(xs: set(a)):<> intGte(0)

(* ****** ****** *)

(* end of [funset_avltree.sats] *)
