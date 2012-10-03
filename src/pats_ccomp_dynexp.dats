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
// Start Time: October, 2012
//
(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

implement
hidexp_ccomp
  (env, res, hde0) = let
//
val loc0 = hde0.hidexp_loc
val hse0 = hde0.hidexp_type
//
in
//
case+ hde0.hidexp_node of
| HDEint (i) => primval_int (loc0, hse0, i)
| HDEbool (b) => primval_bool (loc0, hse0, b)
| HDEchar (c) => primval_char (loc0, hse0, c)
| HDEstring (str) => primval_string (loc0, hse0, str)
| _ => exitloc (1)
//
end // end of [hidexp_ccomp]

(* ****** ****** *)

implement
hidexplst_ccomp
  (env, res, hdes) = let
//
fun loop (
  env: !ccompenv
, res: !instrseq
, hdes: hidexplst
, pmvs: &primvalist_vt? >> primvalist_vt
) : void = let
in
//
case+ hdes of
| list_cons
    (hde, hdes) => let
    val pmv =
      hidexp_ccomp (env, res, hde)
    val () = pmvs := list_vt_cons {..}{0} (pmv, ?)
    val list_vt_cons (_, !p_pmvs) = pmvs
    val () = loop (env, res, hdes, !p_pmvs)
    val () = fold@ (pmvs)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => let
    val () = pmvs := list_vt_nil () in (*nothing*)
  end // end of [list_nil]
//
end // end of [loop]
//
var pmvs: primvalist_vt
val () = loop (env, res, hdes, pmvs)
//
in
//
list_of_list_vt (pmvs)
//
end // end of [hidexplst_ccomp]

(* ****** ****** *)

implement
hidexp_ccomp_ret (
  env, res, hde0, tmpret
) = let
  val loc0 = hde0.hidexp_loc
  val hse0 = hde0.hidexp_type
in
//
case+ hde0.hidexp_node of
//
| HDEbool (b) => let
    val pmv = primval_bool (loc0, hse0, b)
    val ins = instr_move_val (loc0, tmpret, pmv)
  in
    instrseq_add (res, ins)
  end // end of [HDEbool]
| HDEchar (c) => let
    val pmv = primval_char (loc0, hse0, c)
    val ins = instr_move_val (loc0, tmpret, pmv)
  in
    instrseq_add (res, ins)
  end // end of [HDEchar]
//
| _ => let
    val () = println! ("hidexp_ccomp_ret: hde0 = ", hde0)
  in
    exitloc (1)
  end
//
end // end of [hidexp_ccomp_ret]

(* ****** ****** *)

(* end of [pats_ccomp_dynexp.dats] *)
