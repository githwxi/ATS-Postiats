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
// Start Time: October, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

staload "pats_ccomp.sats"

(* ****** ****** *)

local

viewtypedef funlablst_vt = List_vt (funlab)

val the_funlablst = ref_make_elt<funlablst_vt> (list_vt_nil ())

in // in of [local]

implement
the_funlablst_add (fl) = let
  val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
in
  !p := list_vt_cons (fl, !p)
end // end of [the_funlablst_add]

implement
the_funlablst_get () = let
  val xs = xs where {
    val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
    val xs = !p
    val () = !p := list_vt_nil ()
  } // end of [val]
  val xs = list_vt_reverse (xs)
in
  list_of_list_vt (xs)
end // end of [the_funlablst_get]

end // end of [local]

implement
the_funlablst_addlst
  (fls) = list_app_fun (fls, the_funlablst_add)
// end of [the_funlablst_addlst]

(* ****** ****** *)

dataviewtype
markenvlst_vt =
  | MARKENVLSTnil of ()
  | MARKENVLSTmark of (markenvlst_vt)
  | MARKENVLSTcons_var of (d2var, markenvlst_vt)
  | MARKENVLSTcons_impdec of (hiimpdec, markenvlst_vt)
  | MARKENVLSTcons_fundec of (hifundec, markenvlst_vt)
// end of [markenvlst]

(* ****** ****** *)
//
extern
fun markenvlst_vt_free (xs: markenvlst_vt): void
//
implement
markenvlst_vt_free (xs) = let
in
  case+ xs of
  | ~MARKENVLSTnil () => ()
  | ~MARKENVLSTmark (xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_var (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_impdec (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_fundec (_, xs) => markenvlst_vt_free (xs)
end // end of [markenvlst_vt_free]

(* ****** ****** *)
//
extern
fun fprint_markenvlst
  (out: FILEref, xs: !markenvlst_vt): void
//
implement
fprint_markenvlst (out, xs) = let
//
fun loop (
  out: FILEref, xs: !markenvlst_vt, i: int
) : void = let
in
//
case+ xs of
| MARKENVLSTnil () => fold@ (xs)
| MARKENVLSTmark (!p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_string (out, "||")
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTmark]
| MARKENVLSTcons_var
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_d2var (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_var]
| MARKENVLSTcons_impdec
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val imp = !p_x
    val () = fprint_d2cst (out, imp.hiimpdec_cst)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec]
| MARKENVLSTcons_fundec
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val hfd = !p_x
    val () = fprint_d2var (out, hfd.hifundec_var)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_fundec]
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_markenvlst]

(* ****** ****** *)

viewtypedef
ccompenv_struct = @{
  ccompenv_markenvlst = markenvlst_vt
, ccompenv_varbindmap= d2varmap_vt (primval)
} // end of [ccompenv_struct]

(* ****** ****** *)

extern
fun ccompenv_struct_uninitize
  (x: &ccompenv_struct >> ccompenv_struct?): void
// end of [ccompenv_struct_uninitize]

implement
ccompenv_struct_uninitize (x) = let
  val () =
    markenvlst_vt_free (x.ccompenv_markenvlst)
  // end of [val]
  val () = d2varmap_vt_free (x.ccompenv_varbindmap)
in
  // end of [ccompenv_struct_uninitize]
end // end of [ccompenv_struct_uninitize]

(* ****** ****** *)

dataviewtype
ccompenv = CCOMPENV of ccompenv_struct

(* ****** ****** *)

assume ccompenv_vtype = ccompenv

(* ****** ****** *)

implement
ccompenv_make
  () = env where {
  val env = CCOMPENV (?)
  val CCOMPENV (!p) = env
//
  val () = p->ccompenv_markenvlst := MARKENVLSTnil ()
  val () = p->ccompenv_varbindmap := d2varmap_vt_make_nil ()
//
  val () = fold@ (env)
} // end of [ccompenv_make]

(* ****** ****** *)

implement
ccompenv_free (env) = let
in
//
case+ env of
| CCOMPENV (!p_env) => let
    val () = ccompenv_struct_uninitize (!p_env)
  in
    free@ (env)
  end // end of [CCOMPENV]
//
end // end of [ccompenv_free]

(* ****** ****** *)

implement
fprint_ccompenv
  (out, env) = let
in
//
case+ env of
| CCOMPENV (!p_env) => let
    val () = fprint_string (out, "ccompenv_markenvlst: ")
    val () = fprint_markenvlst (out, p_env->ccompenv_markenvlst)
    val () = fprint_newline (out)
  in
    fold@ (env)
  end // end of [CCOMPENV]
//
end // end of [fprint_ccompenv]

(* ****** ****** *)

local

assume ccompenv_push_v = unit_v

fun auxpop (
  map: &d2varmap_vt (primval), xs: markenvlst_vt
) : markenvlst_vt = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in xs
  end // end of [MENVLSTnil]
| ~MARKENVLSTmark (xs) => xs
| ~MARKENVLSTcons_var (d2v, xs) => let
    val _(*removed*) = d2varmap_vt_remove (map, d2v)
  in
    auxpop (map, xs)
  end // end of [MENVLSTcons]
| ~MARKENVLSTcons_impdec (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_fundec (_, xs) => auxpop (map, xs)
//
end // end of [auxpop]

in // in of [local]

implement
ccompenv_pop
  (pfpush | env) = let
//
  prval unit_v () = pfpush
//
  val CCOMPENV (!p) = env
//
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := auxpop (p->ccompenv_varbindmap, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_pop]

implement
ccompenv_push (env) = let
//
  val CCOMPENV (!p) = env
//
  val () = p->ccompenv_markenvlst := MARKENVLSTmark (p->ccompenv_markenvlst)
//
  prval () = fold@ (env)
//
in
  (unit_v | ())
end // end of [ccompenv_push]

end // end of [local]

(* ****** ****** *)

implement
ccompenv_add_varbind
  (env, d2v, pmv) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_var (d2v, xs)
  val _(*inserted*) = d2varmap_vt_insert (p->ccompenv_varbindmap, d2v, pmv)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_varbind]

implement
ccompenv_find_varbind
  (env, d2v) = opt where {
//
  val CCOMPENV (!p) = env
  val opt = d2varmap_vt_search (p->ccompenv_varbindmap, d2v)
  prval () = fold@ (env)
} // end of [ccompenv_add_varbind]

(* ****** ****** *)

implement
ccompenv_add_impdec
  (env, imp) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_impdec (imp, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_impdec]

implement
ccompenv_add_fundec
  (env, hfd) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_fundec (hfd, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_impdec]

(* ****** ****** *)

(* end of [pats_ccomp_ccompenv.dats] *)
