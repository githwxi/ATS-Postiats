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
// Start Time: April, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"
staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)
//
// HX-2011-05:
// the list of possible errors that may occur
// during the level-1 translation
//
datatype
trans1err =
  | T1E_prec_tr of (i0de)
  | T1E_e0xp_tr of (e0xp)
  | T1E_s0rt_tr of (s0rt)
  | T1E_s0exp_tr of (s0exp)
  | T1E_d0cstdec_tr of (d0cstdec)
  | T1E_p0at_tr of (p0at)
  | T1E_termination_metric_check of (location)
  | T1E_d0exp_tr of (d0exp)
  | T1E_i0nclude_tr of (d0ecl) // file for inclusion is not available
  | T1E_s0taload_tr of (d0ecl) // file for staloading is not available
  | T1E_d0ynload_tr of (d0ecl) // file for dynloading is not available
// end of [trans1err]

(* ****** ****** *)

fun the_trans1errlst_add (x: trans1err): void
fun the_trans1errlst_finalize (): void // cleanup all the errors

(* ****** ****** *)

fun do_e0xpact_prerr (v: v1al): void
fun do_e0xpact_error (loc: location, v: v1al): void
fun do_e0xpact_assert (loc: location, v: v1al): void

(* ****** ****** *)

fun e0xp_tr (x: e0xp): e1xp
fun e0xplst_tr (x: e0xplst): e1xplst

(* ****** ****** *)

fun e0fftaglst_tr
  (tags:  e0fftaglst): @(fcopt, int, int, effcst)
// end of [e0fftaglst_tr]

(* ****** ****** *)

fun s0rt_tr (_: s0rt): s1rt
fun s0rtlst_tr (_: s0rtlst): s1rtlst
fun s0rtopt_tr (_: s0rtopt): s1rtopt

(* ****** ****** *)

fun a0srt_tr (x: a0srt): a1srt
fun a0msrt_tr (x: a0msrt): a1msrt
fun a0msrtlst_tr (x: a0msrtlst): a1msrtlst

(* ****** ****** *)

fun s0arg_tr (x: s0arg): s1arg
fun s0arglst_tr (x: s0arglst): s1arglst
fun s0marg_tr (xs: s0marg): s1marg
fun s0marglst_tr (xss: s0marglst): s1marglst

(* ****** ****** *)

fun s0vararg_tr (s0v: s0vararg): s1vararg
fun s0vararglst_tr (s0v: s0vararglst): s1vararglst

(* ****** ****** *)

fun sp0at_tr (x: sp0at): sp1at

(* ****** ****** *)

fun s0exp_tr (x: s0exp): s1exp
fun s0explst_tr (x: s0explst): s1explst
fun s0expopt_tr (x: s0expopt): s1expopt

fun labs0exp_tr (x: labs0exp): labs1exp

fun s0rtext_tr (x: s0rtext): s1rtext

fun s0qualst_tr (xs: s0qualst): s1qualst
fun s0qualstlst_tr (xs: s0qualstlst): s1qualstlst

fun witht0ype_tr (x: witht0ype): witht1ype

(* ****** ****** *)

fun d0ecl_fixity_tr
  (dec: f0xty, ids: i0delst): void
fun d0ecl_nonfix_tr (ids: i0delst): void

(* ****** ****** *)

fun d0atsrtdec_tr (d: d0atsrtdec): d1atsrtdec

(* ****** ****** *)

fun s0rtdef_tr (x: s0rtdef): s1rtdef

fun s0tacst_tr (x: s0tacst): s1tacst
fun s0tacon_tr (x: s0tacon): s1tacon

(*
fun s0tavar_tr (x: s0tavar): s1tavar // HX: removed
*)

fun t0kindef_tr (x: t0kindef): t1kindef

fun s0expdef_tr (x: s0expdef): s1expdef
fun s0aspdec_tr (x: s0aspdec): s1aspdec

(* ****** ****** *)

fun q0marg_tr (x: q0marg): q1marg
fun q0marglst_tr (x: q0marglst): q1marglst

(* ****** ****** *)

fun i0mparg_tr (x: i0mparg): i1mparg

fun t0mpmarg_tr (x: t0mpmarg): t1mpmarg

(* ****** ****** *)

fun d0atcon_tr (d: d0atcon): d1atcon
fun d0atdec_tr (d: d0atdec): d1atdec
fun e0xndec_tr (d: e0xndec): e1xndec

(* ****** ****** *)

fun dcstextdef_tr
  (sym: symbol, extopt: s0tringopt): dcstextdef
// end of [dcstextdef_tr]

(* ****** ****** *)

fun a0typ_tr (x: a0typ): s1exp
fun a0typlst_tr (x: a0typlst): s1explst

fun s0exparg_tr (loc: location, s0a: s0exparg): s1exparg

(* ****** ****** *)

fun m0acarglst_tr (m0as: m0acarglst): m1acarglst

(* ****** ****** *)

fun d0cstdeclst_tr
  (isfun: bool, isprf: bool, ds: d0cstdeclst): d1cstdeclst
// end of [d0cstdeclst_tr]

(* ****** ****** *)

fun p0at_tr (p0t: p0at): p1at
fun labp0at_tr (lp0t: labp0at): labp1at
fun p0atlst_tr (p0ts: p0atlst): p1atlst

(* ****** ****** *)

fun d0exp_tr (x: d0exp): d1exp
fun d0explst_tr (xs: d0explst): d1explst
fun d0expopt_tr (xs: d0expopt): d1expopt

fun labd0exp_tr (x: labd0exp): labd1exp

fun d0exp_tr_lams_dyn
(
  knd : int, locopt : Option(location), fcopt : fcopt, lin : int
, args : f0arglst, res : s0expopt, efcopt : effcstopt, body : d0exp
) : d1exp // end of [d0exp_lams_dyn_tr]

fun termination_metric_check
  (loc: location, is_met: bool, oefc: effcstopt): void
// end of [termination_metric_check]

(* ****** ****** *)
//
// HX: for supporting syndef
//
(* ****** ****** *)

typedef
fsyndef = (location, d1explst) -<fun1> d1exp

fun d1exp_syndef_resolve (loc0: location, d1e: d1exp): d1exp

(* ****** ****** *)

fun d0ecl_tr (d0c: d0ecl): d1ecl
fun d0eclist_tr (d0cs: d0eclist): d1eclist

(* ****** ****** *)

fun d0eclist_tr_errck (d0cs: d0eclist): d1eclist

(* ****** ****** *)

fun trans1_finalize (
) : void // for setting STALOADFLAG, DYNLOADFLAG, PACKNAME, etc.

(* ****** ****** *)

(* end of [pats_trans1.sats] *)
