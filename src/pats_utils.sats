(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

fun{a:t@ype}
fprintlst (
  out: FILEref
, xs: List a
, sep: string
, fprint: (FILEref, a) -> void
) : void // end of [fprintlst]

(* ****** ****** *)

local

staload Q = "libats/SATS/linqueue_arr.sats"
stadef QUEUE = $Q.QUEUE

in // in of [local]

fun queue_get_strptr1
  {m,n:int}
  {st,ln:nat | st+ln <= n} (
  q: &QUEUE (char, m, n), st: size_t st, ln: size_t ln
) : strptr1 // end of [queue_get_strptr1]

end // end of [local]

(* ****** ****** *)

(* end of [pats_utils.sats] *)
