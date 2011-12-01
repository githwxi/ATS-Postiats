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
// HX-2011-11-17:
// for handling syntactic constants (int, bool, char, string, float) during
// translation of level 3
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "pats_utils.sats"
macdef strcasecmp = $UT.strcasecmp

(* ****** ****** *)

staload INT = "pats_intinf.sats"
stadef intinf = $INT.intinf // integers of infinite precision

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_syncst"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

#define s2s string1_of_string

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef hnflst = s2hnflst_of_s2explst
macdef unhnf = s2exp_of_s2hnf
macdef unhnflst = s2explst_of_s2hnflst

(* ****** ****** *)

implement
d2exp_trup_i0nt
  (d2e0, base, rep, sfx) = let
  val loc0 = d2e0.d2exp_loc
//
  datatype intknd =
    | INT | UINT | LINT | ULINT | LLINT | ULLINT | ERROR
  // end of [intknd]
//
  var p_sfx: ptr = null
//
  var rep1: string = rep
  val () = if
    sfx > 0u then let
    val n = string_length (rep)
    val ln = n - (size_of_uint)sfx
    val () = p_sfx := $UN.cast2ptr (rep) + ln
    val () = rep1 :=
      __make (rep, 0, ln) where {
      extern fun __make (
        x: string, st: size_t, ln: size_t
      ) : string = "atspre_string_make_substring"
    } // end of [val]
  in
    // nothing
  end // end of [val]
  val [n:int] rep1 = (s2s)rep1
  val inf = (case+ base of
    | 8 => let
        prval () = __assert () where {
          extern praxi __assert (): [n >= 1] void
        } // end of [prval]
      in
        $INT.intinf_make_base_string_ofs (8, rep1, 1(*0*))
      end // end of [8]
    | 16 => let
        prval () = __assert () where {
          extern praxi __assert (): [n >= 2] void
        } // end of [prval]
      in
        $INT.intinf_make_base_string_ofs (16, rep1, 2(*0x*))
      end // end of [16]
    | _ => $INT.intinf_make_string (rep1) // base=10 and ofs=0
  ) : intinf // end of [val]
  val () = if
    sfx > 0u then __free (rep1) where {
    extern fun __free (x: string): void = "ats_free_gc"
  } // end of [val]
//
in
//
case+ sfx of
| _ when sfx = 0u => let
    val s2f = s2exp_int_t0ype () in d3exp_int (loc0, s2f, rep, inf)
  end // end of [default]
| _ => let
    val sfx = $UN.cast {string} (p_sfx)
    val knd = (case+ 0 of
      | _ when strcasecmp (sfx, "U") = 0 => UINT
//
      | _ when strcasecmp (sfx, "L") = 0 => LINT
      | _ when strcasecmp (sfx, "UL") = 0 => ULINT
      | _ when strcasecmp (sfx, "LU") = 0 => ULINT
//
      | _ when strcasecmp (sfx, "LL") = 0 => LLINT
      | _ when strcasecmp (sfx, "ULL") = 0 => ULLINT
      | _ when strcasecmp (sfx, "LLU") = 0 => ULLINT
//
      | _ => ERROR ()
    ) : intknd // end of [val]
    val s2f = (case+ knd of
      | INT () => s2exp_int_intinf_t0ype (inf)
      | UINT () => s2exp_uint_intinf_t0ype (inf)
      | LINT () => s2exp_lint_intinf_t0ype (inf)
      | ULINT () => s2exp_ulint_intinf_t0ype (inf)
      | LLINT () => s2exp_llint_intinf_t0ype (inf)
      | ULLINT () => s2exp_ullint_intinf_t0ype (inf)
      | _ => let
          val () = prerr_error3_loc (loc0)
          val () = filprerr_ifdebug "d2exp_trup_i0nt"
          val () = prerr ": the suffix of the integer is not supported."
          val () = prerr_newline ()
          val () = the_trans3errlst_add (T3E_intsp (d2e0))
        in
          s2hnf_err (s2rt_t0ype)
        end // end of [_]
    ) : s2hnf // end of [val]
  in
    d3exp_int (loc0, s2f, rep, inf)
  end // end of [_]
// end of [case]
//
end // end of [d2exp_trup_int]

(* ****** ****** *)

implement
d2exp_trup_bool
  (d2e0, b) = let
  val loc0 = d2e0.d2exp_loc
  val s2f = s2exp_bool_bool_t0ype (b) in d3exp_bool (loc0, s2f, b)
end // end of [d2exp_trup_bool]

implement
d2exp_trup_char
  (d2e0, c) = let
  val loc0 = d2e0.d2exp_loc
  val s2f = s2exp_char_char_t0ype (c) in d3exp_char (loc0, s2f, c)
end // end of [d2exp_trup_char]

implement
d2exp_trup_string
  (d2e0, str) = let
  val loc0 = d2e0.d2exp_loc
  val n = string_length (str)
  val s2f = s2exp_string_int_type (n)
in
  d3exp_string (loc0, s2f, str)
end // end of [d2exp_trup_string]

implement
d2exp_trup_f0loat
  (d2e0, rep, sfx) = let
  datatype fltknd =
    | FLOAT | DOUBLE | LDOUBLE | ERROR
  // end of [fltknd]
  val loc0 = d2e0.d2exp_loc
in
//
case+ 0 of
| _ when sfx = 0u => let
    val s2f = s2exp_double_t0ype () in d3exp_float (loc0, s2f, rep)
  end // end of [default]
| _ => let
    val rep = (s2s)rep
    val n = string_length (rep)
    val ln = n - (size_of_uint)sfx
    val p_sfx = $UN.cast2ptr (rep) + ln
    val sfx = $UN.cast {string} (p_sfx)
    val knd = (case+ 0 of
      | _ when strcasecmp (sfx, "F") = 0 => FLOAT
      | _ when strcasecmp (sfx, "D") = 0 => DOUBLE
      | _ when strcasecmp (sfx, "LD") = 0 => LDOUBLE
      | _ => ERROR ()
    ) : fltknd // end of [val]
    val s2f = (case+ knd of
      | FLOAT () => s2exp_float_t0ype ()
      | DOUBLE () => s2exp_double_t0ype ()
      | LDOUBLE () => s2exp_ldouble_t0ype ()
      | _ => let
          val () = prerr_error3_loc (loc0)
          val () = filprerr_ifdebug "d2exp_trup_i0nt"
          val () = prerr ": the suffix of the floating point number is not supported."
          val () = prerr_newline ()
          val () = the_trans3errlst_add (T3E_floatsp (d2e0))
        in
          s2hnf_err (s2rt_t0ype)
        end // end of [_]
    ) : s2hnf // end of [val]
  in
    d3exp_float (loc0, s2f, rep)
  end // end of [_]
// end of [case]
end // end of [d2exp_trup_float]

(* ****** ****** *)

(* end of [pats_trans3_syncst.dats] *)
