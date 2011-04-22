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

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "pats_dynexp1.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

typedef
atsyndef_search_all_type =
  (symbol, intlst) -<fun1> Option_vt (fsyndef)
extern
fun atsyndef_search_all : atsyndef_search_all_type
// end of [extern]
implement atsyndef_search_all (_, _) = None_vt ()

(* ****** ****** *)

implement
d1exp_app_syndef (
  loc0, d1e_fun, d1e_arg
) =
  case+ d1e_fun.d1exp_node of
  | D1Eidextapp
      (id, ns, arglst) => let
      val n = (
        case+ d1e_arg.d1exp_node of
        | D1Elist (_(*npf*), d1es) => list_length (d1es) | _ => 1
      ) : int // end of [val]
      val ns = list_cons (n, ns)
      val arglst = list_cons (d1e_arg, arglst)
      val opt = atsyndef_search_all (id, ns)
    in
      case+ opt of
      | ~Some_vt (fsyndef) => fsyndef (loc0, arglst)
      | ~None_vt () => d1exp_idextapp (loc0, id, ns, arglst)
    end // end of [D1Eidexpapp]
  | _ => (case+ d1e_arg.d1exp_node of
    | D1Elist (npf, d1es) => begin
        d1exp_app_dyn (loc0, d1e_fun, d1e_arg.d1exp_loc, npf, d1es)
      end // end of [D1Elist]
    | D1Esexparg s1a => (
      case+ d1e_fun.d1exp_node of
      | D1Eapp_sta (d1e_fun, s1as) =>
          d1exp_app_sta (loc0, d1e_fun, l2l (list_extend (s1as, s1a)))
        // end of [D1Eapp_sta]
      | _ => let
          val s1as = list_sing (s1a) in d1exp_app_sta (loc0, d1e_fun, s1as)
        end // end of [_]
      ) // end of [D1Esexparg]
    | _ => let
        val npf = 0 and d1es = list_sing (d1e_arg) in
        d1exp_app_dyn (loc0, d1e_fun, d1e_arg.d1exp_loc, npf, d1es)
      end // end of [_]    
    ) // end of [_]
// end of [d1exp_app_syndef]

(* ****** ****** *)

implement
d1exp_idextapp_resolve
  (loc0, d1e) = begin
  case+ d1e.d1exp_node of
  | D1Eidextapp (
      id, _(*ns*), d1es_arg
    ) => begin case+ 0 of
    | _ when id = $SYM.symbol_TUPZ =>
        d1exp_list (loc0, ~1(*npf*), l2l (list_reverse (d1es_arg)))
      // end of [_ when ...]
    | _ => d1e
    end // end of [D1Eidextapp]
  | _ => d1e // end of [_]
end // end of [d1exp_idextapp_resolve]

(* ****** ****** *)

(* end of [pats_dynexp1_syndef.dats] *)
