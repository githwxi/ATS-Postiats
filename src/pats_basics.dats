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
// Start Time: March, 2011
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

#include "pats_basics.hats"

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

implement funkind_is_tailrecur fk =
  case+ fk of FK_fnstar () => true | _ => false
// end of [funkind_is_tailrecur]

implement valkind_is_proof (vk) =
  case+ vk of VK_prval () => true | _ => false
// end of [valkind_is_proof]

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

(* end of [pats_basics.dats] *)
