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

(*
**
** A functional map implementation based on ordered lists
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: May 18, 2011
**
*)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats"
#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

#include "./SHARE/funset.hats"

(* ****** ****** *)

castfn
list_of_funset {a:t0p} (xs: set (INV(a))):<> List0 (a)

(* ****** ****** *)

(* end of [funset_listord.sats] *)
