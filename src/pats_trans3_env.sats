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
// Start Time: October, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_patcst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

datatype c3strkind =
  | C3STRKINDmain of () // generic
(*
  | C3STRKINDmetric_nat (* metric being welfounded *)
  | C3STRKINDmetric_dec (* metric being decreasing *)
*)
  | C3STRKINDcase_exhaustiveness of
      (caskind (*case/case+*), p2atcstlst) // HX: no [case-]
(*
  | C3STRKINDvarfin of (d2var_t, s2exp, s2exp)
  | C3STRKINDloop of int (* 0/1/2: enter/break/continue *)
*)
// end of [c3strkind]

datatype s3itm =
  | S3ITMcstr of c3str
  | S3ITMdisj of s3itmlstlst
  | S3ITMhypo of h3ypo
  | S3ITMsvar of s2var
  | S3ITMsVar of s2Var
// end of [s3item]

and c3str_node =
  | C3STRprop of s2exp
  | C3STRitmlst of s3itmlst
// end of [c3str_node]

and h3ypo_node =
  | H3YPOprop of s2exp
  | H3YPObind of (s2var, s2exp)
  | H3YPOeqeq of (s2exp, s2exp)
// end of [h3ypo_node]

where
s3itmlst = List (s3itm)
and
s3itmlst_vt = List_vt (s3itm)
and
s3itmlstlst = List (s3itmlst)

and c3str = '{
  c3str_loc= location
, c3str_kind= c3strkind
, c3str_node= c3str_node
} // end of [c3str]

and c3stropt = Option (c3str)

and h3ypo = '{
  h3ypo_loc= location
, h3ypo_node= h3ypo_node
} // end of [h3ypo]

(* ****** ****** *)

fun c3str_prop
  (loc: location, s2e: s2exp): c3str
fun c3str_itmlst (
  loc: location, knd: c3strkind, s3is: s3itmlst
) : c3str // end of [c3str_itmlst]
fun c3str_case_exhaustiveness (
  loc: location, casknd: caskind, p2tcs: !p2atcstlst_vt
) : c3str // end of [c3str_case_exhaustiveness]

(* ****** ****** *)

fun h3ypo_prop
  (loc: location, s2e: s2exp): h3ypo
fun h3ypo_bind
  (loc: location, s2v: s2var, s2e: s2exp): h3ypo
fun h3ypo_eqeq
  (loc: location, s2e1: s2exp, s2e2: s2exp): h3ypo

(* ****** ****** *)

fun fprint_c3str : fprint_type (c3str)
fun fprint_c3strkind : fprint_type (c3strkind)
fun fprint_h3ypo : fprint_type (h3ypo)
fun fprint_s3itm : fprint_type (s3itm)
fun fprint_s3itmlst : fprint_type (s3itmlst)
fun fprint_s3itmlstlst : fprint_type (s3itmlstlst)

(* ****** ****** *)

fun s2exp_Var_make_srt (loc: location, s2t: s2rt): s2exp
fun s2exp_Var_make_var (loc: location, s2v: s2var): s2exp

(* ****** ****** *)

fun s2exp_exiuni_instantiate_all // knd=0/1:exi/uni
  (knd: int, s2e: s2exp, locarg: location, err: &int): (s2exp, s2explst_vt)
fun s2exp_exi_instantiate_all
  (s2e: s2exp, locarg: location, err: &int): (s2exp, s2explst_vt)
fun s2exp_uni_instantiate_all
  (s2e: s2exp, locarg: location, err: &int): (s2exp, s2explst_vt)

fun s2exp_uni_instantiate_sexparglst
  (s2e: s2exp, arg: s2exparglst, err: &int): (s2exp, s2explst_vt)
// end of [s2exp_uni_instantiate_sexparglst]

(* ****** ****** *)

fun s2exp_tmp_instantiate_rest (
  s2f: s2exp, locarg: location, s2qs: s2qualst, err: &int
) : (s2exp(*res*), t2mpmarglst)
// end of [s2exp_tmp_instantiate_rest]

fun s2exp_tmp_instantiate_tmpmarglst (
  s2f: s2exp
, locarg: location, s2qs: s2qualst, t2mas: t2mpmarglst, err: &int
) : (s2exp(*res*), t2mpmarglst)
// end of [s2exp_tmp_instantiate_tmpmarglst]

(* ****** ****** *)

absview trans3_env_push_v

fun trans3_env_pop
  (pf: trans3_env_push_v | (*none*)): s3itmlst_vt
// end of [trans3_env_pop]

fun trans3_env_pop_and_add
  (pf: trans3_env_push_v | loc: location, knd: c3strkind): void
// end of [trans3_env_pop_and_add]

fun trans3_env_pop_and_add_main
  (pf: trans3_env_push_v | loc: location): void
// end of [trans3_env_pop_and_add_main]

fun trans3_env_push (): (trans3_env_push_v | void)

(* ****** ****** *)

fun trans3_env_add_svar (s2v: s2var): void
fun trans3_env_add_svarlst (s2vs: s2varlst): void

fun trans3_env_add_sVar (s2V: s2Var): void
fun trans3_env_add_sVarlst (s2Vs: s2Varlst): void

fun trans3_env_add_cstr (c3s: c3str): void

fun trans3_env_add_prop (loc: location, s2p: s2exp): void
fun trans3_env_add_proplst (loc: location, s2ps: s2explst): void
fun trans3_env_add_proplst_vt (loc: location, s2ps: s2explst_vt): void

fun trans3_env_add_eqeq
  (loc: location, s2e1: s2exp, s2e2: s2exp): void
// end of [trans3_env_add_eqeq]

fun trans3_env_add_patcstlstlst_false (
  loc: location
, casknd: caskind, cp2tcss: p2atcstlstlst_vt, s2es_pat: s2explst
) : void // end of [trans3_env_add_p2atcstlstlst_false]

(* ****** ****** *)
//
fun trans3_env_hypadd_prop (loc: location, s2p: s2exp): void
fun trans3_env_hypadd_proplst (loc: location, s2ps: s2explst): void
fun trans3_env_hypadd_proplst_vt (loc: location, s2ps: s2explst_vt): void
//
fun trans3_env_hypadd_propopt (loc: location, os2p: s2expopt): void
fun trans3_env_hypadd_propopt_neg (loc: location, os2p: s2expopt): void
//
fun trans3_env_hypadd_bind (loc: location, s2v1: s2var, s2e2: s2exp): void
fun trans3_env_hypadd_eqeq (loc: location, s2e1: s2exp, s2e2: s2exp): void
//
fun trans3_env_hypadd_patcst
  (loc: location, p2tc: p2atcst, s2e: s2exp): void
fun trans3_env_hypadd_patcstlst
  (loc: location, p2tcs: p2atcstlst_vt, s2es: s2explst): void
fun trans3_env_hypadd_labpatcstlst
  (loc: location, lp2tcs: labp2atcstlst_vt, ls2es: labs2explst): void
fun trans3_env_hypadd_patcstlstlst
  (loc: location, p2tcs: p2atcstlstlst_vt, s2es: s2explst): void
//
(* ****** ****** *)
//
// HX: for the purpose of debugging
//
fun fprint_the_s2varbindmap (out: FILEref): void
fun fprint_the_s3itmlst (out: FILEref): void
fun fprint_the_s3itmlstlst (out: FILEref): void
//
(* ****** ****** *)

fun s2hnf_absuni_and_add
  (loc: location, s2f: s2hnf): s2exp
// end of [s2hnf_absuni_and_add]

fun s2hnf_opnexi_and_add
  (loc: location, s2f: s2hnf): s2exp
// end of [s2hnf_opnexi_and_add]

(* ****** ****** *)

fun d3exp_open_and_add (d3e: d3exp): void
fun d3explst_open_and_add (d3es: d3explst): void

(* ****** ****** *)

fun trans3_env_initialize (): void

(* ****** ****** *)

(* end of [pats_trans3_env.sats] *)
