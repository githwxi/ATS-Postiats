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

staload "libats/ML/basics.sats"

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)
//
// HX: for sets of elements of type a
//
abstype map_type (key: t@ype, itm: t0ype+)
typedef map (key:t0p, itm:t0p) = map_type (key, itm)
//
(* ****** ****** *)

typedef cmp (key:t0p) = (key, key) -<cloref0> int

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_insert (
  map: &map (key, itm) >> _, k: key, x: itm, cmp: cmp(key)
) : option0 (itm) // end of [funmap_insert]

(* ****** ****** *)

fun{
key,itm:t0p
} funmap_listize (map: map (key, itm)):<> list0 @(key, itm)

(* ****** ****** *)

(* end of [funmap.sats] *)
