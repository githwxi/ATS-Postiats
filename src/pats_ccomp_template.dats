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
// Start Time: November, 2012
//
(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

dataviewtype impenv =
  | IMPENVcons of (s2var, s2exp, impenv) | IMPENVnil of ()
// end of [impenv]

(* ****** ****** *)

extern
fun impenv_make_svarlst
  (s2vs: s2varlst): impenv
implement
impenv_make_svarlst (s2vs) = let
in
//
case+ s2vs of
| list_cons
    (s2v, s2vs) => let
    val env = impenv_make_svarlst (s2vs)
    val s2e = s2exp_err (s2var_get_srt (s2v))
  in
    IMPENVcons (s2v, s2e, env)
  end // end of [list_cons]
| list_nil () => IMPENVnil ()
//
end // end of [impenv_make_svarlst]

(* ****** ****** *)

extern
fun tmparg_match
  (env: impenv, s2e_pat: s2exp, s2e_arg: s2exp): bool
// end of [tmparg_match]

(* ****** ****** *)


(* ****** ****** *)

(* end of [pats_ccomp_template.dats] *)
