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
// Start Time: May, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload SYM = "pats_symbol.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_stacst2"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_trans2_env.sats"
staload "pats_stacst2.sats"

(* ****** ****** *)

abstype s2cstnul (l:addr)
typedef s2cstnul = [l:agez] s2cstnul (l)

extern
castfn s2cstnul_none (x: ptr null):<> s2cstnul (null)

extern
castfn s2cstnul_some (x: s2cst):<> [l:agz] s2cstnul (l)
extern
castfn s2cstnul_unsome {l:agz} (x: s2cstnul l):<> s2cst

extern
fun s2cstnul_is_null {l:addr}
  (x: s2cstnul (l)): bool (l==null) = "atspre_ptr_is_null"
// end of [s2cstnul_is_null]
extern
fun s2cstnul_isnot_null {l:addr}
  (x: s2cstnul (l)): bool (l > null) = "atspre_ptr_isnot_null"
// end of [s2cstnul_isnot_null]

(* ****** ****** *)

local

typedef
syms2cst_struct = @{
  sym= symbol, cst= s2cstnul
} // end of [syms2cst_struct]

assume s2cstref_type = ref (syms2cst_struct)

in // in of [local]

fun s2cstref_get_sym
  (r: s2cstref): symbol = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->sym
end // end of [s2cstref_get_sym]

fun s2cstref_get_cstnul
  (r: s2cstref): s2cstnul = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->cst
end // end of [s2cstref_get_cstnul]
fun s2cstref_set_cstnul
  (r: s2cstref, s2c: s2cstnul): void = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->cst := s2c
end // end of [s2cstref_set_cstnul]

implement
s2cstref_make (name) = let
  val id = $SYM.symbol_make_string (name)
  val (pfgc, pfat | p) = ptr_alloc<syms2cst_struct> ()
  prval () = free_gc_elim (pfgc)
  val () = (p->sym := id; p->cst := s2cstnul_none (null))
in
  ref_make_view_ptr (pfat | p)
end  // end of [s2cstref_make]

end // end of [local]

(* ****** ****** *)

implement
s2cstref_get_cst (r) = let
//
fn auxerr (id: symbol) = let
  val () = prerr_interror ()
  val () = prerr ": s2cstref_get_cst: "
  val () = prerr "the pervasive static constant ["
  val () = $SYM.prerr_symbol (id)
  val () = prerr "] is not available."
  val () = prerr_newline ();
in
  $ERR.abort {s2cst} ()
end (* end of [auxerr] *)
//
  val s2c = s2cstref_get_cstnul (r)
  val isnul = s2cstnul_is_null (s2c)
//
in
//
if isnul then let
  val id = s2cstref_get_sym (r)
  val ans = the_s2expenv_pervasive_find (id)
in
  case+ ans of
  | ~Some_vt (s2i) => (
    case+ s2i of
    | S2ITMcst s2cs => let
        val- list_cons (s2c, _) = s2cs
        val () = s2cstref_set_cstnul (r, s2cstnul_some (s2c))
      in
        s2c
      end // end of [S2ITMcst]
    | _ => auxerr (id)
    ) // end of [Some_vt]
  | ~None_vt () => auxerr (id)
end else
  s2cstnul_unsome (s2c)
// end of [if]
end // end of [s2cstref_get_cst]

(* ****** ****** *)

implement
the_exception_viewtype = s2cstref_make "exception_viewtype"

(* ****** ****** *)

(* end of [pats_stacst2.dats] *)
