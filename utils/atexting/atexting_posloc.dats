(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)

staload "./atexting.sats"

(* ****** ****** *)

implement
position_byrow(pos) =
{
//
val () = pos.pos_ntot := pos.pos_ntot + 1
val () = pos.pos_ncol := 0 (* beginning *)
val () = pos.pos_nrow := pos.pos_nrow + 1
//
} (* end of [position_byrow] *)

(* ****** ****** *)
//
implement
position_incby_1
  (pos) = pos.incby(1)
//
implement
position_incby_n
  (pos, n) = () where
{
//
val () = pos.pos_ntot := pos.pos_ntot + n
val () = pos.pos_ncol := pos.pos_ncol + n
//
} (* end of [position_incby_n] *)

(* ****** ****** *)

implement
position_decby_n(pos, n) =
{
//
val () = pos.pos_ntot := pos.pos_ntot - n
val () = pos.pos_ncol := pos.pos_ncol - n
//
} (* end of [position_decby_n] *)

(* ****** ****** *)

implement
position_incby_char
  (pos, c) = (
//
if
c >= 0
then
(
  if c = '\n'
    then position_byrow(pos)
    else position_incby_1(pos)
  // end of [if]
) (* then *)
else ((*void*))
//
) (* position_incby_char *)
  
(* ****** ****** *)

(* end of [atexting_posloc.sats] *)
