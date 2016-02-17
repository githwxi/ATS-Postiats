(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/list0.sats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)
//
implement
parerr_make
  (loc, node) = '{
  parerr_loc=loc, parerr_node=node
} (* end of [parerr_make] *)
//
(* ****** ****** *)
//
implement
the_parerrlst_insert2
  (loc, node) =
(
  the_parerrlst_insert(parerr_make(loc, node))
) (* the_parerrlst_insert2 *)
//
(* ****** ****** *)

implement
the_parerrlst_print_free
  ((*void*)) = let
//
val out = stderr_ref
//
fun
auxlst
(
  xs: List_vt(parerr), n: int
) : int =
(
case+ xs of
| ~list_vt_nil() => n
| ~list_vt_cons(x, xs) =>
  (
    fprint_parerr(out, x); auxlst(xs, n+1)
  )
) (* end of [auxlst] *)
//
in
//
  auxlst(the_parerrlst_pop_all(), 0(*nerr*))
//
end // end of [the_parerrlst_print_free]
//
(* ****** ****** *)
//
extern
fun
fprint_parerr_node: fprint_type(parerr_node)
//
(* ****** ****** *)
//
implement
fprint_parerr(out, x0) =
{
  val () = fprint(out, x0.parerr_loc)
  val () = fprint_parerr_node(out, x0.parerr_node)
}
//
implement
fprint_parerr_node
  (out, node) = let
in
//
case+ node of
| PARERR_SQUOTE(loc0) =>
    fprintln! (out, ": the single-quote at (", loc0, ") is not closed.")
| PARERR_DQUOTE(loc0) =>
    fprintln! (out, ": the double-quote at (", loc0, ") is not closed.")
| PARERR_FUNARG(loc0) =>
    fprintln! (out, ": the funarg starting at (", loc0, ") is not closed.")
| PARERR_EXTCODE(loc0) =>
    fprintln! (out, ": the ext-code starting at (", loc0, ") is not closed.")
//
end // end of [fprint_parerr_node]
//
(* ****** ****** *)

(* end of [atexting_parerr.dats] *)
