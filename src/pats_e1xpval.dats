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
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "./pats_basics.sats"
//
macdef isdebug () = (debug_flag_get () > 0)
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload LOC = "./pats_location.sats"
macdef prerr_location = $LOC.prerr_location

staload SYM = "./pats_symbol.sats"
//
macdef NEG = $SYM.symbol_NEG
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

staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"
staload "./pats_trans1_env.sats"
staload "./pats_e1xpval.sats"

(* ****** ****** *)

#define MAX_VALIZE_LEVEL 99
#define MAX_NORMAL_LEVEL 99

(* ****** ****** *)

fun
prerr_error1_loc
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(1)"
) // end of [prerr_error1_loc]

(* ****** ****** *)

implement
v1al_is_err (v) =
(
  case+ v of | V1ALerr () => true | _ => false
) (* end of [v1al_is_err] *)

implement
v1al_is_true (v) = let
in
//
case+ v of
| V1ALint i => i <> 0 // most common
| V1ALchar c => c <> '\000'
| V1ALstring s => string_isnot_empty s // 2nd most common
| V1ALfloat f => f <> 0.0
| V1ALerr ((*void*)) => false
//
end // end of [v1al_is_true]

implement v1al_is_false (v) = ~v1al_is_true(v)

(* ****** ****** *)
//
extern
fun e1xplev_valize (lev: int, e0: e1xp) : v1al
//
extern fun e1xp_valize_defined (e0: e1xp) : v1al
extern fun e1xp_valize_undefined (e0: e1xp) : v1al
//
(* ****** ****** *)

implement
e1xp_valize
  (e) = res where {
  val res = e1xplev_valize (0(*lev*), e)
  val ((*void*)) =
  (
    case+ res of
    | V1ALerr () => {
        val () = fprint_the_valerrlst (stderr_ref)
        val () = $ERR.abort ()
      } (* end of [V1ALerr] *)
    | _ (*non-err*) => ((*void*))
  ) : void // end of [val]
} (* end of [e1xp_valize] *)

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
lenv_vtype (a:type) // local environment
viewtypedef lenv (a:type) = lenv_vtype (a)
extern fun lenvmake_nil {a:type} (): lenv (a)
extern fun lenvfree {a:type} (env: lenv (a)): void
extern fun
lenvfind {a:type} (env: !lenv (a), x: symbol): Option_vt (a)

(* ****** ****** *)

viewtypedef vlenv = lenv (v1al)
extern fun
lenvmake_v1alist (xs: symbolist, vs: v1alist): vlenv
viewtypedef elenv = lenv (e1xp)
extern fun
lenvmake_e1xplst (lorg: location, xs: symbolist, es: e1xplst): elenv

(* ****** ****** *)

local

assume lenv_vtype (a:type) = List_vt @(symbol, a)

in // in of [local]

implement
lenvmake_nil () = list_vt_nil ()

implement lenvfree (env) = list_vt_free (env)

implement
lenvfind {a} (env, x) = let
  typedef keyitm = (symbol, a)
  val env = $UN.castvwtp1 {List(keyitm)} (env)
in
  list_assoc_fun<symbol,a> (env, lam (x1, x2) =<fun> x1 = x2, x)
end // end of [envfind]

implement
lenvmake_v1alist
  (xs, vs) = let
  fun aux (
    xs: symbolist, vs: v1alist
  ) : lenv (v1al) =
    case+ xs of
    | list_cons (x, xs) => (
      case+ vs of
      | list_cons (v, vs) =>
          list_vt_cons ((x, v), aux (xs, vs))
      | list_nil () => let
          val v = V1ALint(0) in list_vt_cons ((x, v), aux (xs, vs))
        end // end of [list_nil]
      ) (* end of [list_cons] *)
    | list_nil () => list_vt_nil ()
in
  aux (xs, vs)
end // end of [envmake_bindlst]

implement
lenvmake_e1xplst
  (lorg, xs, es) = let
  fun aux (
    lorg: location, xs: symbolist, es: e1xplst
  ) : elenv =
    case+ xs of
    | list_cons (x, xs) => (
      case+ es of
      | list_cons (e, es) =>
          list_vt_cons ((x, e), aux (lorg, xs, es))
      | list_nil () => let
          val e = e1xp_none (lorg)
        in
          list_vt_cons ((x, e), aux (lorg, xs, es))
        end // end of [list_nil]
      ) (* end of [list_cons] *)
    | list_nil () => list_vt_nil ()
in
  aux (lorg, xs, es)
end // end of [lenvmake_e1xplst]

end // end of [local]

(* ****** ****** *)

fn e1xp_valize_int
  (rep: string): int = let
  val x = $UT.llint_make_string (rep) in int_of_llint (x)
end // end of [e1xp_valize_int]

(* ****** ****** *)

fn e1xplevenv_valize_ide (
  lev: int, env: !vlenv, e0: e1xp, x: symbol
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
fun e1xplevenv_valize (lev: int, env: !vlenv, e0: e1xp): v1al
extern
fun e1xplevenv_valize_main (lev: int, env: !vlenv, e0: e1xp): v1al

(* ****** ****** *)

fun
e1xplstlevenv_valize
(
  lev: int, env: !vlenv, es: e1xplst
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

fun
e1xplevenv_valize_list
(
  lev: int, env: !vlenv, e0: e1xp, es: e1xplst
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
fun
e1xplevenv_valize_delta
(
  lev: int, env: !vlenv, e0: e1xp, id: symbol, es: e1xplst
) : v1al // end of [e1xplevenv_valize_delta]

(* ****** ****** *)

fun
e1xplevenv_valize_appid
(
  lev: int, env: !vlenv, e0: e1xp, id: symbol, es: e1xplst
) : v1al = let
  val opt = the_e1xpenv_find (id)
in
//
case+ opt of
| ~Some_vt e => (case e.e1xp_node of
//
  | E1XPide (id) => 
      e1xplevenv_valize_appid (lev+1, env, e, id, es)
    // end of [E1XPide]
//
  | E1XPfun (xs, body) => res where {
      val vs = e1xplstlevenv_valize (lev, env, es)
//
      val env1 =
        lenvmake_v1alist (xs, $UN.castvwtp1 {v1alist} (vs))
      // end of [env1]
      val iserr = // HX: it is only need if err = 0 holds
        list_exists_fun ($UN.castvwtp1 {v1alist} (vs), v1al_is_err)
      // end of [val]
      val () = list_vt_free (vs)
//
      val res = (
        if iserr then
          V1ALerr () else e1xplevenv_valize (lev+1, env1, body)
        // end of [if]
      ) : v1al // end of [if]
//
      val () = lenvfree (env1)
//
    } // end of [E1XPfun]
  | _ => V1ALerr () where {
      val () = the_valerrlst_add (VE_E1XPappid_fun (e0, id))
    } // end of [_]
  ) (* end of [Some_vt] *)
| ~None_vt () => e1xplevenv_valize_delta (lev, env, e0, id, es)
//
end // end of [e1xplevenv_valize_appid]

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
#define MAXLEV MAX_VALIZE_LEVEL
//
(*
  val () = begin
    print "e1xplevenv_valize: e0 = "; print e0; print_newline ()
  end // end of [val]
*)
//
in
//
if lev <= MAXLEV then let
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
| E1XPint (i) => V1ALint (i)
| E1XPintrep (rep) => let
    val v = e1xp_valize_int (rep) in V1ALint (v)
  end // end of [E1XPi0nt]
| E1XPchar (x) => V1ALchar (x)
| E1XPstring (x) => V1ALstring (x)
| E1XPfloat (x) => V1ALfloat (double_of_string x)
//
| E1XPv1al (v) => v
//
| E1XPnone () => V1ALint (0)
//
| E1XPundef () => let
    val () =
      the_valerrlst_add (VE_E1XPundef (e0)) in V1ALerr()
    // end of [val]
  end // end of [E1XPundef]
//
| E1XPapp
  (
    e_fun, _(*loc_arg*), es_arg
  ) => (
    case+
    e_fun.e1xp_node of
    | E1XPide id => (
        e1xplevenv_valize_appid (lev, env, e0, id, es_arg)
     ) // end of [E1XPide]
    | _ (*non-ide*) => let
        val () =
          the_valerrlst_add (VE_E1XPapp_fun(e0)) in V1ALerr()
        // end of [val]
      end (* end of [_] *)
  ) (* end of [E1XPapp] *)
//
| E1XPif (_cond, _then, _else) => let
    val _cond =
      e1xplevenv_valize (lev, env, _cond)
    // end of [val]
  in
    case+ _cond of
    | V1ALerr() => V1ALerr()
    | _ (*non-V1ALerr*) => let
        val _taken = (
          if v1al_is_true (_cond) then _then else _else
        ) : e1xp // end of [val]
      in
        e1xplevenv_valize (lev, env, _taken)
      end (* end of [non-V1ALerr] *)
  end
//
| E1XPlist (es) =>
    e1xplevenv_valize_list (lev, env, e0, es)
  // end of [E1XPlist]
//
| E1XPeval (e1) => e1xplevenv_valize (lev, env, e1) // HX: right?
//
| E1XPfun _ => V1ALerr () where {
    val () = the_valerrlst_add (VE_E1XPfun (e0))
  }
//
| E1XPerr () => V1ALerr () where {
    val () = the_valerrlst_add (VE_E1XPerr (e0))
  }
//
end // end of [e1xplevenv_valize_main]

(* ****** ****** *)

fn
e1xplevenv_valize_neg
(
  lev: int, env: !vlenv
, e0: e1xp, id: symbol, e1: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
in
  case+ (v1) of
  | (V1ALint i1) => V1ALint (~i1)
  | (V1ALfloat f1) => V1ALfloat(~f1)
  | _(*non-number*) => V1ALerr () where {
      val () = the_valerrlst_add(VE_opr_arglst(e0, id))
    }
end // end of [e1xplevenv_valize_neg]

(* ****** ****** *)

fn
e1xplevenv_valize_add
(
  lev: int, env: !vlenv
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

fn
e1xplevenv_valize_sub
(
  lev: int, env: !vlenv
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

fn
e1xplevenv_valize_mul
(
  lev: int, env: !vlenv
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

fn
e1xplevenv_valize_div
(
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
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
  lev: int, env: !vlenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => let
      val i2 = int1_of_int i2
      val () = if (i2 < 0) then {
        val () = prerr_location (e0.e1xp_loc)
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
  lev: int, env: !vlenv
, e0: e1xp, id: symbol, e1: e1xp, e2: e1xp
) : v1al = let
  val v1 = e1xplevenv_valize (lev, env, e1)
  val v2 = e1xplevenv_valize (lev, env, e2)
in
  case+ (v1, v2) of
  | (V1ALint i1, V1ALint i2) => let
      val i2 = int1_of_int i2
      val () = if (i2 < 0) then {
        val () = prerr_location (e0.e1xp_loc)
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
oprarity_err () = V1ALerr () where {
  val () = the_valerrlst_add (VE_E1XPappid_arity (e0, id))
} // end of [oprarity_err]
//
in
//
case+ 0 of
| _ when id = DEFINED => (
  case+ es of
  | e :: nil () => e1xp_valize_defined(e)
  | _ => oprarity_err ()
  )
| _ when id = UNDEFINED => (
  case+ es of
  | e :: nil () => e1xp_valize_undefined(e)
  | _ => oprarity_err ()
  )
//
| _ when id = NEG => (
  case+ es of
  | e1 :: nil () => e1xplevenv_valize_neg(lev, env, e0, id, e1)
  | _ => oprarity_err ()
  )
//
| _ when id = ADD => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_add(lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = SUB => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_sub(lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = MUL => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_mul(lev, env, e0, id, e1, e2)
  | _ => oprarity_err ()
  )
| _ when id = DIV => (
  case+ es of
  | e1 :: e2 :: nil () => e1xplevenv_valize_div(lev, env, e0, id, e1, e2)
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
end // end of [e1xplevenv_valize_delta]

(* ****** ****** *)

extern
fun e1xplev_normalize
  (lorg: location, lev: int, e0: e1xp): e1xp
// end of [e1xplev_normalize]

extern
fun e1xplevenv_normalize
  (lorg: location, lev: int, env: !elenv, e0: e1xp): e1xp
// end of [e1xplevenv_normalize]

extern
fun e1xplevenv_normalize_main
  (lorg: location, lev: int, env: !elenv, e0: e1xp): e1xp
// end of [e1xplevenv_normalize_main]

(* ****** ****** *)

implement
e1xp_normalize (e0) =
  e1xplev_normalize (e0.e1xp_loc, 0(*lev*), e0)
// end of [e1xp_normalize]

implement
e1xplev_normalize
  (lorg, lev, e0) = res where {
  val env = lenvmake_nil ()
  val res = e1xplevenv_normalize (lorg, lev, env, e0)
  val () = lenvfree (env)
} // end of [e1xplev_normalize]

(* ****** ****** *)

fn e1xplevenv_normalize_ide (
  lorg: location
, lev: int, env: !elenv, e0: e1xp, x: symbol
) : e1xp = let
  val ans = lenvfind (env, x)
in
//
case+ ans of
| ~Some_vt e => e
| ~None_vt _ => (
  case+ the_e1xpenv_find (x) of
  | ~Some_vt e =>
      e1xplev_normalize (lorg, lev+1, e)
    // end of [Some_vt]
  | ~None_vt _ => e1xp_make (lorg, e0.e1xp_node)
  ) // end of [None_vt]
end // end of [e1xplevenv_normalize_ide]

(* ****** ****** *)

fun e1xplstlevenv_normalize (
  lorg: location, lev: int, env: !elenv, es: e1xplst
) : e1xplst = case+ es of
  | list_cons (e, es) => let
      val e = e1xplevenv_normalize (lorg, lev, env, e)
      val es = e1xplstlevenv_normalize (lorg, lev, env, es)
    in
      list_cons (e, es)
    end
  | list_nil () => list_nil ()
// end of [e1xplstlevenv_normalize]

(* ****** ****** *)
(*
//
// HX-2011-04-29: this example works now:
// #define f(n, x) if n > 0 then x * f (n, x)
//
*)
implement
e1xplevenv_normalize
  (lorg, lev, env, e0) = let
//
#define MAXLEV MAX_NORMAL_LEVEL
//
in
  if lev <= MAXLEV then
    e1xplevenv_normalize_main (lorg, lev, env, e0)
  else let
    val () = prerr_error1_loc (lorg)
    val () = prerrf (": the maximal normlization depth (%i) has been reached.", @(lev))
    val () = prerr_newline ()
  in
    e1xp_err (lorg)
  end (* end of [if] *)
end // end of [e1xplevenv_normalize]

implement
e1xplevenv_normalize_main
  (lorg, lev, env, e0) = let
  val node = e0.e1xp_node in case+ node of
  | E1XPide id => e1xplevenv_normalize_ide (lorg, lev, env, e0, id)
//
  | E1XPint _ => e1xp_make (lorg, node)
  | E1XPintrep _ => e1xp_make (lorg, node)
  | E1XPchar _ => e1xp_make (lorg, node)
  | E1XPstring _ => e1xp_make (lorg, node)
  | E1XPfloat _ => e1xp_make (lorg, node)
//
  | E1XPv1al _ => e1xp_make (lorg, node)
//
  | E1XPnone () => e1xp_make (lorg, node)
  | E1XPundef () => e1xp_make (lorg, node)
//
  | E1XPlist es => let
      val es = e1xplstlevenv_normalize (lorg, lev, env, es)
    in
      e1xp_list (lorg, es)
    end
  | E1XPeval (e) => let
      val v =
      e1xp_valize (
        e1xplevenv_normalize (lorg, lev, env, e)
      ) // end of [val]
    in
      e1xp_v1al (lorg, v)
    end (* end of [E1XPeval] *)
//
  | E1XPapp (
      e_fun, _(*loc_arg*), es_arg
    ) => let
      val e_fun = e1xplevenv_normalize (lorg, lev, env, e_fun)
      val es_arg = e1xplstlevenv_normalize (lorg, lev, env, es_arg)
    in
      case+ e_fun.e1xp_node of
      | E1XPfun (xs, body) => res where {
          val env1 = lenvmake_e1xplst (lorg, xs, es_arg)
          val res = e1xplevenv_normalize (lorg, lev+1, env1, body)
          val ((*void*)) = lenvfree (env1)
        } (* end of [E1XPfun] *)
      | _ => e1xp_app (lorg, e_fun, lorg, es_arg)
    end // end of [E1XPapp]
  | E1XPfun _ => e1xp_make (lorg, node)
//
  | E1XPif (
      _cond, _then, _else // HX: specially treated
    ) => let
      val v =
      e1xp_valize (
        e1xplevenv_normalize (lorg, lev, env, _cond)
      ) // end of [val]
      val istt = v1al_is_true (v)
    in
      if istt then
        e1xplevenv_normalize (lorg, lev, env, _then)
      else
        e1xplevenv_normalize (lorg, lev, env, _else)
      // end of [if]
    end (* end of [E1XPif] *)
//
  | E1XPerr _ => e1xp_make (lorg, node)
//
end // end of [e1xplevenv_normalize_main]

(* ****** ****** *)

(* end of [pats_e1xpval.dats] *)
