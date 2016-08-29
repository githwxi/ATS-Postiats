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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<> () = prerr "pats_trans2_dynexp"
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
overload print with $LOC.print_location

(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload
LEX = "./pats_lexing.sats"

(* ****** ****** *)
//
staload
SYN = "./pats_syntax.sats"
typedef d0ynq = $SYN.d0ynq
//
overload fprint with $SYN.fprint_macsynkind
//
macdef
print_dqid (dq, id) =
  ($SYN.print_d0ynq ,(dq); $SYM.print_symbol ,(id))
// end of [print_dqid]
macdef
prerr_dqid (dq, id) =
  ($SYN.prerr_d0ynq ,(dq); $SYM.prerr_symbol ,(id))
// end of [prerr_dqid]
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_e1xpval.sats"
staload "./pats_dynexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

#include "./pats_basics.hats"

(* ****** ****** *)
//
macdef
l2l (x) = list_of_list_vt (,(x))
macdef
list_sing (x) = list_cons (,(x), list_nil)
//
(* ****** ****** *)

(*
** HX: dynamic special identifier
*)
datatype
dynspecid =
  | SPDIDderef | SPDIDassgn | SPDIDxchng | SPDIDnone
// end of [dynspecid]

(* ****** ****** *)

fun
dynspecid_of_dqid
(
  dq: d0ynq, id: symbol
) : dynspecid = let
in
//
case+
dq.d0ynq_node
of // case+
| $SYN.D0YNQnone() =>
  (case+ 0 of
   | _ when id = $SYM.symbol_BANG => SPDIDderef ()
   | _ when id = $SYM.symbol_COLONEQ => SPDIDassgn ()
   | _ when id = $SYM.symbol_COLONEQCOLON => SPDIDxchng ()
   | _ => SPDIDnone ()        
  ) (* end of [D0YNQnone] *)
| _ (*non-D0YNQnone*) => SPDIDnone ()
//
end // end of [dynspecid_of_dqid]

(* ****** ****** *)

fun
d2sym_bang
  (d1e0: d1exp): d2sym = let
//
val id =
  $SYM.symbol_BANG
// end of [val]
//
var err: int = 0
var d2pis
  : d2pitmlst = list_nil()
// end of [var]
//
val ans = the_d2expenv_find(id)
val () = (
  case+ ans of
  | ~None_vt
      ((*void*)) => (err := err + 1)
    // end of [None_vt]
  | ~Some_vt(d2i) =>
    (
    case+ d2i of
    | D2ITMsymdef(sym, xs) => d2pis := xs
    | _ (*non-D2ITMsymdef*) => (err := err+1)
    ) // end of [Some_vt]
) (* end of [val] *)
//
val loc0 = d1e0.d1exp_loc
//
val ((*void*)) =
  if (err > 0) then {
    val () =
    prerr_interror_loc(loc0)
    val () =
    prerrln! (": d2sym_bang: d1e0 = ", d1e0)
  } (* end of [if] *)
//
in
//
  d2sym_make(loc0, $SYN.d0ynq_none(loc0), id, d2pis)
//
end // end of [d2sym_bang]

fun
d2sym_lrbrackets
  (d1e0: d1exp): d2sym = let
//
val id =
  $SYM.symbol_LRBRACKETS
// end of [val]
//
var err: int = 0
var d2pis
  : d2pitmlst = list_nil()
// end of [var]
//
val ans = the_d2expenv_find(id)
val () = (
  case+ ans of
  | ~None_vt
      ((*void*)) => (err := err + 1)
    // end of [None_vt]
  | ~Some_vt(d2i) =>
    (
    case+ d2i of
    | D2ITMsymdef(sym, xs) => d2pis := xs
    | _ (*non-D2ITMsymdef*) => (err := err+1)
    ) // end of [Some_vt]
) (* end of [val] *)
//
val loc0 = d1e0.d1exp_loc
//
val ((*void*)) =
  if (err > 0) then {
    val () =
    prerr_interror_loc(loc0)
    val () =
    prerrln! (": d2sym_lrbrackets: d1e0 = ", d1e0)
  } (* end of [if] *)
//
in
//
  d2sym_make(loc0, $SYN.d0ynq_none(loc0), id, d2pis)
//
end // end of [d2sym_lrbrackets]

(* ****** ****** *)

fun
macdef_check
(
  loc0: location
, d2m0: d2mac, dq: d0ynq, id: symbol
) : void = let
  val lev = the_maclev_get ()
  val knd = d2mac_get_kind (d2m0)
in
//
if
lev > 0
then (
  if knd >= 1 then let
    val () = prerr_ERROR_beg()
    val () = prerr_error2_loc (loc0)
    val () =
    prerr ": the identifier ["
    val () = prerr_dqid (dq, id)
    val () =
    prerrln! ("] refers to a macdef in long form but one in short form is expected.")
    val () = prerr_ERROR_end()
  in
    the_trans2errlst_add (T2E_macdef_check (loc0, d2m0))
  end else () // end of [if]
) else ( // lev = 0
  if knd = 0 then let //
    val () = prerr_ERROR_beg()
    val () = prerr_error2_loc (loc0)
    val () =
    prerr ": the identifier ["
    val () = prerr_dqid (dq, id)
    val () =
    prerrln! ("] refers to a macdef in short form but one in long form is expected.")
    val () = prerr_ERROR_end()
  in
    the_trans2errlst_add (T2E_macdef_check (loc0, d2m0))    
  end else () // end of [if]
) (* end of [if] *)
//
end (* end of [macdef_check] *)

fun macvar_check
(
  loc0: location, d2v: d2var, dq: d0ynq, id: symbol
) : void = let
  val lev = the_maclev_get ()
in
//
if lev > 0 then let
  val () = prerr_error2_loc (loc0)
  val () = prerr ": the identifier ["
  val () = prerr_dqid (dq, id)
  val () = prerr "] refers incorrectly to a macro argument variable.";
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_macvar_check (loc0, d2v))
end (* end of [if] *)
//
end // end of [macvar_check]

(* ****** ****** *)

fun
d1exp_tr_dqid
(
  d1e0: d1exp, dq: d0ynq, id: symbol
) : d2exp = let
//
fun
auxerr (
  d1e0: d1exp, dq: d0ynq, id: symbol
) : void = {
  val () =
    prerr_error2_loc (d1e0.d1exp_loc)
  // end of [val]
  val () =
    filprerr_ifdebug "d1exp_tr_dqid"
  val () =
    prerr ": the dynamic identifier ["
  val () = prerr_dqid (dq, id)
  val () = prerrln! "] is unrecognized."
  val () = the_trans2errlst_add (T2E_d1exp_tr(d1e0))
} (* end of [auxerr] *)
//
val loc0 = d1e0.d1exp_loc
val ans0 = the_d2expenv_find_qua (dq, id)
//
in
//
case+ ans0 of
| ~Some_vt d2i0 => (
  case+ d2i0 of
//
  | D2ITMcst d2c => d2exp_cst (loc0, d2c)
  | D2ITMvar d2v => d2exp_var (loc0, d2v)
//
  | D2ITMcon d2cs => let
      val d2cs = d2con_select_arity (d2cs, 0)
      val-list_cons (d2c, _) = d2cs // HX: [d2cs] cannot be nil
      val locarg = $LOC.location_rightmost (loc0)
    in
      d2exp_con (
        loc0, d2c, loc0, list_nil(*sarg*), ~1(*npf*), locarg, list_nil(*darg*)
      ) // end of [d2exp_con]
    end // end of [D2ITEMcon]
//
  | D2ITMe1xp exp => let
      val d1e = d1exp_make_e1xp (loc0, exp)
    in
      d1exp_tr (d1e)
    end // end of [D2ITMe1xp]
//
  | D2ITMsymdef
      (sym, d2pis) => let
      val d2s = d2sym_make (loc0, dq, id, d2pis)
    in
      d2exp_sym (loc0, d2s)
    end // end of [D2ITEMsymdef]
//
  | D2ITMmacdef (d2m) => let
      val () = macdef_check (loc0, d2m, dq, id)
    in
      d2exp_mac (loc0, d2m)
    end // end of [D2ITEMmacdef]
  | D2ITMmacvar (d2v) => let
      val () = macvar_check (loc0, d2v, dq, id)
    in
      d2exp_var (loc0, d2v)
    end // end of [D2ITEMmacvar]
//
(*
  | _ (*rest-of-d2itm*) => let
      val () = (
        print "d1exp_tr_dqid: d2i0 = "; print_d2itm d2i0; print_newline ()
      ) // end of [val]
      val () = auxerr (d1e0, dq, id)
    in
      d2exp_err (loc0)
    end // end of [_(*rest-of-d2itm*)]
*)
//
  ) // end of [Some_vt]
| ~None_vt () => let
    val () = auxerr (d1e0, dq, id) in d2exp_errexp (loc0)
  end // end of [None_vt]
end // end of [d1exp_tr_dqid]

(* ****** ****** *)

extern
fun
d1exp_tr_app_dyn
(
  d1e0: d1exp // all
, d1e1: d1exp // fun
, locarg: location, npf: int, darg: d1explst
) : d2exp // end of [d1exp_tr_app_dyn]
extern
fun
d1exp_tr_app_sta_dyn
(
  d1e0: d1exp // all
, d1e1: d1exp // sapp
, d1e2: d1exp // fun
, sarg: s1exparglst // static arg
, locarg: location, npf: int, darg: d1explst
) : d2exp // end of [d1exp_tr_app_sta_dyn]

(* ****** ****** *)
//
extern
fun
d1exp_tr_deref(d1e0: d1exp, d1es: d1explst): d2exp
and
d1exp_tr_assgn(d1e0: d1exp, d1es: d1explst): d2exp
and
d1exp_tr_xchng(d1e0: d1exp, d1es: d1explst): d2exp
//
(* ****** ****** *)

implement
d1exp_tr_deref
  (d1e0, d1es) = let
  val loc0 = d1e0.d1exp_loc
in
  case+ d1es of
  | list_cons
    (
      d1e, list_nil()
    ) => let
      val d2s = d2sym_bang(d1e)
    in
      d2exp_deref(loc0, d2s, d1exp_tr(d1e))
    end // end of [list_sing]
  | _ => let
      val () = prerr_interror_loc (loc0)
      val () = prerrln! (": d1exp_tr_deref: d1e0 = ", d1e0)
    in
      $ERR.abort_interr{d2exp}((*reachable*))
    end // end of [_]
end // end of [d1exp_tr_deref]

implement
d1exp_tr_assgn
  (d1e0, d1es) = let
  val loc0 = d1e0.d1exp_loc
in
  case+ d1es of
  | list_cons (
      d1e1, list_cons (d1e2, list_nil ())
    ) =>
      d2exp_assgn (loc0, d1exp_tr d1e1, d1exp_tr d1e2)
    // end of [...]
  | _ => let
      val () = prerr_interror_loc (loc0)
      val () = prerrln! (": d1exp_tr_assgn: d1e0 = ", d1e0)
    in
      $ERR.abort_interr{d2exp}((*reachable*))
    end // end of [_]
end // end of [d1exp_tr_assgn]

implement
d1exp_tr_xchng
  (d1e0, d1es) = let
  val loc0 = d1e0.d1exp_loc
in
  case+ d1es of
  | list_cons (
      d1e1, list_cons (d1e2, list_nil ())
    ) =>
      d2exp_xchng (loc0, d1exp_tr d1e1, d1exp_tr d1e2)
    // end of [...]
  | _ => let
      val () = prerr_interror_loc (loc0)
      val () = prerrln! (": d1exp_tr_xchng: d1e0 = ", d1e0)
    in
      $ERR.abort_interr{d2exp}((*reachable*))
    end // end of [_]
end // end of [d1exp_tr_xchng]

(* ****** ****** *)

fun
d1exp_tr_app_dyn_dqid
(
  d1e0: d1exp // all
, d1e1: d1exp // sapp
, dq: d0ynq, id: symbol // d1e1 -> dqid
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
//
val spdid = dynspecid_of_dqid (dq, id) 
//
in
//
case+ spdid of
| SPDIDderef () => d1exp_tr_deref (d1e0, darg)
| SPDIDassgn () => d1exp_tr_assgn (d1e0, darg)
| SPDIDxchng () => d1exp_tr_xchng (d1e0, darg)
| _ (*SPDIDnone*) => let
    val ans = the_d2expenv_find_qua (dq, id)
  in
    case+ ans of
    | ~Some_vt d2i => (
      case+ d2i of
      | D2ITMe1xp (exp) =>
          d1exp_tr_app_dyn_e1xp (d1e0, d1e1, exp, locarg, npf, darg)
      | _ => let
          val sarg = list_nil() in
          d1exp_tr_app_sta_dyn_dqid_itm
            (d1e0, d1e1, d1e1, dq, id, d2i, sarg, locarg, npf, darg)
        end // end of [_]
      ) // end of [Some_vt]
    | ~None_vt () => let
        val () = prerr_error2_loc (d1e1.d1exp_loc)
        val () = filprerr_ifdebug "d1exp_tr_app_dyn_dqid"
        val () = prerr ": the dynamic identifier ["
        val () = prerr_dqid (dq, id)
        val () = prerr "] is unrecognized."
        val () = prerr_newline ((*void*))
        val () = the_trans2errlst_add (T2E_d1exp_tr (d1e0))
      in
        d2exp_errexp (d1e0.d1exp_loc)
      end // end of [None_vt]
  end // end of [_]
//
end // end of [d1exp_tr_app_dyn_dqid]

and
d1exp_tr_app_dyn_e1xp
(
  d1e0: d1exp // all
, d1e1: d1exp // fun
, exp1: e1xp // exp1 <- d1e1
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
in
//
case+ exp1.e1xp_node of
| E1XPfun _ => let
    val
    loc0 = d1e0.d1exp_loc
//
    prval pfu = unit_v ()
//
    val exps =
    list_map_vclo<d1exp>
      {unit_v}
    (
      pfu | darg, !p_clo
    ) where {
      var !p_clo = @lam (pf: !unit_v | d1e: d1exp): e1xp => e1xp_make_d1exp (loc0, d1e)
    } // end of [where] // end of [val]
//
    prval unit_v () = pfu
//
    val exp1 = e1xp_app (loc0, exp1, loc0, (l2l)exps)
(*
    val () = println! ("d1exp_tr_app_dyn_e1xp: exp1 = ", exp1)
*)
    val exp2 = e1xp_normalize (exp1)
(*
    val () = println! ("d1exp_tr_app_dyn_e1xp: exp2 = ", exp2)
*)
    val d1e0_new = d1exp_make_e1xp (loc0, exp2)
  in
    d1exp_tr (d1e0_new)
  end // end of [E1XPfun]
| _ => let
    val loc1 = d1e1.d1exp_loc
    val d1e_fun = d1exp_make_e1xp (loc1, exp1)
  in
    d1exp_tr_app_dyn (d1e0, d1e_fun, locarg, npf, darg)
  end (* end of [_] *)
//
end // end of [d1exp_tr_app_dyn_e1xp]

and
d1exp_tr_app_sta_dyn_dqid
(
  d1e0: d1exp // all
, d1e1: d1exp // sapp
, d1e2: d1exp // fun
, dq: d0ynq, id: symbol
, sarg: s1exparglst // static arg
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
  val ans = the_d2expenv_find_qua (dq, id)
in
//
case+ ans of
| ~Some_vt d2i => let
(*
    val () =
    (
      println! ("d1exp_tr_app_sta_dyn_dqid: d2i = ", d2i)
    ) // end of [val]
*)
  in
    d1exp_tr_app_sta_dyn_dqid_itm (
      d1e0, d1e1, d1e1, dq, id, d2i, sarg, locarg, npf, darg
    ) // end of [...]
  end // end of [Some_vt]
| ~None_vt () => let
    val () = prerr_error2_loc (d1e1.d1exp_loc)
    val () = filprerr_ifdebug "d1exp_tr_app_sta_dyn_dqid"
    val () = prerr ": unrecognized dynamic identifier ["
    val () = prerr_dqid (dq, id)
    val () = prerr "]."
    val () = prerr_newline ()
    val () = the_trans2errlst_add (T2E_d1exp_tr (d1e0))
  in
    d2exp_errexp (d1e0.d1exp_loc)
  end // end of [None_vt]
end // end of [d1exp_tr_app_sta_dyn_dqid]

and
d1exp_tr_app_sta_dyn_dqid_itm
(
  d1e0: d1exp // all
, d1e1: d1exp // sapp
, d1e2: d1exp // fun
, dq: d0ynq, id: symbol
, d2i: d2itm
, sarg: s1exparglst
, locarg: location, npf: int, darg: d1explst 
) : d2exp = let
//
val loc0 = d1e0.d1exp_loc
val loc1 = d1e1.d1exp_loc
val loc2 = d1e2.d1exp_loc
//
(*
val () =
(
  println! ("d1exp_tr_app_sta_dyn_dqid_itm: loc0 = ", loc0);
  println! ("d1exp_tr_app_sta_dyn_dqid_itm: d1e0 = ", d1e0);
  println! ("d1exp_tr_app_sta_dyn_dqid_itm: d1e1 = ", d1e1);
  println! ("d1exp_tr_app_sta_dyn_dqid_itm: d1e2 = ", d1e2);
) // end of [val]
val () = (
  print "d1exp_tr_app_sta_dyn_dqid_itm: dqid = "; print_dqid (dq, id); print_newline ()
) // end of [val]
*)
//
in
//
case+ d2i of
//
| D2ITMcst (d2c) => let
    val d2e2 =
      d2exp_cst (loc2, d2c)
    // end of [val]
    val sarg =
      s1exparglst_tr (sarg)
    // end of [val]
    val darg = d1explst_tr (darg)
  in
    d2exp_app_sta_dyn (loc0, loc1, d2e2, sarg, locarg, npf, darg)
  end // end of [D2ITMcst]
//
| D2ITMvar (d2v) => let
    val d2e2 =
      d2exp_var (loc2, d2v)
    // end of [val]
    val sarg =
      s1exparglst_tr (sarg)
    // end of [val]
    val darg = d1explst_tr (darg)
  in
    d2exp_app_sta_dyn (loc0, loc1, d2e2, sarg, locarg, npf, darg)
  end // end of [D2ITMvar]
//
| D2ITMcon (d2cs) => let
//
    val n = list_length (darg)
    val d2cs =
      d2con_select_arity (d2cs, n)
    // end of [val]
    val-list_cons (d2c, d2cs) = d2cs
//
    val sarg =
      s1exparglst_tr (sarg)
    // end of [val]
    val darg = d1explst_tr (darg)
//
    val npf = (if npf >= ~1 then npf else ~1): int
//
  in
    d2exp_con (loc0, d2c, loc1, sarg, npf, locarg, darg)
  end // end of [D2ITEMcon]
//
| D2ITMe1xp (exp) => let
    val d1e2 = d1exp_make_e1xp (loc2, exp) in
    d1exp_tr_app_sta_dyn (d1e0, d1e1, d1e2, sarg, locarg, npf, darg)
  end // end of [D2ITMe1xp]
//
| D2ITMsymdef (sym, d2pis) => let
//
    val d2s2 =
      d2sym_make(loc2, dq, id, d2pis)
    // end of [val]
    val d2e2 = d2exp_sym (loc2, d2s2)
//
    val sarg =
      s1exparglst_tr (sarg)
    // end of [val]
    val darg = d1explst_tr (darg)
//
  in
    d2exp_app_sta_dyn (loc0, loc1, d2e2, sarg, locarg, npf, darg)
  end // end of [D2ITMsymdef]
//
| D2ITMmacdef (d2m) => let
//
    val loc2 = d1e2.d1exp_loc
//
    val () =
      macdef_check(loc2,d2m,dq,id)
    // end of [val]
//
    val d2e2 = d2exp_mac (loc2, d2m)
//
    val sarg =
      s1exparglst_tr (sarg)
    // end of [val]
    val darg = d1explst_tr (darg)
//
  in
    d2exp_app_sta_dyn (loc0, loc1, d2e2, sarg, locarg, npf, darg)    
  end // end of [D2ITEMmacdef]
//
(*
| D2ITMmacvar (d2v) => let
    val loc2 = d1e2.d1exp_loc
    val () =
      macvar_check (loc,d2v,dq,id)
    // end of [val]
  in
    d2exp_var (loc0, d2v)
  end // end of [D2ITEMmacvar]
*)
| _ => let
//
    val () =
    prerr_error2_loc (loc2)
    val () =
    filprerr_ifdebug "d1exp_tr_app_sta_dyn_dqid_itm"
//
    val () = prerr ": the identifier ["
    val () = prerr_dqid (dq, id)
    val () = prerr "] does not refer to any variable, constant or constructor."
    val () = prerr_newline ((*void*))
    val () = the_trans2errlst_add (T2E_d1exp_tr (d1e0))
//
  in
    d2exp_errexp (loc0)
  end (* end of [_] *)
//
end // end of [d1exp_tr_app_sta_dyn_dqid_itm]

(* ****** ****** *)

implement
d1exp_tr_app_dyn
(
  d1e0, d1e1, locarg, npf, darg
) = let
(*
  val () = begin
    println! ("d1exp_tr_app_dyn: d1e0 = ", d1e0);
  end // end of [val]
*)
in
//
case+
d1e1.d1exp_node of
| D1Eide (id) => let
    val dq = $SYN.the_d0ynq_none in
    d1exp_tr_app_dyn_dqid (d1e0, d1e1, dq, id, locarg, npf, darg)
  end
| D1Edqid (dq, id) =>
    d1exp_tr_app_dyn_dqid (d1e0, d1e1, dq, id, locarg, npf, darg)
  // end of [D1Edqid]
| _ => let
    val d2e1 = d1exp_tr (d1e1)
    val darg = d1explst_tr (darg)
  in
    d2exp_app_dyn (d1e0.d1exp_loc, d2e1, npf, locarg, darg)
  end // end of [_]
//
end // end of [d1exp_tr_app_dyn]

implement
d1exp_tr_app_sta_dyn
(
  d1e0, d1e1, d1e2, sarg, locarg, npf, darg
) = let
(*
  val () = (
    println! ("d1exp_tr_app_sta_dyn: d1e0 = ", d1e0);
    fprintln! (stdout_ref, "d1exp_tr_app_sta_dyn: sarg = ", sarg);
  ) // end of [val]
*)
in
//
case+
d1e2.d1exp_node of
| D1Eide (id) => let
    val dq = $SYN.the_d0ynq_none in
    d1exp_tr_app_sta_dyn_dqid (d1e0, d1e1, d1e2, dq, id, sarg, locarg, npf, darg)
  end
| D1Edqid (dq, id) =>
    d1exp_tr_app_sta_dyn_dqid (d1e0, d1e1, d1e2, dq, id, sarg, locarg, npf, darg)
  // end of [D1Edqid]
| _ => let
    val d2e2 = d1exp_tr (d1e2)
    val sarg = s1exparglst_tr (sarg)
    val darg = d1explst_tr (darg)
  in
    d2exp_app_sta_dyn (d1e0.d1exp_loc, d1e1.d1exp_loc, d2e2, sarg, locarg, npf, darg)
  end // end of [_]
//
end // end of [d1exp_tr_app_sta_dyn]

(* ****** ****** *)

extern
fun
d1exp_tr_macsyn
  (d1e0: d1exp): d2exp
//
implement
d1exp_tr_macsyn(d1e0) = let
//
val loc0 = d1e0.d1exp_loc
val-D1Emacsyn (knd, d1e) = d1e0.d1exp_node
(*
val () = {
  val out = stdout_ref
  val () = fprintln! (out, "d1exp_tr_macsyn: knd = ", knd)
  val () = fprintln! (out, "d1exp_tr_macsyn: d1e = ", d1e)
} (* end of [val] *)
*)
//
macdef inc () = the_maclev_inc (loc0)
macdef dec () = the_maclev_dec (loc0)
//
in
//
case+ knd of
| $SYN.MSKxstage () => let
    val () = dec ()
    val d2e = d1exp_tr (d1e)
    val () = inc ()
  in
    d2exp_macsyn (loc0, knd, d2e)
  end // end of [MSKcross]
| $SYN.MSKdecode () => let
    val () = dec ()
    val d2e = d1exp_tr (d1e)
    val () = inc ()
  in
    d2exp_macsyn (loc0, knd, d2e)
  end // end of [MSKdecode]
| $SYN.MSKencode () => let
    val () = inc ()
    val d2e = d1exp_tr (d1e)
    val () = dec ()
  in
    d2exp_macsyn (loc0, knd, d2e)
  end // end of [MSKencode]
//
end // end of [d1exp_tr_macsyn]

(* ****** ****** *)

extern
fun
d1exp_tr_macfun
  (d1e0: d1exp): d2exp
//
implement
d1exp_tr_macfun(d1e0) = let
//
val loc0 = d1e0.d1exp_loc
val-D1Emacfun (name, d1es) = d1e0.d1exp_node
//
val d2es = d1explst_tr (d1es)
//
in
  d2exp_macfun (loc0, name, d2es)
end // end of [d1exp_tr_macfun]

(* ****** ****** *)

fun
d1exp_tr_arrsub
(
  d1e0: d1exp, arr: d1exp
, locind: location, ind: d1explst
) : d2exp = let
  val loc0 = d1e0.d1exp_loc
  val d2s0 = d2sym_lrbrackets (d1e0)
  val arr  = d1exp_tr (arr)
  val ind  = d1explst_tr (ind)
in
  d2exp_arrsub(loc0, d2s0, arr, locind, ind)
end // end of [d1exp_tr_arrsub]

(* ****** ****** *)
//
// HX: [w1ts] is assumed to be not empty
//
fun
d1exp_tr_wths1explst
(
  d1e0: d1exp, w1ts: wths1explst
) : d2exp = let
  val loc0 = d1e0.d1exp_loc
in
//
case+
d1e0.d1exp_node of
| D1Eann_type (d1e, s1e) => let
    val d2e = d1exp_tr (d1e)
    val s2e = s1exp_trdn_res_impred (s1e, w1ts)
  in
    d2exp_ann_type (loc0, d2e, s2e)
  end // end of [D1Eann_type]
| D1Eann_effc (d1e, efc) => let
    val d2e = d1exp_tr_wths1explst (d1e, w1ts)
    val s2fe = effcst_tr (efc)
  in
    d2exp_ann_seff (loc0, d2e, s2fe)
  end // end of [D1Eann_effc]
| D1Eann_funclo (d1e, fc) => let
    val d2e = d1exp_tr_wths1explst (d1e, w1ts)
  in
    d2exp_ann_funclo (loc0, d2e, fc)
  end // end of[D1Eann_funclo]
| _ => let
    val () = prerr_error2_loc (loc0)
    val () = filprerr_ifdebug "d1exp_wths1explst_tr"
    val () = prerr ": the dynamic expression is expected to be ascribed a type but it is not."
    val () = prerr_newline ((*void*))
    val () = the_trans2errlst_add (T2E_d1exp_tr (d1e0))
  in
    d2exp_errexp (loc0)
  end // end of [_]
end (* end of [d1exp_tr_wths1explst] *)

fun
d1exp_tr_arg_body
(
  p1t_arg: p1at, d1e_body: d1exp
) : @(int, p2atlst, d2exp) = let
  var w1ts = WTHS1EXPLSTnil ()
  val p2t_arg = p1at_tr_arg (p1t_arg, w1ts)
  val () = w1ts := wths1explst_reverse (w1ts)
  var npf: int = ~1 // HX: default
  val p2ts_arg = (
    case+ p2t_arg.p2at_node of
    | P2Tlist (npf1, p2ts) => (npf := npf1; p2ts)
    | _ => list_sing (p2t_arg) // HX: npf = -1
  ) : p2atlst // end of [val]
  val (pfenv | ()) = the_trans2_env_push ()
  val () = {
    val () = the_s2expenv_add_svarlst ($UT.lstord2list (p2t_arg.p2at_svs))
    val () = the_d2expenv_add_dvarlst ($UT.lstord2list (p2t_arg.p2at_dvs))
  } (* end of [val] *)
//
  val (pfinc | ()) = the_d2varlev_inc ()
//
  val d2e_body = let
    val isnone = wths1explst_is_none (w1ts)
  in
    if isnone
      then d1exp_tr (d1e_body) // HX: regular
      else d1exp_tr_wths1explst (d1e_body, w1ts)
    // end of [if]
  end : d2exp // end of [val]
//
  val () = the_d2varlev_dec (pfinc | (*none*))
//
  val () = the_trans2_env_pop (pfenv | (*none*))
//
// val p2ts_arg = lamvararg_proc (p2ts_arg) // HX-2010-08-26: for handling variadic functions
//
in
  @(npf, p2ts_arg, d2e_body)
end // end of [d1exp_tr_arg_body]

(* ****** ****** *)

fun
d1exp_tr_delay
  (d1e0: d1exp): d2exp = let
//
#define nil list_nil
#define cons list_cons
#define :: list_cons
//
val loc0 = d1e0.d1exp_loc
val-D1Edelay (lin, d1e) = d1e0.d1exp_node
//
in
//
case+ 0 of
| _ when lin = 0 => (
    d2exp_delay (loc0, d1exp_tr (d1e))
  ) // end of [_ when lin = 0]
| _ => ( // $ldelay: lin = 1
  case+ d1e.d1exp_node of
  | D1Elist (
      _(*npf*), d1es
    ) => (
    case+ d1es of
    | cons (
        d1e1, cons (d1e2, d1es)
      ) => let
        val d2e1 = d1exp_tr (d1e1)
        and d2e2 = d1exp_tr (d1e2)
      in
        d2exp_ldelay (loc0, d2e1, Some (d2e2))
      end // cons (_, cons (_, nil))
    | _ => (
        d2exp_ldelay_none (loc0, d1exp_tr (d1e))
      ) // end of [_]
    ) // end of [D1Elist]
  | _ => d2exp_ldelay_none (loc0, d1exp_tr (d1e))
  ) // end of [_]
//
end // end of [d1exp_tr_delay]

(* ****** ****** *)

fun i1nvarg_tr
  (x: i1nvarg): Option_vt (i2nvarg) = let
//
fun auxerr1 (x: i1nvarg): void = {
  val () = prerr_error2_loc (x.i1nvarg_loc)
  val () = filprerr_ifdebug ("i1nvarglst_tr")
  val () = prerr ": the dynamic identifier ["
  val () = $SYM.prerr_symbol (x.i1nvarg_sym)
  val () = prerr "] should refer to a variable but it does not."
  val () = prerr_newline ()
  val () = the_trans2errlst_add (T2E_i1nvarg_tr (x))
} // end of [auxerr1]
fun auxerr2 (x: i1nvarg): void = {
  val () = prerr_error2_loc (x.i1nvarg_loc)
  val () = filprerr_ifdebug ("i1nvarglst_tr")
  val () = prerr ": the dynamic identifier ["
  val () = $SYM.prerr_symbol (x.i1nvarg_sym)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
  val () = the_trans2errlst_add (T2E_i1nvarg_tr (x))
} // end of [auxerr2]
//
val ans = the_d2expenv_find x.i1nvarg_sym
//
in
//
case+ ans of
| ~Some_vt d2i => (case+ d2i of
  | D2ITMvar d2v => let
      val typ = (
        case+ x.i1nvarg_type of
        | Some s1e => let
            val s2e = s1exp_trdn_impred (s1e)
          in
            Some (s2e)
          end // end of [Some]
        | None () => None ()
      ) : s2expopt // end of [val]
      val arg = i2nvarg_make (d2v, typ)
    in
      Some_vt (arg)
    end // end of [D2ITEMvar]
  | _ => let
      val () = auxerr1 (x) in None_vt ()
    end // end of [_]
  ) // end of [Some_vt]
| ~None_vt () => let
    val () = auxerr2 (x) in None_vt ()
  end // end of [None_vt]
// end of [case]
end // end of [i1nvarg_tr]

fun
i1nvarglst_tr
  (xs: i1nvarglst): i2nvarglst = let
(*
  val () = print "i1nvarlst_tr: xs = "
  val () = fprint_i1nvarglst (stdout_ref, xs)
  val () = print_newline ()
*)
in
//
case+ xs of
| list_cons (x, xs) => let
    val opt = i1nvarg_tr (x) in case+ opt of
    | ~Some_vt (x) => list_cons (x, i1nvarglst_tr (xs))
    | ~None_vt () => i1nvarglst_tr (xs)
  end (* end of [list_cons] *)
| list_nil () => list_nil ()
//
end // end of [i1nvarglst_tr]

fun
i1nvresstate_tr
  (r1es: i1nvresstate): i2nvresstate = let
  val s2q = s1qualst_tr (r1es.i1nvresstate_qua)
  val body = i1nvarglst_tr (r1es.i1nvresstate_arg)
in
  i2nvresstate_make (s2q.s2qua_svs, s2q.s2qua_sps, body)
end // end of [i1nvresstate_tr]

fun
loopi1nv_tr
  (inv: loopi1nv): loopi2nv = let
  val loc = inv.loopi1nv_loc
  val s2q = s1qualst_tr (inv.loopi1nv_qua)
  val met = inv.loopi1nv_met
  val met = (
    case+ met of
    | Some s1es => let
        val s2es = s1explst_trdn_int s1es in Some (s2es)
      end // end of [Some]
    | None () => None ()
  ) : s2explstopt // end of [val]
  val arg = i1nvarglst_tr (inv.loopi1nv_arg)
  val res = i1nvresstate_tr (inv.loopi1nv_res)
in
  loopi2nv_make (loc, s2q.s2qua_svs, s2q.s2qua_sps, met, arg, res)
end // end of [loopi1nv_tr]

(* ****** ****** *)

fun
i1fcl_tr
  (ifcl: i1fcl): i2fcl = let
  val test = d1exp_tr(ifcl.i1fcl_test)
  val body = d1exp_tr(ifcl.i1fcl_body)
in
  i2fcl_make(ifcl.i1fcl_loc, test, body)
end // end of [i1fcl_tr]

fun
i1fclist_tr
  (xs: i1fclist): i2fclist =
(
  case+ xs of
  | list_cons (x, xs) =>
      list_cons (i1fcl_tr(x), i1fclist_tr(xs))
  | list_nil () => list_nil ()
) (* end of [i1fclist_tr] *)

(* ****** ****** *)

fun
gm1at_tr
(
  gm1t: gm1at
) : gm2at = let
  val d2e = d1exp_tr (gm1t.gm1at_exp)
  val p2topt = (
    case+ gm1t.gm1at_pat of
    | Some p1t => let
        val p2t = p1at_tr p1t
        val s2vs = $UT.lstord2list (p2t.p2at_svs)
        val () = the_s2expenv_add_svarlst s2vs
        val d2vs = $UT.lstord2list (p2t.p2at_dvs)
        val () = the_d2expenv_add_dvarlst d2vs
      in
        Some (p2t)
      end // end of [Some]
    | None () => None ()
  ) : p2atopt // end of [val]
in
  gm2at_make (gm1t.gm1at_loc, d2e, p2topt)
end // end of [gm1at_tr]

(* ****** ****** *)

fun
c1lau_tr{n:nat}
  (n: int n, c1l: c1lau): c2lau = let
//
fun auxerr
(
  c1l: c1lau, n: int, n1: int
) : void = let
  val () =
    prerr_error2_loc (c1l.c1lau_loc)
  // end of [val]
  val () = filprerr_ifdebug ("c1lau_tr")
  val () = prerr ": this clause should contain "
  val () = prerr_string (if n >= n1 then "more" else "fewer")
  val () = prerr " patterns."
  val () = prerr_newline ()
  val () = the_trans2errlst_add (T2E_c1lau_tr (c1l))
in
  // nothing
end // end of [auxerr]
//
val loc = c1l.c1lau_loc
val p1t = c1l.c1lau_pat
val p1ts =
(
  case+
  p1t.p1at_node of
  | P1Tlist (_(*npf*), p1ts) => p1ts | _ => list_sing (p1t)
) : p1atlst // end of [val]
val p2ts = p1atlst_tr (p1ts)
val np2ts = list_length (p2ts)
//
// HX-2016-05-13:
// See bug-2016-05-13.dats
// Fixing a bug with empty match p2atlst
//
val p2ts = (
//
if
np2ts > 0
then p2ts
else let
//
val p2t0 = p2at_any(loc)
//
in
  list_cons(p2t0, list_nil())
end // end of [if]
//
) : p2atlst
//
val np2ts =
  (if np2ts > 0 then np2ts else 1): int
//
(*
val () =
(
  printf ("c1lau_tr: n = %i and n1 = %i\n", @(n, n1))
) // end of [val]
*)
//
val () =
if n != np2ts then
  auxerr(c1l, n, np2ts)
// end of [ifthen]
//
val (pfenv | ()) =
  the_trans2_env_push()
//
val () = let
  val s2vs = $UT.lstord2list(p2atlst_svs_union(p2ts))
in
  the_s2expenv_add_svarlst (s2vs)
end // end of [val]
val () = let
  val d2vs = $UT.lstord2list (p2atlst_dvs_union(p2ts))
in
  the_d2expenv_add_dvarlst (d2vs)
end // end of [val]
//
val gua = c1l.c1lau_gua
val gua =
  l2l (list_map_fun(gua, gm1at_tr))
//
val body = d1exp_tr (c1l.c1lau_body)
//
val () = the_trans2_env_pop (pfenv | (*none*))
//
in
  c2lau_make (loc, p2ts, gua, c1l.c1lau_seq, c1l.c1lau_neg, body)
end // end of [c1lau_tr]

fun c1laulst_tr {n:nat}
  (n: int n, c1ls: c1laulst): c2laulst = (
  case+ c1ls of
  | list_cons (c1l, c1ls) =>
      list_cons (c1lau_tr (n, c1l), c1laulst_tr (n, c1ls))
  | list_nil () => list_nil ()
) // end of [c1laulst_tr]

(* ****** ****** *)

fun sc1lau_trdn (
  sc1l: sc1lau, s2t_pat: s2rt
) : sc2lau = let
  val sp1t = sc1l.sc1lau_pat
  val (pfenv | ()) = the_s2expenv_push_nil ()
  val sp2t = sp1at_trdn (sp1t, s2t_pat)
  val () = the_s2expenv_add_sp2at (sp2t)
  val body = d1exp_tr (sc1l.sc1lau_body)
  val () = the_s2expenv_pop_free (pfenv | (*none*))  
in
  sc2lau_make (sc1l.sc1lau_loc, sp2t, body)
end // end of [sc1lau_tr]

fun sc1laulst_trdn (
  xs: sc1laulst, s2t: s2rt
) : sc2laulst = (
  case+ xs of
  | list_cons (x, xs) =>
      list_cons (sc1lau_trdn (x, s2t), sc1laulst_trdn (xs, s2t))
  | list_nil () => list_nil ()
) // end of [sc1laulst_trdn]

(* ****** ****** *)

local

vtypedef
sc2laulst_vt = List_vt (sc2lau)

fun
sc2lau_get_dstag
  .<>.
(
  sc2l: sc2lau
) :<> int = let
  val sp2t = sc2l.sc2lau_pat
in
  case+ sp2t.sp2at_node of
  | SP2Tcon (s2c, _) =>
      $effmask_all (s2cst_get_dstag (s2c))
  | SP2Terr () => ~1 (*err*)
end // end of [sc2lau_get_dstag]

fun auxerr_lt
  (loc0: location, sc2l: sc2lau): void = let
  val loc = sc2l.sc2lau_loc
  val () = prerr_error2_loc (loc)
  val () = prerr ": the static clause is repeated."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_sc2laulst_coverck_repeat (loc0, sc2l))
end // end of [auxerr_lt]

fun auxerr_gts (
  loc0: location, s2cs: s2cstlst, n: int, tag: int
) : void = let
in
//
if n < tag then (
  case+ s2cs of
  | list_cons (s2c, s2cs) => (
      if n > 0 then
        auxerr_gts (loc0, s2cs, n-1, tag-1)
      else let
        val () = prerr_error2_loc (loc0)
        val () = prerr ": the static clause associated with ["
        val () = prerr_s2cst (s2c)
        val () = prerr "] is missing."
        val () = prerr_newline ()
        val () = 
          the_trans2errlst_add (T2E_sc2laulst_coverck_missing (loc0, s2c))
        // end of [val]
      in
        auxerr_gts (loc0, s2cs, 0, tag-1)
      end // end of [if]
    ) // end of [list_cons]
  | list_nil () => ()
) else () // end of [if]
//
end // end of [auxerr_gts]

fun auxmain1 (
  loc0: location
, sc2ls: sc2laulst
, s2td_pat: s2rtdat
) : void = let
  val
  sc2ls2 =
    list_copy (sc2ls)
  val
  sc2ls2 = let
    var !p_clo = @lam
    (
      x1: &sc2lau, x2: &sc2lau
    ) : int =<clo> sc2lau_get_dstag (x1) - sc2lau_get_dstag (x2)
  in
    list_vt_mergesort (sc2ls2, !p_clo)
  end // end of [val]
  val () = auxmain2 (loc0, sc2ls2, s2td_pat)
in
  // empty
end // end of [auxmain1]

and auxmain2 (
  loc0: location
, sc2ls: List_vt (sc2lau)
, s2td_pat: s2rtdat
) : void = let
//
fun loop (
  loc0: location
, sc2ls: sc2laulst_vt, s2cs: s2cstlst, n: int
) : void = let
in
//
case+ sc2ls of
| ~list_vt_cons
    (sc2l, sc2ls) => let
    val tag = sc2lau_get_dstag (sc2l)
  in
    if tag >= 0 then (
      if tag < n then let
        val () = auxerr_lt (loc0, sc2l)
      in
        loop (loc0, sc2ls, s2cs, n)
      end else let
        val () = auxerr_gts (loc0, s2cs, n, tag)
      in
        loop (loc0, sc2ls, s2cs, tag+1)
      end // end of [if]
    ) else
      loop (loc0, sc2ls, s2cs, n) // skipping SP2Terr 
    // end of [if]
  end // end of [list_vt_cons]
| ~list_vt_nil () => let
    val ns2cs = list_length (s2cs)
  in
    auxerr_gts (loc0, s2cs, n, ns2cs)
  end // end of [list_vt_nil]
end // end of [loop]
//
val s2cs = s2rtdat_get_sconlst (s2td_pat)
//
in
  loop (loc0, sc2ls, s2cs, 0)
end // end of [auxmain2]

in (* in of [local] *)

implement
sc2laulst_coverck
  (loc0, sc2ls, s2t_pat) = let
//
fun
auxerr1 (
  loc0: location, s2t_pat: s2rt
) : void = let
  val () = prerr_error2_loc (loc0)
  val () =
  prerr ": the static expression being analyzed is of the sort ["
  val () = prerr_s2rt (s2t_pat)
  val () = prerrln! ("], which is not a base sort as is required.")
in
  the_trans2errlst_add (T2E_sc2laulst_coverck_sort (loc0, s2t_pat))
end // end of [auxerr1]
fun
auxerr2 (
  loc0: location, s2t_pat: s2rt
) : void = let
  val () = prerr_error2_loc (loc0)
  val () =
  prerr ": the static expression being analyzed is of the sort ["
  val () = prerr_s2rt (s2t_pat)
  val () = prerrln! ("], which is not a datasort as is required.")
in
  the_trans2errlst_add (T2E_sc2laulst_coverck_sort (loc0, s2t_pat))
end // end of [auxerr2]
//
in
//
case s2t_pat of
| S2RTbas s2tb => (
    case+ s2tb of
    | S2RTBASdef s2td => auxmain1 (loc0, sc2ls, s2td)
    | _ (*non-S2RTBASdef*) => auxerr2 (loc0, s2t_pat)
  ) (* end of [S2RTbas] *)
| _(*non-S2RTbas*) => auxerr1 (loc0, s2t_pat)
//
end // end of [sc2laulst_coverck]

end // end of [local]

(* ****** ****** *)
//
fun
un_d1exp_sing
  (d1e: d1exp): d1exp =
(
//
case+ d1e.d1exp_node of
| D1Esing(d1e) => un_d1exp_sing(d1e) | _ => d1e
//
) (* end of [un_d1exp_sing] *)
//
(* ****** ****** *)

implement
d1exp_tr (d1e0) = let
  val loc0 = d1e0.d1exp_loc
//
(*
fun
aux_d2e2i
(d2e: d2exp): int =
(
case+
d2e.d2exp_node of
//
| D2Eint (i) => i
//
| D2Ei0nt (x) => let
    val-$LEX.T_INT
      (base, rep, sfx) = x.token_node
  in
    $UN.cast2int($UT.llint_make_string(rep))
  end // end of [D2Ei0nt]
| _(*rest-of-D2E*) => (~1)
) (* end of [aux_d2e2i] *)
*)
(*
//
val () = println! ("d1exp_tr: d1e0 = ", d1e0)
//
*)
in
//
case+
d1e0.d1exp_node of
//
| D1Eide
    (id) => let
    val dq = $SYN.the_d0ynq_none
  in
    d1exp_tr_dqid (d1e0, dq, id)
  end // end of [D1Eide]
| D1Edqid
    (dq, id) =>
    d1exp_tr_dqid (d1e0, dq, id)
//
| D1Eint (i) => d2exp_int (loc0, i)
| D1Eintrep
    (rep) => d2exp_intrep (loc0, rep)
//
| D1Ebool (b) => d2exp_bool (loc0, b)
| D1Echar (c) => d2exp_char (loc0, c)
//
| D1Efloat
    (rep) => d2exp_float (loc0, rep)
| D1Estring
    (str) => d2exp_string (loc0, str)
//
| D1Ei0nt (x) => d2exp_i0nt (loc0, x)
| D1Ec0har (x) => d2exp_c0har (loc0, x)
| D1Ef0loat (x) => d2exp_f0loat (loc0, x)
| D1Es0tring (x) => d2exp_s0tring (loc0, x)
//
| D1Ecstsp
    (csp) => d2exp_cstsp (loc0, csp)
  // end of [D1Ecstsp]
//
| D1Eliteral
    (d1e) =>
    d2exp_literal(loc0, d1exp_tr(d1e))
  // end of [D1Eliteral]
//
| D1Etop () => d2exp_top (loc0)
| D1Eempty () => d2exp_empty (loc0)
//
| D1Eextval
    (s1e, name) => let
    val s2e =
      s1exp_trdn_vt0ype (s1e)
    // end of [val]
  in
    d2exp_extval (loc0, s2e, name)
  end (* end of [D1Eextval] *)
//
| D1Eextfcall
    (s1e, _fun, _arg) => let
    val s2e = s1exp_trdn_vt0ype (s1e)
    val _arg = d1explst_tr (_arg)
  in
    d2exp_extfcall (loc0, s2e, _fun, _arg)
  end (* end of [D1Eextfcall] *)
| D1Eextmcall
  (
    s1e, _obj, _mtd, _arg
  ) => let
    val s2e =
      s1exp_trdn_vt0ype (s1e)
    // end of [val]
    val _obj = d1exp_tr (_obj)
    val _arg = d1explst_tr (_arg)
  in
    d2exp_extmcall (loc0, s2e, _obj, _mtd, _arg)
  end (* end of [D1Eextmcall] *)
//
| D1Eloopexn (knd) => d2exp_loopexn (loc0, knd)
//
| D1Efoldat (s1as, d1e) => let
    val d1e = un_d1exp_sing (d1e)
    val s2as = s1exparglst_tr (s1as) in
    d2exp_foldat (loc0, s2as, d1exp_tr (d1e))
  end // end of [D1Efoldat]
| D1Efreeat (s1as, d1e) => let
    val d1e = un_d1exp_sing (d1e)
    val s2as = s1exparglst_tr (s1as) in
    d2exp_freeat (loc0, s2as, d1exp_tr (d1e))
  end // end of [D1Efreeat]
//
| D1Etmpid (qid, t1mas) => let
    val q = qid.dqi0de_qua
    and id = qid.dqi0de_sym
    val d2e_qid = d1exp_tr_dqid (d1e0, q, id)
    val t2mas = t1mpmarglst_tr (t1mas)
  in
    d2exp_tmpid (loc0, d2e_qid, t2mas)
  end // end of [D1Etmpid]
//
| D1Elet (d1cs, d1e) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d1exp_tr (d1e)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_let (loc0, d2cs, d2e)
  end // end of [D1Elet]
| D1Ewhere (d1e, d1cs) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d1exp_tr (d1e)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_where (loc0, d2e, d2cs)
  end // end of [D1Ewhere]
| D1Edecseq (d1cs) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d2exp_empty (loc0)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_let (loc0, d2cs, d2e)
  end // end of [D1Edecseq]
//
| D1Eapp_dyn
  (
    d1e1, locarg, npf, darg
  ) => (
    case+ d1e1.d1exp_node of
    | D1Eapp_sta
        (d1e2, sarg) =>
      d1exp_tr_app_sta_dyn (
        d1e0, d1e1, d1e2, sarg, locarg, npf, darg
      ) // end of [D1Eapp_sta]
    | _ => d1exp_tr_app_dyn (d1e0, d1e1, locarg, npf, darg)
  ) // end of [D1Eapp_dyn]
| D1Eapp_sta
    (d1e1, sarg) => let
    val locarg = loc0 // HX: it is just a dummy
  in
    d1exp_tr_app_sta_dyn (
      d1e0, d1e0, d1e1, sarg, locarg, ~2(*fake*), list_nil(*darg*)
    ) // end of [d1exp_tr_app_sta_dyn]
  end // end of [D1Eapp_sta]
//
| D1Esing (d1e) => d2exp_sing(loc0, d1exp_tr (d1e))
//
| D1Elist
  (
    npf, d1es
  ) => (
  case+ d1es of
  | list_cons _ => let
      val d2es = d1explst_tr (d1es) in d2exp_list (loc0, npf, d2es)
    end // end of [list_cons]
  | list_nil () => d2exp_empty (loc0)
  ) // end of [D1Elist]  
//
| D1Eifhead
  (
    r1es, _cond, _then, _else
  ) => let
    val r2es = i1nvresstate_tr r1es
    val _cond = d1exp_tr (_cond)
    val _then = d1exp_tr (_then)
    val _else = d1expopt_tr (_else)
  in
    d2exp_ifhead (loc0, r2es, _cond, _then, _else)
  end // end of [D1Eifhead]
| D1Esifhead
  (
    r1es, _cond, _then, _else
  ) => let
    val r2es = i1nvresstate_tr (r1es)
    val _cond = s1exp_trdn_bool (_cond)
    val _then = d1exp_tr (_then) and _else = d1exp_tr (_else)
  in
    d2exp_sifhead (loc0, r2es, _cond, _then, _else)
  end // end of [D1Eifhead]
//
| D1Eifcasehd
    (r1es, ifcls) => let
    val r2es =
      i1nvresstate_tr(r1es)
    // end of [val]
    val ifcls = i1fclist_tr (ifcls)
  in
    d2exp_ifcasehd (loc0, r2es, ifcls)
  end // end of [D1Eifcasehd]
//
| D1Ecasehead
  (
    knd, r1es, d1es, c1ls
  ) => let
    val r2es =
      i1nvresstate_tr (r1es)
    val d2es = d1explst_tr (d1es)
    val ntup = list_length (d2es)
//
// HX-2016-05-13:
// See bug-2016-05-13.dats
// Fixing a bug with empty match d2explst
//
    val d2es =
    (
      if ntup > 0
        then d2es
        else let
          val d2e0 = d2exp_empty(loc0)
        in
          list_cons(d2e0, list_nil(*none*))
        end // end of [if]
    ) : d2explst
    val ntup =
    (
      if (ntup > 0) then ntup else 1
    ) : intGte(1) // end of [val]
//
    val c2ls = c1laulst_tr (ntup, c1ls)
//
  in
    d2exp_casehead (loc0, knd, r2es, d2es, c2ls)
  end // end of [D1Ecasehead]
| D1Escasehead
  (
    r1es, s1e, sc1ls
  ) => let
    val r2es = i1nvresstate_tr (r1es)
    val s2e = s1exp_trup (s1e)
    val s2t_pat = s2e.s2exp_srt
    val sc2ls = sc1laulst_trdn (sc1ls, s2t_pat)
    val () =
      sc2laulst_coverck (loc0, sc2ls, s2t_pat) // FIXME!!!
    // end of [val]
  in
    d2exp_scasehead (loc0, r2es, s2e, sc2ls)
  end // end of [D1Escasehead]
//
| D1Elst
  (
    lin, s1eopt, d1es
  ) => let
    val opt =
    (
    case+ s1eopt of
    | Some s1e => let
        val s2e = (
          case+ lin of 
          | 0 => s1exp_trdn_t0ype (s1e)
          | 1 => s1exp_trdn_vt0ype (s1e)
          | _ => s1exp_trdn_impred (s1e) // unspecified
        ) : s2exp // end of [val]
      in
        Some (s2e)
      end // end of [Some]
    | None () => None ()
    ) : s2expopt // end of [val]
    val d2es = d1explst_tr (d1es)
  in
    d2exp_lst (loc0, lin, opt, d2es)
  end // end of [D1Elst]
//
| D1Etup
  (
    tupknd, npf, d1es
  ) => let
  in
    d2exp_tup (loc0, tupknd, npf, d1explst_tr d1es)
  end // end of [D1Etup]
| D1Erec
  (
    recknd, npf, ld1es
  ) => let
    val ld2es =
      list_map_fun (ld1es, labd1exp_tr)
    // end of [val]
  in
    d2exp_rec (loc0, recknd, npf, (l2l)ld2es)
  end // end of [D1Erec]
//
| D1Eseq d1es => let
    val d2es = d1explst_tr (d1es) in d2exp_seq2 (loc0, d2es)
  end // end of [D1Eseq]
//
| D1Earrsub
    (arr, locind, ind) => let
  in
    d1exp_tr_arrsub (d1e0, arr, locind, ind)
  end // end of [D1Earrsub]
| D1Earrpsz
    (elt, init) => let
    val opt = s1expopt_trup (elt)
    val opt =
    (
      case+ opt of
      | Some s2e => Some (s2e) | None () => None ()
    ) : s2expopt
    val init = d1explst_tr (init)
  in
    d2exp_arrpsz (loc0, opt, init)
  end // end of [D1Earrpsz]
//
| D1Earrinit
  (
    s1e_elt, asz, init
  ) => let
    val s2t_elt =
    (
      case+ asz of
      | Some _ => (
          case+ init of
          | list_cons _ => s2rt_t0ype // cannot be linear
          | list_nil ((*uninitized*)) => s2rt_vt0ype // can be linear
        ) (* end of [Some] *)
      | None _ => s2rt_vt0ype // can be linear
    ) : s2rt // end of [val]
    val s2e_elt = s1exp_trdn (s1e_elt, s2t_elt)
    val asz = d1expopt_tr (asz)
    val init = d1explst_tr (init)
  in
    d2exp_arrinit (loc0, s2e_elt, asz, init)
  end // end of [D1Earrinit]
//
| D1Eptrof (d1e) => let
    val d1e = un_d1exp_sing (d1e)
  in
    d2exp_ptrof (loc0, d1exp_tr (d1e))
  end // end of [D1Eptrof]
//
| D1Eviewat (d1e) => let
    val d1e = un_d1exp_sing (d1e)
  in
    d2exp_viewat (loc0, d1exp_tr (d1e))
  end // end of [D1Eviewat]
//
| D1Eselab
    (knd, d1e, d1l) => let
    val d2e = d1exp_tr(d1e)
    val d2l = d1lab_tr(d1l)
  in
    if knd = 0
      then ( // [.]
      case+
      d2e.d2exp_node
      of // case+
      | D2Eselab
          (d2e_root, d2ls) =>
        (
          d2exp_sel_dot(loc0, d2e_root, l2l(list_extend (d2ls, d2l)))
        ) (* end of [D2Eselab] *)
      | _ (*non-D2Eselab*) => d2exp_sel_dot(loc0, d2e, list_sing (d2l))
    ) else let
      val d2s = d2sym_bang(d1e)
    in
      d2exp_sel_ptr(loc0, d2s, d2e, d2l) // [->]
    end (* end of [if] *)
  end (* end of [D1Eselab] *)
//
| D1Eraise
    (d1e_exn) => let
    val d1e_exn =
      un_d1exp_sing (d1e_exn)
    // end of [val]
  in
    d2exp_raise (loc0, d1exp_tr(d1e_exn))
  end // end of [D1Eraise]
//
| D1Eeffmask
    (efc, d1e_body) => let
    val s2fe = effcst_tr(efc)
    val d1e_body =
      un_d1exp_sing (d1e_body)
    // end of [val]
    val d2e_body = d1exp_tr (d1e_body)
  in
    d2exp_effmask (loc0, s2fe, d2e_body)
  end // end of [D1Eeffmask]
//
| D1Eshowtype
    (d1e) => let
    val d1e = un_d1exp_sing(d1e)
  in
    d2exp_showtype (loc0, d1exp_tr(d1e))
  end // end of [D1Eshowtype]
//
| D1Evcopyenv
    (knd, d1e) => let
    val d1e = un_d1exp_sing(d1e)
  in
    d2exp_vcopyenv (loc0, knd, d1exp_tr d1e)
  end // end of [D1Evcopyenv]
//
| D1Etempenver
    (d1e) => let
//
    fun auxlst
    (
      d2es: d2explst
    ) : d2varlst =
    (
      case+ d2es of
      | list_nil ((*void*)) => list_nil ()
      | list_cons (d2e, d2es) => auxlst2 (d2e, d2es)
    ) (* end of [auxlst] *)
//
    and auxlst2
    (
      d2e: d2exp, d2es: d2explst
    ) : d2varlst =
    (
      case+
      d2e.d2exp_node of
      | D2Evar (d2v) =>
          list_cons(d2v, auxlst(d2es))
        // end of [D2Evar]
      | _(*non-D2Evar*) => auxlst(d2es)
    ) (* end of [auxlst2] *)
//
    val d2e = d1exp_tr (d1e)
//
    val d2vs =
    (
      case+
      d2e.d2exp_node of
      | D2Evar (d2v) => list_sing(d2v)
      | D2Esing (d2e) =>
          auxlst2(d2e, list_nil(*void*))
        // end of [D2Esing]
      | D2Elist
          (_(*npf*), d2es) => auxlst (d2es)
        // end of [D2Elist]
      | _(*rest-of-d2exp*) => list_nil(*void*)
    ) : d2varlst // end of [val]
  in
    d2exp_tempenver (loc0, d2vs)
  end // end of [D1Etempenver]
//
| D1Eexist (s1a, d1e) => let
    val s2a = s1exparg_tr(s1a)
    val d1e = un_d1exp_sing(d1e)
  in
    d2exp_exist (loc0, s2a, d1exp_tr(d1e))
  end // end of [D1Eexist]
//
| D1Elam_dyn
  (
    lin, p1t_arg, d1e_body
  ) => let
    val @(
      npf, p2ts_arg, d2e_body
    ) =
      d1exp_tr_arg_body (p1t_arg, d1e_body)
    // end of [val]
  in
    d2exp_lam_dyn (loc0, lin, npf, p2ts_arg, d2e_body)
  end // end of [D1Elam_dyn]
| D1Elaminit_dyn
  (
    lin, p1t_arg, d1e_body
  ) => let
    val @(npf, p2ts_arg, d2e_body) = d1exp_tr_arg_body (p1t_arg, d1e_body)
  in
    d2exp_laminit_dyn (loc0, lin, npf, p2ts_arg, d2e_body)
  end // end of [D1Elam_dyn]
| D1Elam_met
    (locarg, met, body) => let
    val met = s1explst_trup (met)
    val body = d1exp_tr (body)
  in
    d2exp_lam_met_new (loc0, met, body)
  end (* end of [D1Elam_met] *)
| D1Efix
  (
    knd, id, d1e_body
  ) => let
    val d2v =
      d2var_make (id.i0de_loc, id.i0de_sym)
    // end of [val]
    val () = d2var_set_isfix (d2v, true)
    val (pfenv | ()) = the_d2expenv_push_nil ()
    val () = the_d2expenv_add_dvar (d2v)
    val d2e_body = d1exp_tr (d1e_body)
    val () = the_d2expenv_pop_free (pfenv | (*none*))
  in
    d2exp_fix (loc0, knd, d2v, d2e_body)
  end // end of [D1Efix]
//
| D1Elam_sta_syn
  (
    _(*locarg*), s1qs, d1e
  ) => let
    val (pfenv | ()) = the_s2expenv_push_nil ()
    val s2q = s1qualst_tr (s1qs)
    val d2e = d1exp_tr (d1e)
    val () = the_s2expenv_pop_free (pfenv | (*none*))
  in
    d2exp_lam_sta (loc0, s2q.s2qua_svs, s2q.s2qua_sps, d2e)
  end // end of [D1Elam_sta_syn]
//
| D1Edelay _ => d1exp_tr_delay (d1e0)
//
| D1Ewhile
  (
    i1nv, d1e_test, d1e_body
  ) => let
    val (pfenv | ()) = the_s2expenv_push_nil ()
    val i2nv = loopi1nv_tr (i1nv)
    val d2e_test = d1exp_tr (d1e_test)
    val d2e_body = d1exp_tr (d1e_body)
    val () = the_s2expenv_pop_free (pfenv | (*none*))
  in
    d2exp_while (loc0, i2nv, d2e_test, d2e_body)
  end // end of [D1Ewhile]
//
| D1Efor
  (
    i1nv, init, test, post, body
  ) => let
    val init = d1exp_tr (init)
    val (pfenv | ()) = the_s2expenv_push_nil ()
    val i2nv = loopi1nv_tr (i1nv)
    val test = (
      case+ test.d1exp_node of
      | D1Eempty () => d2exp_bool (loc0, true) | _ => d1exp_tr test
    ) : d2exp // end of [val]
    val post = d1exp_tr (post)
    val body = d1exp_tr (body)
    val () = the_s2expenv_pop_free (pfenv | (*none*))
  in
    d2exp_for (loc0, i2nv, init, test, post, body)
  end // end of [D1Efor]
//
| D1Etrywith
    (r1es, d1e, c1ls) => let
    val r2es = i1nvresstate_tr (r1es)
    val d2e = d1exp_tr (d1e)
    val c2ls = c1laulst_tr (1(*npat*), c1ls)
  in
    d2exp_trywith (loc0, r2es, d2e, c2ls)
  end // end of [D1Etrywith]
//
| D1Eann_type
    (d1e, s1e) => let
    val d2e = d1exp_tr (d1e)
    val s2e = s1exp_trdn_impred (s1e)
  in
    d2exp_ann_type (loc0, d2e, s2e)
  end // end of [D1Eann_type]
| D1Eann_effc
    (d1e, efc) => let
    val d2e = d1exp_tr (d1e)
    val s2fe = effcst_tr (efc)
  in
    d2exp_ann_seff (loc0, d2e, s2fe)
  end // end of [D1Eann_effc]
| D1Eann_funclo
    (d1e, funclo) => let
    val d2e = d1exp_tr (d1e)
  in
    d2exp_ann_funclo (loc0, d2e, funclo)
  end // end of [D1Eann_funclo]
//
| D1Emacsyn _ => d1exp_tr_macsyn (d1e0)
| D1Emacfun _ => d1exp_tr_macfun (d1e0)
//
| D1Esolassert(d1e) =>
    d2exp_solassert(loc0, d1exp_tr(d1e))
  // end of [D1Esolassert]
| D1Esolverify(s1e) =>
    d2exp_solverify(loc0, s1exp_trdn(s1e, s2rt_prop))
  // end of [D1Esolverify]
//
| D1Eerrexp((*void*)) => d2exp_errexp (loc0)
//
| D1Eidextapp
    (id, d1es) => let
    val () = prerr_error2_loc(loc0)
    val () = prerr ": the external id ["
    val () = $SYM.prerr_symbol (id)
    val () = prerr "] cannot be handled."
    val () = prerr_newline ((*void*))
    val () = the_trans2errlst_add (T2E_d1exp_tr (d1e0))
  in
    d2exp_errexp (loc0)
  end // end of [_]
//
| D1Esexparg _ => let
    val () = prerr_error2_loc(loc0)
    val () = prerr ": this form of expression is only allowed to occur as an argument."
    val () = prerr_newline ((*void*))
    val () = the_trans2errlst_add (T2E_d1exp_tr (d1e0))
  in
    d2exp_errexp (loc0)
  end // end of [D1Esexparg]
//
// (*
| _ (*unsupported*) => let
    val () = prerr_interror_loc (loc0)
    val () = filprerr_ifdebug "d1exp_tr"
    val () = prerrln! (": not yet implemented: d1e0 = ", d1e0)
  in
    $ERR.abort_interr{d2exp}((*reachable*))
  end // end of [_(*unsupported*)]
// *)
//
end // end of [let] // end of [d1exp_tr]

(* ****** ****** *)

implement
d1explst_tr (d1es) = l2l (list_map_fun (d1es, d1exp_tr))

implement
d1expopt_tr (d1eopt) =
(
case+ d1eopt of
| Some (d1e) => Some (d1exp_tr (d1e)) | None () => None ()
) (* end of [d1expopt_tr] *)

(* ****** ****** *)

implement
labd1exp_tr (ld1e) = let
  val+$SYN.DL0ABELED (l, d1e) = ld1e in labd2exp_make (l, d1exp_tr (d1e))
end // end of [labd0exp_tr]

(* ****** ****** *)

implement
d1lab_tr (d1l0) = let
//
val loc0 = d1l0.d1lab_loc
//
in
//
case+
d1l0.d1lab_node of
| D1LABlab (lab) => let
    val dotid =
      $LAB.label_dotize (lab)
    // end of [dotid]
    val ans = the_d2expenv_find (dotid)
    val opt = (
      case+ ans of
      | ~Some_vt (d2i) =>
        (
          case+ d2i of
          | D2ITMsymdef
              (sym, xs) =>
            (
              case+ xs of
              | list_nil () => None ()
              | list_cons _ => let
                  val dq = $SYN.the_d0ynq_none
                  val d2s = d2sym_make (loc0, dq, dotid, xs)
                in
                  Some (d2s)
                end // end of [list_cons]
            ) (* D2ITMsymdef *)
          | _ (*non-symdef*) => None ()
        ) (* end of [some_vt] *)
      | ~None_vt ((*void*)) => None ()
    ) : d2symopt // end of [val]
  in
    d2lab_lab (loc0, lab, opt)
  end // end of [d1lab_tr]
| D1LABind (ind) => d2lab_ind (loc0, d1explst_tr (ind))
//
end // end of [d1lab_tr]

(* ****** ****** *)
//
// HX: it is declared in [pats_trans3_env.sats]
//
extern
fun
s2exp_tmp_instantiate_tmpmarglst
(
  s2f: s2exp
, locarg: loc_t, s2qs: s2qualst, t2mas: t2mpmarglst, err: &int
) : (s2exp(*res*), t2mpmarglst) = "ext#patsopt_s2exp_tmp_instantiate_tmpmarglst"
//
implement
S1Ed2ctype_tr(d2ctp) = let
//
val d2e0 =
  d1exp_tr($UN.cast{d1exp}(d2ctp))
//
fun
auxerr_cst
(
  d2c: d2cst
) :<cloref1> void =
{
  val () =
  prerr_error2_loc (d2e0.d2exp_loc)
  val () = filprerr_ifdebug "S1Ed2ctype_tr"
  val () =
  prerrln! (": the dynamic constant [", d2c, "] should be instantiated.")
  val () = the_trans2errlst_add (T2E_S1Ed2ctype_tr(d2ctp))
}
//
fun
auxerr1_tmpid
(
  d2e_id: d2exp
) :<cloref1> void =
{
  val () =
  prerr_error2_loc (d2e_id.d2exp_loc)
  val () = filprerr_ifdebug "S1Ed2ctype_tr"
  val () =
  prerrln! (": a declared dynamic constant is expected instead of [", d2e_id, "].")
}
fun
auxerr2_tmpid
(
  d2e_id: d2exp, d2c: d2cst
) :<cloref1> void =
{
  val () =
  prerr_error2_loc (d2e_id.d2exp_loc)
  val () = filprerr_ifdebug "S1Ed2ctype_tr"
  val () =
  prerrln! (": the dynamic constant [", d2c, "] is required to be be fully instantiated.")
  val () = the_trans2errlst_add (T2E_S1Ed2ctype_tr(d2ctp))
}
//
in
//
case+
d2e0.d2exp_node
of (* cast+ *)
//
| D2Ecst(d2c) => let
    val
    istmp = d2cst_is_tmpcst(d2c)
    val () =
    if istmp then auxerr_cst(d2c)
  in
    d2cst_get_type(d2c)
  end // end of [D2Ecst]
//
| D2Etmpid
    (d2e_id, t2mas) => (
    case+
    d2e_id.d2exp_node
    of (* case+ *)
    | D2Ecst (d2c) => let
        val
        loc0 = d2e0.d2exp_loc
        val
        locarg =
        $LOC.location_rightmost(loc0)
        val s2e = d2cst_get_type(d2c)
        val s2qs = d2cst_get_decarg (d2c)
        val s2e_d2c = d2cst_get_type (d2c)
//
        var err: int = 0
        val (s2e_tmp, t2mas2) =
        s2exp_tmp_instantiate_tmpmarglst(s2e_d2c, locarg, s2qs, t2mas, err)
//
        val sgn =
        list_length_compare(t2mas, t2mas2)
        val ((*check*)) =
        if sgn < 0 then auxerr2_tmpid(d2e_id, d2c) // partial instantiation
//
      in
        s2e_tmp
      end // end of [D2Ecst]
    | _ (*non-D2Ecst*) => let
        val () = auxerr1_tmpid(d2e_id) in s2exp_s2rt_err()
      end // end of [non-D2Ecst]
  ) (* end of [D2Etmpid] *)
//
| _(*rest-of-d2exp*) => let
    val () =
    prerr_error2_loc (d2e0.d2exp_loc)
    val () = filprerr_ifdebug "S1Ed2ctype_tr"
    val () =
    println! (": [$d2ctype] can only be applied to a declared dynamic constant.")
    val () = the_trans2errlst_add (T2E_S1Ed2ctype_tr(d2ctp))
  in
    s2exp_s2rt_err((*error*))
  end // end of [rest-d2exp]
//
end // end of [S1Ed2ctype_tr]

(* ****** ****** *)

(* end of [pats_trans2_dynexp.dats] *)
