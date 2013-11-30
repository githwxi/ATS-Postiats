(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: February, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_stamp.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

implement
s2explst_check_termet
  (loc0, s2es_met) = let
//
fun
loop (
  loc0: loc_t, s2es: s2explst
) : void = let
in
//
case+ s2es of
| list_cons
    (s2e, s2es) => let
    val isint = s2rt_is_int (s2e.s2exp_srt)
    val () = if isint then
      trans3_env_add_cnstr (c3nstr_termet_isnat (loc0, s2e))
    // end of [val]
  in
    loop (loc0, s2es)
  end // end of [list_cons]
| list_nil () => () // end of [list_nil]
//
end (* end of [loop] *)
//
in
  loop (loc0, s2es_met)
end // end of [s2explst_check_termet]

(* ****** ****** *)

local
//
assume termetenv_push_v = unit_v
//
viewtypedef
metbindlst_vt = List_vt @(stampset_vt, s2explst)
//
val the_metbindlst = ref_make_elt<metbindlst_vt> (list_vt_nil)
//
in // in of [local]

implement
termetenv_pop
  (pfpush | (*none*)) = let
//
vtypedef vt = @(stampset_vt, s2explst)
//
prval unit_v () = pfpush
val (vbox pf | p) = ref_get_view_ptr (the_metbindlst)
val-list_vt_cons (!p1_x, !p2_xs) = !p
val () = stampset_vt_free (p1_x->0)
val xs = !p2_xs
val () = free@ {vt?}{0} (!p)
val () = !p := xs
//
in
  (*nothing*)
end // end of [termetenv_pop]

implement
termetenv_push
  (d2vs, s2es_met) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_metbindlst)
val (
) = !p := list_vt_cons (@(d2vs, s2es_met), !p)
//
in
  (unit_v () | ())
end // end of [termetenv_push]

implement
termetenv_push_dvarlst
  (d2vs, s2es_met) = let
  vtypedef res = stampset_vt
  val res = stampset_vt_nil ()
  fn f (
    res: res, d2v: d2var
  ) : res = 
    stampset_vt_add (res, d2var_get_stamp (d2v))
  // end of [f]
  val res = list_fold_left_fun<res><d2var> (f, res, d2vs)
in
  termetenv_push (res, s2es_met)
end // end of [termetenv_push_dvarlst]

implement
termetenv_get_termet
  (d2v) = let
//
vtypedef vt =
  @(stampset_vt, s2explst)
vtypedef res = Option_vt (s2explst)
fun loop
  {n:nat} .<n>. (
  xs: !list_vt (vt, n), d2v: stamp
) : res = let
in
//
case+ xs of
| list_vt_cons
    (!p1_x, !p2_xs) => let 
    val ismem = stampset_vt_is_member (p1_x->0, d2v)
    val ans = (
      if ismem then Some_vt (p1_x->1) else loop (!p2_xs, d2v)
    ) : res // end of [val]
    prval () = fold@ (xs)
  in
    ans
  end // end of [list_vt_cons]
| list_vt_nil () => let
    prval () = fold@ xs in None_vt ()
  end // end of [list_vt_nil]
//
end // end of [loop]
//
val (vbox pf | p) = ref_get_view_ptr (the_metbindlst)
//
in
  $effmask_ref (loop (!p, d2v))
end // end of [termetenv_get_termet]

end // end of [local]

implement
s2exp_termet_instantiate
  (loc0, stamp, met) = let
//
val ans = termetenv_get_termet (stamp)
//
in
//
case+ ans of
| ~Some_vt (met_bound) => let
    val c3t = c3nstr_termet_isdec (loc0, met, met_bound)
  in
    trans3_env_add_cnstr (c3t)
  end // end of [Some_vt]
| ~None_vt () => let
    val s2p = s2exp_bool (false)
  in
    trans3_env_add_prop (loc0, s2p)
  end // end of [None_vt]
//
end // end of [s2exp_termet_instantiate]

(* ****** ****** *)

implement
s2exp_metfun_load
  (s2e0, d2v0) = let
//
fun aux (
  s2e0: s2exp
, d2v0: d2var
, s2ts0: &s2rtlst
) : Option_vt s2exp = let
  val s2f0 = s2exp2hnf (s2e0)
  val s2e0 = s2hnf2exp (s2f0)
in
//
case+ s2e0.s2exp_node of
| S2Efun (
    fc, lin, s2fe, npf, s2es, s2e
  ) => let
    val ans = aux (s2e, d2v0, s2ts0)
  in
    case ans of
    | ~Some_vt (s2e) => Some_vt (
        s2exp_fun_srt (s2e0.s2exp_srt, fc, lin, s2fe, npf, s2es, s2e)
      ) // end of [Some_vt]
    | ~None_vt () => None_vt ()
  end // end of [S2Efun]
| S2Emetfun (
    _(*stampopt*), s2es, s2e
  ) => let
    val stamp = d2var_get_stamp (d2v0)
    val () = let
      val s2ts = list_map_fun<s2exp><s2rt> (s2es, lam s2e =<0> s2e.s2exp_srt)
    in
      s2ts0 := list_of_list_vt (s2ts)
    end // end of [val]
  in
    Some_vt (s2exp_metfun (Some stamp, s2es, s2e))
  end // end of [S2Emetfun]
| S2Euni (
    s2vs, s2ps, s2e
  ) => let
    val ans = aux (s2e, d2v0, s2ts0)
  in
    case+ ans of
    | ~Some_vt s2e => Some_vt (s2exp_uni (s2vs, s2ps, s2e))
    | ~None_vt () => None_vt ()
  end // end of [S2Euni]
| _ => None_vt ()
//
end // end of [aux]
//
var s2ts: s2rtlst = list_nil ()
//
in
//
case+ aux (s2e0, d2v0, s2ts) of
| ~Some_vt s2e => Some_vt @(s2e, s2ts) | ~None_vt () => None_vt ()
//
end // end of [s2exp_metfun_load]

(* ****** ****** *)

(* end of [pats_trans3_env_termet.dats] *)
