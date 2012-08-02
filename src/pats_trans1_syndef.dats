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
// Start Time: April, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload
LOC = "pats_location.sats"
typedef location = $LOC.location
staload
SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
//
macdef symbol_CAR = $SYM.symbol_CAR
macdef symbol_CDR = $SYM.symbol_CDR
macdef symbol_ISNIL = $SYM.symbol_ISNIL
macdef symbol_ISCONS = $SYM.symbol_ISCONS
macdef symbol_ISLIST = $SYM.symbol_ISLIST
//
macdef symbol_TUPZ = $SYM.symbol_TUPZ
overload = with $SYM.eq_symbol_symbol
//
staload SYN = "pats_syntax.sats"
//
(* ****** ****** *)

staload "pats_dynexp1.sats"

(* ****** ****** *)

staload "pats_trans1.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

typedef
syndef_search_all_type =
  (symbol) -<fun1> Option_vt (fsyndef)
extern
fun syndef_search_all : syndef_search_all_type
// end of [extern]

(* ****** ****** *)

local

(* ****** ****** *)

fun fsyndef_CAR (
  loc0: location, d1es: d1explst
) : d1exp = d1exp_macfun (loc0, symbol_CAR, d1es)
fun fsyndef_CDR (
  loc0: location, d1es: d1explst
) : d1exp = d1exp_macfun (loc0, symbol_CDR, d1es)

fun fsyndef_ISNIL (
  loc0: location, d1es: d1explst
) : d1exp = d1exp_macfun (loc0, symbol_ISNIL, d1es)
fun fsyndef_ISCONS (
  loc0: location, d1es: d1explst
) : d1exp = d1exp_macfun (loc0, symbol_ISCONS, d1es)
fun fsyndef_ISLIST (
  loc0: location, d1es: d1explst
) : d1exp = d1exp_macfun (loc0, symbol_ISLIST, d1es)

(* ****** ****** *)

val symbol_PRINT = $SYM.symbol_make_string "print"
val symbol_PRINTLN = $SYM.symbol_make_string "println"

(* ****** ****** *)

fun aux1 (
  loc0: location, fid: d1exp, d1e: d1exp
) : d1exp = let
in
  d1exp_app_dyn (loc0, fid, loc0, ~1(*npf*), list_sing (d1e))
end // end of [aux1]

fun aux1lst (
  loc0: location, fid: d1exp, d1es: d1explst
) : d1explst = let
  val d1es = list_map_cloptr (d1es, lam d1e =<1> aux1 (loc0, fid, d1e))
in
  list_of_list_vt (d1es)
end // end of [aux1lst]

fun aux2 (
  loc0: location, fid: d1exp, d1e: d1exp
) : d1exp = let
in
  case+ d1e.d1exp_node of
  | D1Elist (npf, d1es) =>
      d1exp_seq (loc0, aux1lst (loc0, fid, d1es))
  | _ => aux1 (loc0, fid, d1e)
end // end of [aux2]

fun aux2lst (
  loc0: location, fid: d1exp, d1es: d1explst
) : d1explst = let
  val d1es = list_map_cloptr (d1es, lam d1e =<1> aux2 (loc0, fid, d1e))
in
  list_of_list_vt (d1es)
end // end of [aux2lst]

(* ****** ****** *)

fun fsyndef_TUPZ (
  loc0: location, d1es: d1explst
) : d1exp = d1exp_list (loc0, ~1(*npf*), d1es)

fun fsyndef_PRINT (
  loc0: location, d1es: d1explst
) : d1exp = let
(*
val () = fprintln!
  (stdout_ref, "fsyndef_PRINT: d1es = ", d1es)
// end of [val]
*)
val dq = $SYN.d0ynq_none (loc0)
val fid = d1exp_dqid (loc0, dq, symbol_PRINT)
//
in
  d1exp_seq (loc0, aux2lst (loc0, fid, d1es))
end // end of [fsyndef_PRINT]

fun fsyndef_PRINTLN (
  loc0: location, d1es: d1explst
) : d1exp = let
(*
val () = fprintln!
  (stdout_ref, "fsyndef_PRINTLN: d1es = ", d1es)
// end of [val]
*)
val d1e1 = fsyndef_PRINT (loc0, d1es)
//
val dq = $SYN.d0ynq_none (loc0)
val sym = $SYM.symbol_make_string ("print_newline")
val fid = d1exp_dqid (loc0, dq, sym)
val d1e2 = d1exp_app_dyn (loc0, fid, loc0, ~1(*npf*), list_nil)
//
in
  d1exp_seq (loc0, list_pair (d1e1, d1e2))
end // end of [fsyndef_PRINTLN]

in // in of [local]

implement
syndef_search_all (id) = let
in
//
case+ 0 of
//
| _ when id = symbol_CAR => Some_vt (fsyndef_CAR)
| _ when id = symbol_CDR => Some_vt (fsyndef_CDR)
//
| _ when id = symbol_ISNIL => Some_vt (fsyndef_ISNIL)
| _ when id = symbol_ISCONS => Some_vt (fsyndef_ISCONS)
| _ when id = symbol_ISLIST => Some_vt (fsyndef_ISLIST)
//
| _ when id = symbol_TUPZ => Some_vt (fsyndef_TUPZ)
//
| _ when id = symbol_PRINT => Some_vt (fsyndef_PRINT)
| _ when id = symbol_PRINTLN => Some_vt (fsyndef_PRINTLN)
| _ => None_vt ()
//
end // end of [syndef_search_all]

end // end of [local]

(* ****** ****** *)

implement
d1exp_syndef_resolve
  (loc0, d1e) = begin
  case+ d1e.d1exp_node of
  | D1Eidextapp
      (id, d1es) => let
      val opt = syndef_search_all (id)
    in
      case+ opt of
      | ~Some_vt (f) => let
          val d1es = list_reverse (d1es) in f (loc0, (l2l)d1es)
        end // end of [Some_vt]
      | ~None_vt () => d1e
    end // end of [D1Eidextapp]
  | _ => d1e // end of [_]
end // end of [d1exp_syndef_resolve]

(* ****** ****** *)

(* end of [pats_trans1_syndef.dats] *)
