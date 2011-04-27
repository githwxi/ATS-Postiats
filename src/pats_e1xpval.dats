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

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"
staload ERR = "pats_error.sats"

(* ****** ****** *)

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
macdef EQ = $SYM.symbol_EQ
macdef EQEQ = $SYM.symbol_EQEQ
macdef LTGT = $SYM.symbol_LTGT
macdef BANGEQ = $SYM.symbol_BANGEQ
//
macdef LAND = $SYM.symbol_LAND
macdef LOR = $SYM.symbol_LOR
//
macdef LTLT = $SYM.symbol_LTLT
macdef GTGT = $SYM.symbol_GTGT
macdef DEFINED = $SYM.symbol_DEFINED
macdef UNDEFINED = $SYM.symbol_UNDEFINED
//
overload = with $SYM.eq_symbol_symbol
//
(* ****** ****** *)

staload "pats_basics.sats"
macdef isdebug () = (debug_flag_get () > 0)

(* ****** ****** *)

staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_trans1_env.sats"
staload "pats_e1xpval.sats"

(* ****** ****** *)

implement
v1al_is_err (v) =
 case+ v of | V1ALerr () => true | _ => false
// end of [v1al_is_err]

implement
v1al_is_true (v) = begin
  case+ v of
  | V1ALint i => i <> 0 // most common
  | V1ALchar c => c <> '\000'
  | V1ALstring s => string_isnot_empty s // 2nd most common
  | V1ALfloat f => f <> 0.0
  | V1ALerr () => false
end // end of [v1al_is_true]

implement v1al_is_false (v) = ~v1al_is_true(v)

(* ****** ****** *)

extern
fun e1xplev_valize (lev: int, e0: e1xp) : v1al
extern fun e1xp_valize_defined (e0: e1xp) : v1al
extern fun e1xp_valize_undefined (e0: e1xp) : v1al

(* ****** ****** *)

implement
e1xp_valize
  (e) = res where {
  val res = e1xplev_valize (0(*lev*), e)
  val () = (case+ res of
    | V1ALerr () => {
        val () = fprint_the_valerrlst (stderr_ref)
        val () = $ERR.abort ()
      } // end of [V1ALerr]
    | _ => ()
  ) : void // end of [val]
} // end of [e1xp_valize]

implement
e1xp_valize_if (knd, e) =
  case+ knd of
  | SRPIFKINDif () => e1xp_valize (e)
  | SRPIFKINDifdef () => e1xp_valize_defined (e)
  | SRPIFKINDifndef () => e1xp_valize_undefined (e)
// end of [e1xp_valize_if]

(* ****** ****** *)

implement
e1xp_valize_defined
  (e) = case+ e.e1xp_node of
  | E1XPide id => V1ALint (i) where {
      val i = (case+ the_e1xpenv_find id of
        | ~Some_vt e => (
            case+ e.e1xp_node of E1XPundef () => 0 | _ => 1
          ) // end of [Some_vt]
        | ~None_vt () => 0
      ) : int // end of [val]
    } // end of [E1XPide]
  | _ => V1ALerr () where {
      val () = the_valerrlst_add (VE_valize_defined (e))
    } // end of [_]
// end of [e1xp_valize_defined]

implement
e1xp_valize_undefined
  (e) = case+ e.e1xp_node of
  | E1XPide id => V1ALint (i) where {
      val i = (case+ the_e1xpenv_find id of
        | ~Some_vt e => (
            case+ e.e1xp_node of E1XPundef () => 1 | _ => 0
          ) // end of [Some_vt]
        | ~None_vt () => 1
      ) : int // end of [val]
    } // end of [E1XPide]
  | _ => V1ALerr () where {
      val () = the_valerrlst_add (VE_valize_undefined (e))
    } // end of [_]
// end of [e1xp_valize_undefined]

(* ****** ****** *)

absviewtype
lenv_vtype // local environment
viewtypedef lenv = lenv_vtype
extern fun lenvmake_nil (): lenv
extern fun lenvfree (env: lenv): void

extern
fun lenvmake_bindlst
  (xs: symbolist, vs: v1alist, err: &int? >> int): lenv
// end of [envmake]

extern
fun lenvfind (env: !lenv, x: symbol): Option_vt (v1al)

(* ****** ****** *)

local

typedef symv1al = @(symbol, v1al)
assume lenv_vtype = List_vt (symv1al)

in // in of [local]

implement
lenvmake_nil () = list_vt_nil ()

implement
lenvmake_bindlst (
  xs, vs, err
) = let
  fun aux (
    xs: symbolist, vs: v1alist, err: &int >> int
  ) : lenv =
    case+ (xs, vs) of
    | (list_cons (x, xs),
       list_cons (v, vs)) => let
        val env = aux (xs, vs, err) in list_vt_cons ((x, v), env)
      end
    | (list_nil (),
       list_nil ()) => list_vt_nil ()
    | (_, _) => let
        val () = err := err + 1 in list_vt_nil ()
      end
  // end of [aux]
  val () = err := 0
in
  aux (xs, vs, err)
end // end of [envmake_bindlst]

implement lenvfree (env) = list_vt_free<symv1al> (env)

implement lenvfind (env, x) = let
  val env = $UN.castvwtp1 {List(symv1al)} (env)
in
  list_assoc_fun<symbol,v1al> (env, lam (x1, x2) =<fun> x1 = x2, x)
end // end of [envfind]

end // end of [local]

(* ****** ****** *)

fn e1xp_valize_int
  (rep: string): int = let
  val x = $UT.llint_make_string (rep) in int_of_llint (x)
end // end of [e1xp_valize_int]

(* ****** ****** *)

fn e1xplevenv_valize_ide (
  lev: int, env: !lenv, e0: e1xp, x: symbol
) : v1al = let
  val ans = lenvfind (env, x)
in
//
case+ ans of
| ~Some_vt v => v
| ~None_vt _ => (
  case+ the_e1xpenv_find (x) of
  | ~Some_vt e => e1xplev_valize (lev+1, e)
  | ~None_vt _ => V1ALerr () where {
      val () = the_valerrlst_add (VE_E1XPide_unbound (e0))
    } // end of [None_vt]
  ) (* end of [None_vt] *)
end // end of [e1xplevenv_valize_ide]

(* ****** ****** *)

extern
fun e1xplevenv_valize (lev: int, env: !lenv, e0: e1xp): v1al
extern
fun e1xplevenv_valize_main (lev: int, env: !lenv, e0: e1xp): v1al

(* ****** ****** *)

fun e1xplstlevenv_valize (
  lev: int, env: !lenv, es: e1xplst
) : List_vt (v1al) =
  case+ es of
  | list_cons (e, es) => let
      val v = e1xplevenv_valize (lev, env, e)
      val vs = e1xplstlevenv_valize (lev, env, es)
    in
      list_vt_cons (v, vs)
    end
  | list_nil () => list_vt_nil ()
// end of [e1xplstlevenv_valist]

(* ****** ****** *)

fn e1xplevenv_valize_list (
  lev: int, env: !lenv, e0: e1xp, es: e1xplst
) : v1al = case+ es of
  | list_cons (e, es) => (
    case+ es of
    | list_nil () => e1xplevenv_valize (lev, env, e)
    | list_cons _ => V1ALerr () where {
        val () = the_valerrlst_add (VE_E1XPlist (e0))
      } // end of [list_cons]
    ) (* end of [list_cons] *)
  | list_nil () => V1ALint (0)
// end of [e1xplevenv_valist_list]

(* ****** ****** *)

extern
fun e1xplevenv_valize_delta (
  lev: int, env: !lenv, e0: e1xp, id: symbol, es: e1xplst
) : v1al // end of [e1xplevenv_valize_delta]

(* ****** ****** *)

fn e1xplevenv_valize_appid (
  lev: int, env: !lenv, e0: e1xp, id: symbol, es: e1xplst
) : v1al = case+ the_e1xpenv_find (id) of
  | ~Some_vt e => (case e.e1xp_node of
    | E1XPfun (xs, body) => res where {
//
        val vs = e1xplstlevenv_valize (lev, env, es)
//
        var err: int // uninitialized
        val env1 =
          lenvmake_bindlst (xs, $UN.castvwtp1 {v1alist} (vs), err)
        // end of [env1]
        val iserr = // HX: it is only need if err = 0 holds
          list_exists_fun ($UN.castvwtp1 {v1alist} (vs), v1al_is_err)
        // end of [val]
        val () = list_vt_free (vs)
//
        val res = (
          if err = 0 then (
            if iserr then
              V1ALerr () else e1xplevenv_valize (lev + 1, env1, body)
            // end of [if]
          ) else let
            val () = the_valerrlst_add (VE_E1XPappid_arity (e0, id))
          in
            V1ALerr ()
          end // end of [if]
        ) : v1al // end of [if]
//
        val () = lenvfree (env1)
//
      } // end of [E1XPfun]
    | _ => V1ALerr () where {
        val () = the_valerrlst_add (VE_E1XPappid_fun (e0, id))
      } // end of [_]
    ) (* end of [Some_vt] *)
  | ~None_vt _ => e1xplevenv_valize_delta (lev, env, e0, id, es)
// end of [e1xplevenv_valize_appid]

(* ****** ****** *)

implement
e1xplev_valize
  (lev, e0) = res where {
  val env = lenvmake_nil ()
  val res = e1xplevenv_valize (lev, env, e0)
  val () = lenvfree (env)
} // end of [e1xplev_valize]

(* ****** ****** *)

implement
e1xplevenv_valize
  (lev, env, e0) = let
//
#define MAXLEVEL 99
//
(*
  val () = begin
    print "e1xplevenv_valize: e0 = "; print e0; print_newline ()
  end // end of [val]
*)
//
in
//
if lev <= MAXLEVEL then let
  val res = e1xplevenv_valize_main (lev, env, e0)
  val () = (case+ res of
    | V1ALerr () => the_valerrlst_add (VE_valize (e0))
    | _ => ()
  ) : void // end of [val]
in
  res
end else let
  val () = the_valerrlst_add (VE_maxlevel (lev, e0))
in
  V1ALerr ()
end // end of [if]
//
end // end of [e1xplevenv_valize]

implement
e1xplevenv_valize_main
  (lev, env, e0) = let
  val loc0 = e0.e1xp_loc
in
//
case+ e0.e1xp_node of
| E1XPide (sym) =>
    e1xplevenv_valize_ide (lev, env, e0, sym)
//
| E1XPint (x) => let
    val v = e1xp_valize_int (x) in V1ALint (v)
  end
| E1XPchar (x) => V1ALchar (x)
| E1XPstring (x) => V1ALstring (x)
| E1XPfloat (x) => V1ALfloat (double_of_string x)
//
| E1XPval (v) => v
//
| E1XPnone () => V1ALint 0
| E1XPundef () => V1ALerr () where {
    val () = the_valerrlst_add (VE_E1XPundef (e0))
  }
//
| E1XPapp (
    e_fun, _(*loc_arg*), es_arg
  ) => (
  case+ e_fun.e1xp_node of
  | E1XPide id =>
      e1xplevenv_valize_appid (lev, env, e0, id, es_arg)
   // end of [E1XPide]
  | _ => V1ALerr () where {
      val () = the_valerrlst_add (VE_E1XPapp_fun (e0))
    } (* end of [_] *)
  ) // end of [E1XPapp]
//
| E1XPlist (es) => e1xplevenv_valize_list (lev, env, e0, es)
| E1XPeval (e1) => e1xplevenv_valize (lev, env, e1) // HX: is this right?
//
| E1XPif (_cond, _then, _else) => let
    val _cond = e1xplevenv_valize (lev, env, _cond)
  in
    case+ _cond of
    | V1ALerr () => V1ALerr ()
    | _ => let
        val _taken = (
          if v1al_is_true (_cond) then _then else _else
        ) : e1xp // end of [val]
      in
        e1xplevenv_valize (lev, env, _taken)
      end (* end of [_] *)
  end
//
| E1XPfun _ => V1ALerr () where {
    val () = the_valerrlst_add (VE_E1XPfun (e0))
  }
//
(*
| _ => V1ALerr ()
*)
//
end // end of [e1xplevenv_valize_main]

(* ****** ****** *)

fn e1xplevenv_valize_add (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 + i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 + f2)
  | (V1ALstring s1, V1ALstring s2) => V1ALstring (s1 + s2)
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_add]

fn e1xplevenv_valize_sub (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 - i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 - f2)
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_sub]

fn e1xplevenv_valize_mul (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 * i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 * f2)
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_mul]

fn e1xplevenv_valize_div (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => V1ALint (i1 / i2)
  | (V1ALfloat f1, V1ALfloat f2) => V1ALfloat (f1 / f2)
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_div]

(* ****** ****** *)

fn e1xplevenv_valize_lt (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 < f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 < i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 < s2 then V1ALint 1 else V1ALint 0
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_lt]

fn e1xplevenv_valize_lteq (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 <= f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 <= i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 <= s2 then V1ALint 1 else V1ALint 0
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_lteq]

fn e1xplevenv_valize_gt (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 > f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 > i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 > s2 then V1ALint 1 else V1ALint 0
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_gt]

fn e1xplevenv_valize_gteq (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALfloat f1, V1ALfloat f2) =>
      if f1 >= f2 then V1ALint 1 else V1ALint 0
  | (V1ALint i1, V1ALint i2) =>
      if i1 >= i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 >= s2 then V1ALint 1 else V1ALint 0
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_gteq]

(* ****** ****** *)

fun e1xplevenv_valize_eq (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) =>
      if i1 = i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 = s2 then V1ALint 1 else V1ALint 0
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_eq]

fun e1xplevenv_valize_neq (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) =>
      if i1 <> i2 then V1ALint 1 else V1ALint 0
  | (V1ALstring s1, V1ALstring s2) =>
      if s1 <> s2 then V1ALint 1 else V1ALint 0
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_neq]

(* ****** ****** *)

fun e1xplevenv_valize_land (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => begin
      if i1 = 0 then V1ALint 0
      else if i2 = 0 then V1ALint 0
      else V1ALint 1
    end // end of [V1ALint, V1ALint]
  | (V1ALstring s1, V1ALstring s2) => let
      val s1 = string1_of_string s1 and s2 = string1_of_string s2
    in
      if string_is_empty s1 then V1ALint (0)
      else if string_is_empty s1 then V1ALint (0)
      else V1ALint 1
    end // end of [V1ALstring, V1ALstring]
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_land]

fun e1xplevenv_valize_lor (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => begin
      if i1 <> 0 then V1ALint 1
      else if i2 <> 0 then V1ALint 1
      else V1ALint 0
    end // end of [V1ALint, V1ALint]
  | (V1ALstring s1, V1ALstring s2) => let
      val s1 = string1_of_string s1 and s2 = string1_of_string s2
    in
      if string_isnot_empty s1 then V1ALint (1)
      else if string_isnot_empty s2 then V1ALint (1)
      else V1ALint 0
    end // end of [V1ALstring, V1ALstring]
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_lor]

(* ****** ****** *)

fn e1xplevenv_valize_asl (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => let
      val i2 = int1_of_int i2
      val () = if (i2 < 0) then {
        val () = $LOC.prerr_location (e0.e1xp_loc)
//
        val () = if isdebug () then prerr ": e1xplevenv_valize_asl"
//
        val () = prerr ": the second argument of [<<] is required to be a natural number."
        val () = prerr_newline ()
        val () = $ERR.abort {void} ()
      } // end of [val]
      val () = assert (i2 >= 0) // redundant at run-time
    in
       V1ALint (i1 << i2)
    end // end of [(V1ALint _, V1ALint _)]
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_asl]

fn e1xplevenv_valize_asr (
  lev: int, env: !lenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => let
      val i2 = int1_of_int i2
      val () = if (i2 < 0) then {
        val () = $LOC.prerr_location (e0.e1xp_loc)
//
        val () = if isdebug () then prerr ": e1xplevenv_valize_asl"
//
        val () = prerr ": the second argument of [>>] is required to be a natural number."
        val () = prerr_newline ()
        val () = $ERR.abort {void} ()
      } // end of [val]
      val () = assert (i2 >= 0) // redundant at run-time
    in
       V1ALint (i1 >> i2)
    end // end of [(V1ALint _, V1ALint _)]
  | (_, _) => V1ALerr () where {
      val () = the_valerrlst_add (VE_opr_arglst (e0, id))
    }
end // end of [e1xplevenv_valize_asr]

(* ****** ****** *)

implement
e1xplevenv_valize_delta
  (lev, env, e0, id, es) = let
(*
  val () = begin
    print "e1xplevenv_valize_delta: id = "; $SYM.print_symbol id; print_newline ()
  end // end of [val]
*)
//
#define nil list_nil
#define :: list_cons
#define cons list_cons
//
macdef
oprarity_err () = let
  val () = the_valerrlst_add (VE_E1XPappid_arity (e0, id)) in V1ALerr ()
end // end of [oprarity_err]
//
in
//
case+ 0 of
| _ when id = DEFINED => (
  case+ es of
  | e :: nil () => e1xp_valize_defined (e)
  | _ => oprarity_err ()
  )
| _ when id = UNDEFINED => (
  case+ es of
  | e :: nil () => e1xp_valize_undefined (e)
  | _ => oprarity_err ()
  )
//
| _ when id = ADD => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_add (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = SUB => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_sub (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = MUL => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_mul (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = DIV => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_div (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
//
| _ when id = LT => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_lt (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = LTEQ => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_lteq (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = GT => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_gt (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = GTEQ => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_gteq (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
//
| _ when (id = EQ orelse id = EQEQ) => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_eq (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when (id = LTGT orelse id = BANGEQ) => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_neq (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
//
| _ when id = LAND => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_land (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = LOR => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_lor (lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
//
| _ => V1ALerr () where {
    val () = the_valerrlst_add (VE_E1XPappid_opr (e0, id))
  } // end of [_]
//
end // end of [

(* ****** ****** *)

(* end of [pats_e1xpval.dats] *)
