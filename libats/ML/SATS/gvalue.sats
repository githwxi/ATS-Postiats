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

macdef
GVint_uncons(x0) =
(
case+
,(x0)
of // case+
| GVint(i) => i
| _(*non-int*) =>
  let val () = assertloc(false) in exit(1) end
) : int // end of [GVint_uncons]

macdef
GVptr_uncons(x0) =
(
case+
,(x0)
of // case+
| GVptr(i) => i
| _(*non-ptr*) =>
  let val () = assertloc(false) in exit(1) end
) : ptr // end of [GVptr_uncons]

(* ****** ****** *)

macdef
GVbool_uncons(x0) =
(
case+
,(x0)
of // case+
| GVbool(i) => i
| _(*non-bool*) =>
  let val () = assertloc(false) in exit(1) end
) : bool // end of [GVbool_uncons]

macdef
GVchar_uncons(x0) =
(
case+
,(x0)
of // case+
| GVchar(i) => i
| _(*non-char*) =>
  let val () = assertloc(false) in exit(1) end
) : char // end of [GVchar_uncons]

(* ****** ****** *)

macdef
GVfloat_uncons(x0) =
(
case+
,(x0)
of // case+
| GVfloat(f) => f
| _(*non-float*) =>
  let val () = assertloc(false) in exit(1) end
) : double // end of [GVfloat_uncons]

(* ****** ****** *)

macdef
GVstring_uncons(x0) =
(
case+
,(x0)
of // case+
| GVstring(s) => s
| _(*non-string*) =>
  let val () = assertloc(false) in exit(1) end
) : string // end of [GVstring_uncons]

(* ****** ****** *)

macdef
GVlist_uncons(x0) =
(
case+
,(x0)
of // case+
| GVlist(xs) => xs
| _(*non-string*) =>
  let val () = assertloc(false) in exit(1) end
) : gvlist // end of [GVlist_uncons]

(* ****** ****** *)

macdef
GVarray_uncons(x0) =
(
case+
,(x0)
of // case+
| GVarray(xs) => xs
| _(*non-string*) =>
  let val () = assertloc(false) in exit(1) end
) : gvarray // end of [GVarray_uncons]

(* ****** ****** *)

macdef
GVhashtbl_uncons(x0) =
(
case+
,(x0)
of // case+
| GVhashtbl(kxs) => kxs
| _(*non-string*) =>
  let val () = assertloc(false) in exit(1) end
) : gvhashtbl // end of [GVhashtbl_uncons]

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
fprint_gvdynarr : fprint_type(gvdynarr)
fun
fprint_gvhashtbl : fprint_type(gvhashtbl)
//
overload fprint with fprint_gvlist of 10
overload fprint with fprint_gvarray of 10
overload fprint with fprint_gvdynarr of 10
overload fprint with fprint_gvhashtbl of 20
//
(* ****** ****** *)
//
fun gvalue_nil(): gvalue
//
fun gvalue_int(int): gvalue
//
fun gvalue_ptr(ptr): gvalue
//
fun gvalue_bool(bool): gvalue
fun gvalue_char(char): gvalue
//
fun gvalue_float(double): gvalue
fun gvalue_string(string): gvalue
//
(* ****** ****** *)
//
fun gvalue_ref(gvref): gvalue
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
gvref_make_elt
  (x0: gvalue): gvref
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
gvdynarr_make_nil
  (cap: intGte(1)): gvdynarr
//
(* ****** ****** *)
//
fun
gvdynarr_get_at
  (gvdynarr, i: intGte(0)): gvalue
fun
gvdynarr_set_at
  (gvdynarr, i: intGte(0), x: gvalue): void
//
overload [] with gvdynarr_get_at
overload [] with gvdynarr_set_at
//
(* ****** ****** *)
//
fun
gvdynarr_insert_atbeg
  (gvdynarr, x: gvalue): void
fun
gvdynarr_insert_atend
  (gvdynarr, x: gvalue): void
//
overload .insbeg with gvdynarr_insert_atbeg
overload .insend with gvdynarr_insert_atend
//
(* ****** ****** *)
//
fun
gvdynarr_listize0(gvdynarr): list0(gvalue)
fun
gvdynarr_listize1(gvdynarr): list0(gvalue)
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
overload [] with gvhashtbl_get_atkey of 20
overload [] with gvhashtbl_set_atkey of 20
//
(*
overload .get with gvhashtbl_get_atkey of 20
overload .set with gvhashtbl_set_atkey of 20
*)
//
(* ****** ****** *)
//
fun
gvhashtbl_pop_atkey
  (gvhashtbl, k: string): gvalue
fun
gvhashtbl_push_atkey
  (gvhashtbl, k: string, x: gvalue): void
//
(* ****** ****** *)
//
fun{}
gvhashtbl_foreach_cloref
(
  tbl: gvhashtbl
, fwork: (string, &gvalue >> _) -<cloref1> void
) : void // end of [gvhashtbl_foreach_cloref]
//
fun{}
gvhashtbl_foreach_method
(
  tbl: gvhashtbl
)
(
  fwork: (string, &gvalue >> _) -<cloref1> void
) : void // end of [gvhashtbl_foreach_method]
//
(* ****** ****** *)
//
fun{}
gvhashtbl_listize1(gvhashtbl): list0 @(string, gvalue)
//
(* ****** ****** *)

(* end of [gvalue.sats] *)
