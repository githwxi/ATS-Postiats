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
// Start Time: March, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

#include "pats_basics.hats"

(* ****** ****** *)

implement VIEWT0YPE_knd = VIEWT0YPE_int

(* ****** ****** *)

implement
test_boxkind (knd) = let
  val knd = uint_of (knd)
  val boxflag = uint_of (BOXFLAG)
in
  (knd \land_uint_uint boxflag) > 0u
end // end of [test_boxkind]

implement
test_linkind (knd) = let
  val knd = uint_of (knd)
  val linflag = uint_of (LINFLAG)
in
  (knd \land_uint_uint linflag) > 0u
end // end of [test_linkind]

implement
test_prfkind (knd) = let
  val knd = uint_of (knd)
  val prfflag = uint_of (PRFFLAG)
in
  (knd \land_uint_uint prfflag) > 0u
end // end of [test_prfkind]

implement
test_prgmkind (knd) = let
  val knd = uint_of (knd)
  val prfflag = uint_of (PRFFLAG)
in
  (knd \land_uint_uint prfflag) = 0u
end // end of [test_prgmkind]

implement
test_polkind (knd) = let
  val knd = uint_of (knd)
  val polflag = uint_of (POLFLAG)
  val knd = knd \land_uint_uint polflag
in
  if knd = 0u then 0 else if knd = 1u then 1 else ~1
end // end of [test_polkind]

(* ****** ****** *)

implement
impkind_linearize (knd) = let
  val linflag = uint_of (LINFLAG)
  val knd = uint_of (knd) \lor_uint_uint linflag
in
  int_of (knd)
end // end of [impkind_linearize]

implement
impkind_neutralize (knd) = let
  val polflag = uint_of (POLFLAG)
  val knd = uint_of (knd) \land_uint_uint ~polflag
in
  int_of (knd)
end // end of [impkind_neutralize]

(* ****** ****** *)

implement
lte_impkind_impkind (k1, k2) = let
  val polflag = uint_of (POLFLAG)
  val polmask = ~polflag
  val k1 = uint_of (k1) \land_uint_uint polmask
  val k2 = uint_of (k2) \land_uint_uint polmask
in
  (k1 \land_uint_uint ~k2) = 0u
end // end of [lte_impkind_impkind]

(* ****** ****** *)

implement
funkind_is_proof fk = case+ fk of
  | FK_prfun () => true
  | FK_prfn () => true
  | FK_praxi () => true
  | _ => false
// end of [funkind_is_proof]

implement
funkind_is_recursive fk = case+ fk of
  | FK_fun () => true
  | FK_fnstar () => true
  | FK_prfun () => true
  | FK_castfn () => true
  | _ => false
// end of [funkind_is_recursive]

implement
funkind_is_tailrecur fk =
  case+ fk of FK_fnstar () => true | _ => false
// end of [funkind_is_tailrecur]

implement
fprint_funkind (out, fk) = case+ fk of
  | FK_fun () => fprint_string (out, "fun")
  | FK_prfun () => fprint_string (out, "prfun")
  | FK_praxi () => fprint_string (out, "praxi")
  | FK_castfn () => fprint_string (out, "castfn")
  | FK_fn () => fprint_string (out, "fn")
  | FK_fnstar () => fprint_string (out, "fn*")
  | FK_prfn () => fprint_string (out, "prfn")
// end of [fprint_funkind]

(* ****** ****** *)

implement valkind_is_proof (vk) =
  case+ vk of VK_prval () => true | _ => false
// end of [valkind_is_proof]

implement
fprint_valkind (out, vk) = case+ vk of
  | VK_val () => fprint_string (out, "val")
  | VK_val_pos () => fprint_string (out, "val+")
  | VK_val_neg () => fprint_string (out, "val-")
  | VK_prval () => fprint_string (out, "prval")
// end of [fprint_valkind]

(* ****** ****** *)

implement
dcstkind_is_fun (x) =
  case+ x of DCKfun () => true | _ => false
// end of [dcstkind_is_fun]

implement
dcstkind_is_val (x) =
  case+ x of DCKval () => true | _ => false
// end of [dcstkind_is_val]

implement
dcstkind_is_prfun (x) =
  case+ x of DCKprfun () => true | _ => false
// end of [dcstkind_is_prfun]

implement
dcstkind_is_prval (x) =
  case+ x of DCKprval () => true | _ => false
// end of [dcstkind_is_prval]

implement
dcstkind_is_proof (dk) =
  case+ dk of
  | DCKpraxi () => true | DCKprfun () => true | DCKprval () => true
  | _ => false
// end of [dcstkind_is_proof]

implement
dcstkind_is_castfn (x) =
  case+ x of DCKcastfn () => true | _ => false
// end of [dcstkind_is_castfn]

(* ****** ****** *)

implement
fprint_dcstkind
  (out, x) = case+ x of
  | DCKfun () => fprint_string (out, "DCKfun()")
  | DCKval () => fprint_string (out, "DCKval()")
  | DCKpraxi () => fprint_string (out, "DCKpraxi()")
  | DCKprfun () => fprint_string (out, "DCKprfun()")
  | DCKprval () => fprint_string (out, "DCKprval()")
  | DCKcastfn () => fprint_string (out, "DCKcastfn()")
// end of [fprint_dcstkind]

(* ****** ****** *)

implement
eq_funclo_funclo
  (fc1, fc2) = case+ (fc1, fc2) of
  | (FUNCLOclo knd1, FUNCLOclo knd2) => knd1 = knd2
  | (FUNCLOfun (), FUNCLOfun ()) => true
  | (_, _) => false
// end of [eq_funclo_funclo]

implement
neq_funclo_funclo (fc1, fc2) = ~eq_funclo_funclo (fc1, fc2)

(* ****** ****** *)

implement
fprint_funclo
  (out, fc) = case+ fc of
  | FUNCLOclo (knd) =>
      fprintf (out, "CLO(%i)", @(knd))
  | FUNCLOfun () => fprintf (out, "FUN", @())
// end of [fprint_funclo]

(* ****** ****** *)

local

var the_flag: int = 1 // 0
val p_the_flag = &the_flag
val (pf_the_flag | ()) =
  vbox_make_view_ptr {int} (view@ the_flag | p_the_flag)
// end of [val]

in // in of [local]

implement
debug_flag_get () = let
  prval vbox (pf) = pf_the_flag in !p_the_flag
end // end of [debug_flag_get]

implement
debug_flag_set (x) = let
  prval vbox (pf) = pf_the_flag in !p_the_flag := x
end // end of [debug_flag_set]

end // end of [local]

(* ****** ****** *)

%{$

ats_void_type
patsopt_vfprintf_ifdebug (
  ats_ptr_type out
, ats_ptr_type fmt
, va_list ap // variadic arguments
) {
//
  if (patsopt_debug_flag_get () > 0) {
    (void)vfprintf((FILE*)out, (char*)fmt, ap) ;
  } // end of [if]
//
  return ;
} // end of [patsopt_debug_printf]

ats_void_type
patsopt_prerrf_ifdebug (
  ats_ptr_type fmt, ...
) {
  va_list ap ;
  va_start(ap, fmt) ;
  patsopt_vfprintf_ifdebug(stderr, (char*)fmt, ap) ;
  va_end(ap) ;
  return ;
} // end of [patsopt_debug_prerrf]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_basics.dats] *)
