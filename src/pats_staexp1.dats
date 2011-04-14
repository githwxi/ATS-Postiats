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

staload "pats_syntax.sats"
staload "pats_staexp1.sats"

(* ****** ****** *)

implement
e1xp_app (
  loc, e_fun, loc_arg, es_arg
) = '{
  e1xp_loc= loc, e1xp_node= E1XPapp (e_fun, loc_arg, es_arg)
} // end of [e1xp_app]

implement
e1xp_char (loc, c) = '{
  e1xp_loc= loc, e1xp_node= E1XPchar c
} // end of [e1xp_char]

implement
e1xp_float (loc, f) = '{
  e1xp_loc= loc, e1xp_node= E1XPfloat (f: string)
} // end of [e1xp_float]

implement
e1xp_ide (loc, id) = '{
  e1xp_loc= loc, e1xp_node= E1XPide (id: symbol)
} // end of [e1xp_ide]

implement
e1xp_int (loc, int) = '{
  e1xp_loc= loc, e1xp_node= E1XPint (int: string)
} // end of [e1xp_int]

implement
e1xp_list (loc, es) = '{
  e1xp_loc= loc, e1xp_node= E1XPlist (es: e1xplst)
} // end of [e1xp_list]

implement
e1xp_none (loc) = '{
  e1xp_loc= loc, e1xp_node= E1XPnone ()
} // end of [e1xp_none]

implement
e1xp_string (loc, str) = '{
  e1xp_loc= loc, e1xp_node= E1XPstring (str)
} // end of [e1xp_string]

implement
e1xp_undef (loc) = '{
  e1xp_loc= loc, e1xp_node= E1XPundef ()
} // end of [e1xp_undef]

(* ****** ****** *)

implement e1xp_true  (loc) = e1xp_int (loc, "1")
implement e1xp_false (loc) = e1xp_int (loc, "0")

(* ****** ****** *)

implement v1al_true = V1ALint 1
implement v1al_false = V1ALint 0

(* ****** ****** *)

(*
** HX: functions for constructing sorts
*)

macdef MINUSGT = $SYM.symbol_MINUSGT
overload = with $SYM.eq_symbol_symbol

fn s0rtq_is_none (q: s0rtq): bool =
  case+ q.s0rtq_node of S0RTQnone () => true | _ => false
// end of [s0rtq_is_none]

(* ****** ****** *)

implement
s1rt_arrow (loc) = let
  val q = s0rtq_none (loc) in '{
  s1rt_loc= loc, s1rt_node= S1RTqid (q, MINUSGT)
} end // end of [s1rt_arrow]

(* '->' is a special sort constructor *)
implement
s1rt_is_arrow (s1t) =
  case+ s1t.s1rt_node of
  | S1RTqid (q, id) =>
      if s0rtq_is_none q then id = MINUSGT else false
    // end of [S1RTqid]
  | _ => false
// end of [s1rt_is_arrow]

(* ****** ****** *)

implement
s1rt_app (
  loc, s1t_fun, s1ts_arg
) = '{
  s1rt_loc= loc, s1rt_node= S1RTapp (s1t_fun, s1ts_arg)
} // end of [s1rt_app]

implement
s1rt_fun (loc, s1t1, s1t2) = let
  val s1ts = list_cons (s1t1, list_cons (s1t2, list_nil))
in '{
  s1rt_loc= loc, s1rt_node= S1RTapp (s1rt_arrow (loc), s1ts)
} end // end of [s1rt_fun]

implement
s1rt_ide (loc, id) = let
  val q = s0rtq_none (loc) in '{
  s1rt_loc= loc, s1rt_node= S1RTqid (q, id)
} end // end of [s1rt_ide]

implement
s1rt_list
  (loc, s1ts) = case+ s1ts of
  | list_cons (s1t, list_nil ()) => s1t // singleton elimination
  | _ => '{
      s1rt_loc= loc, s1rt_node= S1RTlist s1ts
    } // end of [_]
// end of [s1rt_list]

implement
s1rt_qid (loc, q, id) = '{
  s1rt_loc= loc,  s1rt_node= S1RTqid (q, id)
} // end of [s1rt_qid]

(*
implement
s1rt_tup (loc, s1ts) = '{
  s1rt_loc= loc, s1rt_node= S1RTtup s1ts
} // end of [s1rt_tup]
*)

implement
s1rt_type (loc, knd) = '{
  s1rt_loc= loc, s1rt_node= S1RTtype (knd)
}

(* ****** ****** *)

implement
s1rtpol_make (loc, s1t, pol) = '{
  s1rtpol_loc= loc, s1rtpol_srt= s1t, s1rtpol_pol= pol
} // end of [s1rtpol_make]

(* ****** ****** *)

(* end of [pats_staexp1.dats] *)
