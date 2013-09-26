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

staload UT = "./pats_utils.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload LOC = "./pats_location.sats"
overload + with $LOC.location_combine
//
staload SYM = "./pats_symbol.sats"
//
macdef BACKSLASH = $SYM.symbol_BACKSLASH
//
overload = with $SYM.eq_symbol_symbol
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans1_e0xp"

(* ****** ****** *)

staload "./pats_lexing.sats"

(* ****** ****** *)

staload "./pats_fixity.sats"
staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"

(* ****** ****** *)

staload "./pats_trans1.sats"
staload "./pats_trans1_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

implement
do_e0xpact_prerr
  (v) = case+ v of
  | V1ALint i => prerr i
  | V1ALchar c => prerr c
  | V1ALstring s => prerr s
  | V1ALfloat f => prerr f
  | V1ALerr () => let
      val () = assertloc (false) in (*deadcode*)
    end (* end of [V1ALerr] *)
// end of [do_e0xpact_prerr]

(* ****** ****** *)

implement
do_e0xpact_error
  (loc, v) = let
//
  val () = prerr_error1_loc (loc)
  val () = prerr ": [#error] directive is encountered: "
//
  val () = (case+ v of
    | V1ALint i => prerr i
    | V1ALchar c => prerr c
    | V1ALstring s => prerr s
    | V1ALfloat f => prerr f
    | V1ALerr () => let
        val () = assertloc (false) in (*deadcode*)
      end (* end of [V1ALerr] *)
  ) : void // end of [val]
in
  exit {void} (1)
end // end of [do_e0xpact_error]

(* ****** ****** *)

implement
do_e0xpact_assert
  (loc, v) = let
  val is_false = (
    case+ v of
    | V1ALint i => i = 0
    | V1ALstring s => let
        val s = string1_of_string s in string_is_empty s
      end // end of [V1ALstring]
    | V1ALfloat f => f = 0.0
    | V1ALchar c => c = '\0'
    | V1ALerr () => let
        val () = assertloc (false) in false // HX: this should be deadcode!
      end (* end of [V1ALerr] *)
  ) : bool // end of [val]
in
  if is_false then let
    val () = prerr_error1_loc loc
    val () = prerr ": [#assert] failed!"
    val () = prerr_newline ()
  in
    exit {void} (1)
  end // end of [if]
end // end of [do_e0xpact_assert]

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
  val loc_fun = _fun.e1xp_loc
  val loc_arg = _arg.e1xp_loc
  val loc = loc_fun + loc_arg
  val xs_arg = (
    case+ _arg.e1xp_node of
    | E1XPlist xs => xs | _ => list_sing (_arg)
  ) : e1xplst // end of [val]
  val _app = e1xp_app (loc, _fun, loc_arg, xs_arg)
in
  FXITMatm (_app)
end // end of [appf]

in (* in of [local] *)

fn e1xpitm_app
  (loc: location): e1xpitm = fxitm_app (loc, appf)
// end of [e1xpitm]

end // end of [local]

(* ****** ****** *)

fn e1xp_get_loc (x: e1xp): location = x.e1xp_loc

fn e1xp_make_opr (
  opr: e1xp, f: fxty
) : e1xpitm = (
  fxopr_make {e1xp} (
    e1xp_get_loc
  , lam (loc, x, loc_arg, xs) => e1xp_app (loc, x, loc_arg, xs)
  , opr, f
  ) // end of [e1xp_make_opr]
) (* end of [e1xp_make_opr] *)

fn e1xpitm_backslash
  (loc_opr: location) = (
  fxopr_make_backslash {e1xp} (
    lam x => x.e1xp_loc
  , lam (loc, x, loc_arg, xs) => e1xp_app (loc, x, loc_arg, xs)
  , loc_opr
  ) // end of [fxopr_make_backslash]
) (* end of [e1xpitm_backslash] *)

(* ****** ****** *)

local

fn e0xp_tr_errmsg_opr
  (e0: e0xp): e1xp = let
  val loc0 = e0.e0xp_loc
  val () = prerr_error1_loc (loc0)
  val () = prerr ": the operator needs to be applied."
  val () = prerr_newline ()
  val () = the_trans1errlst_add (T1E_e0xp_tr (e0))
in
  e1xp_err (loc0)
end // end of [e0xp_tr_errmsg_opr]

fn e0xp_tr_errmsg_float
  (e0: e0xp): void = let
  val () = prerr_error1_loc (e0.e0xp_loc)
  val () = prerr ": the floating point number is required to be of base 10."
  val () = prerr_newline ()
  val () = the_trans1errlst_add (T1E_e0xp_tr (e0))
in
  // nothing
end // end of [e0xp_tr_errmsg_float]

in (* in of [local] *)
  
implement e0xp_tr (e0) = let
//
fun aux_item (e0: e0xp): e1xpitm = let
  val loc0 = e0.e0xp_loc in case+ e0.e0xp_node of
//
  | E0XPide id when
      id = BACKSLASH => e1xpitm_backslash (loc0)
  | E0XPide id => let
      val opt = the_fxtyenv_find (id)
    in
      case+ opt of
      | ~None_vt () => FXITMatm (e1xp_ide (loc0, id))
      | ~Some_vt (fxty) => let
          val e = e1xp_ide (loc0, id) in e1xp_make_opr (e, fxty)
        end // end of [Some_vt]
    end // E0XPide(non-backslash)
//
  | E0XPint (x) => let
      val-T_INTEGER
        (base, rep, sfx) = x.token_node
    in
      FXITMatm (e1xp_intrep (loc0, rep))
    end // end of [E0XPint]
//
  | E0XPchar (x) => let
      val-T_CHAR (c) =
        x.token_node in FXITMatm (e1xp_char (loc0, c))
      // end of [val]
    end // end of [E0XPchar]
//
  | E0XPstring (x) => let
      val-T_STRING (str) =
        x.token_node in FXITMatm (e1xp_string (loc0, str))
      // end of [val]
    end // end of [E0XPstring]
  | E0XPstringid (str) => FXITMatm (e1xp_string (loc0, str))
//
  | E0XPfloat (x) => let
      val-T_FLOAT
        (base, rep, sfx) = x.token_node
      val () = if base != 10 then e0xp_tr_errmsg_float (e0)
    in
      FXITMatm (e1xp_float (loc0, rep))
    end // end of [E0XPfloat]
//
  | E0XPlist (es) =>
      FXITMatm (e1xp_list (loc0, e0xplst_tr (es)))
//
  | E0XPapp _ => let
      val e0_new =
      fixity_resolve (
        loc0, e1xp_get_loc, e1xpitm_app (loc0), aux_itemlst e0
      ) // end of [val]
    in
      FXITMatm (e0_new)
    end // end of [E0XPapp]
//
  | E0XPfun (arg, body) =>
      FXITMatm (e1xp_fun (loc0, arg, e0xp_tr (body)))
//
  | E0XPif (
      e0_cond, e0_then, e0_else
    ) => let
      val e1_cond = e0xp_tr (e0_cond)
      val e1_then = e0xp_tr (e0_then)
      val e1_else = (
        case e0_else of Some x => e0xp_tr (x) | None _ => e1xp_none (loc0)
      ) : e1xp (* end of [val] *)
    in
      FXITMatm (e1xp_if (loc0, e1_cond, e1_then, e1_else))
    end // end of [E0Xpif]
//
  | E0XPeval (e) => FXITMatm (e1xp_eval (loc0, e0xp_tr e))
//
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
| FXITMopr _ => e0xp_tr_errmsg_opr (e0)
//
end // end of [e0xp_tr]

end // end of [local]

implement
e0xplst_tr (es) = l2l (list_map_fun (es, e0xp_tr))

(* ****** ****** *)

(* end of [pats_trans1_e0xp.dats] *)
