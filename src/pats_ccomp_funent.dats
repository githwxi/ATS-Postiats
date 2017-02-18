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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

typedef
funent = '{
//
  funent_loc= location
//
, funent_lab= funlab // attached function label
//
, funent_imparg= s2varlst
, funent_tmparg= s2explstlst
, funent_tmpsub= tmpsubopt
//
, funent_tmpret= tmpvar // storing the return value
//
// HX-2013-04-12:
// [flablst] may contain the following flabs:
// 1. outer functions called internally
// 2. sibling functions called internally
//
// [flablst_fin] may contain the following flabs:
// 1. self
// 1. outer functions called transitively
// 2. sibling functions called transitively
//
, funent_flablst= funlablst // flabs in function body
, funent_flablst_fin= Option(funlablst) // final value
//
, funent_d2envlst= d2envlst // d2vars in function body
, funent_d2envlst_fin= Option(d2envlst) // final value
//
, funent_vbindmap= vbindmap // local varbind map
//
, funent_instrlst= instrlst // instructions of function body
//
, funent_tmpvarlst= tmpvarlst // tmpvars in function body
//
, funent_fnxlablst= funlablst // mutually tail-recursive funs
//
} (* end of [funent] *)

assume funent_type = funent
extern typedef "funent_t" = funent

in (* in of [local] *)

implement
funent_make
(
  loc, flab
, imparg, tmparg, tmpsub
, tmpret, fls0, d2es, vbmap, inss, tmplst
) = let
(*
val () = fprintln! (stdout_ref, "funent_make: flab = ", flab)
val () = fprintln! (stdout_ref, "funent_make: d2es = ", d2es)
*)
in '{
  funent_loc= loc
//
, funent_lab= flab
//
, funent_imparg= imparg
, funent_tmparg= tmparg
, funent_tmpsub= tmpsub
//
, funent_tmpret= tmpret
//
, funent_flablst= fls0
, funent_flablst_fin= None()
//
, funent_d2envlst= d2es
, funent_d2envlst_fin= None()
//
, funent_vbindmap= vbmap
//
, funent_instrlst= inss
//
, funent_tmpvarlst= tmplst
//
, funent_fnxlablst= list_nil()
//
} end // end of [funent_make]

(* ****** ****** *)

implement
funent_get_loc (fent) = fent.funent_loc

implement
funent_get_lab (fent) = fent.funent_lab

implement
funent_get_level
  (fent) = funlab_get_level (fent.funent_lab)
// end of [funent_get_level]

implement
funent_get_imparg (fent) = fent.funent_imparg

implement
funent_get_tmparg (fent) = fent.funent_tmparg

implement
funent_get_tmpsub (fent) = fent.funent_tmpsub

implement
funent_get_tmpret (fent) = fent.funent_tmpret

implement
funent_get_flablst (fent) = fent.funent_flablst
implement
funent_get_flablst_fin (fent) = fent.funent_flablst_fin

implement
funent_get_d2envlst (fent) = fent.funent_d2envlst
implement
funent_get_d2envlst_fin (fent) = fent.funent_d2envlst_fin

implement
funent_get_vbindmap (fent) = fent.funent_vbindmap

implement
funent_get_instrlst (fent) = fent.funent_instrlst

implement
funent_get_tmpvarlst (fent) = fent.funent_tmpvarlst

(* ****** ****** *)

implement
funent_get_fnxlablst (fent) = fent.funent_fnxlablst

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
funent_make2
(
  loc, flab
, imparg, tmparg
, tmpret, fls0, d2es, vbmap, inss
) = let
  val tmps = instrlst_get_tmpvarset (inss)
  val tmps = tmpvarset_vt_add (tmps, tmpret)
  val tmplst = tmpvarset_vt_listize_free (tmps)
  val tmplst = list_of_list_vt (tmplst)
in
//
funent_make
(
  loc, flab
, imparg, tmparg, None(*tsub*), tmpret, fls0, d2es, vbmap, inss, tmplst
) // end of [funent_make]
//
end // end of [funent_make2]

(* ****** ****** *)

implement
fprint_funent
  (out, fent) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
val flab = funent_get_lab (fent)
//
val imparg = funent_get_imparg (fent)
val tmparg = funent_get_tmparg (fent)
val tsubopt = funent_get_tmpsub (fent)
//
val tmpret = funent_get_tmpret (fent)
//
val inss = funent_get_instrlst (fent)
//
val () = prstr "FUNENT(\n"
//
val () = prstr "lab="
val () = fprint_funlab (out, flab)
val () = prstr "\n"
//
val () = prstr "imparg="
val () = fprint_s2varlst (out, imparg)
val () = prstr "\n"
//
val () = prstr "tmparg="
val () = $UT.fprintlst (out, tmparg, "; ", fprint_s2explst)
val () = prstr "\n"
//
val () = prstr "tmpsub="
val () = fprint_tmpsubopt (out, tsubopt)
val () = prstr "\n"
//
val () = prstr "tmpret="
val () = fprint_tmpvar (out, tmpret)
val () = prstr "\n"
//
val () = prstr "instrlst=\n"
val () = fprint_instrlst (out, inss)
//
val () = prstr ")"
in
  // nothing
end // end of [fprint_funent]

(* ****** ****** *)

implement
funent_is_tmplt (fent) = let
  val tmparg = funent_get_tmparg (fent)
in
//
case+ tmparg of list_cons _ => true | list_nil () => false
//
end // end of [funent_is_tmplst]

(* ****** ****** *)

implement
print_funent (fent) = fprint_funent (stdout_ref, fent)
implement
prerr_funent (fent) = fprint_funent (stderr_ref, fent)

(* ****** ****** *)

%{$

extern
ats_void_type
patsopt_funent_set_tmpsub
(
  ats_ptr_type fent, ats_ptr_type opt
) {
  ((funent_t)fent)->atslab_funent_tmpsub = opt ; return ;
} // end of [patsopt_funent_set_tmpsub]

extern
ats_void_type
patsopt_funent_set_flablst_fin
(
  ats_ptr_type fent, ats_ptr_type opt
) {
  ((funent_t)fent)->atslab_funent_flablst_fin = opt ; return ;
} // end of [patsopt_funent_set_flablst_fin]

extern
ats_void_type
patsopt_funent_set_d2envlst_fin
(
  ats_ptr_type fent, ats_ptr_type opt
) {
  ((funent_t)fent)->atslab_funent_d2envlst_fin = opt ; return ;
} // end of [patsopt_funent_set_d2envlst_fin]

extern
ats_void_type
patsopt_funent_set_fnxlablst
(
  ats_ptr_type fent, ats_ptr_type fls
) {
  ((funent_t)fent)->atslab_funent_fnxlablst = fls ; return ;
} // end of [patsopt_funent_set_fnxlablst]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_ccomp_funent.dats] *)
