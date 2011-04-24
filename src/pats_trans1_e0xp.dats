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
// Start Time: April, 2011
//
(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload LOC = "pats_location.sats"
overload + with $LOC.location_combine
//
staload SYM = "pats_symbol.sats"
//
macdef ADD = $SYM.symbol_ADD
macdef SUB = $SYM.symbol_SUB
macdef MUL = $SYM.symbol_MUL
macdef DIV = $SYM.symbol_DIV
//
macdef LT = $SYM.symbol_LT
macdef LTEQ = $SYM.symbol_LTEQ
macdef GT = $SYM.symbol_GT
macdef GTEQ = $SYM.symbol_GTEQ
//
macdef BACKSLASH = $SYM.symbol_BACKSLASH
macdef LTLT = $SYM.symbol_LTLT
macdef GTGT = $SYM.symbol_GTGT
macdef DEFINED = $SYM.symbol_DEFINED
macdef UNDEFINED = $SYM.symbol_UNDEFINED
//
overload = with $SYM.eq_symbol_symbol
//
(* ****** ****** *)

staload "pats_lexing.sats"

(* ****** ****** *)

staload "pats_basics.sats"
staload "pats_fixity.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"

(* ****** ****** *)

staload "pats_trans1.sats"
staload "pats_trans1_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn prerr_loc_error1
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(1)"
) // end of [prerr_loc_error1]

fn prerr_interror
  (): void = prerr "INTERROR(pats_trans1_e0xp)"
// end of [prerr_interror]

(* ****** ****** *)

implement
v1al_is_true (v) = begin
  case+ v of
  | V1ALint i => i <> 0 // most common
  | V1ALstring s => string_isnot_empty s // 2nd most common
  | V1ALfloat f => f <> 0.0
  | V1ALchar c => c <> '\000'
end // end of [v1al_is_true]

implement v1al_is_false (v) = ~v1al_is_true(v)

(* ****** ****** *)

fun isdebug (): bool = debug_flag_get () > 0

(* ****** ****** *)

fn e1xp_eval_errmsg_app
  (loc: location): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval"
  val () = prerr ": an identifier is expected to be applied."
  val () = prerr_newline ()
in
  $ERR.abort {v1al} ()
end // end of [e1xp_eval_errmsg_app]

fn e1xp_eval_errmsg_ide
  (loc: location, sym: symbol): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval"
  val () = prerr ": unrecognized identifier: "
  val () = $SYM.prerr_symbol (sym)
  val () = prerr_newline ()
in
  $ERR.abort {v1al} ()
end // end of [e1xp_eval_errmsg_id]

fn e1xp_eval_errmsg_list
  (loc: location): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval"
  val () = prerr ": the list expression is incorrectly used."
  val () = prerr_newline ()
in
  $ERR.abort {v1al} ()
end // end of [e1xp_eval_errmsg_list]

fn e1xp_eval_errmsg_undef
  (loc: location): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval"
  val () = prerr ": a defined expression is expected here."
  val () = prerr_newline ()
in
  $ERR.abort {v1al} ()
end // end of [e1xp_eval_errmsg_undef]

(* ****** ****** *)

fn e1xp_eval_appid_errmsg_arity
  (loc: location, opr: symbol): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval_appid"
  val () = prerr ": the arity of ["
  val () = $SYM.prerr_symbol (opr)
  val () = prerr "] is mismatched."
  val () = prerr_newline ()
in
  $ERR.abort ()
end // end of [e1xp_eval_appid_errmsg_arity]

fn e1xp_eval_appid_errmsg_opr
  (loc: location, opr: symbol): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval_appid"
  val () = prerr ": unrecognized operation: ["
  val () = $SYM.prerr_symbol opr
  val () = prerr "]"
  val () = prerr_newline ()
in
  $ERR.abort ()
end // end of [e1xp_eval_appid_errmsg_opr]

(* ****** ****** *)

fn e1xp_eval_opr_errmsg_arglst
  (loc: location, opr: symbol): v1al = let
  val () = $LOC.prerr_location (loc)
  val () = if isdebug () then prerr ": e1xp_eval"
  val () = prerr ": illegal argument(s) for ["
  val () = $SYM.prerr_symbol (opr)
  val () = prerr "]"
  val () = prerr_newline ()
in
  $ERR.abort {v1al} ()
end // end of [e1xp_eval_opr_errmsg]

(* ****** ****** *)

fun e1xp_eval_int
  (rep: string): int = let
  val x = $UT.llint_make_string (rep) in int_of_llint (x)
end // end of [e1xp_eval_int]

(* ****** ****** *)

fun e1xp_eval_defined
  (loc: location, e: e1xp): v1al = begin
  case+ e.e1xp_node of
  | E1XPide id => V1ALint (i) where {
      val i = (case+ the_e1xpenv_find id of
        | ~Some_vt e => (case+ e.e1xp_node of E1XPundef () => 0 | _ => 1)
        | ~None_vt () => 0
      ) : int // end of [val]
    } // end of [E1XPide]
  | _ => begin
      e1xp_eval_opr_errmsg_arglst (loc, DEFINED)
    end // end of [_]
end // end of [e1xp_eval_defined]

and e1xp_eval_undefined
  (loc: location, e: e1xp): v1al = begin
  case+ e.e1xp_node of
  | E1XPide id => V1ALint (i) where {
      val i = (case+ the_e1xpenv_find id of
        | ~Some_vt e => (case+ e.e1xp_node of E1XPundef () => 1 | _ => 0)
        | ~None_vt () => 1
      ) : int // end of [val]
    } // end of [E1XPide]
  | _ => begin
      e1xp_eval_opr_errmsg_arglst (loc, UNDEFINED)
    end // end of [_]
end // end of [e1xp_eval_undefined]

(* ****** ****** *)

fun e1xp_eval_add (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 + i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 + f2)
  | (V1ALstring s1, V1ALstring s2) => V1ALstring (s1 + s2)
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, ADD)
end // end of [e1xp_eval_add]

and e1xp_eval_sub (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 - i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 - f2)
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, SUB)
end // end of [e1xp_eval_sub]

and e1xp_eval_mul (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 * i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 * f2)
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, MUL)
end // end of [e1xp_eval_mul]

and e1xp_eval_div (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 / i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 / f2)
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, DIV)
end // end of [e1xp_eval_div]

(* ****** ****** *)

fun e1xp_eval_lt (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 < f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 < i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 < s2 then V1ALint 1 else V1ALint 0
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, LT)
end // end of [e1xp_eval_lt]

fun e1xp_eval_lteq (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 <= f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 <= i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 <= s2 then V1ALint 1 else V1ALint 0
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, LTEQ)
end // end of [e1xp_eval_lteq]

(* ****** ****** *)

and e1xp_eval_gt (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 > f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 > i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 > s2 then V1ALint 1 else V1ALint 0
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, GT)
end // end of [e1xp_eval_gt]

and e1xp_eval_gteq (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 >= f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 >= i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 >= s2 then V1ALint 1 else V1ALint 0
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, GTEQ)
end // end of [e1xp_eval_gteq]

(* ****** ****** *)

fn e1xp_eval_asl (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => let
      val i2 = int1_of_int i2
      val () = if (i2 < 0) then {
        val () = $LOC.prerr_location (loc)
        val () = if isdebug () then prerr ": e1xp_eval_asl"
        val () = prerr ": the second argument of [<<] must be a natural number."
        val () = prerr_newline ()
        val () = $ERR.abort {void} ()
      } // end of [val]
      val () = assert (i2 >= 0) // redundant at run-time
    in
       V1ALint (i1 << i2)
    end // end of [(V1ALint _, V1ALint _)]
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, LTLT)
end // end of [e1xp_eval_asl]

fn e1xp_eval_asr (
  loc: location, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xp_eval e1; val v2 = e1xp_eval e2
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => let
      val i2 = int1_of_int i2
      val () = if (i2 < 0) then {
        val () = $LOC.prerr_location (loc)
        val () = if isdebug () then prerr ": e1xp_eval_asl"
        val () = prerr ": the second argument of [>>] must be a natural number."
        val () = prerr_newline ()
        val () = $ERR.abort {void} ()
      } // end of [val]
      val () = assert (i2 >= 0) // redundant at run-time
    in
       V1ALint (i1 >> i2)
    end // end of [(V1ALint _, V1ALint _)]
  | (_, _) => e1xp_eval_opr_errmsg_arglst (loc, GTGT)
end // end of [e1xp_eval_asr]

(* ****** ****** *)

fun e1xp_eval_appid (
  loc0: location, sym: symbol, es: e1xplst
) : v1al = let
(*
  val () = begin
    print "e1xp_eval_appid: id = "; $SYM.print_symbol id; print_newline ()
  end // end of [val]
*)
#define nil list_nil
#define :: list_cons
#define cons list_cons
in
//
case+ 0 of
| _ when sym = DEFINED => (
  case+ es of
  | e :: nil () => e1xp_eval_defined (loc0, e)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = UNDEFINED => (
  case+ es of
  | e :: nil () => e1xp_eval_undefined (loc0, e)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = ADD => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_add (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = SUB => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_sub (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = MUL => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_mul (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = DIV => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_div (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = LT => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_lt (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = LTEQ => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_lteq (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = GT => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_gt (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ when sym = GTEQ => (
  case+ es of
  | e1 :: e2 :: nil () => e1xp_eval_gteq (loc0, e1, e2)
  | _ => e1xp_eval_appid_errmsg_arity (loc0, sym)
  )
| _ => e1xp_eval_appid_errmsg_opr (loc0, sym)
//
end // end of [e1xp_eval_appid]

(*
  end else if id = $Sym.symbol_EQ then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_eq (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_EQEQ then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_eq (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_NEQ then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_neq (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_NEQEQ then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_neq (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_LAND then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_and (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_LOR then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_or (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_LTLT then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_asl (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else if id = $Sym.symbol_GTGT then begin case+ es of
    | cons (e1, cons (e2, nil ())) => e1xp_eval_asr (loc, e1, e2)
    | _ => e1xp_eval_appid_errmsg_arity (loc, id)
  end else begin
    e1xp_eval_appid_errmsg_opr (loc, id)
  end // end of [if]
end // end of [e1xp_eval_appid]
*)

(* ****** ****** *)

implement
e1xp_eval (e0) = let
(*
  val () = begin
    print "e1xp_eval: e0 = "; print e0; print_newline ()
  end // end of [val]
*)
  val loc0 = e0.e1xp_loc
in
  case+ e0.e1xp_node of
  | E1XPapp (e_fun, _(*loc_arg*), es_arg) => (
      case+ e_fun.e1xp_node of
      | E1XPide id => e1xp_eval_appid (e_fun.e1xp_loc, id, es_arg)
      | _ => e1xp_eval_errmsg_app (e_fun.e1xp_loc)
    ) // end of [E1XPapp]
  | E1XPchar c => V1ALchar c
  | E1XPfloat f(*string*) => V1ALfloat (double_of f)
  | E1XPint (int: string) => V1ALint (e1xp_eval_int int)
  | E1XPide (sym) => (
    case+ the_e1xpenv_find (sym) of
    | ~Some_vt e => e1xp_eval e
    | ~None_vt () => e1xp_eval_errmsg_ide (loc0, sym)
    ) // end of [E1XPide]
  | E1XPlist es => (
    case+ es of
    | list_cons (e, list_nil ()) => e1xp_eval e
    | _ => e1xp_eval_errmsg_list (loc0)
    ) // end of [E1XPlist]
  | E1XPnone () => V1ALint 0
  | E1XPstring (s) => V1ALstring s
  | E1XPundef () => e1xp_eval_errmsg_undef (loc0)
end // end of [e1xp_eval]

(* ****** ****** *)

implement
e1xp_eval_if (knd, e) =
  case+ knd of
  | SRPIFKINDif () => e1xp_eval (e)
  | SRPIFKINDifdef () => e1xp_eval_defined (e.e1xp_loc, e)
  | SRPIFKINDifndef () => e1xp_eval_undefined (e.e1xp_loc, e)
// end of [e1xp_eval_if]

(* ****** ****** *)

implement
e1xp_make_v1al
  (loc, v) = case+ v of // v1al -> e1xp
  | V1ALint i => let
      val s = tostring_int i in e1xp_int (loc, s)
    end // end of [V1ALint]
  | V1ALstring s => e1xp_string (loc, s)
  | V1ALfloat f => let
      val s = tostring_double f in e1xp_float (loc, s)
    end // end of [V1ALfloat]
  | V1ALchar c => e1xp_char (loc, c)
// end of [e1xp_make_v1al]

(* ****** ****** *)

implement
do_e0xpact_assert
  (loc, v) = let
  val is_false = (
    case+ v of
    | V1ALchar c => c = '\0'
    | V1ALfloat f => f = 0.0
    | V1ALint i => i = 0
    | V1ALstring s => let
        val s = string1_of_string s in string_is_empty s
      end // end of [V1ALstring]
  ) : bool // end of [val]
in
  if is_false then begin
    prerr_loc_error1 loc;
    prerr ": [#assert] failed"; prerr_newline ();
    exit {void} (1)
  end // end of [if]
end // end of [do_e0xpact_assert]

implement
do_e0xpact_error
  (loc, v) = let
  val () = {
    val () = prerr_loc_error1 (loc)
    val () = prerr ": [#error] directive is encountered: "
  } // end of [val]
  val () = (case+ v of
    | V1ALchar c => prerr c
    | V1ALfloat f => prerr f
    | V1ALint i => prerr i
    | V1ALstring s => prerr s
  ) : void // end of [val]
in
  exit {void} (1)
end // end of [do_e0xpact_error]

implement
do_e0xpact_prerr
  (v) = case+ v of
  | V1ALchar c => prerr c
  | V1ALfloat f => prerr f
  | V1ALint i => prerr i
  | V1ALstring s => prerr s
// end of [do_e0xpact_prerr]

(* ****** ****** *)
//
// HX: translation of sorts
//
typedef e1xpitm = fxitm (e1xp)
typedef e1xpitmlst = List (e1xpitm)

(* ****** ****** *)

local

fn appf (
  _fun: e1xp, _arg: e1xp
) :<cloref1> e1xpitm = let
  val loc_arg = _arg.e1xp_loc
  val loc = _fun.e1xp_loc + loc_arg
  val xs_arg = (
    case+ _arg.e1xp_node of
    | E1XPlist xs => xs | _ => list_cons (_arg, list_nil ())
  ) : e1xplst // end of [val]
  val _app = e1xp_app (loc, _fun, loc_arg, xs_arg)
in
  FXITMatm (_app)
end // end of [appf]

in // in of [local]

fn e1xpitm_app
  (loc: location): e1xpitm = fxitm_app (loc, appf)
// end of [e1xpitm]

end // end of [local]

fn e1xp_get_loc (x: e1xp): location = x.e1xp_loc

fn e1xp_make_opr (
  opr: e1xp, f: fxty
) : e1xpitm = begin
  fxopr_make {e1xp} (
    e1xp_get_loc
  , lam (loc, x, loc_arg, xs) => e1xp_app (loc, x, loc_arg, xs)
  , opr, f
  ) // end of [oper_make]
end // end of [e1xp_make_opr]

fn e1xpitm_backslash
  (loc_opr: location) = begin
  fxopr_make_backslash {e1xp} (
    lam x => x.e1xp_loc
  , lam (loc, x, loc_arg, xs) => e1xp_app (loc, x, loc_arg, xs)
  , loc_opr
  ) // end of [oper_make_backslash]
end // end of [e1xpitm_backslash]

(* ****** ****** *)

local

fn e0xp_tr_errmsg_opr
  (loc: location): e1xp = let
  val () = prerr_loc_error1 (loc)
  val () = prerr ": the operator needs to be applied."
  val () = prerr_newline ()
in
  $ERR.abort {e1xp} ()
end // end of [e0xp_tr_errmsg_opr]

fn e0xp_tr_errmsg_float
  (loc: location): void = let
  val () = prerr_loc_error1 (loc)
  val () = prerr ": the floating point number is required to be of base 10."
  val () = prerr_newline ()
in
  $ERR.abort ()
end // end of [e0xp_tr_errmsg_float]

in // in of [local]
  
implement e0xp_tr (e0) = let
//
fun aux_item (e0: e0xp): e1xpitm = let
  val loc0 = e0.e0xp_loc in case+ e0.e0xp_node of
  | E0XPide id when
      id = BACKSLASH => e1xpitm_backslash (loc0)
  | E0XPide id => begin case+ the_fxtyenv_find id of
    | ~Some_vt f => begin
        let val e = e1xp_ide (loc0, id) in e1xp_make_opr (e, f) end
      end // end of [Some_vt]
    | ~None_vt () => FXITMatm (e1xp_ide (loc0, id))
    end (* end of [E0XPide] *)
  | E0XPint (x) => let
      val- T_INTEGER (bas, rep, sfx) = x.token_node
    in
      FXITMatm (e1xp_int (loc0, rep))
    end
  | E0XPchar (x) => let
      val- T_CHAR (c) = x.token_node in FXITMatm (e1xp_char (loc0, c))
    end
  | E0XPfloat (x) => let
      val- T_FLOAT (bas, rep, sfx) = x.token_node
      val () = if bas != 10 then e0xp_tr_errmsg_float (loc0)
    in
      FXITMatm (e1xp_float (loc0, rep))
    end
  | E0XPstring (x) => let
      val- T_STRING (str) = x.token_node in FXITMatm (e1xp_string (loc0, str))
    end
  | E0XPstringid (str) => FXITMatm (e1xp_string (loc0, str))
  | E0XPapp _ => let
      val e0_new = fixity_resolve (
        loc0, e1xp_get_loc, e1xpitm_app (loc0), aux_itemlst e0
      ) // end of [val]
    in
      FXITMatm (e0_new)
    end // end of [E0XPapp]
  | E0XPeval (e: e0xp) => let
      val v = e1xp_eval (e0xp_tr e)
      val e = e1xp_make_v1al (loc0, v)
    in
      FXITMatm (e)
    end // end of [E0XPeval]
  | E0XPlist (es) => FXITMatm (e1xp_list (loc0, e0xplst_tr es))
end // end of [aux_item]
//
and aux_itemlst
  (e0: e0xp): e1xpitmlst = let
  fun loop (
    e0: e0xp, res: e1xpitmlst
  ) : e1xpitmlst =
    case+ e0.e0xp_node of
    | E0XPapp (e1, e2) => let
        val res = list_cons (aux_item e2, res) in loop (e1, res)
      end (* end of [E0XPapp] *)
    | _ => list_cons (aux_item e0, res)
  // end of [loop]
in
  loop (e0, list_nil ())
end // end of [aux_itemlst]
//
in
//
case+ aux_item e0 of
| FXITMatm (e) => e
| FXITMopr _ => e0xp_tr_errmsg_opr (e0.e0xp_loc)
//
end // end of [e0xp_tr]

end // end of [local]

implement
e0xplst_tr (es) = l2l (list_map_fun (es, e0xp_tr))

(* ****** ****** *)

(* end of [pats_trans1_e0xp.dats] *)
