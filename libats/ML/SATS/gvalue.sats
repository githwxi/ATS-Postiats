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

(* Author: Hongwei Xi *)
(* Authoremail:
   gmhwxiATgmailDOTcom *)
(* Starting time: December, 2015 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

(*
typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose
*)

(* ****** ****** *)
//
fun
print_gvalue : gvalue -> void
fun
prerr_gvalue : gvalue -> void
fun
fprint_gvalue : fprint_type(gvalue)
//
overload print with print_gvalue
overload prerr with prerr_gvalue
overload fprint with fprint_gvalue
//
fun
fprint_gvlist : fprint_type(gvlist)
fun
fprint_gvarray : fprint_type(gvarray)
fun
fprint_gvhashtbl : fprint_type(gvhashtbl)
//
overload fprint with fprint_gvlist of 10
overload fprint with fprint_gvarray of 10
overload fprint with fprint_gvhashtbl of 10
//
(* ****** ****** *)
//
fun gvalue_nil(): gvalue
//
fun gvalue_int(int): gvalue
//
fun gvalue_bool(bool): gvalue
fun gvalue_char(char): gvalue
//
fun gvalue_float(double): gvalue
fun gvalue_string(string): gvalue
//
fun gvalue_boxed{a:type}(a): gvalue
//
(* ****** ****** *)
//
fun gvalue_list(xs: gvlist): gvalue
//
fun gvalue_array(xs: gvarray): gvalue
//
fun gvalue_hashtbl(kxs: gvhashtbl): gvalue
//
(* ****** ****** *)
//
fun
gvarray_make_nil
  (asz: intGte(0)): gvarray
//
(* ****** ****** *)
//
fun
gvhashtbl_make_nil
  (cap: intGte(1)): gvhashtbl
//
(* ****** ****** *)
//
fun
gvhashtbl_get_atkey
  (gvhashtbl, k: string): gvalue
fun
gvhashtbl_set_atkey
  (gvhashtbl, k: string, x: gvalue): void
//
fun
gvhashtbl_exch_atkey
  (gvhashtbl, k: string, x: gvalue): gvalue
//
(* ****** ****** *)
//
overload [] with gvhashtbl_get_atkey
overload [] with gvhashtbl_set_atkey
//
(*
overload .get with gvhashtbl_get_atkey
overload .set with gvhashtbl_set_atkey
*)
//
(* ****** ****** *)

(* end of [gvalue.sats] *)
