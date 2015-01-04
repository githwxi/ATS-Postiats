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
// Start Time: April, 2011
//
(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_effect"

(* ****** ****** *)

staload "./pats_effect.sats"

(* ****** ****** *)

assume effect_t0ype = uint

(* ****** ****** *)
//
#define EFFntm 0 // nonterm
#define EFFexn 1 // exception
#define EFFref 2 // reference
#define EFFwrt 3 // writeover
//
// HX-2012-03:
// the maximal numberof effect is required to
// strictly less than the size of unsigned int
// as one bit is needed for the-rest-of-effects
//
#define MAX_EFFECT_NUMBER 4
//
(* ****** ****** *)

implement effect_ntm = (uint_of)EFFntm
implement effect_exn = (uint_of)EFFexn
implement effect_ref = (uint_of)EFFref
implement effect_wrt = (uint_of)EFFwrt

implement
effectlst_all = '[
  effect_ntm, effect_exn, effect_ref, effect_wrt
] // end of [effectlst_all]

implement
eq_effect_effect (eff1, eff2) = eq_uint_uint (eff1, eff2)

(* ****** ****** *)

implement
effect_get_name
  (eff) = let
//
val eff = int_of(eff)
//
in
  case+ eff of
  | EFFntm => "ntm"
  | EFFexn => "exn"
  | EFFref => "ref"
  | EFFwrt => "wrt"
  | _ => let
      val () = assertloc (false) in $ERR.abort_interr((*deadcode*))
    end // end of [_]
end // end of [effect_get_name]

(* ****** ****** *)

implement
fprint_effect (out, x) = fprint_string (out, effect_get_name (x))

(* ****** ****** *)

assume effset_t0ype = uint

(* ****** ****** *)
//
implement effset_nil = uint_of_int (0) // 0U
implement effset_all = uint_of_int (~1) // 1...1U
//
implement effset_ntm = (1u << effect_ntm)
implement effset_exn = (1u << effect_exn)
implement effset_ref = (1u << effect_ref)
implement effset_wrt = (1u << effect_wrt)
//
implement effset_sing (x) = (1u << x)
//
implement eq_effset_effset (efs1, efs2) = eq_uint_uint (efs1, efs2)
//
(* ****** ****** *)

implement effset_add (xs, x) = xs lor (1u << x)
implement effset_del (xs, x) = xs land ~(1u << x)

(* ****** ****** *)

implement
effset_isnil (xs) = eq_effect_effect (xs, effset_nil)
implement
effset_isall (xs) = eq_effect_effect (xs, effset_all)
implement
effset_isfin (xs) = // finite
  (xs land (1u << MAX_EFFECT_NUMBER)) \eq_uint_uint 0u
// end of [effset_isfin]
implement
effset_iscof (xs) = // cofinite
  (xs land (1u << MAX_EFFECT_NUMBER)) \lt_uint_uint 0u
// end of [effset_iscof]

(* ****** ****** *)

implement
effset_ismem (xs, x) = (xs land (1u << x)) > 0u

implement
effset_supset
  (xs1, xs2) = eq_uint_uint (~xs1 land xs2, 0u)
// end of [effset_supset]

implement
effset_subset
  (xs1, xs2) = eq_uint_uint (xs1 land ~xs2, 0u)
// end of [effset_subset]

implement
effset_is_inter (xs1, xs2) =
  ~effset_isnil (effset_inter (xs1, xs2))
// end of [effset_is_inter]

implement
effset_cmpl (xs) = lnot_uint (xs)

implement
effset_diff
  (xs1, xs2) = (xs1) land effset_cmpl(xs2)
// end of [effset_diff]

implement
effset_inter (xs1, xs2) = xs1 land xs2

implement
effset_union (xs1, xs2) = (xs1) lor (xs2)

(* ****** ****** *)

implement
fprint_effset
  (out, efs) = let
//
fun loop (
  out: FILEref
, efs: effset, n: uint, i: uint, k: &int
) : void = let
in
//
if i < n then let
  val isint =
    effset_is_inter (efs, effset_sing (i))
  val () = if isint then {
    val () = if (k > 0) then fprint_string (out, ", ")
    val () = k := k + 1
    val () = fprint_effect (out, i)
  } // end of [if] // end of [val]
in
  loop (out, efs, n, i+1u, k)
end // end of [if]
//
end // end of [loop]
//
var k: int = 0
//
in
//
case+ 0 of
| _ when
    effset_isnil(efs) => fprint_string (out, "0")
| _ when
    effset_isall(efs) => fprint_string (out, "1")
| _ => (
    fprint_string (out, "[");
    loop (out, efs, (uint_of)MAX_EFFECT_NUMBER, 0u, k);
    fprint_string (out, "]");
  ) (* end of [_] *)
//
end // end of [fprint_effset]

implement
print_effset (x) = fprint_effset (stdout_ref, x)
implement
prerr_effset (x) = fprint_effset (stderr_ref, x)

(* ****** ****** *)

(* end of [pats_effect.dats] *)
