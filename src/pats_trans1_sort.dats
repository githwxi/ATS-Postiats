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

staload ERR = "./pats_error.sats"
staload LOC = "./pats_location.sats"
overload + with $LOC.location_combine

staload SYM = "./pats_symbol.sats"
macdef BACKSLASH = $SYM.symbol_BACKSLASH
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans1_sort"

(* ****** ****** *)

staload "./pats_fixity.sats"
staload "./pats_syntax.sats"
staload "./pats_staexp1.sats"

(* ****** ****** *)

staload "./pats_trans1.sats"
staload "./pats_trans1_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil ())

(* ****** ****** *)
//
// HX: translation of sorts
//
typedef s1rtitm = fxitm (s1rt)
typedef s1rtitmlst = List s1rtitm

(* ****** ****** *)

local

fn appf (
  _fun: s1rt, _arg: s1rt
) :<cloref1> s1rtitm = let
  val loc = _fun.s1rt_loc + _arg.s1rt_loc
  val xs_arg = (
    case+ _arg.s1rt_node of
    | S1RTlist s1ts => s1ts | _ => list_sing (_arg)
  ) : s1rtlst // end of [val]
  val s1t_app = s1rt_app (loc, _fun, xs_arg)
in
  FXITMatm (s1t_app)
end // end of [appf]

in // in of [local]

fn s1rtitm_app
  (loc: location): s1rtitm = fxitm_app (loc, appf)
// end of [s1rtitm_app]

end // end of [local]

(* ****** ****** *)

fn s1rt_get_loc (x: s1rt): location = x.s1rt_loc

fn s1rt_make_opr (
  opr: s1rt, f: fxty
) : s1rtitm = begin
  fxopr_make {s1rt} (
    s1rt_get_loc
  , lam (loc, x, _(*loc_arg*), xs) => s1rt_app (loc, x, xs)
  , opr, f
  ) // end of [oper_make]
end // end of [s1rt_make_opr]

fn s1rtitm_backslash
  (loc_opr: location) = begin
  fxopr_make_backslash {s1rt} (
    lam x => x.s1rt_loc
  , lam (loc, x, _(*loc_arg*), xs) => s1rt_app (loc, x, xs)
  , loc_opr
  ) // end of [oper_make_backslash]
end // end of [s1rtitm_backslash]

(* ****** ****** *)

local

fn s0rt_tr_errmsg_opr
  (s0t0: s0rt): s1rt = let
  val loc0 = s0t0.s0rt_loc
  val () = prerr_error1_loc (loc0)
  val () = prerr ": the operator needs to be applied."
  val () = prerr_newline ()
  val () = the_trans1errlst_add (T1E_s0rt_tr (s0t0))
in
  s1rt_err (loc0)
end // end of [s0rt_tr_errmsg_opr]

in // in of [local]
  
implement s0rt_tr (s0t0) = let
//
fun aux_item
  (s0t0: s0rt): s1rtitm = let
  val loc0 = s0t0.s0rt_loc in case+ s0t0.s0rt_node of
  | S0RTapp _ => let 
      val s1t0 = fixity_resolve (
        loc0, s1rt_get_loc, s1rtitm_app (loc0), aux_itemlst (s0t0)
      ) // end of [val]
    in
      FXITMatm (s1t0)
    end // end of [S0RTapp]
  | S0RTide id
      when id = BACKSLASH => s1rtitm_backslash (loc0)
  | S0RTide id => begin case+ the_fxtyenv_find id of
    | ~Some_vt f => s1rt_make_opr (s1rt_ide (loc0, id), f)
    | ~None_vt () => FXITMatm (s1rt_ide (loc0, id))
    end // end of [S0RTide]
  | S0RTlist xs => FXITMatm (s1rt_list (loc0, s0rtlst_tr xs))
  | S0RTqid (q, id) => FXITMatm (s1rt_qid (loc0, q, id))
(*
  | S0RTtup (xs) => FXITMatm (s1rt_tup (loc0, s0rtlst_tr xs))
*)
  | S0RTtype knd => FXITMatm (s1rt_type (loc0, knd))
end // end of [aux_item]
//
and aux_itemlst
  (s0t0: s0rt): s1rtitmlst = let
  fun loop (
    s0t0: s0rt, res: s1rtitmlst
  ) : s1rtitmlst =
    case+ s0t0.s0rt_node of
    | S0RTapp (s0t1, s0t2) => let
        val res = list_cons (aux_item s0t2, res) in loop (s0t1, res)
      end // end of [S0RTapp]
    | _ => list_cons (aux_item s0t0, res) // end of [_]
  // end of [loop]
in
  loop (s0t0, list_nil ())
end // end of [aux_itemlst]
//
in
//
case+ aux_item s0t0 of
| FXITMatm (s1t) => s1t
| FXITMopr (loc, _) => s0rt_tr_errmsg_opr (s0t0)
// end of [case]
end // end of [s0rt_tr]

end // end of [local]

implement
s0rtlst_tr (s0ts) = l2l (list_map_fun (s0ts, s0rt_tr))

implement
s0rtopt_tr (s0topt) =
  case+ s0topt of Some s0t => Some (s0rt_tr s0t) | None () => None ()
// end of [s0rtopt_tr]

(* ****** ****** *)

implement a0srt_tr (x) =
  a1srt_make (x.a0srt_loc, x.a0srt_sym, s0rt_tr (x.a0srt_srt))
// end of [a0srt_tr]

implement
a0msrt_tr (x) = let
  val arg = l2l (list_map_fun (x.a0msrt_arg, a0srt_tr))
in
  a1msrt_make (x.a0msrt_loc, arg)
end // end of [a0msrt_tr]

implement a0msrtlst_tr (xs) = l2l (list_map_fun (xs, a0msrt_tr))

(* ****** ****** *)

local

fn d0atsrtcon_tr
  (x: d0atsrtcon): d1atsrtcon = let
  val loc = x.d0atsrtcon_loc and nam = x.d0atsrtcon_sym
  val s1ts = (
    case+ x.d0atsrtcon_arg of
    | Some s0t => let
        val s1t = s0rt_tr s0t in
        case+ s1t.s1rt_node of
        | S1RTlist s1ts => s1ts | _ => list_cons (s1t, list_nil ())
      end // end of [Some]
    | None () => list_nil ()
  ) : s1rtlst // end of [val]
in
  d1atsrtcon_make (loc, nam, s1ts)
end // end of [d0atsrtcon_tr]

fn d0atsrtconlst_tr
  (xs: d0atsrtconlst): d1atsrtconlst =
  l2l (list_map_fun (xs, d0atsrtcon_tr))

in // in of [local]

implement
d0atsrtdec_tr (d) = let
  val loc = d.d0atsrtdec_loc
  val name = d.d0atsrtdec_sym
  val conlst = d0atsrtconlst_tr (d.d0atsrtdec_con)
in
  d1atsrtdec_make (loc, name, conlst)
end // end of [d0atsrtdec_tr]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans1_sort.dats] *)
