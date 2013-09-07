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
// Start Time: October, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"
//
(* ****** ****** *)
//
staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"
//
(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

vtypedef
exndeclst_vt = List_vt (hidecl)
vtypedef
saspdeclst_vt = List_vt (hidecl)

val the_exndeclst =
  ref_make_elt<exndeclst_vt> (list_vt_nil ())
val the_saspdeclst =
  ref_make_elt<saspdeclst_vt> (list_vt_nil ())
// end of [val]

in (* in of [local] *)

implement
the_exndeclst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_exndeclst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_exndeclst_add]

implement
the_exndeclst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_exndeclst)
val xs = !p
val () = !p := list_vt_nil ()
val xs = list_vt_reverse<hidecl> (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_exndeclst_get]

(* ****** ****** *)

implement
the_saspdeclst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_saspdeclst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_saspdeclst_add]

implement
the_saspdeclst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_saspdeclst)
val xs = !p
val () = !p := list_vt_nil ()
val xs = list_vt_reverse<hidecl> (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_saspdeclst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef
extcodelst_vt = List_vt (hidecl)

val the_extcodelst =
  ref_make_elt<extcodelst_vt> (list_vt_nil ())
// end of [val]

in (* in of [local] *)

implement
the_extcodelst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_extcodelst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_extcodelst_add]

implement
the_extcodelst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_extcodelst)
//
val xs = !p
val () = !p := list_vt_nil ()
//
var !p_cmp = @lam
(
  x1: &hidecl, x2: &hidecl
) : int =<clo>
  (pos1 - pos2) where
{
  val-HIDextcode (knd1, pos1, _) = x1.hidecl_node
  val-HIDextcode (knd2, pos2, _) = x2.hidecl_node
} (* end of [where] // end of [@lam] *)
//
val xs = list_vt_reverse (xs)
val xs = list_vt_mergesort<hidecl> (xs, !p_cmp) // HX: stable-sorting
//
in
  list_of_list_vt (xs)
end // end of [the_extcodelst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef
staloadlst_vt = List_vt (hidecl)
vtypedef
dynloadlst_vt = List_vt (hidecl)

val the_staloadlst =
  ref_make_elt<staloadlst_vt> (list_vt_nil ())
val the_dynloadlst =
  ref_make_elt<dynloadlst_vt> (list_vt_nil ())

in (* in of [local] *)

implement
the_staloadlst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_staloadlst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_staloadlst_add]

implement
the_staloadlst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_staloadlst)
val xs = !p
val () = !p := list_vt_nil ()
val xs = list_vt_reverse<hidecl> (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_staloadlst_get]

(* ****** ****** *)

implement
the_dynloadlst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_dynloadlst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_dynloadlst_add]

implement
the_dynloadlst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_dynloadlst)
val xs = !p
val () = !p := list_vt_nil ()
val xs = list_vt_reverse<hidecl> (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_dynloadlst_get]

end // end of [local]

(* ****** ****** *)

local
//
val the_dyncstset =
  ref_make_elt<d2cstset> (d2cstset_nil ())
val the_dyncstlst =
  ref_make_elt<d2cstlst_vt> (list_vt_nil ())
//
in (* in of [local] *)

implement
the_dyncstlst_add
  (d2c) = let
  val d2cs = !the_dyncstset
  val found = d2cstset_ismem (d2cs, d2c)
in
//
if ~(found) then let
  val () = let
    val (
      vbox pf | p
    ) = ref_get_view_ptr (the_dyncstlst)
  in
    !p := list_vt_cons (d2c, !p)
  end // end of [val]
in
  !the_dyncstset := d2cstset_add (d2cs, d2c)
end (* end of [if] *)
//
end // end of [the_dyncstlst_add]

implement
the_dyncstlst_get () = let
//
val d2cs = let
  val (
    vbox pf | p
  ) = ref_get_view_ptr (the_dyncstlst)
  val d2cs = !p
  val () = !p := list_vt_nil ()
in
  list_vt_reverse (d2cs)
end // end of [val]
//
in
  list_of_list_vt (d2cs)
end // end of [the_dyncstlst_get]

end // end of [local]

(* ****** ****** *)

local
//
val the_dynconset =
  ref_make_elt<d2conset> (d2conset_nil ())
val the_dynconlst =
  ref_make_elt<d2conlst_vt> (list_vt_nil ())
//
in (* in of [local] *)

implement
the_dynconlst_add
  (d2c) = let
  val d2cs = !the_dynconset
  val found = d2conset_ismem (d2cs, d2c)
in
//
if ~(found) then let
  val () = let
    val (
      vbox pf | p
    ) = ref_get_view_ptr (the_dynconlst)
  in
    !p := list_vt_cons (d2c, !p)
  end // end of [val]
in
  !the_dynconset := d2conset_add (d2cs, d2c)
end (* end of [if] *)
//
end // end of [the_dynconlst_add]

implement
the_dynconlst_get () = let
//
val d2cs = let
  val (
    vbox pf | p
  ) = ref_get_view_ptr (the_dynconlst)
  val d2cs = !p
  val () = !p := list_vt_nil ()
in
  list_vt_reverse (d2cs)
end // end of [val]
//
in
  list_of_list_vt (d2cs)
end // end of [the_dynconlst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef funlablst_vt = List_vt (funlab)

val the_funlablst =
  ref_make_elt<funlablst_vt> (list_vt_nil ())
// end of [the_funlablst]

in (* in of [local] *)

implement
the_funlablst_add (fl) = let
//
val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
//
in
  !p := list_vt_cons (fl, !p)
end // end of [the_funlablst_add]

implement
the_funlablst_addlst
  (fls) = list_app_fun (fls, the_funlablst_add)
// end of [the_funlablst_addlst]

(* ****** ****** *)

implement
the_funlablst_get () = let
//
val fls = fls where
{
val (
  vbox pf | p
) = ref_get_view_ptr (the_funlablst)
val fls = !p; val () = !p := list_vt_nil ()
} (* end of [val] *)
//
val fls = list_vt_reverse (fls)
//
in
  list_of_list_vt (fls)
end // end of [the_funlablst_get]

end // end of [local]

(* ****** ****** *)

datavtype
markenvlst_vt =
  | MARKENVLSTnil of ()
  | MARKENVLSTmark of (markenvlst_vt)
  | MARKENVLSTcons_var of (d2var, markenvlst_vt)
  | MARKENVLSTcons_fundec of (hifundec, markenvlst_vt)
  | MARKENVLSTcons_impdec of (hiimpdec, markenvlst_vt)
  | MARKENVLSTcons_impdec2 of (hiimpdec2, markenvlst_vt)
  | MARKENVLSTcons_staload of (filenv, markenvlst_vt)
  | MARKENVLSTcons_tmpsub of (tmpsub, markenvlst_vt)
  | MARKENVLSTcons_tmpcstmat of (tmpcstmat, markenvlst_vt) 
  | MARKENVLSTcons_tmpvarmat of (tmpvarmat, markenvlst_vt) 
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
  | ~MARKENVLSTcons_fundec (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_impdec (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_impdec2 (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_staload (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpsub (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpcstmat (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpvarmat (_, xs) => markenvlst_vt_free (xs)
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
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_string (out, "||")
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTmark]
| MARKENVLSTcons_var
    (!p_x, !p_xs) => let
    val () =
    (
       if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_d2var (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_var]
//
| MARKENVLSTcons_fundec
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val hfd = !p_x
    val () = fprint_d2var (out, hfd.hifundec_var)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val imp = !p_x
    val () = fprint_d2cst (out, imp.hiimpdec_cst)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec]
| MARKENVLSTcons_impdec2
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_hiimpdec2 (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val fname = filenv_get_name (!p_x)
    val () = $FIL.fprint_filename_full (out, fname)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_staload]
//
| MARKENVLSTcons_tmpsub
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_tmpsub (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpsub]
//
| MARKENVLSTcons_tmpcstmat
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_tmpcstmat (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpcstmat]
//
| MARKENVLSTcons_tmpvarmat
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_tmpvarmat (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpvarmat]
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_markenvlst]

(* ****** ****** *)

vtypedef
freeconenv = List_vt (primvalist_vt)

extern
fun freeconenv_free (xs: freeconenv): void

implement
freeconenv_free (xs) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = list_vt_free (x) in freeconenv_free (xs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [freeconenv_free]

(* ****** ****** *)

datavtype
looptmplab3 =
LOOPTMPLAB3 of
(
  tmplab(*init*), tmplab(*fini*), tmplab(*cont*)
) // end of [looptmplab3]

vtypedef
loopexnenv = List_vt (looptmplab3)

extern
fun loopexnenv_free (xs: loopexnenv): void

implement
loopexnenv_free (xs) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val+~LOOPTMPLAB3 (_, _, _) = x in loopexnenv_free (xs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [loopexnenv_free]

(* ****** ****** *)

datavtype
tlcalitm =
  | TCIfun of funlab
  | TCIfnx of funlablst_vt
// end of [tlcalitm]

vtypedef tailcalenv = List_vt (tlcalitm)

extern
fun tlcalitm_free (x: tlcalitm): void
implement
tlcalitm_free (x) = let
in
//
case+ x of
| ~TCIfun (fl) => ()
| ~TCIfnx (fls) => list_vt_free (fls)
//
end // end of [tlcalitm_free]

extern
fun tailcalenv_free (xs: tailcalenv): void

implement
tailcalenv_free (xs) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) =>
  (
    tlcalitm_free (x); tailcalenv_free (xs)
  ) // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [tailcalenv_free]

(* ****** ****** *)

vtypedef
flabsetenv = List_vt (funlabset_vt)

extern
fun flabsetenv_free (xs: flabsetenv): void
implement
flabsetenv_free (xs) =
(
case+ xs of
| ~list_vt_cons
    (x, xs) =>
  (
    funlabset_vt_free (x); flabsetenv_free (xs)
  )
| ~list_vt_nil () => ()
) // end of [flabsetenv_free]

(* ****** ****** *)

vtypedef
dvarsetenv = List_vt (d2envset_vt)

extern
fun dvarsetenv_free (xs: dvarsetenv): void
implement
dvarsetenv_free (xs) =
(
case+ xs of
| ~list_vt_cons
    (x, xs) =>
  (
    d2envset_vt_free (x); dvarsetenv_free (xs)
  )
| ~list_vt_nil () => ()
) // end of [dvarsetenv_free]

(* ****** ****** *)
//
vtypedef vbindmapenv = List_vt (vbindmap)
//
(* ****** ****** *)
//
extern
fun vbindmapenv_free (xs: vbindmapenv): void
//
implement
vbindmapenv_free (vbms) = let
in
//
case+ vbms of
| ~list_vt_cons
    (vbm, vbms) => vbindmapenv_free (vbms)
| ~list_vt_nil () => ()
//
end // end of [vbindmapenv_free]
//
(* ****** ****** *)

viewtypedef
ccompenv_struct =
@{
  ccompenv_tmplevel= int
, ccompenv_tmprecdepth= int
//
, ccompenv_freeconenv= freeconenv
, ccompenv_loopexnenv= loopexnenv
//
, ccompenv_tailcalenv= tailcalenv
//
, ccompenv_flabsetenv= flabsetenv
, ccompenv_dvarsetenv= dvarsetenv
, ccompenv_vbindmapenv= vbindmapenv
//
, ccompenv_markenvlst= markenvlst_vt
, ccompenv_vbindmapall= d2varmap_vt (primval)
//
} // end of [ccompenv_struct]

(* ****** ****** *)

extern
fun ccompenv_struct_uninitize
  (x: &ccompenv_struct >> ccompenv_struct?): void
// end of [ccompenv_struct_uninitize]

implement
ccompenv_struct_uninitize (x) = let
//
  val () =
    markenvlst_vt_free (x.ccompenv_markenvlst)
//
  val () = freeconenv_free (x.ccompenv_freeconenv)
  val () = loopexnenv_free (x.ccompenv_loopexnenv)
//
  val () = tailcalenv_free (x.ccompenv_tailcalenv)
//
  val () = flabsetenv_free (x.ccompenv_flabsetenv)
  val () = dvarsetenv_free (x.ccompenv_dvarsetenv)
  val () = vbindmapenv_free (x.ccompenv_vbindmapenv)
//
  val () = d2varmap_vt_free (x.ccompenv_vbindmapall)
//
in
  // end of [ccompenv_struct_uninitize]
end // end of [ccompenv_struct_uninitize]

(* ****** ****** *)

datavtype
ccompenv_vt = CCOMPENV of ccompenv_struct

(* ****** ****** *)

assume ccompenv_vtype = ccompenv_vt

(* ****** ****** *)

implement
ccompenv_make
  () = env where
{
val env = CCOMPENV (?)
val CCOMPENV (!p) = env
//
val () = p->ccompenv_tmplevel := 0
val () = p->ccompenv_tmprecdepth := 0
//
val () = p->ccompenv_freeconenv := list_vt_nil ()
val () = p->ccompenv_loopexnenv := list_vt_nil ()
//
val () = p->ccompenv_tailcalenv := list_vt_nil ()
//
val () = p->ccompenv_flabsetenv := list_vt_nil ()
val () = p->ccompenv_dvarsetenv := list_vt_nil ()
val () = p->ccompenv_vbindmapenv := list_vt_nil ()
//
val () = p->ccompenv_markenvlst := MARKENVLSTnil ()
//
val () = p->ccompenv_vbindmapall := d2varmap_vt_nil ()
//
val () = fold@ (env)
//
val () = ccompenv_inc_flabsetenv (env) // toplevel flabs
val () = ccompenv_inc_dvarsetenv (env) // toplevel d2vars
val () = ccompenv_inc_vbindmapenv (env) // toplevel vbinds
//
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

implement
ccompenv_get_tmplevel
  (env) = let
  val CCOMPENV (!p) = env
  val tmplev = p->ccompenv_tmplevel
  prval () = fold@ (env)
in
  tmplev
end // end of [ccompenv_get_tmplevel]

implement
ccompenv_inc_tmplevel
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmplevel := p->ccompenv_tmplevel + 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_tmplevel]

implement
ccompenv_dec_tmplevel
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmplevel := p->ccompenv_tmplevel - 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_dec_tmplevel]

(* ****** ****** *)

implement
ccompenv_get_tmprecdepth
  (env) = let
  val CCOMPENV (!p) = env
  val depth = p->ccompenv_tmprecdepth
  prval () = fold@ (env)
in
  depth
end // end of [ccompenv_get_tmprecdepth]

implement
ccompenv_inc_tmprecdepth
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmprecdepth := p->ccompenv_tmprecdepth + 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_tmprecdepth]

implement
ccompenv_dec_tmprecdepth
  (env) = let
  val CCOMPENV (!p) = env
  val depth = p->ccompenv_tmprecdepth
  val ((*void*)) = p->ccompenv_tmprecdepth := depth - 1
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_dec_tmprecdepth]

(* ****** ****** *)

implement
ccompenv_inc_freeconenv
  (env) = let
  val CCOMPENV (!p) = env
  val pmvs = list_vt_nil{primval}()
  val pmvss = p->ccompenv_freeconenv
  val ((*void*)) =
    p->ccompenv_freeconenv := list_vt_cons (pmvs, pmvss)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_freeconenv]

implement
ccompenv_getdec_freeconenv
  (env) = pmvs where
{
val CCOMPENV (!p) = env
val-~list_vt_cons (pmvs, pmvss) = p->ccompenv_freeconenv
val ((*void*)) = p->ccompenv_freeconenv := pmvss
prval () = fold@ (env)
} // end of [ccompenv_getdec_freeconenv]

(* ****** ****** *)

implement
ccompenv_add_freeconenv
  (env, pmv) = let
//
val CCOMPENV (!p) = env
val-list_vt_cons
  (!p_pmvs, _) = p->ccompenv_freeconenv
val () = !p_pmvs := list_vt_cons (pmv, !p_pmvs)
prval () = fold@ (p->ccompenv_freeconenv)
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_freeconenv]

implement
ccompenv_add_freeconenv_if
  (env, pmv, pck, d2c) = let
in
//
case+ pck of
| PCKfree () => let
    val isnul = d2con_is_nullary (d2c)
  in
    if not(isnul) then ccompenv_add_freeconenv (env, pmv)
  end (* end of [PCKfree] *)
| _ => ((*nothing*))
//
end // end of [ccompenv_add_freeconenv_if]

(* ****** ****** *)

implement
ccompenv_inc_loopexnenv
  (env, tl1, tl2, tl3) = let
  val tlll = LOOPTMPLAB3 (tl1, tl2, tl3)
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_loopexnenv := list_vt_cons (tlll, p->ccompenv_loopexnenv))
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_loopexnenv]

implement
ccompenv_dec_loopexnenv
  (env) = let
  val CCOMPENV (!p) = env
  val-~list_vt_cons (x, xs) = p->ccompenv_loopexnenv
  val+~LOOPTMPLAB3 (_, _, _) = x
  val () = (p->ccompenv_loopexnenv := xs)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_dec_loopexnenv]

implement
ccompenv_get_loopfini
  (env) = let
  val CCOMPENV (!p) = env
  val-list_vt_cons (!px, _) = p->ccompenv_loopexnenv
  val+LOOPTMPLAB3 (_, tl_fini, _) = !px
  prval () = fold@ (!px)
  prval () = fold@ (p->ccompenv_loopexnenv)
  prval () = fold@ (env)
in
  tl_fini
end // end of [ccompenv_get_loopfini]

implement
ccompenv_get_loopcont
  (env) = let
  val CCOMPENV (!p) = env
  val-list_vt_cons (!px, _) = p->ccompenv_loopexnenv
  val+LOOPTMPLAB3 (_, _, tl_cont) = !px
  prval () = fold@ (!px)
  prval () = fold@ (p->ccompenv_loopexnenv)
  prval () = fold@ (env)
in
  tl_cont
end // end of [ccompenv_get_loopcont]

(* ****** ****** *)

implement
ccompenv_inc_tailcalenv
  (env, fl) = () where
{
//
(*
val (
) = println! ("ccompenv_inc_tailcalenv: fl = ", fl)
*)
//
val CCOMPENV (!p) = env
val tci = TCIfun (fl)
val tcis = p->ccompenv_tailcalenv
val ((*void*)) =
  p->ccompenv_tailcalenv := list_vt_cons (tci, tcis)
prval () = fold@ (env)
//
} // end of [ccompenv_inc_tailcalenv]

implement
ccompenv_inc_tailcalenv_fnx
  (env, fls) = () where
{
//
val CCOMPENV (!p) = env
val tci = TCIfnx (fls)
val tcis = p->ccompenv_tailcalenv
val ((*void*)) =
  p->ccompenv_tailcalenv := list_vt_cons (tci, tcis)
prval () = fold@ (env)
//
} // end of [ccompenv_inc_tailcalenv_fnx]

implement
ccompenv_dec_tailcalenv
  (env) = () where
{
//
val CCOMPENV (!p) = env
val-~list_vt_cons
  (tci, tcis) = p->ccompenv_tailcalenv
val () = tlcalitm_free (tci)
val () = p->ccompenv_tailcalenv := tcis
prval () = fold@ (env)
//
} // end of [ccompenv_dec_tailcalenv]

(* ****** ****** *)

local

fun auxfind
(
  s0: stamp, tci: !tlcalitm
) : int = let
in
//
case+ tci of
| TCIfun (fl) => let
    val s = funlab_get_stamp (fl)
    val iseq = $STMP.eq_stamp_stamp (s0, s)
    prval () = fold@ (tci)
  in
    if iseq then 0 else ~1
  end // end of [TCIfun]
| TCIfnx (!p_fls) => let
    val res = auxfind_lst (s0, $UN.linlst2lst(!p_fls), 1)
    prval () = fold@ (tci)
  in
    res
  end // end of [TCIfnx]
//
end // end of [auxfind]

and auxfind_lst
(
  s0: stamp, fls: List(funlab), i: int
) : int = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val s = funlab_get_stamp (fl)
    val iseq = $STMP.eq_stamp_stamp (s0, s)
  in
    if iseq then i else auxfind_lst (s0, fls, i+1)
  end // end of [list_cons]
| list_nil ((*void*)) => ~1
//
end // end of [auxfind_lst]

fun auxfind2
(
  d2c0: d2cst, tci: !tlcalitm
) : funlabopt_vt = let
//
val-TCIfun (fl) = tci
val opt = funlab_get_d2copt (fl)
prval () = fold@ (tci)
//
in
//
case+ opt of
| Some (d2c) => let
    val iseq = eq_d2cst_d2cst (d2c0, d2c)
  in
    if iseq then Some_vt(fl) else None_vt()
  end // end of [Some]
| None ((*void*)) => None_vt((*void*))
//
end // end of [auxfind2]

in (* in of [local] *)

implement
ccompenv_find_tailcalenv
  (env, fl0) = let
//
val s0 = funlab_get_stamp (fl0)
//
val CCOMPENV (!p) = env
val-list_vt_cons
  (!p_tci, _) = p->ccompenv_tailcalenv
val ans = auxfind (s0, !p_tci)
prval () = fold@ (p->ccompenv_tailcalenv)
prval () = fold@ (env)
//
in
  ans
end // end of [ccompenv_find_tailcalenv]

implement
ccompenv_find_tailcalenv_cst
  (env, d2c0) = let
//
val CCOMPENV (!p) = env
val-list_vt_cons
  (!p_tci, _) = p->ccompenv_tailcalenv
val ans = auxfind2 (d2c0, !p_tci)
prval () = fold@ (p->ccompenv_tailcalenv)
prval () = fold@ (env)
//
in
  ans
end // end of [ccompenv_find_tailcalenv]

end // end of [local]

(* ****** ****** *)

implement
ccompenv_find_tailcalenv_tmpcst
  (env, d2c0, t2mas) = let
//
val opt = ccompenv_find_tailcalenv_cst (env, d2c0)
//
in
//
case+ opt of
| ~None_vt () => None_vt ()
| ~Some_vt (fl0) => let
    val ans =
      funlab_tmpcst_match (fl0, d2c0, t2mas)
    // end of [val]
(*
    val () =
      println! ("ccompenv_find_tailcalenv_tmpcst: fl0 = ", fl0)
    val () =
      println! ("ccompenv_find_tailcalenv_tmpcst: ans = ", ans)
*)
  in
    if ans then Some_vt (fl0) else None_vt ()
  end // end [Some_vt]
//
end // end of [ccompenv_find_tailcalenv_tmpcst]

(* ****** ****** *)

(*
implement
ccompenv_get_funlevel
  (env) = n where
{
//
val
CCOMPENV (!p) = env
val n = list_vt_length (p->ccompenv_flabsetenv)
prval () = fold@ (env)
//
} // end of [ccompenv_get_funlevel]
*)

(* ****** ****** *)

implement
ccompenv_inc_dvarsetenv
  (env) = let
//
val CCOMPENV (!p) = env
val d2es = d2envset_vt_nil ()
val d2ess = p->ccompenv_dvarsetenv
val () = (p->ccompenv_dvarsetenv := list_vt_cons (d2es, d2ess))
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_inc_dvarsetenv]

implement
ccompenv_incwth_dvarsetenv
  (env, d2es) = let
//
val d2es = d2envlst2set (d2es)
//
val CCOMPENV (!p) = env
val d2ess = p->ccompenv_dvarsetenv
val () = (p->ccompenv_dvarsetenv := list_vt_cons (d2es, d2ess))
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_incwth_dvarsetenv]

(* ****** ****** *)

implement
ccompenv_getdec_dvarsetenv
  (env) = (d2vs) where
{
//
val CCOMPENV (!p) = env
val-~list_vt_cons (d2vs, d2vss) = p->ccompenv_dvarsetenv
val () = p->ccompenv_dvarsetenv := d2vss
prval () = fold@ (env)
//
} // end of [ccompenv_getdec_dvarsetenv]

(* ****** ****** *)

implement
ccompenv_add_dvarsetenv_var
  (env, d2v) = ((*void*)) where
{
//
val lvl = d2var_get_level (d2v)
//
val () =
if (lvl > 0) then
{
val CCOMPENV (!p) = env
//
val d2e = d2var2env (d2v)
//
val-list_vt_cons
  (!p_d2es, _) = p->ccompenv_dvarsetenv
val () = !p_d2es := d2envset_vt_add (!p_d2es, d2e)
prval () = fold@ (p->ccompenv_dvarsetenv)
//
prval () = fold@ (env)
} (* end of [if] *)
//
} // end of [ccompenv_add_dvarsetenv]

implement
ccompenv_add_dvarsetenv_env
  (env, d2e) = ((*void*)) where
{
//
val d2v = d2env_get_var (d2e)
val lvl = d2var_get_level (d2v)
//
val () =
if (lvl > 0) then
{
val CCOMPENV (!p) = env
//
val-list_vt_cons
  (!p_d2es, _) = p->ccompenv_dvarsetenv
val () = !p_d2es := d2envset_vt_add (!p_d2es, d2e)
prval () = fold@ (p->ccompenv_dvarsetenv)
//
prval () = fold@ (env)
} (* end of [if] *)
//
} // end of [ccompenv_add_dvarsetenv]

implement
ccompenv_inc_flabsetenv
  (env) = let
  val CCOMPENV (!p) = env
  val flset = funlabset_vt_nil ()
  val () =
  (
    p->ccompenv_flabsetenv := list_vt_cons (flset, p->ccompenv_flabsetenv)
  )
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_flabsetenv]

implement
ccompenv_getdec_flabsetenv
  (env) = (fls) where
{
//
val CCOMPENV (!p) = env
val-~list_vt_cons (fls, flss) = p->ccompenv_flabsetenv
val () = p->ccompenv_flabsetenv := flss
prval () = fold@ (env)
//
} // end of [ccompenv_getdec_flabsetenv]

(* ****** ****** *)

implement
ccompenv_add_flabsetenv
  (env, fl) = ((*void*)) where
{
//
val CCOMPENV (!p) = env
val-list_vt_cons
  (!p_fls, _) = p->ccompenv_flabsetenv
val () = !p_fls := funlabset_vt_add (!p_fls, fl)
prval () = fold@ (p->ccompenv_flabsetenv)
prval () = fold@ (env)
//
} // end of [ccompenv_add_flabsetenv]

(* ****** ****** *)

implement
ccompenv_addlst_dvarsetenv_if
  (env, flvl0, d2es) = let
//
fun addlst_if
(
  env: !ccompenv
, flvl0: int, d2es: d2envlst
) : void = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val d2v = d2env_get_var (d2e)
    val lvl = d2var_get_level (d2v)
    val () = 
    ( // HX: no need for handling siblings (=lvl0)
      if lvl <= flvl0 then ccompenv_add_dvarsetenv_env (env, d2e)
    ) : void // end of [val]
  in
    addlst_if (env, flvl0, d2es)
  end (* end of [list_cons] *)
| list_nil () => ()
//
end // end of [addlst_if]
//
in
//
addlst_if (env, flvl0, d2es)
//
end // end of [ccompenv_addlst_dvarsetenv_if]

(* ****** ****** *)

implement
ccompenv_addlst_flabsetenv_ifmap
  (env, flvl0, vbmap, fls0) = let
//
fun auxenv
(
  env: !ccompenv
, vbmap: vbindmap, d2es: d2envlst
) : void = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val d2v = d2env_get_var (d2e)
    val opt = d2varmap_search (vbmap, d2v)
    val () =
    (
      case+ opt of
      | ~Some_vt _ => ()
      | ~None_vt _ => ccompenv_add_dvarsetenv_env (env, d2e)
    ) : void // end of [val]
  in
    auxenv (env, vbmap, d2es)
  end (* end of [list_cons] *)
| list_nil () => ()
//
end (* end of [auxenv] *)
//
fun addlst_if
(
  env: !ccompenv
, flvl0: int, vbmap: vbindmap, fls: funlablst_vt
) : funlablst_vt = let
in
//
case+ fls of
| ~list_vt_cons
    (fl, fls) => let
    val flvl = funlab_get_level (fl)
  in
    if flvl > flvl0 then let
      val-Some (fent) = funlab_get_funent (fl)
      val () = auxenv (env, vbmap, funent_get_d2envlst (fent))
    in
      addlst_if (env, flvl0, vbmap, fls)
    end else let
      val () = ccompenv_add_flabsetenv (env, fl)
      val fls = addlst_if (env, flvl0, vbmap, fls)
    in
      list_vt_cons (fl, fls)
    end (* end of [if] *)
  end // end of [list_cons]
| ~list_vt_nil () => list_vt_nil ()
//
end // end of [addlst_if]
//
in
//
addlst_if (env, flvl0, vbmap, fls0)
//
end // end of [ccompenv_addlst_flabsetenv_ifmap]

(* ****** ****** *)

implement
ccompenv_inc_vbindmapenv
  (env) = let
//
val CCOMPENV (!p) = env
val vbm = d2varmap_nil ()
val vbms = p->ccompenv_vbindmapenv
val () = (p->ccompenv_vbindmapenv := list_vt_cons (vbm, vbms))
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_inc_vbindmapenv]

implement
ccompenv_getdec_vbindmapenv
  (env) = vbm where
{
//
val CCOMPENV (!p) = env
//
val-~list_vt_cons
  (vbm, vbms) = p->ccompenv_vbindmapenv
val () = p->ccompenv_vbindmapenv := vbms
//
prval () = fold@ (env)
//
} // end of [ccompenv_getdec_vbindmapenv]

(* ****** ****** *)

implement
ccompenv_add_vbindmapenv
  (env, d2v, pmv) = let
//
val CCOMPENV (!p) = env
//
val-list_vt_cons
  (!p_vbm, _) = p->ccompenv_vbindmapenv
val _(*replaced*) = d2varmap_insert (!p_vbm, d2v, pmv)
prval () = fold@ (p->ccompenv_vbindmapenv)
//
prval () = fold@ (env)
//
in
  // nothing
end (* end of [ccompenv_add_vbindmapenv] *)

implement
ccompenv_find_vbindmapenv
  (env, d2v) = opt where
{
//
val
CCOMPENV (!p) = env
//
val-list_vt_cons
  (!p_vbm, _) = p->ccompenv_vbindmapenv
val opt = d2varmap_search (!p_vbm, d2v)
prval () = fold@ (p->ccompenv_vbindmapenv)
//
prval () = fold@ (env)
//
} (* end of [ccompenv_find_vbindmapenv] *)

(* ****** ****** *)

local

assume ccompenv_push_v = unit_v

fun auxpop
(
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
| ~MARKENVLSTcons_fundec (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_impdec (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_impdec2 (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_staload (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpsub (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpcstmat (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpvarmat (_, xs) => auxpop (map, xs)
//
end // end of [auxpop]

fun auxjoin
(
  map: &d2varmap_vt (primval), xs: &markenvlst_vt
) : void = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTnil]
| ~MARKENVLSTmark (xs1) => let
    val () = xs := auxpop (map, xs1) in (*nothing*)
  end // end of [MARKENVLSTmark]
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_var]
//
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_impdec]
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_staload]
//
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpsub]
//
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpcstmat]
//
| MARKENVLSTcons_tmpvarmat (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpvarmat]
//
end // end of [auxjoin]

in (* in of [local] *)

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

implement
ccompenv_pop
  (pfpush | env) = let
//
  prval unit_v () = pfpush
//
  val CCOMPENV (!p) = env
//
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := auxpop (p->ccompenv_vbindmapall, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_pop]

implement
ccompenv_localjoin
  (pfpush, pfpush2 | env) = let
//
  prval unit_v () = pfpush
  prval unit_v () = pfpush2
//
  val CCOMPENV (!p) = env
//
  val () = auxjoin (p->ccompenv_vbindmapall, p->ccompenv_markenvlst)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_localjoin]

end // end of [local]

(* ****** ****** *)

implement
ccompenv_add_vbindmapall
  (env, d2v, pmv) = let
//
(*
val () =
(
  println! ("ccompenv_add_vbindmapall: d2v = ", d2v);
  println! ("ccompenv_add_vbindmapall: pmv = ", pmv);
) : void // end of [val]
*)
//
val CCOMPENV (!p) = env
//
val xs = p->ccompenv_markenvlst
val () = p->ccompenv_markenvlst := MARKENVLSTcons_var (d2v, xs)
val _(*replaced*) = d2varmap_vt_insert (p->ccompenv_vbindmapall, d2v, pmv)
//
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_vbindmapall]

implement
ccompenv_find_vbindmapall
  (env, d2v) = opt where
{
//
  val CCOMPENV (!p) = env
  val opt = d2varmap_vt_search (p->ccompenv_vbindmapall, d2v)
  prval () = fold@ (env)
//
} // end of [ccompenv_add_vbindmapall]

(* ****** ****** *)

implement
ccompenv_add_vbindmapenvall
  (env, d2v, pmv) = () where {
//
val () = ccompenv_add_vbindmapenv (env, d2v, pmv)
val () = ccompenv_add_vbindmapall (env, d2v, pmv)
//
} (* end of [ccompenv_add_vbindmapenvall] *)

(* ****** ****** *)

implement
ccompenv_add_fundec
  (env, hfd) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_fundec (hfd, xs)
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_fundec]

(* ****** ****** *)

implement
ccompenv_add_impdec
  (env, imp) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_impdec (imp, xs)
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_impdec]

(* ****** ****** *)

implement
ccompenv_add_staload
  (env, fenv) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_staload (fenv, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_staload]

(* ****** ****** *)

implement
ccompenv_add_tmpsub
  (env, tsub) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_tmpsub (tsub, xs)
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_tmpsub]

extern
fun ccompenv_find_tmpsub
  (env: !ccompenv): tmpsubopt_vt
implement
ccompenv_find_tmpsub (env) = let
//
fun loop
(
  xs: !markenvlst_vt
) : tmpsubopt_vt = let
in
//
case+ xs of
//
| MARKENVLSTcons_tmpsub
    (tsub, !p_xs) => let
    prval () = fold@ (xs) in Some_vt (tsub)
  end // end of [MARKENVLSTcons_tmpsub]
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_var]
//
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_impdec]
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_staload]
//
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_tmpcstmat]
| MARKENVLSTcons_tmpvarmat (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_tmpvarmat]
//
| MARKENVLSTmark (!p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_mark]
//
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in None_vt ()
  end // end of [MARKENVLSTnil]
//
end // end of [loop]
//
val CCOMPENV (!p) = env
val res = loop (p->ccompenv_markenvlst)
prval () = fold@ (env)
//
in
  res
end // end of [ccompenv_find_tmpsub]

(* ****** ****** *)

implement
ccompenv_add_impdec2 (env, imp2) = let
//
val CCOMPENV (!p) = env
val xs = p->ccompenv_markenvlst
val () = p->ccompenv_markenvlst := MARKENVLSTcons_impdec2 (imp2, xs)
//
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_impdec2]

implement
ccompenv_add_impdecloc
  (env, imp) = let
  val-~Some_vt (tsub) = ccompenv_find_tmpsub (env)
  val sub = tmpsub2stasub (tsub)
  val tmparg = s2explstlst_subst (sub, imp.hiimpdec_tmparg)
  val () = stasub_free (sub)
  val imp2 = HIIMPDEC2 (imp, tsub, tmparg)
in
  ccompenv_add_impdec2 (env, imp2)
end // end of [ccompenv_add_impdecloc]

(* ****** ****** *)

implement
ccompenv_add_tmpcstmat
  (env, tmpmat) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_tmpcstmat (tmpmat, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_tmpcstmat]

implement
ccompenv_add_tmpvarmat
  (env, tmpmat) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_tmpvarmat (tmpmat, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_tmpvarmat]

(* ****** ****** *)

local

fun auxlst
(
  env: !ccompenv, hfds: hifundeclst
) : void = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val () =
      ccompenv_add_fundec (env, hfd) in auxlst (env, hfds)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

in (* in of [local] *)

implement
ccompenv_add_fundecsloc
  (env, knd, decarg, hfds) = let
in
//
case+ decarg of
| list_cons _ => auxlst (env, hfds) | list_nil _ => ()
//
end // end of [ccompenv_add_fundecsloc]

end // end of [local]

(* ****** ****** *)

local

fun auxlst
(
  xs: !markenvlst_vt
, d2c0: d2cst
, t2mas: t2mpmarglst
) : tmpcstmat = let
in
//
case+ xs of
//
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in TMPCSTMATnone ()
  end // end of [MARKENVLSTnil]
//
| MARKENVLSTmark (!p_xs) => let
    val res = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTmark] *)
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val res = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_var] *)
//
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val res = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_fundec] *)
//
| MARKENVLSTcons_impdec
    (imp, !p_xs) => let
    val res =
      hiimpdec_tmpcst_match (imp, d2c0, t2mas)
    val res = auxcont (res, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_impdec]
//
| MARKENVLSTcons_impdec2
    (imp2, !p_xs) => let
    val res = hiimpdec2_tmpcst_match (imp2, d2c0, t2mas)
    val res = auxcont (res, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload
    (fenv, !p_xs) => tmpmat where
  {
    val-Some (map) =
      filenv_get_tmpcstimpmapopt (fenv)
    // end of [val]
    val implst = tmpcstimpmap_find (map, d2c0)
    val tmpmat = hiimpdeclst_tmpcst_match (implst, d2c0, t2mas)
    val tmpmat = auxcont (tmpmat, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  } (* end of [MARKENVLSTcons_fundec] *)
//
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val res = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_tmpsub] *)
//
| MARKENVLSTcons_tmpcstmat
    (mat, !p_xs) => let
    val res =
      tmpcstmat_tmpcst_match (mat, d2c0, t2mas)
    // end of [val]
    val res = auxcont (res, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_tmpcstmat]
//
| MARKENVLSTcons_tmpvarmat (_, !p_xs) => let
    val res = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_tmpvarmat] *)
//
end (* end of [auxlst] *)

and auxcont
(
  opt: tmpcstmat
, xs: !markenvlst_vt
, d2c0: d2cst
, t2mas: t2mpmarglst
) : tmpcstmat = let
in
//
case+ opt of
| TMPCSTMATsome _ => opt
| TMPCSTMATsome2 _ => opt
| TMPCSTMATnone _ => auxlst (xs, d2c0, t2mas)
//
end // end of [auxcont]

in (* in of [local] *)

implement
ccompenv_tmpcst_match
  (env, d2c0, t2mas) = let
//
val CCOMPENV (!p) = env
val opt = auxlst (p->ccompenv_markenvlst, d2c0, t2mas)
prval () = fold@ (env)
//
in
  opt
end // end of [ccompenv_tmpcst_match]

end // end of [local]

(* ****** ****** *)

local

fun auxlst
(
  xs: !markenvlst_vt
, d2v0: d2var
, t2mas: t2mpmarglst
) : tmpvarmat = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in TMPVARMATnone ()
  end // end of [MARKENVLSTnil]
//
| MARKENVLSTmark (!p_xs) => let
    val res = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); res
  end // end of [MARKENVLSTmark]
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val res = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_var] *)
//
| MARKENVLSTcons_fundec
    (hfd, !p_xs) => let
    val res =
      hifundec_tmpvar_match (hfd, d2v0, t2mas)
    val res = auxcont (res, !p_xs, d2v0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val res = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_impdec] *)
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val res = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_impdec2] *)
//
| MARKENVLSTcons_staload
    (fenv, !p_xs) => tmpmat where
  {
    val-Some (map) =
      filenv_get_tmpvardecmapopt (fenv)
    val hfdopt = tmpvardecmap_find (map, d2v0)
    val tmpmat = hifundecopt2tmpvarmat (hfdopt, t2mas)
    val tmpmat = auxcont (tmpmat, !p_xs, d2v0, t2mas)
    prval () = fold@ (xs)
  } (* end of [MARKENVLSTcons_staload] *)
//
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val res = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_tmpsub] *)
//
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val res = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); res
  end (* end of [MARKENVLSTcons_tmpcstmat] *)
//
| MARKENVLSTcons_tmpvarmat
    (tmpmat, !p_xs) => let
    val res = tmpvarmat_tmpvar_match (tmpmat, d2v0, t2mas)
    val res = auxcont (res, !p_xs, d2v0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_tmpvarmat]
//
end // end of [auxlst]

and auxcont
(
  opt: tmpvarmat
, xs: !markenvlst_vt
, d2v0: d2var
, t2mas: t2mpmarglst
) : tmpvarmat = let
in
//
case+ opt of
| TMPVARMATsome _ => opt
| TMPVARMATsome2 _ => opt
| TMPVARMATnone _ => auxlst (xs, d2v0, t2mas)
//
end // end of [auxcont]

in (* in of [local] *)

implement
ccompenv_tmpvar_match
  (env, d2v0, t2mas) = let
//
val CCOMPENV (!p) = env
val opt = auxlst (p->ccompenv_markenvlst, d2v0, t2mas)
prval () = fold@ (env)
//
in
  opt
end // end of [ccompenv_tmpvar_match]

end // end of [local]

(* ****** ****** *)

local

val the_tmplst = ref<tmpvarlst> (list_nil)
val the_pmdlst = ref<primdeclst> (list_nil)

in (* in of [local] *)

implement
the_toplevel_getref_tmpvarlst () = $UN.cast2Ptr1 (the_tmplst)
implement
the_toplevel_getref_primdeclst () = $UN.cast2Ptr1 (the_pmdlst)

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_ccompenv.dats] *)
