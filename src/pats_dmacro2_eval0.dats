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
// Start Time: July, 2012
//
(* ****** ****** *)
//
staload
ATSPRE =
"./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
//
implement
prerr_FILENAME<>() = prerr "pats_dmacro2_eval0"
//
(* ****** ****** *)
(*
** for T_* constructors
*)
staload LEX = "./pats_lexing.sats"

(* ****** ****** *)
//
staload SYM = "./pats_symbol.sats"
//
macdef symbol_ADD = $SYM.symbol_ADD
macdef symbol_SUB = $SYM.symbol_SUB
macdef symbol_MUL = $SYM.symbol_MUL
//
macdef symbol_LT = $SYM.symbol_LT
macdef symbol_LTEQ = $SYM.symbol_LTEQ
//
macdef symbol_GT = $SYM.symbol_GT
macdef symbol_GTEQ = $SYM.symbol_GTEQ
//
macdef symbol_EQ = $SYM.symbol_EQ
macdef symbol_LTGT = $SYM.symbol_LTGT
macdef symbol_BANGEQ = $SYM.symbol_BANGEQ
//
macdef symbol_CAR = $SYM.symbol_CAR
macdef symbol_CDR = $SYM.symbol_CDR
macdef symbol_ISNIL = $SYM.symbol_ISNIL
macdef symbol_ISCONS = $SYM.symbol_ISCONS
macdef symbol_ISLIST = $SYM.symbol_ISLIST
//
overload = with $SYM.eq_symbol_symbol
overload print with $SYM.print_symbol
//
staload SYN = "./pats_syntax.sats"
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"

(* ****** ****** *)

staload "./pats_dmacro2.sats"

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
//
// HX-2012-08:
// it is largely unclear how useful this feature is; so it is
// now only given a primitive implementation, which can be readily
// made more elaborate when a convincing need for it appears.
// 
//
extern
fun
eval0_app_sym
(
  loc: loc_t
, sym: symbol
, ctx: !evalctx
, env: &alphenv, d2as: d2exparglst
) : m2val // end of [eval0_app_sym]

(* ****** ****** *)

local

(* ****** ****** *)

fun
eval0_app_add
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
(*
val () =
println! ("eval0_app_add")
*)
in
//
case+ m2v1 of
| M2Vint (i1) =>
  (
  case+ m2v2 of
  | M2Vint(i2) => M2Vint(i1+i2) | _ => M2Verr()
  ) // end of [M2Vint]
| _ (*non-M2Vint*) => M2Verr(*void*)
//
end // end of [eval0_app_add]

fun
eval0_app_sub
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
(*
val () =
println! ("eval0_app_sub")
*)
in
//
case+ m2v1 of
| M2Vint(i1) =>
  (
  case+ m2v2 of
  | M2Vint(i2) => M2Vint(i1-i2) | _ => M2Verr()
  ) // end of [M2Vint]
| _ (*non-M2Vint*) => M2Verr(*void*)
//
end // end of [eval0_app_sub]

fun
eval0_app_mul
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
(*
val () =
println! ("eval0_app_mul")
*)
in
//
case+ m2v1 of
| M2Vint(i1) =>
  (
  case+ m2v2 of
  | M2Vint(i2) => M2Vint(i1*i2) | _ => M2Verr()
  ) // end of [M2Vint]
| _ (*non-M2Vint*) => M2Verr(*void*)
//
end // end of [eval0_app_mul]

(* ****** ****** *)

fn
eval0_app_cmp_int
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : Sgn = let
//
fun
auxerr
(
  loc0: loc_t
, m2v1: m2val, m2v2: m2val
) : Sgn = let
  val () =
  prerr_errmac_loc(loc0)
  val () =
  prerrln!
  (
    ": values are compared that do not support comparison."
  )
  val () =
  the_trans3errlst_add(T3E_dmacro_eval0_cmp(loc0, m2v1, m2v2))
in
  0(*meaningless*)
end // end of [auxerr]
//
in
//
case+ m2v1 of
| M2Vint(i1) =>
  (
  case+ m2v2 of
  | M2Vint(i2) =>
      compare_int_int(i1, i2)
  | _ (*non-M2Vint*) =>
      auxerr(loc0, m2v1, m2v2)
    // end of [_]
  ) // end of [M2Vint]
| _(*non-M2Vint*) => auxerr(loc0, m2v1, m2v2)
//
end // end of [eval0_app_cmp_int]

(* ****** ****** *)

fun
eval0_app_lt
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
//
val sgn = eval0_app_cmp_int(loc0, m2v1, m2v2)
//
in
  if sgn < 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_lt]

fun
eval0_app_lte
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
//
val sgn = eval0_app_cmp_int(loc0, m2v1, m2v2)
//
in
  if sgn <= 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_lte]

(* ****** ****** *)

fun
eval0_app_gt
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
//
val sgn = eval0_app_cmp_int(loc0, m2v1, m2v2)
//
in
  if sgn > 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_gt]

fun
eval0_app_gte
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
//
val sgn = eval0_app_cmp_int(loc0, m2v1, m2v2)
//
in
  if sgn >= 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_gte]

(* ****** ****** *)

fun
eval0_app_eq
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
//
val
sgn = eval0_app_cmp_int(loc0, m2v1, m2v2)
//
in
  if sgn = 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_eq]

fun
eval0_app_neq
(
  loc0: loc_t, m2v1: m2val, m2v2: m2val
) : m2val = let
//
val sgn= eval0_app_cmp_int(loc0, m2v1, m2v2)
//
in
  if sgn != 0 then m2val_true else m2val_false
end // end of [eval0_exp_app_neq]

(* ****** ****** *)

fun
d2exparg_get_d2explst
  (d2a: d2exparg): d2explst = let
(*
val () =
println! ("d2exparg_get_d2explst")
*)
in
  case+ d2a of
  | D2EXPARGdyn
    (
      _(*loc*), _(*npf*), d2es
    ) => d2es
  | D2EXPARGsta _ => list_nil((*void*))
end // end of [d2exparg_get_d2explst]

(* ****** ****** *)

fun
eval0_d2exparg_1
(
  loc: loc_t
, ctx: !evalctx
, env: &alphenv, d2a: d2exparg
) : m2val = let
//
val
d2es = d2exparg_get_d2explst(d2a)
//
in
//
case+ d2es of
| list_nil
    () => M2Verr()
  // list_nil
| list_cons
    (d2e, _) =>
  (
    eval0_d2exp(loc, ctx, env, d2e)
  ) (* list_cons *)
//
end // end of [eval0_d2exparg_1]

fun
eval0_d2exparglst_1
(
  loc: loc_t
, ctx: !evalctx
, env: &alphenv, d2as: d2exparglst
) : m2val = (
//
case+ d2as of
| list_nil
    () => M2Verr()
  // list_nil
| list_cons
    (d2a, _) =>
  (
    eval0_d2exparg_1(loc, ctx, env, d2a)
  ) // end of [list_cons]
//
) // end of [eval0_d2exparglst_1]

(* ****** ****** *)

typedef m2val2 = @(m2val, m2val)

(* ****** ****** *)

fun
eval0_d2exparg_2
(
  loc: loc_t
, ctx: !evalctx
, env: &alphenv, d2a: d2exparg
) : m2val2 = let
  val d2es = d2exparg_get_d2explst(d2a)
in
//
case+ d2es of
| list_nil
    () => (M2Verr(), M2Verr())
  // list_nil
| list_cons
    (d2e1, d2es) => let
    val m2v1 = eval0_d2exp(loc, ctx, env, d2e1)
  in
    case+ d2es of
    | list_nil() =>
      (m2v1, M2Verr())
    | list_cons(d2e2, _) => let
        val m2v2 = eval0_d2exp(loc, ctx, env, d2e2)
      in
        (m2v1, m2v2)
      end // end of [list_cons]
  end // end of [list_cons]
//
end // end of [eval0_d2exparg_2]

fun
eval0_d2exparglst_2
(
  loc: loc_t
, ctx: !evalctx
, env: &alphenv, d2as: d2exparglst
) : m2val2 = let
in
//
case+ d2as of
| list_nil() => (M2Verr(), M2Verr())
| list_cons(d2a, _) =>
    eval0_d2exparg_2(loc, ctx, env, d2a)
  // end of [list_cons]
//
end // end of [eval0_d2exparglst_2]

(* ****** ****** *)

in (* in of [local] *)

implement
eval0_app_sym
(
  loc0, sym, ctx, env, d2as
) = let
(*
//
val () =
println!
("eval0_app_sym: sym = ", sym)
//
*)
in
//
case+ 0 of
//
| _ when
    sym = symbol_ADD => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_add(loc0, m2v1, m2v2)
  end
| _ when
    sym = symbol_SUB => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_sub(loc0, m2v1, m2v2)
  end
| _ when
    sym = symbol_MUL => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_mul(loc0, m2v1, m2v2)
  end
//
| _ when
    sym = symbol_LT => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_lt (loc0, m2v1, m2v2)
  end
| _ when
    sym = symbol_LTEQ => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_lte(loc0, m2v1, m2v2)
  end
//
| _ when
    sym = symbol_GT => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_gt (loc0, m2v1, m2v2)
  end
| _ when
    sym = symbol_GTEQ => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_gte(loc0, m2v1, m2v2)
  end
//
| _ when
    sym = symbol_EQ => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_eq (loc0, m2v1, m2v2)
  end
| _ when
    sym = symbol_LTGT => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_neq(loc0, m2v1, m2v2)
  end
| _ when
    sym = symbol_BANGEQ => let
    val (m2v1, m2v2) =
      eval0_d2exparglst_2(loc0, ctx, env, d2as)
    // end of [val]
  in
    eval0_app_neq(loc0, m2v1, m2v2)
  end
//
| _ (*unrecognized-operator*) => M2Verr((*void*))
//
end // end of [eval0_app_sym]

end // end of [local]

(* ****** ****** *)

fun
eval0_app_eval
(
  loc0: loc_t, m2v: m2val
) : m2val = let
//
fun
auxerr
(
  loc0: loc_t, m2v: m2val
) : m2val = M2Verr() where
{
  val () =
  prerr_errmac_loc(loc0)
  val () =
  prerrln! (
    ": evaluation is performed on a value not representing code."
  ) (* println! *)
} (* end of [auxerr] *)
//
in
//
case+ m2v of
| M2Vdcode(d2e) => let
    var ctx = evalctx_nil()
    var env = alphenv_nil()
    val m2v_res = eval0_d2exp(loc0, ctx, env, d2e)
    val () = alphenv_free(env)
    val () = evalctx_free(ctx)
  in
    m2v_res
  end // end of [V2ALcode]
| _(*M2Vdcode*) => auxerr(loc0, m2v)
//
end // end of [eval0_app_eval]

(* ****** ****** *)

fun
eval0_app_lift
(
  loc0: loc_t, m2v: m2val
) : m2val = let
  val d2e = liftval2dexp(loc0, m2v) in M2Vdcode(d2e)
end // end of [eval0_app_lift]

(* ****** ****** *)

fun eval0_car
  (m2vs: m2valist): m2val =
  case+ m2vs of
  | list_cons(m2v, _) =>
    (
    case+ m2v of
    | M2Vlist (m2vs) =>
      (
      case m2vs of
      | list_cons(m2v, _) => m2v | _ => M2Verr()
      )
    | _(*non-M2Vlist*) => M2Verr()
    )
  | list_nil((*void*)) => M2Verr() // argumentless
// end of [eval0_car]

fun eval0_cdr
  (m2vs: m2valist): m2val =
  case+ m2vs of
  | list_cons(m2v, _) =>
    (
    case+ m2v of
    | M2Vlist(m2vs) =>
      (
      case m2vs of
      | list_cons
          (_, m2vs) => M2Vlist(m2vs) | _ => M2Verr()
        // list_cons
      )
    | _(*non-M2Vlist*) => M2Verr()
    )
  | list_nil((*void*)) => M2Verr() // argumentless
// end of [eval0_cdr]

(* ****** ****** *)

fun
eval0_islist
  (m2vs: m2valist): m2val =
(
  case+ m2vs of
  | list_cons(m2v, _) =>
    (
    case+ m2v of
    | M2Vlist _ => M2Vbool(true)
    | _(*non-M2Vlist*) => M2Vbool(false)
    )
  | list_nil((*void*)) => M2Verr() // argumentless
) // end of [eval0_islist]

(* ****** ****** *)
//
fun
eval0_isnil
  (m2vs: m2valist): m2val =
(
  case+ m2vs of
  | list_cons(m2v, _) =>
    (
    case+ m2v of
    | M2Vlist(m2vs) =>
      (
      case+ m2vs of
      | list_cons _ => M2Vbool(false) | _ => M2Vbool(true)
      )
    | _(*M2Vlist*) => M2Verr()
    )
  | list_nil((*void*)) => M2Verr () // argumentless
) // end of [eval0_isnil]
//
fun
eval0_iscons
  (m2vs: m2valist): m2val =
(
  case+ m2vs of
  | list_cons(m2v, _) =>
    (
    case+ m2v of
    | M2Vlist(m2vs) =>
      (
      case m2vs of
      | list_cons _ => M2Vbool(true) | _ => M2Vbool(false)
      )
    | _(*M2Vlist*) => M2Verr()
    )
  | list_nil((*void*)) => M2Verr() // argumentless
) // end of [eval0_iscons]
//
(* ****** ****** *)

fun
eval0_d2var
(
  loc: loc_t
, ctx: !evalctx, d2v: d2var
) : m2val = let
//
fun
auxerr
(
  loc: loc_t, d2v: d2var
) : m2val = let
  val () =
  prerr_errmac_loc(loc)
  val () =
  (
    prerr ": the variable [";
    prerr_d2var(d2v); prerr "] is unbound."
  ) (* end of [val] *)
  val () = prerr_newline()
in
  M2Verr((*void*))
end (* end of [auxerr] *)
//
val opt = evalctx_dfind(ctx, d2v)
//
in
//
case+ opt of
| ~Some_vt(m2v) => m2v
| ~None_vt((*void*)) => auxerr(loc, d2v)
//
end (* end of [eval0_d2var] *)

(* ****** ****** *)
//
extern
fun
eval0_d2explst
(
  loc: loc_t
, ctx: !evalctx, env: &alphenv, d2es: d2explst
) : m2valist // end of [eval0_d2expopt]
implement
eval0_d2explst
  (loc, ctx, env, d2es) = let
(*
val () = println! ("eval0_d2explst")
*)
in
  case+ d2es of
  | list_cons
      (d2e, d2es) => let
      val m2v = eval0_d2exp(loc, ctx, env, d2e)
      val m2vs = eval0_d2explst(loc, ctx, env, d2es)
    in
      list_cons(m2v, m2vs)
    end // end of [list_cons]
  | list_nil((*void*)) => list_nil()
end // end of [eval0_d2explst]
//
(* ****** ****** *)
//
extern
fun
eval0_d2expopt
(
  loc: loc_t
, ctx: !evalctx, env: &alphenv, opt: d2expopt
) : m2val // end of [eval0_d2expopt]
implement
eval0_d2expopt
  (loc, ctx, env, opt) = let
in
  case+ opt of
  | None() => M2Vunit()
  | Some(d2e) => eval0_d2exp(loc, ctx, env, d2e)
end // end of [eval0_d2expopt]
//
(* ****** ****** *)

implement
eval0_d2exp
  (loc, ctx, env, d2e0) = let
(*
val () = (
  println! ("eval0_d2exp: d2e0 = ", d2e0)
) // end of [val]
*)
//
macdef
eval0dexp(x) = eval0_d2exp(loc, ctx, env, ,(x))
macdef
eval0dexplst(x) = eval0_d2explst(loc, ctx, env, ,(x))
macdef
eval0dexpopt(x) = eval0_d2expopt(loc, ctx, env, ,(x))
//
in
//
case+
d2e0.d2exp_node
of // case+
//
| D2Evar(d2v) =>
    m2v where {
    val m2v = eval0_d2var(loc, ctx, d2v)
  } (* end of [D2Evar] *)
//
| D2Eint(i) => M2Vint(i)
| D2Echar(c) => M2Vchar(c)
| D2Efloat(rep) => M2Vfloat(rep)
| D2Estring(str) => M2Vstring(str)
//
| D2Ei0nt(x) => let
    val-$LEX.T_INT
      (base, rep, sfx) = x.token_node
    // end of [val]
  in
    M2Vint(int_of_llint($UT.llint_make_string(rep)))
  end // end of [D2Ei0nt]
| D2Ec0har(x) => let
    val-$LEX.T_CHAR(c) = x.token_node in M2Vchar(c)
    // end of [val]
  end // end of [D2Ec0har]
| D2Ef0loat(x) => let
    val-$LEX.T_FLOAT
      (bas, rep, sfx) = x.token_node in M2Vfloat(rep)
    // end of [val]
  end // end of [D2Ef0loat]
| D2Es0tring(x) => let
    val-$LEX.T_STRING(s) = x.token_node in M2Vstring(s)
  end // end of [D2Es0tring]
//
| D2Esing(d2e) => eval0dexp(d2e)
//
| D2Eapplst
    (d2e, d2as) =>
  (
  case+
  d2e.d2exp_node
  of // case+
  | D2Emac(d2m) =>
    (
      // expanding a macro in long form
      eval0_app_mac_long (loc, d2m, ctx, env, d2as)
    ) // end of [D2Emac]
  | D2Esym(d2s)
      when d2sym_is_nonqua d2s => (
      // evaluating a predefined function (e.g., +, -, etc.)
      eval0_app_sym (loc, d2s.d2sym_sym, ctx, env, d2as)
    ) // end of [D2Esym]
  | _ => let
      val () = prerr_errmac_loc(loc)
      val () = prerr ": the dynamic expression at ("
      val () = $LOC.prerr_location(d2e.d2exp_loc)
      val () = prerr ") should be a macro but it is not."
      val () = prerr_newline((*void*))
    in
      M2Verr((*void*))
    end // end of [_]
  ) // end of [D2Eapplst]
//
| D2Eifhead
  (
    i2nv, test, _then, _else
  ) => let
    val test = eval0dexp (test)
  in
    case+ test of
    | M2Vbool (b) => 
        if b then eval0dexp (_then) else eval0dexpopt (_else)
      // end of [M2Vbool]
    | _ => M2Verr ()
  end // end of [D2Eifhead]
//
| D2Emac(d2m) => let
    val d2as = list_nil() // argumentless
  in
    eval0_app_mac_long(loc, d2m, ctx, env, d2as)
  end // end of [D2Emac]
//
| D2Emacsyn(knd, d2e) =>
  (
  case+ knd of
  | $SYN.MSKencode() => let
      val d2e =
        eval1_d2exp(loc, ctx, env, d2e)
      // end of [val]
    in
      M2Vdcode (d2e)
    end // end of [MSKencode]
  | $SYN.MSKdecode() =>
      eval0_app_eval(loc, eval0dexp(d2e))
    // end of [MSKdecode]
  | $SYN.MSKxstage() => let
      val m2v_res =
        eval0_app_eval(loc, eval0dexp(d2e))
      // end of [val]
    in
      M2Vdcode(liftval2dexp (loc, m2v_res))
    end // end of [MSKxstage]
  ) // end of [D2Emacsyn]
//
| D2Emacfun(name, d2es) => let
    val m2vs = eval0dexplst(d2es)
  in
    case+ 0 of
    | _ when name = symbol_CAR => eval0_car (m2vs)
    | _ when name = symbol_CDR => eval0_cdr (m2vs)
    | _ when name = symbol_ISNIL => eval0_isnil (m2vs)
    | _ when name = symbol_ISCONS => eval0_iscons (m2vs)
    | _ when name = symbol_ISLIST => eval0_islist (m2vs)
    | _ => M2Verr ()
  end // end of [D2Emacfun]
//
| _ (*rest-of-d2exp*) => let
    val () =
    prerr_errmac_loc(loc)
    val () = prerr ": the form of dynamic expression ["
    val () = prerr_d2exp(d2e0)
    val () = prerr "] is unsupported for macro expansion."
    val () = prerr_newline((*void*))
    val () =
      the_trans3errlst_add (T3E_dmacro_eval0_d2exp (loc, d2e0))
    // end of [val]
  in
    M2Verr((*void*))
  end // end of [rest-of-d2exp]
//
end // end of [eval0_d2exp]

(* ****** ****** *)

extern
fun
evalctx_extend_arg
(
  loc: loc_t
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, arg: m2acarg
, d2a: d2exparg
, res: evalctx
) : evalctx // end-of-function

extern
fun
evalctx_extend_sarg
(
  loc: loc_t
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, sarg: s2varlst, s2es: s2explst
, res: evalctx
) : evalctx // end-of-functio

extern
fun
evalctx_extend_darg
(
  loc: loc_t
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, darg: d2varlst, d2es: d2explst
, res: evalctx
) : evalctx // end-of-function

extern
fun
evalctx_extend_arglst
(
  loc: loc_t
, d2m: d2mac
, knd: int (* 0/1: short/long *)
, ctx: !evalctx
, env: &alphenv
, args: m2acarglst
, d2as: d2exparglst
, res: evalctx
) : evalctx // end-of-function

(* ****** ****** *)

implement
evalctx_extend_sarg
(
  loc, d2m, knd, ctx, env, s2vs, s2es, res
) = let
//
fun
auxerr
(
  loc: loc_t, d2m: d2mac, sgn: int
) : void = let
  val () =
  prerr_errmac_loc(loc)
  val () = prerr ": some static argument group of the macro ["
  val () = prerr_d2mac(d2m)
  val () =
  if sgn < 0 then prerr "] is expected to contain more arguments."
  val () =
  if sgn > 0 then prerr "] is expected to contain fewer arguments."
  val () = prerr_newline((*void*))
in
  the_trans3errlst_add(T3E_dmacro_evalctx_extend(loc, d2m))
end // end of [auxerr]
//
in
//
case+ s2vs of
| list_cons
    (s2v, s2vs) =>
  (
  case+ s2es of
  | list_cons
      (s2e, s2es) => let
      val res =
        evalctx_sadd(res, s2v, M2Vscode(s2e))
      // end of [val]
    in
      evalctx_extend_sarg
        (loc, d2m, knd, ctx, env, s2vs, s2es, res)
      // evalctx_extend_sarg
    end // end of [list_cons]
  | list_nil((*void*))=>
    let val () = auxerr(loc, d2m, 1) in res end
  )
| list_nil((*void*)) =>
  (
  case+ s2es of
  | list_cons _ =>
    let val () = auxerr(loc, d2m, ~1) in res end
  | list_nil((*void*)) => res
  )
//
end // end of [evalctx_extend_sarg]

(* ****** ****** *)

implement
evalctx_extend_darg
(
  loc, d2m, knd
, ctx, env, d2vs, d2es, res
) = let
//
fun
auxerr
(
  loc: loc_t, d2m: d2mac, sgn: int
) : void = let
  val () =
  prerr_errmac_loc(loc)
  val () = prerr ": some dynamic argument group of the macro ["
  val () = prerr_d2mac (d2m)
  val () = if sgn < 0 then prerr "] is expected to contain more arguments."
  val () = if sgn > 0 then prerr "] is expected to contain fewer arguments."
  val () = prerr_newline((*void*))
in
  the_trans3errlst_add(T3E_dmacro_evalctx_extend(loc, d2m))
end // end of [auxerr]
//
fun
auxexp
(
  loc: loc_t, knd: int
, ctx: !evalctx, env: &alphenv, d2e: d2exp
) : m2val = let
in
//
if knd >= 1 then
  eval0_d2exp(loc, ctx, env, d2e)
else let // short form
  val d2e =
    eval1_d2exp(loc, ctx, env, d2e) in M2Vdcode(d2e)
  // end of [val]
end // end of [if]
//
end // end of [auxexp]
//
fun
auxexplst
(
  loc: loc_t, knd: int
, ctx: !evalctx, env: &alphenv, d2es: d2explst
) : m2valist = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val m2v = auxexp(loc, knd, ctx, env, d2e)
    val m2vs = auxexplst(loc, knd, ctx, env, d2es)
  in
    list_cons(m2v, m2vs)
  end // end of [list_cons]
| list_nil((*void*)) => list_nil((*void*))
//
end // end of [auxexplst]
//
in
//
case+ d2vs of
| list_cons
    (d2v, list_nil()) => (
  case+ d2es of
  | list_cons
      (d2e, list_nil()) => let
      val m2v =
        auxexp(loc, knd, ctx, env, d2e)
      // end of [val]
    in
      evalctx_dadd(res, d2v, m2v)
    end // end of [list_sing]
  | _ => let
      val m2vs =
        auxexplst(loc, knd, ctx, env, d2es)
      // end of [val]
    in
      evalctx_dadd(res, d2v, M2Vlist (m2vs))
    end // end of [_]
  ) // end of [list_sing]
| list_cons
    (d2v, d2vs) =>
  (
  case+ d2es of
  | list_cons
      (d2e, d2es) => let
      val m2v =
        auxexp(loc, knd, ctx, env, d2e)
      // end of [val]
      val res = evalctx_dadd(res, d2v, m2v)
    in
      evalctx_extend_darg
        (loc, d2m, knd, ctx, env, d2vs, d2es, res)
      // evalctx_extend_darg
    end // end of [list_cons]
  | list_nil((*void*)) => let
      val () = auxerr(loc, d2m, 1) in res
    end // end of [_]
  )
| list_nil((*void*)) =>
  (
  case+ d2es of
  | list_cons _ => let
      val () = auxerr(loc, d2m, ~1) in res
    end // end of [list_cons]
  | list_nil((*void*)) => res
  )
//
end // end of [evalctx_extend_darg]

(* ****** ****** *)

fun
s2exparglst_join
  (s2as: s2exparglst): s2explst = let
//
fun
auxwarn(loc: loc_t) =
{
  val () =
  prerr_warning2_loc(loc)
  val () =
  prerrln! (": the static macro argument is ignored.")
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

(* ****** ****** *)

implement
evalctx_extend_arg
(
  loc, d2m, knd
, ctx, env, arg, d2a, res
) = let
//
fun
auxerr
(
  loc: loc_t
, loca: loc_t, d2m: d2mac, stadyn: int
) : void = let
  val () =
  prerr_errmac_loc(loc)
  val () =
  prerr(": the macro argument at (")
  val () =
  $LOC.prerr_location(loca)
  val () =
  if (stadyn = 0) then prerr ") is expected to be static."
  val () =
  if (stadyn > 0) then prerr ") is expected to be dynamic."
  val () = prerr_newline((*void*))
in
  the_trans3errlst_add(T3E_dmacro_evalctx_extend(loc, d2m))
end // end of [auxerr_dyn]
//
in
//
case+ arg of
| M2ACARGsta(s2vs) =>
  (
  case+ d2a of
  | D2EXPARGsta(loca, s2as) => let
      val s2es = s2exparglst_join(s2as)
    in
      evalctx_extend_sarg
        (loc, d2m, knd, ctx, env, s2vs, s2es, res)
      // evalctx_extend_sarg
    end // end of [D2EXPARGsta]
  | D2EXPARGdyn(npf, loca, _) => let
      val () = auxerr (loc, loca, d2m, 0(*sta*)) in res
    end // end of [D2EXPARGdyn]
  )
| M2ACARGdyn(d2vs) =>
  (
  case+ d2a of
  | D2EXPARGdyn
      (loca, npf, d2es) =>
    (
      evalctx_extend_darg
        (loc, d2m, knd, ctx, env, d2vs, d2es, res)
      // evalctx_extend_darg
    )
  | D2EXPARGsta(loca, s2es) => let
      val () = auxerr(loc, loca, d2m, 1(*dyn*)) in res
    end // end of [D2EXPARGsta]
  )
//
end // end of [eval0ctx_extend_arg]

(* ****** ****** *)

implement
evalctx_extend_arglst
(
  loc, d2m, knd
, ctx, env, args, d2as, res) = let
in
//
case+ args of
| list_nil
    ((*void*)) => res
  // list_nil
| list_cons
    (arg, args) => let
    val-list_cons(d2a, d2as) = d2as
    val res =
      evalctx_extend_arg(loc, d2m, knd, ctx, env, arg, d2a, res)
    // end of [val]
  in
    evalctx_extend_arglst(loc, d2m, knd, ctx, env, args, d2as, res)
  end // end of [list_cons]
//
end // end of [evalctx_extend_arglst]

(* ****** ****** *)
//
// HX: expanding macros in long form
//
implement
eval0_app_mac_long
(
  loc, d2m, ctx, env, d2as
) = m2v where
{
//
(*
  val () = println! ("eval0_app_mac_long: d2m = ", d2m)
*)
//
val n0 = list_length(d2as)
val args = d2mac_get_arglst(d2m)
val narg = list_length(args)
//
val () = (
if
(n0 != narg)
then let
  val () =
  prerr_errmac_loc(loc)
  val () =
  prerr ": the macro function ["
  val () =
  prerr_d2mac(d2m)
  val () =
  if n0 > narg then prerr "] is overlly applied."
  val () =
  if n0 < narg then prerr "] is applied insufficiently."
  val () = prerr_newline((*void*))
in
  the_trans3errlst_add
    (T3E_dmacro_eval0_app_mac_arity(loc, d2m, d2as))
  // the_trans3errlst_add
end // end of [if]
) : void // end of [val]
//
val
ctx_new =
evalctx_nil ()
val
ctx_new =
evalctx_extend_arglst
(
  loc, d2m, 1(*long*), ctx, env, args, d2as, ctx_new
) (* end of [val] *)
(*
val () = begin
  print "eval0_app_mac_long: ctx_new =\n"; print ctx_new
end // end of [val]
*)
//
val d2e =
  d2mac_get_def(d2m)
val m2v =
  eval0_d2exp(loc, ctx_new, env, d2e)
//
val ((*void*)) = evalctx_free(ctx_new)
//
} (* end of [eval0_app_mac_long] *)

(* ****** ****** *)
//
// HX: expanding macros in short form
//
implement
eval0_app_mac_short
  (loc, d2m, ctx, env, d2as) = let
//
(*
val () = (
  println! ("eval0_app_mac_short: d2m = ", d2m)
) (* end of [val] *)
*)
//
val n0 = list_length(d2as)
val args = d2mac_get_arglst(d2m)
val narg = list_length(args)
//
(*
val () = (
  println! ("eval0_app_mac_short: n = ", n);
  println! ("eval0_app_mac_short: narg = ", narg);
) // end of [val]
*)
//
val () =
(
//
if
(n0 < narg)
then let
  val () =
  prerr_errmac_loc(loc)
  val () = prerr ": the macro function ["
  val () = prerr_d2mac(d2m)
  val () = prerr "] is applied insufficiently."
  val () = prerr_newline((*void*))
in
  the_trans3errlst_add
    (T3E_dmacro_eval0_app_mac_arity(loc, d2m, d2as))
  // the_trans3errlst_add
end // end of [let] // end of [if]
//
) : void // end of [val]
//
var d2as1
  : d2exparglst = list_nil()
//
val d2as2 =
(
//
if
(n0 >= narg)
then xs2 where
{
  val (xs1, xs2) =
    list_split_at(d2as, narg)
  val ((*void*)) =
    (d2as1 := list_of_list_vt(xs1))
} (* end of [then] *)
else let
  val () = d2as1 := d2as in list_nil()
end // end of [else]
//
) : d2exparglst // end of [val]
//
val
ctx_new =
evalctx_extend_arglst
(
  loc, d2m, 0(*short*), ctx, env, args, d2as1, evalctx_nil()
) // end of [evalctx_extend_arglst]
(*
val () = (
  print "eval0_app_mac_short: ctx_new =\n"; print_evalctx (ctx_new)
) // end of [val]
*)
//
val d2e =
eval1_d2exp
(
  loc, ctx_new, env, d2mac_get_def(d2m)
) (* end of [val] *)
//
val ((*freed*)) = evalctx_free(ctx_new)
//
in
//
case+ d2as2 of
| list_nil
    () => (d2e)
  // list_nil()
| list_cons _ =>
  (
  case+
  d2e.d2exp_node
  of (* case+ *)
  | D2Eapplst
     (d2e_fun, d2as1) =>
   (
     d2exp_applst
       (loc, d2e_fun, list_append(d2as1, d2as2))
   ) // end of [D2Eapplst]
  | _ (*non-D2Eapplst*) => d2exp_applst(loc, d2e, d2as2)
  ) (* end of [list_cons] *)
//
end // end of [eval0_app_mac_short]

(* ****** ****** *)

(* end of [pats_dmacro2_eval0.dats] *)
