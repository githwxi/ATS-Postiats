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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

extern
fun s2exp_hnfize_flag (s2e: s2exp, flag: &int): s2exp
extern
fun s2explst_hnfize_flag (s2es: s2explst, flag: &int): s2explst
extern
fun labs2explst_hnfize_flag (ls2es: labs2explst, flag: &int): labs2explst

(* ****** ****** *)

implement
s2exp_hnfize_flag
  (s2e0, flag) = let
  val () = assertloc (false)
in
  s2e0
end // end of [s2exp_hnfize_flag]


(* ****** ****** *)

implement
s2explst_hnfize_flag
  (s2es0, flag) =
  case+ s2es0 of
  | list_cons (s2e, s2es) => let
      val flag0 = flag
      val s2e = s2exp_hnfize_flag (s2e, flag)
      val s2es = s2explst_hnfize_flag (s2es, flag)
    in
      if flag > flag0 then
        list_cons (s2e, s2es) else s2es0
      // end of [if]
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [s2explst_hnfize_flag]

(* ****** ****** *)

implement
labs2explst_hnfize_flag
  (ls2es0, flag) =
  case+ ls2es0 of
  | list_cons (ls2e, ls2es) => let
      val flag0 = flag
      val SLABELED (l, name, s2e) = ls2e
      val s2e = s2exp_hnfize_flag (s2e, flag)
      val ls2es = labs2explst_hnfize_flag (ls2es, flag)
    in
      if flag > flag0 then
        list_cons (SLABELED (l, name, s2e), ls2es) else ls2es0
      // end of [if]
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [labs2explst_hnfize_flag]

(* ****** ****** *)

implement
s2exp_hnfize (s2e) = let
  var flag: int = 0
  val s2e = s2exp_hnfize_flag (s2e, flag)
in
  s2hnf_of_s2exp (s2e)
end // end of [s2exp_hnfsize]

implement
s2explst_hnfize (s2es) = let
  var flag: int = 0
  val s2es = s2explst_hnfize_flag (s2es, flag)
in
  s2hnflst_of_s2explst (s2es)
end // end of [s2explst_hnfsize]

(* ****** ****** *)

(* end of [pats_staexp2_util2.dats] *)
