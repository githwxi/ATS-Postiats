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

#include "./pats_params.hats"

(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload LOC = "./pats_location.sats"
overload + with $LOC.location_combine

staload SYM = "./pats_symbol.sats"
macdef BACKSLASH = $SYM.symbol_BACKSLASH
macdef UNDERSCORE = $SYM.symbol_UNDERSCORE
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans1_dynexp"

(* ****** ****** *)

staload "./pats_fixity.sats"
staload "./pats_lexing.sats"
staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)

staload "./pats_trans1.sats"
staload "./pats_trans1_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)
//
macdef
list_sing (x) =
  list_cons (,(x), list_nil(*void*))
//
(* ****** ****** *)
//
// HX: translation of dynamic expr
//
typedef d1expitm = fxitm (d1exp)
typedef d1expitmlst = List (d1expitm)
//
(* ****** ****** *)
//
extern
fun
d1exp_app_proc
(
  loc0: location
, d1e_fun: d1exp, d1e_arg: d1exp
) : d1exp // end-of-function
//
implement
d1exp_app_proc
(
  loc0, d1e_fun, d1e_arg
) = let
in
//
case+
d1e_fun.d1exp_node
of // case+
//
| D1Eidextapp
    (id, d1es_arg) => let
    val d1es_arg =
      list_cons (d1e_arg, d1es_arg)
    // end of [val]
  in
    d1exp_idextapp (loc0, id, d1es_arg)
  end // end of [D1Eidexpapp]
| _ (*non-D1Eidextapp*) => let
  in
    case+
    d1e_arg.d1exp_node
    of // case+
    | D1Elist
      (
        npf, d1es
      ) => let
        val locarg = d1e_arg.d1exp_loc
      in
        d1exp_app_dyn (loc0, d1e_fun, locarg, npf, d1es)
      end // end of [D1Elist]
    | D1Esexparg
        (s1a) => let
      in
        case+
        d1e_fun.d1exp_node
        of // case+
        | D1Eapp_sta
            (d1e_fun, s1as) => let
            val s1as = list_extend(s1as, s1a)
          in
            d1exp_app_sta(loc0, d1e_fun, l2l(s1as))
          end // end of [d1exp_app_sta]
        | _ (*non-D1Eapp_sta*) =>
          (
            d1exp_app_sta (loc0, d1e_fun, list_sing(s1a))
          ) (* end of [non-D1Eapp_sta] *)
      end // end of [D1Esexparg]
    | _ (*non-list-sexparg*) => let
        val npf = ~1 // HX: default
        val locarg = d1e_arg.d1exp_loc
        val d1es_arg = list_sing (d1e_arg)
      in
        d1exp_app_dyn (loc0, d1e_fun, locarg, npf, d1es_arg)
      end // end of [non-list-sexparg]
  end // end of [non-D1Eidextapp]
//
end // end of [d1exp_app_proc]

(* ****** ****** *)

local

fn appf (
  d1e1: d1exp
, d1e2: d1exp
) :<cloref1> d1expitm = let
  val loc = d1e1.d1exp_loc + d1e2.d1exp_loc
  val d1e_app = d1exp_app_proc (loc, d1e1, d1e2)
(*
  val () = begin
    println! ("d1expitm_app: f: d1e_app = ", d1e_app)
  end // end of [val]
*)
in
  FXITMatm (d1e_app)
end // end of [appf]

in (* in of [local] *)

fn d1expitm_app
  (loc: location): d1expitm = fxitm_app (loc, appf)
// end of [d1expitm_app]

end // end of [local]

fn d1exp_get_loc (x: d1exp): location = x.d1exp_loc

fn
d1exp_make_opr
(
  opr: d1exp, f: fxty
) : d1expitm = begin
fxopr_make {d1exp} (
  d1exp_get_loc
, lam (loc, x, loc_arg, xs) => d1exp_app_dyn (loc, x, loc_arg, ~1(*npf*), xs)
, opr, f
) // end of [fxopr_make]
end // end of [d1exp_make_opr]

fn
d1expitm_backslash
(
  loc_opr: location
) : d1expitm = begin
fxopr_make_backslash {d1exp} (
  lam x => x.d1exp_loc
, lam (loc, x, loc_arg, xs) => d1exp_app_dyn (loc, x, loc_arg, ~1(*npf*), xs)
, loc_opr
) // end of [fxopr_make_backslash]
end // end of [d1expitm_backslash]

fn d1expitm_underscore
  (loc: location): d1expitm = FXITMatm (d1exp_top (loc))
// end of [d1expitm_underscore]

(* ****** ****** *)

fun
s0expdarg_tr
(
  d0e: d0exp
) : s1exparg = let
  val d1e = d0exp_tr (d0e)
in
//
case+ d1e.d1exp_node of
| D1Esexparg (s1a) => s1a
| _ => let
    val loc = d0e.d0exp_loc
    val () = prerr_interror_loc (loc)
    val () = prerrln! (": s0expdarg_tr: d1e = ", d1e)
  in
    $ERR.abort_interr{s1exparg}((*reachable*))
  end // end of [_]
//
end // end of [s0expdarg_tr]

fn s0expdarglst_tr
  (xs: d0explst): s1exparglst = l2l(list_map_fun (xs, s0expdarg_tr))
// end of [s0expdarglst_tr]

(* ****** ****** *)
//
#if (FUNCLO_DEFAULT = 1)
macdef FUNCLOdefault = FUNCLOcloptr
#endif
//
#if (FUNCLO_DEFAULT = ~1)
macdef FUNCLOdefault = FUNCLOcloref
#endif
//
(* ****** ****** *)

implement
d0exp_tr_lams_dyn
(
  lamknd, locopt, fcopt, lin, args, res, efcopt, d0e_body
) = let
//
fun aux (
  lamknd: int
, args: f0arglst
, d1e_body: d1exp
, flag: int
) :<cloref1> d1exp = begin
//
case+ args of
| list_cons
    (arg, args) => let
    val loc_arg = arg.f0arg_loc
    val d1e_body =
    aux (
      lamknd, args, d1e_body, flag1
    ) where {
      val f0a = arg.f0arg_node
      val flag1 = (
        case+ f0a of F0ARGdyn _ => flag+1 | _ => flag
      ) : int // end of [val]
    } (* end of [where] *)
    val loc_body = d1e_body.d1exp_loc
    val loc = (
      case+ locopt of
      | Some loc => loc | None () => loc_arg + loc_body
    ) : location // end of [val]
  in
    case+
    arg.f0arg_node
    of // case+
//
    | F0ARGdyn p0t
        when flag = 0 => let
        val p1t = p0at_tr p0t
        val isbox = lamkind_isbox (lamknd)
      in
        if isbox > 0 then
          d1exp_lam_dyn (loc, lin, p1t, d1e_body)
        else
          d1exp_laminit_dyn (loc, lin, p1t, d1e_body)
        // end of [if]
      end // end of [F0ARGdyn when ...]
//
    | F0ARGdyn p0t (* flag > 0 *) => let
        val p1t = p0at_tr (p0t)
        val fc0 = FUNCLOdefault(*mac*)
        val d1e_body =
          d1exp_ann_funclo_opt (loc_body, d1e_body, fc0)
        // end of [val]
      in
        d1exp_lam_dyn (loc, lin, p1t, d1e_body)
      end // end of [F0ARGdyn]
//
    | F0ARGsta1 qua =>
      d1exp_lam_sta_syn
        (loc, loc_arg, s0qualst_tr qua, d1e_body)
      // end of [F0ARGsta1]
//
    | F0ARGsta2 s0v =>
      d1exp_lam_sta_ana
        (loc, loc_arg, s0vararg_tr s0v, d1e_body)
      // end of [F0ARGsta2]
//
    | F0ARGmet3 s0es =>
        d1exp_lam_met (loc, loc_arg, s0explst_tr s0es, d1e_body)
      // end of [F0ARGmet3]
  end // end of [list_cons]
//
| list_nil ((*void*)) => d1e_body
//
end (* end of [aux] *)
//
val d1e_body = d0exp_tr (d0e_body)
//
val d1e_body = (case+ res of
  | Some s0e => let
      val loc = s0e.s0exp_loc + d1e_body.d1exp_loc
      val s1e = s0exp_tr (s0e)
    in
      d1exp_ann_type (loc, d1e_body, s1e)
    end // end of [Some]
  | None () => d1e_body // end of [None]
) : d1exp
//
val d1e_body =
(
  case+ efcopt of
  | Some efc => begin
      d1exp_ann_effc (d1e_body.d1exp_loc, d1e_body, efc)
    end // end of [Some]
  | None () => d1e_body
) : d1exp // end of [val]
//
val d1e_body =
(
  case+ fcopt of
  | Some fc => begin
      d1exp_ann_funclo (d1e_body.d1exp_loc, d1e_body, fc)
    end // end of [Some]
  | None () => d1e_body
) : d1exp // end of [val]
//
in
  aux (lamknd, args, d1e_body, 0(*flag*))
end // end of [d0exp_tr_lams_dyn]

(* ****** ****** *)

implement
termet_check
(
  loc, ismet, efcopt
) = (
//
  case+ efcopt of
  | Some efc => let
      val okay = (
        if ismet then true else effcst_contain_ntm (efc)
      ) : bool // end of [val]
    in
      if ~okay then
      {
        val () =
          prerr_error1_loc (loc)
        val () =
          prerrln! (": a termination metric is missing")
        val () = the_trans1errlst_add (T1E_termet_check(loc))
      } (* end of [if] *)
    end // end of [Some]
  | None ((*void*)) => () // end of [None]
//
) (* end of [termet_check] *)

(* ****** ****** *)

fn i0nvarg_tr
  (arg: i0nvarg): i1nvarg = let
  val opt = s0expopt_tr (arg.i0nvarg_typ)
in
  i1nvarg_make (arg.i0nvarg_loc, arg.i0nvarg_sym, opt)
end // end of [i0nvarg_tr]

fun i0nvarglst_tr
  (xs: i0nvarglst): i1nvarglst = l2l(list_map_fun (xs, i0nvarg_tr))

fn i0nvresstate_tr
  (res: i0nvresstate): i1nvresstate = let
  val s1qs = (
    case+ res.i0nvresstate_qua of
    | Some s0qs => s0qualst_tr (s0qs) | None () => list_nil ()
  ) : s1qualst // end of [val]
  val arg = i0nvarglst_tr res.i0nvresstate_arg
in
  i1nvresstate_make (s1qs, arg)
end // end of [i0nvresstate_tr]

(* ****** ****** *)

fn loopi0nv_tr
  (loc: location, inv: loopi0nv): loopi1nv = let
  val qua = (
    case+ inv.loopi0nv_qua of
    | Some s0qs => s0qualst_tr s0qs | None () => list_nil ()
  ) : s1qualst
  val met = (
    case+ inv.loopi0nv_met of
    | Some s0es => Some (s0explst_tr s0es)
    | None () => None ()
  ) : s1explstopt
  val arg = i0nvarglst_tr inv.loopi0nv_arg
  val res = i0nvresstate_tr inv.loopi0nv_res
in
  loopi1nv_make (loc, qua, met, arg, res)
end // end of [loopi0nv_tr]

(* ****** ****** *)

fn i0fcl_tr
  (ifcl: i0fcl): i1fcl = let
//
  val test = d0exp_tr(ifcl.i0fcl_test)
  val body = d0exp_tr(ifcl.i0fcl_body)
//
in
  i1fcl_make(ifcl.i0fcl_loc, test, body)
end // of [i0fcl_tr]

fn i0fclist_tr
  (ifcls: i0fclist): i1fclist =
  list_of_list_vt(list_map_fun<i0fcl>(ifcls, i0fcl_tr))
// end of [i0fclist_tr]

(* ****** ****** *)

fn gm0at_tr
  (gm0t: gm0at): gm1at = let
  val d1e = d0exp_tr(gm0t.gm0at_exp)
  val opt = (
    case+ gm0t.gm0at_pat of
    | Some p0t => Some(p0at_tr p0t) | None() => None()
  ) : p1atopt // end of [val]
in
  gm1at_make (gm0t.gm0at_loc, d1e, opt)
end // end of [gm0at_tr]

fn gm0atlst_tr
  (gm0ts: gm0atlst): gm1atlst =
  list_of_list_vt(list_map_fun<gm0at>(gm0ts, gm0at_tr))
// end of [gm0atlst_tr]

(* ****** ****** *)

fn c0lau_tr
  (c0l: c0lau): c1lau = let
//
val
loc = c0l.c0lau_loc
val
gp0t = c0l.c0lau_pat
//
val p1t = p0at_tr (gp0t.guap0at_pat)
val gua = gm0atlst_tr (gp0t.guap0at_gua)
//
val body = d0exp_tr (c0l.c0lau_body)
//
in
//
c1lau_make
(
  loc, p1t, gua, c0l.c0lau_seq, c0l.c0lau_neg, body
) (* c1lau_make *)
//
end // end of [c0lau_tr]

fn c0laulst_tr
  (c0ls: c0laulst): c1laulst =
  list_of_list_vt(list_map_fun<c0lau>(c0ls, c0lau_tr))
// end of [c0laulst_tr]

fn sc0lau_tr
  (sc0l: sc0lau): sc1lau = let
  val sp1t = sp0at_tr (sc0l.sc0lau_pat)
  val body = d0exp_tr (sc0l.sc0lau_body)
in
  sc1lau_make (sc0l.sc0lau_loc, sp1t, body)
end // end of [sc0lau_tr]

fn sc0laulst_tr
  (sc0ls: sc0laulst): sc1laulst =
  list_of_list_vt(list_map_fun<sc0lau>(sc0ls, sc0lau_tr))
// end of [sc0laulst_tr]

(* ****** ****** *)

local

fn d0exp_tr_errmsg_opr
  (d0e0: d0exp): d1exp = let
  val loc0 = d0e0.d0exp_loc
  val () = prerr_error1_loc (loc0)
  val () = prerrln! (": the operator needs to be applied.")
  val () = the_trans1errlst_add (T1E_d0exp_tr(d0e0))
in
  d1exp_errexp (loc0)
end // end of [d0exp_tr_errmsg_opr]

in (* in of [local] *)

implement
d0exp_tr (d0e0) = let
//
#define :: list_cons
//
fun
aux_item (
  d0e0: d0exp
) : d1expitm = let
//
val loc0 = d0e0.d0exp_loc
//
in
//
case+ d0e0.d0exp_node of
//
| D0Eide id
    when id = BACKSLASH =>
    d1expitm_backslash (loc0)
| D0Eide id
    when id = UNDERSCORE =>
    d1expitm_underscore (loc0)
//
| D0Eide id => let
    val d1e = d1exp_ide (loc0, id)
    val opt = the_fxtyenv_find (id)
  in
    case+ opt of
    | ~None_vt() =>
        FXITMatm (d1e) // HX: not operator
      // end of [None_vt]
    | ~Some_vt(f) =>
        d1exp_make_opr(d1e, f) // HX: operator
      // end of [Some_vt]
  end // end of [D0Eide]
//
| D0Eopid (id) =>
    FXITMatm (d1exp_ide (loc0, id))
| D0Edqid (dq, id) =>
    FXITMatm (d1exp_dqid (loc0, dq, id))
//
| D0Eidext id =>
    FXITMatm (d1exp_idext (loc0, id))
//
| D0Eint x => FXITMatm (d1exp_i0nt (loc0, x))
| D0Echar x => FXITMatm (d1exp_c0har (loc0, x))
| D0Efloat x => FXITMatm (d1exp_f0loat (loc0, x))
| D0Estring x => FXITMatm (d1exp_s0tring (loc0, x))
//
| D0Eempty() => FXITMatm (d1exp_empty (loc0))
//
| D0Ecstsp(x) => FXITMatm (d1exp_cstsp (loc0, x))
//
| D0Etyrep(s0e) =>
    FXITMatm (d1exp_tyrep (loc0, s0exp_tr (s0e)))
  // end of [D0Etyrep]
//
| D0Eliteral (d0e) =>
    FXITMatm (d1exp_literal (loc0, d0exp_tr (d0e)))
  // end of [D0Eliteral]
//
| D0Eextval (s0e, name) =>
    FXITMatm(
      d1exp_extval(loc0, s0exp_tr(s0e), name)
    ) (* [FXITMatm] *)
  // end of [D0Eextval]
//
| D0Eextfcall
    (s0e, _fun, _arg) => let
    val s1e = s0exp_tr (s0e)
    val _arg = d0explst_tr (_arg)
  in
    FXITMatm (
      d1exp_extfcall (loc0, s1e, _fun, _arg)
    ) (* end of [FXITMatm] *)
  end // end of [D0Eextfcall]
| D0Eextmcall
    (s0e, _obj, _mtd, _arg) => let
    val s1e = s0exp_tr (s0e)
    val _obj = d0exp_tr (_obj)
    val _arg = d0explst_tr (_arg)
  in
    FXITMatm (
      d1exp_extmcall (loc0, s1e, _obj, _mtd, _arg)
    ) (* end of [FXITMatm] *)
  end // end of [D0Eextmcall]
//
(*
| D0Elabel lab => d1exp_label (loc0, lab)
*)
| D0Eloopexn (knd) => FXITMatm (d1exp_loopexn (loc0, knd))
//
| D0Efoldat (d0es) => let
    val s1as = s0expdarglst_tr (d0es)
    fn f (
      d1e: d1exp
    ) :<cloref1> d1expitm = let
      val loc = loc0 + d1e.d1exp_loc
    in
      FXITMatm (d1exp_foldat (loc, s1as, d1e))
    end // end of [f]
  in
    FXITMopr (loc0, FXOPRpre (foldat_prec_dyn, f))
  end // end of [D0Efoldat]
//
| D0Efreeat (d0es) => let
    val s1as = s0expdarglst_tr (d0es)
    fn f (
      d1e: d1exp
    ) :<cloref1> d1expitm = let
      val loc = loc0 + d1e.d1exp_loc
    in
      FXITMatm (d1exp_freeat (loc, s1as, d1e))
    end // end of [f]
  in
    FXITMopr (loc0, FXOPRpre (freeat_prec_dyn, f))
  end // end of [D0Efreeat]
//
| D0Etmpid (qid, tmparg) => let
    val tmparg =
      list_map_fun (tmparg, t0mpmarg_tr)
    // end of [val]
  in
    FXITMatm (d1exp_tmpid (loc0, qid, (l2l)tmparg))
  end // end of [D0Etmpid]
//
| D0Elet (d0cs, d0e_body) => let
//
    val (pfenv|()) = the_trans1_env_push()
//
    val d1cs = d0eclist_tr (d0cs)
    val d1e_body = d0exp_tr (d0e_body)
//
    val ((*popped*)) = the_trans1_env_pop (pfenv | (*none*))
//
  in
    FXITMatm (d1exp_let (loc0, d1cs, d1e_body))
  end // end of [D0Elet]
//
| D0Edeclseq d0cs => let
//
    val (pfenv|()) = the_trans1_env_push()
//
    val d1cs = d0eclist_tr (d0cs)
    val body = d1exp_empty (loc0)
//
    val ((*popped*)) = the_trans1_env_pop (pfenv | (*none*))
//
  in
    FXITMatm (d1exp_let (loc0, d1cs, body))
  end // end of [D0Edeclseq]
//
| D0Ewhere (d0e_body, d0cs) => let
//
    val (pfenv|()) = the_trans1_env_push()
//
    val d1cs = d0eclist_tr (d0cs)
    val d1e_body = d0exp_tr (d0e_body)
//
    val ((*popped*)) = the_trans1_env_pop (pfenv | (*none*))
//
  in
    FXITMatm (d1exp_where (loc0, d1e_body, d1cs))
  end // end of [D0Ewhere]
//
| D0Eapp _ => let 
//
    val
    deis = aux_itemlst (d0e0)
//
    val
    d1e0 =
    fixity_resolve
    (
      loc0
    , d1exp_get_loc, d1expitm_app(loc0), deis
    ) (* end of [val] *)
//
(*
    val () =
    println!
      ("d0exp_tr: aux_item: d1e0 = ", d1e0)
    // end of [val]
*)
//
    val d1e0 = d1exp_syndef_resolve (loc0, d1e0)
//
  in
    FXITMatm (d1e0)
  end // end of [D0Eapp]
//
| D0Elist
    (npf, d0es) => let
    val d1es = d0explst_tr (d0es)
  in
    FXITMatm (d1exp_list (loc0, npf, d1es))
  end // end of [D0Elist]
//
| D0Eifhead (
    hd, _cond, _then, _else
  ) => let
    val inv = i0nvresstate_tr hd.ifhead_inv
    val _cond = d0exp_tr (_cond)
    val _then = d0exp_tr (_then)
    val _else = d0expopt_tr (_else)
    val d1e_if = d1exp_ifhead (loc0, inv, _cond, _then, _else)
  in
    FXITMatm (d1e_if)        
  end // end of [D0Eifhead]
| D0Esifhead (
    hd, _cond, _then, _else
  ) => let
    val i0nv = hd.sifhead_inv
    val i1nv = i0nvresstate_tr (i0nv)
    val _cond = s0exp_tr (_cond)
    val _then = d0exp_tr (_then)
    val _else = d0exp_tr (_else)
    val d1e_sif = d1exp_sifhead (loc0, i1nv, _cond, _then, _else)
  in
    FXITMatm (d1e_sif)        
  end // end of [D0Esifhead]
//
| D0Eifcasehd
    (ifhd, ifcls) => let
    val i0nv = ifhd.ifhead_inv
    val i1nv = i0nvresstate_tr(i0nv)
    val ifcls = i0fclist_tr (ifcls)
    val d1e_ifcase = d1exp_ifcasehd(loc0, i1nv, ifcls)
  in
    FXITMatm (d1e_ifcase)
  end // end of [D0Eifcasehd]
//
| D0Ecasehead
    (hd, d0e, c0ls) => let
    val tok = hd.casehead_tok
    val-T_CASE(knd) = tok.token_node
    val i0nv = hd.casehead_inv
    val i1nv = i0nvresstate_tr (i0nv)
    val d1e = d0exp_tr (d0e)
    val d1es = (
      case+ d1e.d1exp_node of
      | D1Elist (_(*npf*), d1es) => d1es | _ => list_sing (d1e)
    ) : d1explst // end of [val]
    val c1ls = c0laulst_tr (c0ls)
  in
    FXITMatm (d1exp_casehead (loc0, knd, i1nv, d1es, c1ls))
  end // end of [D0Ecasehead]
| D0Escasehead
    (hd, s0e, sc0ls) => let
//
// HX: hd.casehead_knd is always 0
//
    val i0nv = hd.scasehead_inv
    val i1nv = i0nvresstate_tr (i0nv)
    val s1e = s0exp_tr (s0e)
    val sc1ls = sc0laulst_tr sc0ls
  in
    FXITMatm (d1exp_scasehead (loc0, i1nv, s1e, sc1ls))
  end // end of [D0Escasehead]
//
| D0Elst (lin, elt, d0e_elts) => let
    val elt = s0expopt_tr (elt)
    val d1e_elts = d0exp_tr (d0e_elts)
    val d1es_elts = (
      case+ d1e_elts.d1exp_node of
      | D1Elist (_(*npf*), d1es) => d1es | _ => list_sing (d1e_elts)
    ) : d1explst // end of [val]
    val d1e_lst = d1exp_lst (loc0, lin, elt, d1es_elts)
  in
    FXITMatm (d1e_lst)
  end // end of [D0Elst]
| D0Etup (knd, npf, d0es) => let
    val d1es = d0explst_tr d0es in
    FXITMatm (d1exp_tup (loc0, knd, npf, d1es))
  end // end of [D0Etup]
| D0Erec (knd, npf, ld0es) => let
    val ld1es =
      list_map_fun (ld0es, labd0exp_tr)
    // end of [val]
  in
    FXITMatm (d1exp_rec (loc0, knd, npf, (l2l)ld1es))
  end // end of [D0Erec]
| D0Eseq d0es => FXITMatm (d1exp_seq (loc0, d0explst_tr d0es))
//
| D0Earrsub (qid, loc_ind, d0ess) => let
    val d1e_arr =
      d1exp_dqid (qid.dqi0de_loc, qid.dqi0de_qua, qid.dqi0de_sym)
    // end of [val]
    val d0es_ind = list_concat (d0ess)
    val d1es_ind = d0explst_tr ($UN.castvwtp1{d0explst}(d0es_ind))
    val () = list_vt_free (d0es_ind)
  in
    FXITMatm (d1exp_arrsub (loc0, d1e_arr, loc_ind, d1es_ind))
  end // end of [D0Earrsub]
| D0Earrpsz (elt, d0e_elts) => let
    val elt = s0expopt_tr (elt)
    val d1e_elts = d0exp_tr (d0e_elts)
    val d1es_elts = (case+ d1e_elts.d1exp_node of
      | D1Elist (_(*npf*), d1es) => d1es | _ => list_sing (d1e_elts)
    ) : d1explst // end of [val]
  in
    FXITMatm (d1exp_arrpsz (loc0, elt, d1es_elts))
  end // end of [D0Earrpsz]
| D0Earrinit (elt, asz, init) => let
    val elt = s0exp_tr (elt)
    val asz = d0expopt_tr (asz)
    val init = d0explst_tr (init)
  in
    FXITMatm (d1exp_arrinit (loc0, elt, asz, init))
  end // end of [D0Earrinit]
//
| D0Eraise (d0e) => FXITMatm (d1exp_raise (loc0, d0exp_tr (d0e)))
//
| D0Eeffmask
    (eff, d0e) => let
    val (
      fcopt, lin, prf, efc // HX: fcopt, lin, prf are all ignored!
    ) = e0fftaglst_tr (eff)
    val d1e = d0exp_tr (d0e)
  in
    FXITMatm (d1exp_effmask (loc0, efc, d1e))
  end // end of [D0Eeffmask]
| D0Eeffmask_arg
    (knd, d0e) => let
    val d1e = d0exp_tr (d0e)
  in
    FXITMatm (d1exp_effmask_arg (loc0, knd, d1e))
  end // end of [D0Eeffmask_arg]
//
| D0Eshowtype
    (d0e) => FXITMatm (d1exp_showtype (loc0, d0exp_tr(d0e)))
//
| D0Evcopyenv
    (knd, d0e) => FXITMatm (d1exp_vcopyenv (loc0, knd, d0exp_tr(d0e)))
//
| D0Etempenver (d0e) => FXITMatm (d1exp_tempenver (loc0, d0exp_tr(d0e)))
//
| D0Eptrof () => let
    fn f (d1e: d1exp):<cloref1> d1expitm = let
      val loc = loc0 + d1e.d1exp_loc in FXITMatm (d1exp_ptrof (loc, d1e))
    end (* end of [f] *)
  in
    FXITMopr (loc0, FXOPRpre (ptrof_prec_dyn, f))
  end // end of [D0Eptrof]
| D0Eviewat () => let
    fn f (d1e: d1exp) :<cloref1> d1expitm = let
      val loc = loc0 + d1e.d1exp_loc in FXITMatm (d1exp_viewat (loc, d1e))
    end (* end of [f] *)
  in
    FXITMopr (loc0, FXOPRpre (viewat_prec_dyn, f))
  end // end of [D0Eviewat]
//
| D0Esexparg (s0a) =>
    FXITMatm (d1exp_sexparg (loc0, s0exparg_tr (loc0, s0a)))
  // end of [D0Esexparg]
| D0Eexist (loc_qua, s0a, d0e) => let
    val s1a = s0exparg_tr (loc_qua, s0a)
    val d1e = d0exp_tr (d0e)
  in
    FXITMatm (d1exp_exist (loc0, s1a, d1e))
  end // end of [D0Eexist]
//
| D0Elam (
    knd, args, res, effopt, body
  ) => let
    val lin0 = lamkind_islin (knd)
    val (
      fcopt, lin, efcopt
    ) = (
      case+ effopt of
      | Some eff => let
          val (
            fcopt, lin, prf, efc
          ) = e0fftaglst_tr (eff)
          val lin = (if lin0 > 0 then 1 else lin): int
        in
          (fcopt, lin, Some efc)
        end // end of [Some]
      | None () => (None (), lin0, None ())
    ) : (fcopt, int, effcstopt)
    val d1e_lam = d0exp_tr_lams_dyn
      (knd, Some loc0, fcopt, lin, args, res, efcopt, body)
    // end of [val]
  in
    FXITMatm (d1e_lam)
  end // end of [D0Elam]
| D0Efix (
    knd, id, args, res, effopt, d0e_def
  ) => let
    val (
      fcopt, lin, efcopt
    ) = (
      case+ effopt of
      | Some(eff) => let
          val
          ( fcopt
          , lin, prf, efc
          ) = e0fftaglst_tr(eff)
        in
          (fcopt, lin, Some(efc))
        end // end of [Some]
      | None((*void*)) => (
          None(*fcopt*), 0(*lin*), None(*efcopt*)
        ) // end of [None]
    ) : (fcopt, int, effcstopt) // end of [val]
    val d1e_def =
    d0exp_tr_lams_dyn (
      knd, Some loc0, fcopt, lin, args, res, efcopt, d0e_def
    ) (* end of [val] *)
//
    val
    ismet =
    d1exp_is_metric (d1e_def)
    val () =
    termet_check (loc0, ismet, efcopt)
//
    val
    isbox = lamkind_isbox (knd) // HX: fixind = lamkind
    val knd = (if isbox > 0 then 1 else 0): int
//
  in
    FXITMatm (d1exp_fix (loc0, knd, id, d1e_def))
  end // end of [D0Efix]
//
| D0Edelay
    (knd, d0e) => let
    val d1e = d0exp_tr (d0e) in FXITMatm (d1exp_delay (loc0, knd, d1e))
  end // end of [D0Edelay]
//
| D0Esel_lab
    (knd, lab) => let
    val d1l = d1lab_lab (loc0, lab)
    fn f (
      d1e: d1exp
    ) :<cloref1> d1expitm =
      let val loc = d1e.d1exp_loc + loc0 in
        FXITMatm (d1exp_selab (loc, knd, d1e, d1l)) end // end of [let]
    // end of [f]
  in
    FXITMopr (loc0, FXOPRpos (select_prec, f))
  end // end of [D0Esel_lab]
| D0Esel_ind
    (knd, d0ess) => let
//
    val
    d0es_ind = list_concat (d0ess)
    val
    d1es_ind =
    d0explst_tr
      ($UN.castvwtp1{d0explst}(d0es_ind))
    // end of [val]
    val () = list_vt_free (d0es_ind)
//
    val d1l = d1lab_ind (loc0, d1es_ind)
    fn f (
      d1e: d1exp
    ) :<cloref1> d1expitm =
      let val loc = d1e.d1exp_loc + loc0 in
        FXITMatm (d1exp_selab (loc, knd, d1e, d1l)) end // end of [let]
    // end of [f]
  in
    FXITMopr (loc0, FXOPRpos (select_prec, f))
  end // end of [D0Esel_ind]
//
| D0Etrywith
    (hd, d0e, c0ls) => let
    val inv = i0nvresstate_tr (hd.tryhead_inv)
    val d1e = d0exp_tr (d0e)
    val c1ls = c0laulst_tr (c0ls)
  in
    FXITMatm (d1exp_trywith (loc0, inv, d1e, c1ls))
  end // end of [D0Etrywith]
//
| D0Efor
  (
    invopt, loc_inv, itp, body
  ) => let
    val inv = (
      case+ invopt of
      | Some x => loopi0nv_tr (loc_inv, x) | None _ => loopi1nv_nil (loc_inv)
    ) : loopi1nv // end of [val]
    val init =
      d0exp_tr itp.itp_init
    val test =
      d0exp_tr itp.itp_test
    val post =
      d0exp_tr itp.itp_post
    val body = d0exp_tr body
  in 
    FXITMatm (d1exp_for (loc0, inv, init, test, post, body))
  end // end of [D0Efor]
| D0Ewhile
  (
    invopt, loc_inv, test, body
  ) => let
    val inv = (
      case+ invopt of
      | Some x => loopi0nv_tr (loc_inv, x) | None _ => loopi1nv_nil (loc_inv)
    ) : loopi1nv // end of [val]
    val test = d0exp_tr (test)
    val body = d0exp_tr (body)
  in
    FXITMatm (d1exp_while (loc0, inv, test, body))
  end // end of [D0Ewhile]
//
| D0Eann (d0e, s0e) => let
    val d1e = d0exp_tr d0e
    val s1e = s0exp_tr s0e
  in
    FXITMatm(d1exp_ann_type (loc0, d1e, s1e))
  end // end of [D0Eann]
//
| D0Emacsyn(knd, d0e) =>
    FXITMatm(d1exp_macsyn (loc0, knd, d0exp_tr(d0e)))
  // end of [D0Emacsyn]
//
| D0Esolassert(d0e) => FXITMatm(d1exp_solassert(loc0, d0exp_tr(d0e)))
| D0Esolverify(s0e) => FXITMatm(d1exp_solverify(loc0, s0exp_tr(s0e)))
//
(*
| _ => let
    val () =
    prerr_interror_loc (loc0)
    val () =
    fprintln! (
      stderr_ref, "d0exp_tr: aux_item: d0e0 = ", d0e0
    ) (* end of [fprintln!] *)
    val () = assertloc (false) in $ERR.abort_interr((*deadcode*))
  end // end of [_]
*)
//
end (* end of [aux_item] *)
//
and aux_itemlst
  (d0e0: d0exp): d1expitmlst = let
  fun loop (d0e0: d0exp, res: d1expitmlst): d1expitmlst =
    case+ d0e0.d0exp_node of
    | D0Eapp (d0e1, d0e2) => let
        val res = aux_item d0e2 :: res in loop (d0e1, res)
      end // end of [D0Eapp]
    | _ => aux_item d0e0 :: res
  // end of [loop]
in
  loop (d0e0, list_nil ())
end // end of [aux_itemlist]
//
(*
val () = {
  val loc0 = d0e0.d0exp_loc
  val () = $LOC. print_location (loc0)
  val () = print ": d0exp_tr: d0e0 = "
  val () = fprint_d0exp (stdout_ref, d0e0)
  val () = print_newline ()
} // end of [val]
*)
//
in
//
case+
aux_item(d0e0)
of (* case+ *)
| FXITMatm(p1t) => p1t
| FXITMopr(_, _) => d0exp_tr_errmsg_opr (d0e0)
//
end // end of [d0exp_tr]

end // end of [local]

(* ****** ****** *)

implement
d0explst_tr (xs) = l2l(list_map_fun(xs, d0exp_tr))

(* ****** ****** *)

implement
d0expopt_tr
  (opt) = (
//
case+ opt of
 | Some(d0e) => Some(d0exp_tr(d0e)) | None() => None()
//
) (* end of [d0expopt_tr] *)

(* ****** ****** *)

implement
labd0exp_tr (ld0e) = let
  val+DL0ABELED (l, d0e) = ld0e in labd1exp_make(l, d0exp_tr(d0e))
end // end of [labd0exp_tr]

(* ****** ****** *)
//
implement
S0Ed2ctype_tr
  (d2ctp) =
(
  $UN.cast{S1Ed2ctype}(d0exp_tr($UN.cast{d0exp}(d2ctp)))
) (* end of [S0Ed2ctype_tr] *)
//
(* ****** ****** *)

(* end of [pats_trans1_dynexp.dats] *)
