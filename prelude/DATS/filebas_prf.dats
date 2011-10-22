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
// Start Time: October, 2011
//
(* ****** ****** *)
//
// HX-2011-10-16:
// file_mode_lte_*_*
// are declared in $ATSHOME/prelude/basic_dyn.ats
//
stadef r = r()
stadef w = w()
stadef rw = rw()
//
implement file_mode_lte_r_r = file_mode_lte_refl {r} ()
implement file_mode_lte_w_w = file_mode_lte_refl {w} ()
implement file_mode_lte_rw_rw = file_mode_lte_refl {rw} ()
//
(* ****** ****** *)

(* end of [filebas_prf.dats] *)
