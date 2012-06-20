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
//
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: June, 2012
//
(* ****** ****** *)

datatype // t@ype+: covariant
list0_t0ype_type (a: t@ype+) =
  | list0_cons of (a, list0_t0ype_type a)
  | list0_nil of ()
stadef list0 = list0_t0ype_type

(* ****** ****** *)

datatype // t@ype+: covariant
option0_t0ype_type
  (a: t@ype+) = Some0 of (a) | None0 of ()
stadef option0 = option0_t0ype_type

(* ****** ****** *)

(* end of [basics.sats] *)
