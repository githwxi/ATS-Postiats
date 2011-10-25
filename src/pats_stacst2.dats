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

macdef hnf = s2hnf_of_s2exp
macdef unhnf = s2exp_of_s2hnf

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
fn auxerr
  (id: symbol): s2cst = let
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
//
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
//
end else
  s2cstnul_unsome (s2c)
// end of [if]
end // end of [s2cstref_get_cst]

(* ****** ****** *)

implement
the_true_bool = s2cstref_make ("true_bool")
implement
the_false_bool = s2cstref_make ("false_bool")

implement
s2exp_bool (b) = let
  val s2cref = (
    if b then the_true_bool else the_false_bool
  ) : s2cstref // end of [val]
in
  s2exp_cst (s2cstref_get_cst (s2cref))
end // end of [s2exp_bool]

(* ****** ****** *)

implement
the_bool_t0ype = s2cstref_make "bool_t0ype"
implement
the_bool_bool_t0ype = s2cstref_make "bool_bool_t0ype"

implement
s2exp_bool_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_bool_t0ype))
// end of [s2exp_bool_t0ype]

implement
s2exp_bool_bool_t0ype (b) = let
  val s2c = s2cstref_get_cst (the_bool_bool_t0ype)
  val ind = unhnf (s2exp_bool (b))
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_bool_bool_t0ype]

(* ****** ****** *)

implement
the_char_t0ype = s2cstref_make "char_t0ype"
implement
the_char_char_t0ype = s2cstref_make "char_char_t0ype"

implement
s2exp_char_t0ype () =
  s2exp_cst (s2cstref_get_cst (the_char_t0ype))
// end of [s2exp_char_t0ype]

implement
s2exp_char_char_t0ype (c) = let
  val s2c = s2cstref_get_cst (the_char_char_t0ype)
  val ind = unhnf (s2exp_char (c))
in
  s2exp_cstapp (s2c, list_sing (ind))
end // end of [s2exp_char_char_t0ype]

(* ****** ****** *)

implement
the_exception_viewtype = s2cstref_make "exception_viewtype"

(* ****** ****** *)

extern
fun at_viewt0ype_addr_view_assume (): void

implement
stacst2_initialize () = () where {
  val () = at_viewt0ype_addr_view_assume ()
} // end of [stacst2_initialize]

(* ****** ****** *)

implement
the_at_viewt0ype_addr_view =
  s2cstref_make "at_viewt0ype_addr_view" // in prelude/basics_pre.sats
// end of [the_at_viewt0ype_addr_view]

implement
at_viewt0ype_addr_view_assume () = let
  val s2c = s2cstref_get_cst (the_at_viewt0ype_addr_view)
  val s2t_def = s2cst_get_srt (s2c)
  val s2v1 = s2var_make_srt s2rt_viewt0ype and s2v2 = s2var_make_srt s2rt_addr
  val arg1 = s2exp_var (s2v1)
  val arg2 = s2exp_var (s2v2)
  val s2f_body = s2exp_at ((unhnf)arg1, (unhnf)arg2)
  val s2e_def = s2exp_lam_srt (s2t_def, '[s2v1, s2v2], (unhnf)s2f_body)
in
  s2cst_set_def (s2c, Some s2e_def)
end // end of [at_viewt0ype_addr_view_assume]

(* ****** ****** *)

(* end of [pats_stacst2.dats] *)
