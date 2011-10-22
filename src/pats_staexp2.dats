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
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload LEX = "pats_lexing.sats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef unhnf = s2exp_of_s2hnf
macdef hnflst = s2hnflst_of_s2explst
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

implement
sp2at_con
  (loc, s2c, s2vs) = let
  val s2fs =
    l2l (list_map_fun (s2vs, s2exp_var))
  val s2e_pat = s2exp_cstapp (s2c, unhnflst (s2fs))
in '{
  sp2at_loc= loc
, sp2at_exp= s2e_pat, sp2at_node = SP2Tcon (s2c, s2vs)
} end // end of [sp2at_con]

implement
sp2at_err (loc) = let
  val s2t_pat = s2rt_err ()
  val s2e_pat = s2exp_err (s2t_pat)
in '{
  sp2at_loc= loc
, sp2at_exp= hnf (s2e_pat)
, sp2at_node= SP2Terr ()
} end // end of [sp2at_err]

(* ****** ****** *)

implement
s2qua_make
  (svs, sps) = @{
  s2qua_svs= svs, s2qua_sps= sps
} // end of [s2qua_make]

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef unhnf = s2exp_of_s2hnf

(* ****** ****** *)

implement
s2exp_int (i) = hnf '{
  s2exp_srt= s2rt_int, s2exp_node= S2Eint (i)
} // end of [s2exp_int]
implement
s2exp_intinf (int) = hnf '{
  s2exp_srt= s2rt_int, s2exp_node= S2Eintinf (int)
} // end of [s2exp_intinf]

implement
s2exp_char (c) = hnf '{
  s2exp_srt= s2rt_char, s2exp_node= S2Echar (c)
} // end of [s2exp_char]

implement
s2exp_cst (s2c) = let
  val s2t = s2cst_get_srt (s2c)
in hnf '{
  s2exp_srt= s2t, s2exp_node= S2Ecst (s2c)
} end // end of [s2exp_cst]

implement
s2exp_var (s2v) = let
  val s2t = s2var_get_srt (s2v)
in hnf '{
  s2exp_srt= s2t, s2exp_node= S2Evar (s2v)
} end // end of [s2exp_var]

(* ****** ****** *)

implement
s2exp_extype_srt
  (s2t, name, s2ess) = hnf '{
  s2exp_srt= s2t, s2exp_node= S2Eextype (name, s2ess)
} // end of [s2exp_extype_srt]

(* ****** ****** *)

implement
s2exp_app_srt
  (s2t, _fun, _arg) = '{
  s2exp_srt= s2t, s2exp_node= S2Eapp (_fun, _arg)
} // end of [s2exp_app_srt]

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
s2exp_fun_srt (
  s2t, fc, lin, s2fe, npf, _arg, _res
) = hnf '{
  s2exp_srt= s2t, s2exp_node= S2Efun (fc, lin, s2fe, npf, _arg, _res)
} // end of [s2exp_fun_srt]

implement
s2exp_metfn (
  opt, s2es_met, s2e_body
) = let
  val s2t = s2e_body.s2exp_srt
in hnf '{
  s2exp_srt= s2t, s2exp_node= S2Emetfn (opt, s2es_met, s2e_body)
} end // end of [s2exp_metfn]

(* ****** ****** *)

implement
s2exp_cstapp
  (s2c_fun, s2es_arg) = let
  val s2t_fun = s2cst_get_srt s2c_fun
  val s2e_fun = s2exp_cst (s2c_fun)
  val s2e_fun = unhnf (s2e_fun)
  val- S2RTfun (s2ts_arg, s2t_res) = s2t_fun
in
  hnf (s2exp_app_srt (s2t_res, s2e_fun, s2es_arg))
end // end of [s2exp_cstapp]

implement
s2exp_confun (
  npf, s2es_arg, s2e_res
) = hnf '{
  s2exp_srt= s2rt_type
, s2exp_node= S2Efun (
    FUNCLOfun (), 0(*lin*), S2EFFnil (), npf, s2es_arg, s2e_res
  ) // end of [S2Efun]
} (* end of [s2exp_confun] *)

(* ****** ****** *)

implement
s2exp_datconptr
  (d2c, arg) = let
  val arity_real = d2con_get_arity_real (d2c)
  val s2t = (
    if arity_real > 0 then s2rt_viewtype else s2rt_type
  ) : s2rt // end of [val]
in hnf '{
  s2exp_srt= s2t, s2exp_node= S2Edatconptr (d2c, arg)
} end // end of [s2exp_datconptr]

implement
s2exp_datcontyp
  (d2c, arg) = let
  val arity_real = d2con_get_arity_real (d2c)
  val s2t = (
    if arity_real > 0 then s2rt_viewtype else s2rt_type
  ) : s2rt // end of [val]
in hnf '{
  s2exp_srt= s2t, s2exp_node= S2Edatcontyp (d2c, arg)
} end // end of [s2exp_datcontyp]

(* ****** ****** *)

implement
s2exp_top_srt (s2t, knd, s2e) = '{
  s2exp_srt= s2t, s2exp_node= S2Etop (knd, s2e)
} // end of [s2exp_top_srt]

(* ****** ****** *)

implement
s2exp_tyarr (elt, ind) = hnf '{
  s2exp_srt=elt.s2exp_srt, s2exp_node= S2Etyarr (elt, ind)
}

implement
s2exp_tyrec_srt
  (s2t, knd, npf, ls2es) = hnf '{
  s2exp_srt= s2t, s2exp_node= S2Etyrec (knd, npf, ls2es)
}

(* ****** ****** *)

implement
s2exp_refarg (refval, s2e) = '{
  s2exp_srt= s2e.s2exp_srt, s2exp_node= S2Erefarg (refval, s2e)
} // end of [s2exp_refarg]

implement
s2exp_vararg (s2e) = hnf '{
  s2exp_srt= s2rt_t0ype, s2exp_node= S2Evararg (s2e)
} // end of [s2exp_vararg]

(* ****** ****** *)

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
s2exp_uni (
  s2vs, s2ps, s2e
) = case+ (s2vs, s2ps) of
  | (list_nil (), list_nil ()) => s2e
  | (_, _) => '{
      s2exp_srt= s2e.s2exp_srt, s2exp_node= S2Euni (s2vs, s2ps, s2e)
    } // end of [s2exp_uni]
// end of [s2exp_uni]

implement
s2exp_exiuni
  (knd, s2vs, s2ps, s2e) =
  if knd = 0 then
    s2exp_exi (s2vs, s2ps, s2e)
  else
    s2exp_uni (s2vs, s2ps, s2e)
  (* end of [if] *)
// end of [s2exp_exiuni]

(* ****** ****** *)

implement
s2exp_wth (s2e, wths2es) = '{
  s2exp_srt= s2e.s2exp_srt, s2exp_node= S2Ewth (s2e, wths2es)
} // end of [s2exp_wth]

(* ****** ****** *)

implement
s2exp_err (s2t) = '{
  s2exp_srt= s2t, s2exp_node= S2Eerr ()
}
implement
s2exp_s2rt_err () = s2exp_err (s2rt_err ())

(* ****** ****** *)

implement
s2tavar_make (loc, s2v) = '{
  s2tavar_loc= loc, s2tavar_var= s2v
}

implement
s2aspdec_make (loc, s2c, def) = '{
  s2aspdec_loc= loc, s2aspdec_cst= s2c, s2aspdec_def= def
}

(* ****** ****** *)

(* end of [pats_staexp2.dats] *)
