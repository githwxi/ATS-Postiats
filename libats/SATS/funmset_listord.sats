(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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

(*
**
** Functional mset
** based on ordered lists
**
** Contributed by
** Hongwei Xi (hwxiATcsDOTbuDOTedu)
** Time: May 18, 2011
**
*)

(* ****** ****** *)
//
// HX-2015-09:
// ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.funmset_listord"
//
(* ****** ****** *)

#include "./SHARE/funmset.hats"

(* ****** ****** *)
//
castfn
funmset2list{a:t0p}
  (xs: mset(INV(a))):<> List0 @(intGt(1), a)
//
(* ****** ****** *)

(* end of [funmset_listord.sats] *)
