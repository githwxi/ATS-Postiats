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

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload LEX = "pats_lexing.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
s2exp_int (i) = '{
  s2exp_srt= s2rt_int, s2exp_node= S2Eint (i)
} // end of [s2exp_int]
implement
s2exp_intinf (int) = '{
  s2exp_srt= s2rt_int, s2exp_node= S2Eintinf (int)
} // end of [s2exp_intinf]

implement
s2exp_char (c) = '{
  s2exp_srt= s2rt_char, s2exp_node= S2Echar (c)
} // end of [s2exp_char]

implement
s2exp_cst (s2c) = let
  val s2t = s2cst_get_srt (s2c)
in '{
  s2exp_srt= s2t, s2exp_node= S2Ecst (s2c)
} end // end of [s2exp_cst]

implement
s2exp_var (s2v) = let
  val s2t = s2var_get_srt (s2v)
in '{
  s2exp_srt= s2t, s2exp_node= S2Evar (s2v)
} end // end of [s2exp_var]

(* ****** ****** *)

implement
s2exp_lam
  (s2vs, s2e_body) = let
  val s2ts = l2l (list_map_fun (s2vs, s2var_get_srt))
  val s2t_fun = s2rt_fun (s2ts, s2e_body.s2exp_srt)
in
  s2exp_lam_srt (s2t_fun, s2vs, s2e_body)
end // end of [s2exp_lam]

implement
s2exp_lam_srt
  (s2t_fun, s2vs_arg, s2e_body) = '{
  s2exp_srt= s2t_fun, s2exp_node= S2Elam (s2vs_arg, s2e_body)
} // end of [s2exp_lam_srt]

implement
s2exp_lams (s2vss, s2e_body) =
  case+ s2vss of
  | list_cons (s2vs, s2vss) => s2exp_lams (s2vss, s2exp_lam (s2vs, s2e_body))
  | list_nil () => s2e_body
// end of [s2exp_lams]

implement
s2exp_app_srt
  (s2t, _fun, _arg) = '{
  s2exp_srt= s2t, s2exp_node= S2Eapp (_fun, _arg)
} // end of [s2exp_app_srt]

implement
s2exp_fun_srt (
  s2t, fc, lin, s2fe, npf, _arg, _res
) = '{
  s2exp_srt= s2t, s2exp_node= S2Efun (fc, lin, s2fe, npf, _arg, _res)
} // end of [s2exp_fun_srt]

(* ****** ****** *)

implement
s2exp_refarg (refval, s2e) = '{
  s2exp_srt= s2e.s2exp_srt, s2exp_node= S2Erefarg (refval, s2e)
} // end of [s2exp_refarg]

implement
s2exp_vararg (s2e) = '{
  s2exp_srt= s2rt_t0ype, s2exp_node= S2Evararg (s2e)
} // end of [s2exp_vararg]

implement
s2exp_exi (
  s2vs, s2ps, s2e
) = case+ (s2vs, s2ps) of
  | (list_nil (), list_nil ()) => s2e
  | (_, _) => '{
      s2exp_srt= s2e.s2exp_srt, s2exp_node= S2Eexi (s2vs, s2ps, s2e)
    } // end of [s2exp_exi]
// end of [s2exp_exi]

implement
s2exp_wth (s2e, wths2es) = '{
  s2exp_srt= s2e.s2exp_srt, s2exp_node= S2Ewth (s2e, wths2es)
} // end of [s2exp_wth]

implement
s2exp_err (s2t) = '{
  s2exp_srt= s2t, s2exp_node= S2Eerr ()
}

(* ****** ****** *)

(* end of [pats_staexp2.dats] *)
