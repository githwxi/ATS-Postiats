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

staload SYN = "pats_syntax.sats"

(* ****** ****** *)

staload "pats_symmap.sats"
staload "pats_symenv.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_namespace.sats"
staload "pats_trans2_env.sats"

(* ****** ****** *)

local

viewtypedef
filenv_struct = @{
  sort= s2temap, sexp= s2itmmap, dexp= d2itmmap
} // end of [filenv_struct]

assume filenv_type = ref (filenv_struct)

in // in of [local]

implement
filenv_get_s2temap (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv)
  prval (pf1, fpf1) = __assert (view@ (p->sort)) where {
    extern prfun __assert {a:viewt@ype} {l:addr} (pf: !a @ l): (a @ l, minus (filenv, a @ l))
  } // end of [prval]
in
  (pf1, fpf1 | &p->sort)
end // end of [filenv_get_s2temap]

implement
filenv_get_s2itmmap (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv)
  prval (pf1, fpf1) = __assert (view@ (p->sexp)) where {
    extern prfun __assert {a:viewt@ype} {l:addr} (pf: !a @ l): (a @ l, minus (filenv, a @ l))
  } // end of [prval]
in
  (pf1, fpf1 | &p->sexp)
end // end of [filenv_get_s2itmmap]

end // end of [local]

(* ****** ****** *)

local

viewtypedef s2rtenv = symenv (s2rtext)
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {s2rtenv} (pf | p0)

(* ****** ****** *)

fun
the_s2rtenv_find_namespace .<>.
  (id: symbol): s2rtextopt_vt = let
  fn f (
    fenv: filenv
  ) :<cloptr1> s2rtextopt_vt = let
    val (pf, fpf | p) = filenv_get_s2temap (fenv)
    val ans = symmap_search (!p, id)
    prval () = minus_addback (fpf, pf | fenv)
  in
    ans
  end // end of [f]
in
  the_namespace_search (f)
end // end of [the_s2rtenv_find_namespace]

(* ****** ****** *)

in // in of [local]

implement
the_s2rtenv_find (id) = let
  val ans = let
    prval vbox pf = pf0 in symenv_search (!p0, id)
  end // end of [val]
in
//
case+ ans of
| Some_vt _ => (fold@ ans; ans)
| ~None_vt () => let
    val ans = the_s2rtenv_find_namespace (id)
  in
    case+ ans of
    | Some_vt _ => (fold@ ans; ans)
    | ~None_vt () => let
        prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_s2rtenv_find]

(* ****** ****** *)

implement
the_s2rtenv_find_qua (q, id) = let
// (*
  val () = print "the_s2rtenv_find_qua: qid = "
  val () = $SYN.print_s0rtq (q)
  val () = $SYM.print_symbol (id)
  val () = print_newline ()
// *)
in
//
case+ q.s0rtq_node of
| $SYN.S0RTQnone _ => the_s2rtenv_find (id)
| $SYN.S0RTQsymdot _ => None_vt ()
//
end // end of [the_s2rtenv_find_qua]

end // end of [local]

(* ****** ****** *)

local

viewtypedef s2expenv = symenv (s2itm)
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {s2expenv} (pf | p0)

fun
the_s2expenv_find_namespace .<>.
  (id: symbol): s2itmopt_vt = let
  fn f (
    fenv: filenv
  ) :<cloptr1> s2itmopt_vt = let
    val (pf, fpf | p) = filenv_get_s2itmmap (fenv)
    val ans = symmap_search (!p, id)
    prval () = minus_addback (fpf, pf | fenv)
  in
    ans
  end // end of [f]
in
  the_namespace_search (f)
end // end of [the_s2expenv_find_namespace]

in

implement
the_s2expenv_find (id) = let
  val ans = let
    prval vbox pf = pf0 in symenv_search (!p0, id)
  end // end of [val]
in
//
case+ ans of
| Some_vt _ => (fold@ ans; ans)
| ~None_vt () => let
    val ans = the_s2expenv_find_namespace (id)
  in
    case+ ans of
    | Some_vt _ => (fold@ ans; ans)
    | ~None_vt () => let
        prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_s2expenv_find]

(* ****** ****** *)

implement
the_s2expenv_find_qua (q, id) = let
// (*
  val () = print "the_s2expenv_find_qua: qid = "
  val () = $SYN.print_s0taq (q)
  val () = $SYM.print_symbol (id)
  val () = print_newline ()
// *)
in
//
case+ q.s0taq_node of
| $SYN.S0TAQnone _ => the_s2expenv_find (id)
| $SYN.S0TAQsymdot _ => None_vt ()
| $SYN.S0TAQsymcolon _ => None_vt ()
//
end // end of [the_s2expenv_find_qua]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans2_env.dats] *)
