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

staload "./pats_staexp1.sats"
staload "./pats_e1xpval.sats"

(* ****** ****** *)

implement
fprint_valerr
  (out, x) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ x of
| VE_valize (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression cannot be evaluated to a value."
    val () = fprint_newline (out)
  }
| VE_valize_defined (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression is expected to be an indentifer."
    val () = fprint_newline (out)
  }
| VE_valize_undefined (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression is expected to be an indentifer."
    val () = fprint_newline (out)
  }
| VE_maxlevel (lev, e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = fprintf (
      out, ": error(1): the maximal evaluation depth (%i) has been reached.", @(lev)
    ) // end of [val]
    val () = fprint_newline (out)
  }
| VE_opr_arglst (e0, id) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the operator ["
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr "] cannot handle its argument(s)."
    val () = fprint_newline (out)
  }
| VE_E1XPide_unbound (e0) => {
    val loc0 = e0.e1xp_loc
    val-E1XPide (id) = e0.e1xp_node
    val () = $LOC.fprint_location (out, loc0)
    val () = prstr ": error(1): the identifier ["
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr "] is unbound."
    val () = fprint_newline (out)
  }
| VE_E1XPundef (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression cannot be evaluated as it is un-defined."
    val () = fprint_newline (out)
  }
| VE_E1XPlist (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression cannot be evaluated as it is a tuple."
    val () = fprint_newline (out)
  }
| VE_E1XPapp_fun (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the applied expression is required to be an identifier."
    val () = fprint_newline (out)
  }
| VE_E1XPappid_fun (e0, id) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the applied identifier ["
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr "] does not refer to a function."
    val () = fprint_newline (out)
  }
| VE_E1XPappid_opr (e0, id) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the applied identifier ["
    val () = $SYM.fprint_symbol (out, id)
    val () = prstr "] does not refer to a supported operator."
    val () = fprint_newline (out)
  }
| VE_E1XPappid_arity (e0, id) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): arity mismatch for this function application."
    val () = fprint_newline (out)
  }
| VE_E1XPfun (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression cannot be evaluated as it is a function."
    val () = fprint_newline (out)
  }
| VE_E1XPerr (e0) => {
    val () = $LOC.fprint_location (out, e0.e1xp_loc)
    val () = prstr ": error(1): the expression cannot be evaluated as it indicates an error."
    val () = fprint_newline (out)
  }
//
end // end of [fprint_valerr]

(* ****** ****** *)

viewtypedef
valerrlst_vt = List_vt (valerr)
extern fun the_valerrlst_get (): valerrlst_vt

(* ****** ****** *)

local

val the_valerrlst = ref<valerrlst_vt> (list_vt_nil)

in // in of [local]

implement
the_valerrlst_add
  (x) = () where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_valerrlst)
  val () = !p := list_vt_cons (x, !p)
} // end of [the_valerrlst_add]

implement
the_valerrlst_get
  () = xs where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_valerrlst)
  val xs = !p
  val () = !p := list_vt_nil ()
} // end of [the_valerrlst_get]

end // end of [local]

(* ****** ****** *)

implement
fprint_the_valerrlst
  (out) = let
  val xs = the_valerrlst_get ()
  fun loop (
    out: FILEref, xs: valerrlst_vt
  ) : void =
    case+ xs of
    | ~list_vt_cons (x, xs) => (
        fprint_valerr (out, x); loop (out, xs)
      ) // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [loop]
in
  loop (out, xs)
end // end of [fprint_the_valerrlst]

(* ****** ****** *)

(* end of [pats_e1xpval_error.dats] *)
