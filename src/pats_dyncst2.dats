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
// Start Time: January, 2013
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)
//
staload SYM = "./pats_symbol.sats"
//
overload prerr with $SYM.prerr_symbol
//
(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_stacst2"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
staload "./pats_dyncst2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

abstype d2cstnul (l:addr)
typedef d2cstnul = [l:agez] d2cstnul (l)

extern
castfn d2cstnul_none (x: ptr null):<> d2cstnul (null)

extern
castfn d2cstnul_some (x: d2cst):<> [l:agz] d2cstnul (l)
extern
castfn d2cstnul_unsome {l:agz} (x: d2cstnul l):<> d2cst

extern
fun d2cstnul_is_null {l:addr}
  (x: d2cstnul (l)): bool (l==null) = "atspre_ptr_is_null"
// end of [d2cstnul_is_null]
extern
fun d2cstnul_isnot_null {l:addr}
  (x: d2cstnul (l)): bool (l > null) = "atspre_ptr_isnot_null"
// end of [d2cstnul_isnot_null]

(* ****** ****** *)

local

typedef
symd2cst_struct = @{
  sym= symbol, cst= d2cstnul
} // end of [symd2cst_struct]

assume d2cstref_type = ref (symd2cst_struct)

in (* in of [local] *)

fun d2cstref_get_sym
  (r: d2cstref): symbol = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->sym
end // end of [d2cstref_get_sym]

(* ****** ****** *)

fun d2cstref_get_cstnul
  (r: d2cstref): d2cstnul = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->cst
end // end of [d2cstref_get_cstnul]
fun d2cstref_set_cstnul
  (r: d2cstref, d2c: d2cstnul): void = let
  val (vbox pf | p) = ref_get_view_ptr (r) in p->cst := d2c
end // end of [d2cstref_set_cstnul]

(* ****** ****** *)

implement
d2cstref_make (name) = let
  val id = $SYM.symbol_make_string (name)
  val (pfgc, pfat | p) = ptr_alloc<symd2cst_struct> ()
  prval () = free_gc_elim (pfgc)
  val () = (p->sym := id; p->cst := d2cstnul_none (null))
in
  ref_make_view_ptr (pfat | p)
end  // end of [d2cstref_make]

end // end of [local]

(* ****** ****** *)

implement
d2cstref_get_cst (r) = let
//
fn auxerr
  (id: symbol): d2cst = let
  val () = prerr_interror ()
  val () = prerr ": d2cstref_get_cst"
  val () = prerrln! (": the pervasive dynamic constant [", id, "] is not available.")
in
  $ERR.abort_interr{d2cst}((*reachable*))
end (* end of [auxerr] *)
//
val d2c = d2cstref_get_cstnul (r)
val isnul = d2cstnul_is_null (d2c)
//
in
//
if
isnul
then let
  val id = d2cstref_get_sym (r)
  val ans = the_d2expenv_pervasive_find (id)
in
//
case+ ans of
| ~Some_vt (s2i) => (
  case+ s2i of
  | D2ITMcst (d2c) => let
      val () = d2cstref_set_cstnul (r, d2cstnul_some (d2c))
    in
      d2c
    end // end of [D2ITMcst]
  | _ => auxerr (id)
  ) // end of [Some_vt]
| ~None_vt ((*void*)) => auxerr (id)
//
end // end of [then]
else d2cstnul_unsome (d2c)
//
end // end of [d2cstref_get_cst]

(* ****** ****** *)

implement
d2cstref_equ_cst (r, d2c) =
  eq_d2cst_d2cst (d2cstref_get_cst (r), d2c)
// end of [d2cstref_equ_cst]

(* ****** ****** *)

implement
the_sizeof_vt0ype_size = d2cstref_make ("sizeof")

(* ****** ****** *)

implement
d2cst_is_sizeof (d2c) =
  d2cstref_equ_cst (the_sizeof_vt0ype_size, d2c)
// end of [d2cst_is_sizeof]

(* ****** ****** *)

implement dyncst2_initialize () = ()

(* ****** ****** *)

(* end of [pats_dyncst2.dats] *)
