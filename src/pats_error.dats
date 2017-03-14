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
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: April, 2011
//
(* ****** ****** *)

staload "./pats_error.sats"

(* ****** ****** *)

local
//
extern
fun
segfault
(
// argless
) : int =
  "ext#pats_error_segfault"
//
in (* in-of-local *)

implement
abort() = let
(*
  val _ = segfault()
*)
in
  $raise FatalErrorExn((*void*))
end // end of [abort]

implement
abort_interr() = let
(*
  val _ = segfault()
*)
in
  $raise FatalErrorExn_interr((*void*))
end // end of [abort]

end // end of [local]

(* ****** ****** *)

(* end of [pats_error.dats] *)
