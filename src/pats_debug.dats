
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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "pats_debug.sats"

(* ****** ****** *)

local

var the_flag: int = 0
val p_the_flag = &the_flag
val (pf_the_flag | ()) =
  vbox_make_view_ptr {int} (view@ the_flag | p_the_flag)
// end of [val]

in // in of [local]

implement
debug_flag_get () = let
  prval vbox (pf) = pf_the_flag in !p_the_flag
end // end of [debug_flag_get]

implement
debug_flag_set (x) = let
  prval vbox (pf) = pf_the_flag in !p_the_flag := x
end // end of [debug_flag_set]

end // end of [local]

(* ****** ****** *)

(* end of [pats_debug.dats] *)
