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
// Start Time: March, 2011
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

#include "./pats_basics.hats"

(* ****** ****** *)

implement VIEWT0YPE_knd = VIEWT0YPE_int

(* ****** ****** *)

implement
test_fltkind(knd) = let
  val knd = uint_of (knd)
  val fltflag = uint_of (FLTFLAG)
in
  (knd \land_uint_uint fltflag) > 0u
end // end of [test_fltkind]

implement
test_boxkind(knd) =
  if test_fltkind (knd) then false else true
// end of [test_boxkind]

implement
test_linkind(knd) = let
  val knd = uint_of (knd)
  val linflag = uint_of (LINFLAG)
in
  (knd \land_uint_uint linflag) > 0u
end // end of [test_linkind]

implement
test_prfkind(knd) = let
  val knd = uint_of(knd)
  val prfflag = uint_of(PRFFLAG)
in
  (knd \land_uint_uint prfflag) > 0u
end // end of [test_prfkind]

implement
test_prgmkind(knd) = let
  val knd = uint_of(knd)
  val prfflag = uint_of(PRFFLAG)
in
  (knd \land_uint_uint prfflag) = 0u
end // end of [test_prgmkind]

implement
test_polkind (knd) = let
  val knd = uint_of (knd)
  val polflag = uint_of(POLFLAG)
  val knd = knd \land_uint_uint polflag
in
//
if
(knd = 0u)
then 0 else (if knd < polflag then 1 else ~1)
// end of [if]
//
end // end of [test_polkind]

(* ****** ****** *)

implement
impkind_linearize(knd) = let
  val linflag = uint_of(LINFLAG)
  val knd = uint_of(knd) \lor_uint_uint linflag
in
  int_of(knd)
end // end of [impkind_linearize]

implement
impkind_neutralize(knd) = let
  val polflag = uint_of(POLFLAG)
  val knd = uint_of(knd) \land_uint_uint ~polflag
in
  int_of(knd)
end // end of [impkind_neutralize]

(* ****** ****** *)

implement
lte_impkind_impkind(k1, k2) = let
//
  val
  polflag =
  uint_of(POLFLAG)
  val
  polmask = ~polflag
//
  val k1 = uint_of(k1) \land_uint_uint polmask
  val k2 = uint_of(k2) \land_uint_uint polmask
//
in
  (k1 \land_uint_uint ~k2) = 0u
end // end of [lte_impkind_impkind]

(* ****** ****** *)

implement
fprint_caskind
  (out, knd) = (
  case+ knd of
  | CK_case () => fprint_string (out, "case")
  | CK_case_pos () => fprint_string (out, "case+")
  | CK_case_neg () => fprint_string (out, "case-")
) // end of [fprint_caskind]

(* ****** ****** *)

implement
funkind_is_proof
  (fk) = let
in
//
case+ fk of
| FK_prfn () => true
| FK_prfun () => true
| FK_praxi () => true
| _ (*non-proof*) => false
//
end // end of [funkind_is_proof]

implement
funkind_is_recursive
  (fk) = let
in
//
case+ fk of
//
| FK_fun () => true
| FK_fnx () => true
//
| FK_prfun () => true
| FK_praxi () => true // HX: praxi=prfun
//
| FK_castfn () => true
//
| _ (*non-recursive*) => false
//
end // end of [funkind_is_recursive]

(* ****** ****** *)

implement
funkind_is_mutailrec
  (fk) = (
//
case+ fk of FK_fnx () => true | _ => false
//
) (* end of [funkind_is_mutailrec] *)

(* ****** ****** *)

implement
fprint_funkind
  (out, fk) = let
in
//
case+ fk of
//
  | FK_fn () => fprint_string (out, "fn")
  | FK_fnx () => fprint_string (out, "fnx")
  | FK_fun () => fprint_string (out, "fun")
//
  | FK_prfn () => fprint_string (out, "prfn")
  | FK_prfun () => fprint_string (out, "prfun")
//
  | FK_praxi () => fprint_string (out, "praxi")
//
  | FK_castfn () => fprint_string (out, "castfn")
//
end // end of [fprint_funkind]

(* ****** ****** *)

(*
implement
valkind_is_model (vk) =
  case+ vk of VK_mcval () => true | _ => false
// end of [valkind_is_model]
*)

implement
valkind_is_proof (vk) =
  case+ vk of VK_prval () => true | _ => false
// end of [valkind_is_proof]

(* ****** ****** *)

implement
fprint_valkind
  (out, vk) = let
in
//
case+ vk of
| VK_val () => fprint_string (out, "val")
| VK_val_pos () => fprint_string (out, "val+")
| VK_val_neg () => fprint_string (out, "val-")
| VK_prval () => fprint_string (out, "prval")
//
end (* end of [fprint_valkind] *)

(* ****** ****** *)

implement
valkind2caskind
  (vk) = let
in
//
case+ vk of
| VK_val () => CK_case ()
| VK_prval () => CK_case_pos () // = val+
| VK_val_pos () => CK_case_pos () // val+
| VK_val_neg () => CK_case_neg () // val-
//
end // end of [valkind2caskind]

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

(* ****** ****** *)

implement
dcstkind_is_proof
  (dk) = let
in
//
case+ dk of
| DCKpraxi () => true
| DCKprfun () => true
| DCKprval () => true
| _ (*non-proof*) => false
//
end // end of [dcstkind_is_proof]

implement
dcstkind_is_castfn (dk) =
  case+ dk of DCKcastfn () => true | _ => false
// end of [dcstkind_is_castfn]

(* ****** ****** *)

implement
fprint_dcstkind
  (out, dk) = let
in
//
case+ dk of
| DCKfun () => fprint_string (out, "DCKfun()")
| DCKval () => fprint_string (out, "DCKval()")
| DCKpraxi () => fprint_string (out, "DCKpraxi()")
| DCKprfun () => fprint_string (out, "DCKprfun()")
| DCKprval () => fprint_string (out, "DCKprval()")
| DCKcastfn () => fprint_string (out, "DCKcastfn()")
//
end // end of [fprint_dcstkind]

(* ****** ****** *)

implement
funclo_is_clo (fc) =
  case+ fc of
  | FUNCLOclo (knd) => true | FUNCLOfun _ => false
// end of [funclo_is_clo]

(* ****** ****** *)

implement
funclo_is_ptr (fc) =
  case+ fc of
  | FUNCLOclo (knd) => knd != 0 | FUNCLOfun _ => true
// end of [funclo_is_ptr]

implement
funclo_is_cloptr (fc) =
  case+ fc of
  | FUNCLOclo (knd) => knd != 0 | FUNCLOfun _ => false
// end of [funclo_is_cloptr]

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
  (out, fc) =
(
  case+ fc of
  | FUNCLOclo (knd) =>
      fprintf (out, "CLO(%i)", @(knd))
  | FUNCLOfun () => fprintf (out, "FUN", @())
) (* end of [fprint_funclo] *)

implement print_funclo (fc) = fprint_funclo (stdout_ref, fc)
implement prerr_funclo (fc) = fprint_funclo (stderr_ref, fc)

(* ****** ****** *)

local
//
var the_flag: int = 0 // 1
val p_the_flag = &the_flag
//
val (
  pf_the_flag | ((*void*))
) = vbox_make_view_ptr{int}(view@ the_flag | p_the_flag)
//
in (* in-of-local *)

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
