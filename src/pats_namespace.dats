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
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_namespace.sats"

(* ****** ****** *)
//
vtypedef
fenvlst_vt = List_vt (filenv)
vtypedef
fenvlstlst_vt = List_vt (fenvlst_vt)
vtypedef
savedlst_vt = List_vt @(fenvlst_vt, fenvlstlst_vt)
//
(* ****** ****** *)
//
fn
fenvlst_vt_free
(
  ns: fenvlst_vt
) :<> void = list_vt_free (ns)
//
fun
fenvlstlst_vt_free
  {n:nat} .<n>.
  (nss: list_vt (fenvlst_vt, n)):<> void = 
(
  case+ nss of
  | ~list_vt_nil ((*void*)) => ()
  | ~list_vt_cons (ns, nss) => let
      val () = fenvlst_vt_free (ns) in fenvlstlst_vt_free (nss)
    end // end of [list_vt_cons]
) (* end of [fenvlstlst_vt_free] *)
//
(* ****** ****** *)

local

val the_fenvlst = ref<fenvlst_vt> (list_vt_nil)
val the_fenvlstlst = ref<fenvlstlst_vt> (list_vt_nil)
val the_savedlst = ref<savedlst_vt> (list_vt_nil)

in (* in of [local] *)

implement
the_namespace_add
  (x) = () where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_fenvlst)
  // end of [val]
  val () = !p := list_vt_cons (x, !p)
} // end of [the_namespace_add]

(* ****** ****** *)

implement
the_namespace_search
  {a} (f) = let
//
typedef fenvlst = List (filenv)
typedef fenvlstlst = List (fenvlst)
//
fun auxlst (
  f: !filenv -<cloptr1> Option_vt a, ns: fenvlst
) : Option_vt a =
(
  case+ ns of
  | list_cons (n, ns) => (
      case+ f (n)  of ~None_vt () => auxlst (f, ns) | ans => ans
    ) // end of [list_cons]
  | list_nil ((*void*)) => None_vt ()
) (* end of [auxlst] *)
//
fun auxlstlst (
  f: !filenv -<cloptr1> Option_vt a, nss: fenvlstlst
) : Option_vt a =
(
  case+ nss of
  | list_cons
      (ns, nss) => (
      case+ auxlst (f, ns) of
      | ~None_vt () => auxlstlst (f, nss) | ans => ans
    ) // end of [list_cons]
  | list_nil () => None_vt () // end of [list_nil]
) (* end of [auxlstlst] *)
//
val r_ns =
__cast (the_fenvlst) where
{
  extern castfn __cast (r: ref (fenvlst_vt)): ref (fenvlst)
} (* end of [where] *) // end of [val]
//
val r_nss =
__cast (the_fenvlstlst) where {
   extern castfn __cast (r: ref (fenvlstlst_vt)): ref (fenvlstlst)
} (* end of [where] *) // end of [val]
//
in
//
case+ auxlst (f, !r_ns) of
| ~None_vt () => auxlstlst (f, !r_nss) | ans => ans
//
end // end of [the_namespace_search]

(* ****** ****** *)

implement
the_namespace_pop () = let
  val ns = ns where {
    val (vbox pf | p) = ref_get_view_ptr (the_fenvlstlst)
    val-~list_vt_cons (ns, nss) = !p
    val () = !p := nss
  }
  val ns0 = ns0 where {
    val (vbox pf | p) = ref_get_view_ptr (the_fenvlst)
    val ns0 = !p
    val () = !p := ns
  }
  val () = fenvlst_vt_free (ns0)
in
  // nothing
end // end of [the_namespace_pop]

(* ****** ****** *)

implement
the_namespace_push () = let
//
  val ns = ns where {
    val (vbox pf | p) =
      ref_get_view_ptr (the_fenvlst)
    val ns = !p
    val () = !p := list_vt_nil ()
  } (* end of [val] *)
//
  val () = () where {
    val (vbox pf | p) =
      ref_get_view_ptr (the_fenvlstlst)
    val () = !p := list_vt_cons (ns, !p)
  } (* end of [val] *)
//
in
  // nothing
end // end of [the_namespace_push]

(* ****** ****** *)

implement
the_namespace_localjoin () = let
//
  val ns2 = ns2 where {
    val (vbox pf | p) =
      ref_get_view_ptr (the_fenvlstlst)
    val-~list_vt_cons (ns1, nss) = !p
    val () = fenvlst_vt_free (ns1)
    val-~list_vt_cons (ns2, nss) = nss
    val () = !p := nss
  } (* end of [val] *)
//
  val () = () where {
    val (vbox pf | p) =
      ref_get_view_ptr (the_fenvlst)
    val () = !p := list_vt_append (!p, ns2)
  } (* end of [val] *)
//
in
  // nothing
end // end of [the_namespace_localjoin]

(* ****** ****** *)

implement
the_namespace_save
  () = () where {
//
val x = x where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_fenvlst)
  val x = !p; val () = !p := list_vt_nil ()
} (* end of [val] *)
//
val xs = xs where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_fenvlstlst)
  val xs = !p; val () = !p := list_vt_nil ()
} (* end of [val] *)
//
val () = () where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_savedlst)
  val () = !p := list_vt_cons ((x, xs), !p)
} (* end of [val] *)
//
} (* end of [the_namespace_save] *)

(* ****** ****** *)

implement
the_namespace_restore
  () = () where {
//
val x = x where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_savedlst)
  val-~list_vt_cons (x, xs) = !p; val () = (!p := xs)
} (* end of [val] *)
//
val () = () where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_fenvlst)
  val () = fenvlst_vt_free (!p); val () = (!p := x.0)
} (* end of [val] *)
//
val () = () where {
  val (vbox pf | p) =
    ref_get_view_ptr (the_fenvlstlst)
  val () = fenvlstlst_vt_free (!p); val () = (!p := x.1)
} (* end of [val] *)
//
} (* end of [the_namespace_restore] *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_namespace.dats] *)
