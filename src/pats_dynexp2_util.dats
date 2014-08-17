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
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
d2exp_is_varlamcst
  (d2e0) = let
in
//
case+
d2e0.d2exp_node of
//
| D2Evar d2v =>
  (
    if d2var_is_mutabl d2v then false else true
  ) // end of [D2Evar]
//
| D2Elam_dyn _ => true
| D2Elam_sta _ => true
//
| D2Eint _ => true
| D2Ebool _ => true
| D2Echar _ => true
| D2Estring _ => true
| D2Ei0nt _ => true
| D2Ec0har _ => true
| D2Es0tring _ => true
//
| D2Etop _ => true
//
| D2Eexist (s2as, d2e) => d2exp_is_varlamcst (d2e)
//
| _ (*rest-of-d2exp*) => false
//
end // end of [d2exp_is_varlamcst]

(* ****** ****** *)

implement
d2con_select_arity
  (d2cs, n) = let
  val nd2cs = list_length (d2cs)
in
  if nd2cs >= 2 then let
    var !p_clo = @lam (
      pf: !unit_v | d2c: d2con
    ) : bool =<clo1> d2con_get_arity_full (d2c) = n
    prval pfu = unit_v ()
    val d2cs2 = list_filter_vclo {unit_v} (pfu | d2cs, !p_clo)
    prval unit_v () = pfu
    val d2cs2 = (l2l)d2cs2
  in
    case+ d2cs2 of list_cons _ => d2cs2 | list_nil () => d2cs
  end else d2cs // end of [if]
end // end of [d2con_select_arity]

(* ****** ****** *)

local

typedef intlst = List (int)

fn p1at_arity (p1t: p1at): int =
  case+ p1t.p1at_node of
  | P1Tlist (npf, p1ts) => list_length (p1ts) | _ => 1
// end of [p1at_arity]

fn aritest
  (d1e: d1exp, ns: intlst): bool = let
  fn* loop1 (d1e: d1exp, ns: intlst): bool =
    case+ ns of
    | list_cons (n, ns) => loop2 (d1e, n, ns) | list_nil () => true
  and loop2 (d1e: d1exp, n: int, ns: intlst): bool =
    case+ d1e.d1exp_node of
    | D1Elam_dyn (_(*lin*), p1t, d1e) =>
        if n = p1at_arity (p1t) then loop1 (d1e, ns) else false
    | D1Elam_met (_, _, d1e) => loop2 (d1e, n, ns)
    | D1Elam_sta_ana (_, _, d1e) => loop2 (d1e, n, ns)
    | D1Elam_sta_syn (_, _, d1e) => loop2 (d1e, n, ns)
    | _ => false
in
  loop1 (d1e, ns)
end // end of [aritest]

in // in of [local]

implement
d2cst_match_def (d2c, def) = let
  val ns = d2cst_get_artylst (d2c) in aritest (def, ns)
end // end of [d2cst_match_def]

end // end of [local]

(* ****** ****** *)

fun d2exp_d2var_lvalize (
  d2e0: d2exp, d2v: d2var, d2ls: d2lablst
) : d2lval =
  case+ 0 of
  | _ when d2var_is_linear (d2v) => D2LVALvar_lin (d2v, d2ls)
  | _ when d2var_is_mutabl (d2v) => D2LVALvar_mut (d2v, d2ls)
  | _ => D2LVALnone (d2e0) // end of [_]
// end of [d2var_lvalize]

implement
d2exp_lvalize
  (d2e0) = let
(*
val () = (
  println! ("d2exp_lvalize: d2e0 = ", d2e0)
) // end of [val]
*)
in
//
case+ d2e0.d2exp_node of
| D2Evar (d2v) =>
    d2exp_d2var_lvalize (d2e0, d2v, list_nil)
  // end of [D2Evar]
| D2Ederef (d2e) => D2LVALderef (d2e, list_nil)
| D2Eselab
    (d2e, d2ls) => (
  case+ d2e.d2exp_node of
  | D2Evar (d2v) =>
      d2exp_d2var_lvalize (d2e0, d2v, d2ls)
    // end of [D2Evar]
  | D2Ederef (d2e) => D2LVALderef (d2e, d2ls)
  | _ => D2LVALnone (d2e0)
  ) // end of [D2Esel]
| D2Eviewat (d2e) => D2LVALviewat (d2e)
| D2Earrsub (
    d2s, arr, loc_ind, ind
  ) => D2LVALarrsub (d2s, arr, loc_ind, ind)
| _ => D2LVALnone (d2e0)
//
end // end of [d2exp_lvalize]

(* ****** ****** *)

(* end of [pats_dynexp2_util.dats] *)
