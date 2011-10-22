(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2011
//
(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

implement
d3exp_bool
  (loc, s2e, b) = '{
  d3exp_loc= loc
, d3exp_typ= s2e
, d3exp_node= D3Ebool (b)
} // end of [d3exp_bool]

implement
d3exp_char
  (loc, s2e, c) = '{
  d3exp_loc= loc
, d3exp_typ= s2e
, d3exp_node= D3Echar (c)
} // end of [d3exp_char]

(* ****** ****** *)

(* end of [pats_dynexp3.dats] *)
