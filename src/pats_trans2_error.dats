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
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_trans2.sats"

(* ****** ****** *)

viewtypedef
tran2errlst_vt = List_vt (tran2err)

extern fun the_tran2errlst_get (): tran2errlst_vt

(* ****** ****** *)

local

val the_tran2errlst = ref<tran2errlst_vt> (list_vt_nil)

in

implement
the_tran2errlst_add
  (x) = () where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_tran2errlst)
  val () = !p := list_vt_cons (x, !p)
} // end of [the_tran2errlst_add]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans2_error.dats] *)
