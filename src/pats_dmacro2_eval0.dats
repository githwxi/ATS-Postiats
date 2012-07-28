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
// Start Time: July, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_dmacro2_eval0"

(* ****** ****** *)
(*
** for T_* constructors
*)
staload LEX = "pats_lexing.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

staload "pats_dmacro2.sats"

(* ****** ****** *)
//
// HX: not qualified dynamic symbol
//
fun
d2sym_is_nonqua .<>.
  (d2s: d2sym): bool = let
  val q = d2s.d2sym_qua in
  case+ q.d0ynq_node of $SYN.D0YNQnone () => true | _ => false
end // end of [d2sym_is_nonqua]

(* ****** ****** *)

extern
fun eval0_app_sym (
  loc0: location
, sym: symbol, ctx: !evalctx, env: &alphenv, d2as: d2exparglst
) : m2val // end of [eval0_app_sym]

(* ****** ****** *)

fn eval0_app_cmp_int (
  loc0: location, m2v1: m2val, m2v2: m2val
) : Sgn = let
//
fun auxerr (
  loc0: location
, m2v1: m2val, m2v2: m2val
) : Sgn = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": values are compared that do not support comparison."
  val () = prerr_newline ()
  val () = the_trans3errlst_add (T3E_dmacro_eval0_cmp (loc0, m2v1, m2v2))
in
  0(*meaningless*)
end // end of [auxerr]
//
in
//
case+ m2v1 of
| M2Vint (i1) => (
  case+ m2v2 of
  | M2Vint (i2) =>
      compare_int_int (i1, i2)
  | _ =>
      auxerr (loc0, m2v1, m2v2)
    // end of [_]
  ) // end of [M2Vint]
| _ => auxerr (loc0, m2v1, m2v2)
//
end // end of [eval0_app_cmp_int]

fun eval0_app_lt (
  loc0: location, m2v1: m2val, m2v2: m2val
) : m2val = let
  val sgn = eval0_app_cmp_int (loc0, m2v1, m2v2)
in
  if sgn < 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_lt]

fun eval0_app_lte (
  loc0: location, m2v1: m2val, m2v2: m2val
) : m2val = let
  val sgn = eval0_app_cmp_int (loc0, m2v1, m2v2)
in
  if sgn <= 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_lte]

fun eval0_app_gt (
  loc0: location, m2v1: m2val, m2v2: m2val
) : m2val = let
  val sgn = eval0_app_cmp_int (loc0, m2v1, m2v2)
in
  if sgn > 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_gt]

fun eval0_app_gte (
  loc0: location, m2v1: m2val, m2v2: m2val
) : m2val = let
  val sgn = eval0_app_cmp_int (loc0, m2v1, m2v2)
in
  if sgn >= 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_gte]

fun eval0_app_eq (
  loc0: location, m2v1: m2val, m2v2: m2val
) : m2val = let
  val sgn = eval0_app_cmp_int (loc0, m2v1, m2v2)
in
  if sgn = 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_eq]

fun eval0_app_neq (
  loc0: location, m2v1: m2val, m2v2: m2val
) : m2val = let
  val sgn= eval0_app_cmp_int (loc0, m2v1, m2v2)
in
  if sgn != 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_neq]

(* ****** ****** *)

fun eval0_app_eval (
  loc0: location, m2v: m2val
) : m2val = let
//
fun auxerr (
  loc0: location, m2v: m2val
) : m2val = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": evaluation is performed on a value not representing code."
  val () = prerr_newline ()
in
  M2Verr ()
end (* end of [auxerr] *)
//
in
//
case+ m2v of
| M2Vdcode (d2e) => let
    var ctx = evalctx_nil ()
    var env = alphenv_nil ()
    val m2v_res = eval0_d2exp (loc0, ctx, env, d2e)
    val () = alphenv_free (env)
    val () = evalctx_free (ctx)
  in
    m2v_res
  end // end of [V2ALcode]
| _ => auxerr (loc0, m2v)
//
end // end of [eval0_app_eval]

fun eval0_app_lift (
  loc0: location, m2v: m2val
) : m2val = let
  val d2e = liftval2dexp (loc0, m2v) in M2Vdcode (d2e)
end // end of [eval0_app_lift]

(* ****** ****** *)

fun eval0_d2var (
  loc0: location, ctx: !evalctx, d2v: d2var
) : m2val = let
//
fun auxerr (
  loc0: location, d2v: d2var
) : m2val = let
  val () = prerr_errmac_loc (loc0)
  val () = (prerr ": the variable ["; prerr_d2var (d2v); prerr "] is unbound.")
  val () = prerr_newline ()
in
  M2Verr ()
end (* end of [auxerr] *)
//
val opt = evalctx_dfind (ctx, d2v)
//
in
//
case+ opt of
| ~Some_vt (m2v) => m2v | ~None_vt () => auxerr (loc0, d2v)
//
end (* end of [eval0_d2var] *)

(* ****** ****** *)

extern
fun eval0_labd2explst (
  loc0: location, ctx: !evalctx, env: &alphenv, ld2es: labd2explst
) : labd2explst // end of [eval0_labd2explst]

implement
eval0_d2exp
  (loc0, ctx, env, d2e0) = let
(*
val () = (
  println! ("eval0_d2exp: d2e0 = ", d2e0)
) // end of [val]
*)
//
macdef
eval0dexp (d2e) = eval0_d2exp (loc0, ctx, env, ,(d2e))
//
in
//
case+ d2e0.d2exp_node of
| D2Evar d2v =>
    eval0_d2var (loc0, ctx, d2v)
  // end of [D2Evar]
//
| D2Eint (i) => M2Vint (i)
| D2Echar (c) => M2Vchar (c)
| D2Estring (s) => M2Vstring (s)
| D2Efloat (rep) => M2Vfloat (rep)
//
| D2Ei0nt (x) => let
    val- $LEX.T_INTEGER
      (base, rep, sfx) = x.token_node
    // end of [val]
  in
    M2Vint (int_of_llint ($UT.llint_make_string (rep)))
  end // end of [D2Ei0nt]
| D2Ec0har (x) => let
    val- $LEX.T_CHAR
      (c) = x.token_node in M2Vchar (c)
    // end of [val]
  end // end of [D2Ec0har]
| D2Ef0loat (x) => let
    val- $LEX.T_FLOAT
      (bas, rep, sfx) = x.token_node in M2Vfloat (rep)
    // end of [val]
  end // end of [D2Ef0loat]
| D2Es0tring (x) => let
    val- $LEX.T_STRING (s) = x.token_node in M2Vstring (s)
  end // end of [D2Es0tring]
//
| D2Eapplst
    (d2e, d2as) => (
  case+ d2e.d2exp_node of
  | D2Emac (d2m) => (
      // expanding a macro in long form
      eval0_app_mac_long (loc0, d2m, ctx, env, d2as)
    ) // end of [D2Emac]
(*
  | D2Esym (d2s) when d2sym_is_nonqua d2s => (
      // evaluating a predefined function (e.g., +, -, etc.)
      eval0_app_sym (loc0, d2s.d2sym_sym, ctx, env, d2as)
    ) // end of [D2Esym]
*)
  | _ => let
      val () = prerr_errmac_loc (loc0)
      val () = prerr ": the dynamic expression at ("
      val () = $LOC.prerr_location (d2e.d2exp_loc)
      val () = prerr ") should be a macro but it is not."
      val () = prerr_newline ()
    in
      M2Verr ()
    end // end of [_]
  ) // end of [D2Eapplst]
| D2Emac d2m => let
    val d2as = list_nil () // argumentless
  in
    eval0_app_mac_long (loc0, d2m, ctx, env, d2as)
  end // end of [D2Emac]
| D2Emacsyn (knd, d2e) => (
  case+ knd of
  | $SYN.MSKencode () => let
      val d2e =
        eval1_d2exp (loc0, ctx, env, d2e)
      // end of [val]
    in
      M2Vdcode (d2e)
    end // end of [MSKencode]
  | $SYN.MSKdecode () =>
      eval0_app_eval (loc0, eval0dexp (d2e))
    // end of [MSKdecode]
  | $SYN.MSKxstage () => let
      val m2v_res =
        eval0_app_eval (loc0, eval0dexp (d2e))
      // end of [val]
    in
      M2Vdcode (liftval2dexp (loc0, m2v_res))
    end // end of [MSKxstage]
  ) // end of [D2Emacsyn]
| _ => let
    val () = prerr_errmac_loc (loc0)
    val () = prerr ": the form of dynamic expression ["
    val () = prerr_d2exp (d2e0)
    val () = prerr "] is unsupported for macro expansion."
    val () = prerr_newline ()
    val () =
      the_trans3errlst_add (T3E_dmacro_eval0_d2exp (loc0, d2e0))
    // end of [val]
  in
    M2Verr ()
  end // end of [_]
end // end of [eval0_d2exp]

(* ****** ****** *)

extern fun
evalctx_extend_arg (
  loc0: location
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, arg: m2acarg
, d2a: d2exparg
, res: evalctx
) : evalctx // endfun

extern fun
evalctx_extend_sarg (
  loc0: location
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, sarg: s2varlst, s2es: s2explst
, res: evalctx
) : evalctx // endfun

extern fun
evalctx_extend_darg (
  loc0: location
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, darg: d2varlst, d2es: d2explst
, res: evalctx
) : evalctx // endfun

extern fun
evalctx_extend_arglst (
  loc0: location
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, args: m2acarglst
, d2as: d2exparglst
, res: evalctx
) : evalctx // endfun

(* ****** ****** *)

implement
evalctx_extend_sarg (
  loc0, d2m, knd, ctx, env, s2vs, s2es, res
) = let
//
fun auxerr (
  loc0: location, d2m: d2mac, sgn: int
) : void = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": some static argument group of the macro ["
  val () = prerr_d2mac (d2m)
  val () = if sgn < 0 then prerr "] is expected to contain more arguments."
  val () = if sgn > 0 then prerr "] is expected to contain fewer arguments."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_dmacro_evalctx_extend (loc0, d2m))
end // end of [auxerr]
//
in
//
case+ s2vs of
| list_cons (s2v, s2vs) => (
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val res = evalctx_sadd (res, s2v, M2Vscode (s2e))
    in
      evalctx_extend_sarg (loc0, d2m, knd, ctx, env, s2vs, s2es, res)
    end // end of [list_cons]
  | _ => let
      val () = auxerr (loc0, d2m, 1) in res
    end // end of [_]
  )
| list_nil () => (
  case+ s2es of
  | list_cons _ => let
      val () = auxerr (loc0, d2m, ~1) in res
    end // end of [list_cons]
  | list_nil () => res
  )
//
end // end of [evalctx_extend_sarg]

(* ****** ****** *)

implement
evalctx_extend_darg (
  loc0, d2m, knd, ctx, env, d2vs, d2es, res
) = let
//
fun auxerr (
  loc0: location, d2m: d2mac, sgn: int
) : void = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": some dynamic argument group of the macro ["
  val () = prerr_d2mac (d2m)
  val () = if sgn < 0 then prerr "] is expected to contain more arguments."
  val () = if sgn > 0 then prerr "] is expected to contain fewer arguments."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_dmacro_evalctx_extend (loc0, d2m))
end // end of [auxerr]
//
fun aux (
  loc0: location, knd: int
, ctx: !evalctx, env: &alphenv, d2e: d2exp
) : m2val = let
in
//
if knd >= 1 then
  eval0_d2exp (loc0, ctx, env, d2e)
else let // short form
  val m2v = eval1_d2exp (loc0, ctx, env, d2e)
in
  M2Vdcode (m2v)
end // end of [if]
//
end // end of [aux]
//
in
//
case+ d2vs of
| list_cons (d2v, d2vs) => (
  case+ d2es of
  | list_cons (d2e, d2es) => let
      val m2v =
        aux (loc0, knd, ctx, env, d2e)
      // end of [val]
      val res = evalctx_dadd (res, d2v, m2v)
    in
      evalctx_extend_darg (loc0, d2m, knd, ctx, env, d2vs, d2es, res)
    end // end of [list_cons]
  | _ => let
      val () = auxerr (loc0, d2m, 1) in res
    end // end of [_]
  )
| list_nil () => (
  case+ d2es of
  | list_cons _ => let
      val () = auxerr (loc0, d2m, ~1) in res
    end // end of [list_cons]
  | list_nil () => res
  )
//
end // end of [evalctx_extend_darg]

(* ****** ****** *)

fun s2exparglst_join
  (s2as: s2exparglst): s2explst = let
//
fun auxwarn (loc) = {
  val () = prerr_warning2_loc (loc)
  val () = prerr ": the static macro argument is ignored."
  val () = prerr_newline ()
} // end of [auxwarn]
//
in
//
case+ s2as of
| list_cons
    (s2a, s2as) => (
  case+
    s2a.s2exparg_node of
  | S2EXPARGseq (s2es) => (
    case+ s2as of
    | list_cons _ => let
        val s2es2 =
          s2exparglst_join (s2as) in list_append (s2es, s2es2)
        // end of [val]
      end // end of [list_cons]
    | list_nil () => s2es // HX: this is most likely by far!
    )
  | S2EXPARGone () => let
      val () =
        auxwarn (s2a.s2exparg_loc) in s2exparglst_join (s2as)
      // end of [val]
    end // end of [S2EXPARGone]
  | S2EXPARGall () => let
      val () =
        auxwarn (s2a.s2exparg_loc) in s2exparglst_join (s2as)
      // end of [val]
    end // end of [S2EXPARGall]
  ) // end of [list_cons]
| list_nil () => list_nil ()
//
end // end of [s2exparglst_join]

implement
evalctx_extend_arg (
  loc0, d2m, knd, ctx, env, arg, d2a, res
) = let
//
fun auxerr (
  loc0: location, loc: location, d2m: d2mac, stadyn: int
) : void = let
  val () = prerr_errmac_loc (loc0)
  val () = prerr ": the macro argument at ("
  val () = $LOC.prerr_location (loc)
  val () = if stadyn = 0 then prerr ") is expected to be static."
  val () = if stadyn > 0 then prerr ") is expected to be dynamic."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_dmacro_evalctx_extend (loc0, d2m))  
end // end of [auxerr_dyn]
//
in
//
case+ arg of
| M2ACARGsta (s2vs) => (
  case+ d2a of
  | D2EXPARGsta (loc, s2as) => let
      val s2es = s2exparglst_join (s2as)
    in
      evalctx_extend_sarg (loc0, d2m, knd, ctx, env, s2vs, s2es, res)
    end // end of [D2EXPARGsta]
  | D2EXPARGdyn (npf, loc, _) => let
      val () = auxerr (loc0, loc, d2m, 0(*sta*)) in res
    end // end of [D2EXPARGdyn]
  )
| M2ACARGdyn (d2vs) => (
  case+ d2a of
  | D2EXPARGdyn (loc, npf, d2es) =>
      evalctx_extend_darg (loc0, d2m, knd, ctx, env, d2vs, d2es, res)
  | D2EXPARGsta (loc, s2es) => let
      val () = auxerr (loc0, loc, d2m, 1(*dyn*)) in res
    end // end of [D2EXPARGsta]
  )
//
end // end of [eval0ctx_extend_arglst]

(* ****** ****** *)

implement
evalctx_extend_arglst (
  loc0, d2m, knd, ctx, env, args, d2as, res
) = let
in
//
case+ args of
| list_cons
    (arg, args) => let
    val- list_cons (d2a, d2as) = d2as
    val res =
      evalctx_extend_arg (loc0, d2m, knd, ctx, env, arg, d2a, res)
    // end of [val]
  in
    evalctx_extend_arglst (loc0, d2m, knd, ctx, env, args, d2as, res)
  end // end of [list_cons]
| list_nil () => res
//
end // end of [evalctx_extend_arglst]

(* ****** ****** *)
//
// HX: expanding macros in long form
//
implement
eval0_app_mac_long (
  loc0, d2m, ctx, env, d2as
) = let
(*
  val () = println! ("eval0_app_mac_long: d2m = ", d2m)
*)
//
val n = list_length (d2as)
val args = d2mac_get_arglst (d2m)
val narg = list_length (args)
//
val () = (
  if n != narg then let
    val () = prerr_errmac_loc (loc0)
    val () = prerr ": the macro function ["
    val () = prerr_d2mac (d2m)
    val () = if n > narg then prerr "] is overlly applied."
    val () = if n < narg then prerr "] is applied insufficiently."
    val () = prerr_newline ()
  in
    the_trans3errlst_add (T3E_dmacro_eval0_app_mac_arity (loc0, d2m, d2as))
  end // end of [if]
) : void // end of [val]
//
val ctx_new =
  evalctx_nil ()
val ctx_new =
  evalctx_extend_arglst (
  loc0, d2m, 1(*long*), ctx, env, args, d2as, ctx_new
) // end of [val]
(*
val () = begin
  print "eval0_app_mac_long: ctx_new =\n"; print ctx_new
end // end of [val]
*)
//
val m2v = eval0_d2exp (loc0, ctx_new, env, d2mac_get_def (d2m))
//
val () = evalctx_free (ctx_new)
//
in
  m2v
end // end of [eval0_app_mac_long]

(* ****** ****** *)
//
// HX: expanding macros in short form
//
implement
eval0_app_mac_short
  (loc0, d2m, ctx, env, d2as) = let
// (*
val () = (
  print "eval0_app_mac_short: d2m = "; print_d2mac d2m; print_newline ()
) // end of [val]
// *)
val n = list_length (d2as)
val args = d2mac_get_arglst (d2m)
val narg = list_length (args)
(*
val () = (
  println! ("eval0_app_mac_short: n = ", n)
  println! ("eval0_app_mac_short: narg = ", narg)
) // end of [val]
*)
val () = (
  if n < narg then let
    val () = prerr_errmac_loc (loc0)
    val () = prerr ": the macro function ["
    val () = prerr_d2mac (d2m)
    val () = prerr "] is applied insufficiently."
    val () = prerr_newline ()
  in
    the_trans3errlst_add (T3E_dmacro_eval0_app_mac_arity (loc0, d2m, d2as))
  end 
) : void // end of [val]
//
var d2as1: d2exparglst = list_nil ()
val d2as2 = (
  if narg <= n then let
    val (xs1, xs2) =
      list_split_at (d2as, narg)
    val () = d2as1 := list_of_list_vt (xs1)
  in
    xs2
  end else let
    val () = d2as1 := d2as in list_nil ()
  end // end of [if]
) : d2exparglst // end of [val]
//
val ctx_new =
  evalctx_extend_arglst (
  loc0, d2m, 0(*short*), ctx, env, args, d2as1, evalctx_nil ()
) // end of [evalctx_extend_arglst]
(*
val () = (
  print "eval0_app_mac_short: ctx_new =\n"; print_evalctx (ctx_new)
) // end of [val]
*)
val d2e = d2mac_get_def (d2m)
val d2e = eval1_d2exp (loc0, ctx_new, env, d2e)
val () = evalctx_free (ctx_new)
in
//
case+ d2as2 of
| list_cons _ => (
  case+ d2e.d2exp_node of
  | D2Eapplst (d2e_fun, d2as1) =>
      d2exp_applst (loc0, d2e_fun, list_append (d2as1, d2as2))
    // end of [D2Eapplst]
  | _ =>  d2exp_applst (loc0, d2e, d2as2)
  ) // end of [list_cons]
| list_nil () => (d2e)
//
end // end of [eval0_app_mac_short]

(* ****** ****** *)

(* end of [pats_dmacro2_eval0.dats] *)
