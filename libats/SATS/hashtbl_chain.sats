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
** A hashtable implementation where the buckets
** associated with keys are represented as doubly-linked lists
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: March, 2010 // based on a version done in October, 2008
**
*)

(* ****** ****** *)
//
// HX-2013-01:
//
// ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.hashtbl_chain"
//
(* ****** ****** *)

#include "./SHARE/hashtbl.hats"

(* ****** ****** *)

absvtype
chain_vtype(key:t@ype, itm:vt@ype+) = ptr

(* ****** ****** *)

vtypedef chain(key:t0p, itm:vt0p) = chain_vtype(key, itm)

(* ****** ****** *)

(* end of [hashtbl_chain.sats] *)
