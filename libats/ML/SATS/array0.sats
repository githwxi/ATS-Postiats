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
(* Authoremail: gmmhwxiATgmailDOTcom *)
(* Start time: July, 2012 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

%{#
#include "libats/ML/CATS/array0.cats"
%} // end of [%{#]

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

#if(0)
//
// HX: in [basis.sats]
//
abstype
array0_vt0ype_type
  (a: vt@ype(*invariant*)) = ptr
stadef array0 = array0_vt0ype_type
//
#endif

(* ****** ****** *)

(*
typedef array0 (a: vt@ype) = arrszref (a)
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)
//
fun{}
array0_of_arrszref
  {a:vt0p} (arrszref (a)):<> array0 (a)
//
fun{}
arrszref_of_array0
  {a:vt0p} (A: array0 (a)):<> arrszref (a)
//
(* ****** ****** *)
//
symintr array0
//
fun{}
array0_make_arrpsz
  {a:vt0p}{n:int}
  (psz: arrpsz (INV(a), n)):<!wrt> array0 (a)
overload array0 with array0_make_arrpsz
//
fun{}
array0_make_arrayref
  {a:vt0p}{n:int}
  (A: arrayref (a, n), n: size_t (n)):<!wrt> array0 (a)
overload array0 with array0_make_arrayref
//
(* ****** ****** *)
//
fun{}
array0_get_ref{a:vt0p} (A: array0 a):<> Ptr1
fun{}
array0_get_size{a:vt0p} (A: array0 a):<> size_t
//
fun{}
array0_get_refsize
  {a:vt0p}
  (array0 (a)):<> [n:nat] (arrayref (a, n), size_t (n))
//
(* ****** ****** *)
//
fun{a:t0p}
array0_make_elt (asz: size_t, x: a):<!wrt> array0 (a)
//
(* ****** ****** *)
//
fun{a:t0p}
array0_make_list (xs: list0 (INV(a))):<!wrt> array0 (a)
fun{a:t0p}
array0_make_rlist (xs: list0 (INV(a))):<!wrt> array0 (a)
//
(* ****** ****** *)

fun{a:t0p}
array0_make_subarray
  (A: array0 (a), st: size_t, ln: size_t):<!wrt> array0 (a)
// end of [array0_make_subarray]

(* ****** ****** *)

fun{a:t0p}
array0_get_at_size
  (A: array0 (a), i: size_t):<!exnref> a
fun{a:t0p}{tk:tk}
array0_get_at_gint
  (A: array0 (a), i: g0int(tk)):<!exnref> a
fun{a:t0p}{tk:tk}
array0_get_at_guint
  (A: array0 (a), i: g0uint(tk)):<!exnref> a
//
symintr array0_get_at
overload array0_get_at with array0_get_at_gint
overload array0_get_at with array0_get_at_guint
//
(* ****** ****** *)

fun{a:t0p}
array0_set_at_size
  (A: array0 (a), i: size_t, x: a):<!exnrefwrt> void
fun{a:t0p}{tk:tk}
array0_set_at_gint
  (A: array0 (a), i: g0int(tk), x: a):<!exnrefwrt> void
fun{a:t0p}{tk:tk}
array0_set_at_guint
  (A: array0 (a), i: g0uint(tk), x: a):<!exnrefwrt> void
//
symintr array0_set_at
overload array0_set_at with array0_set_at_gint
overload array0_set_at with array0_set_at_guint
//
(* ****** ****** *)

fun{a:vt0p}
array0_exch_at_size
  (A: array0 (a), i: size_t, x: &a >> _):<!exnrefwrt> void
fun{a:vt0p}{tk:tk}
array0_exch_at_gint
  (A: array0 (a), i: g0int(tk), x: &a >> _):<!exnrefwrt> void
fun{a:vt0p}{tk:tk}
array0_exch_at_guint
  (A: array0 (a), i: g0uint(tk), x: &a >> _):<!exnrefwrt> void
//
symintr array0_exch_at
overload array0_exch_at with array0_exch_at_gint
overload array0_exch_at with array0_exch_at_guint
//
(* ****** ****** *)

fun{a:vt0p}
array0_interchange
  (A: array0 (a), i: size_t, j: size_t):<!exnrefwrt> void
// end of [array0_interchange]

(* ****** ****** *)

fun{a:vt0p}
array0_subcirculate
  (A: array0 (a), i: size_t, j: size_t):<!exnrefwrt> void
// end of [array0_subcirculate]

(* ****** ****** *)
//
(*
fun{}
fprint_array$sep (out: FILEref): void
*)
fun{a:vt0p}
fprint_array0 (out: FILEref, A: array0 (a)): void
fun{a:vt0p}
fprint_array0_sep
  (out: FILEref, A: array0 (a), sep: string): void
//
(* ****** ****** *)

fun{a:t0p}
array0_copy (A: array0 (a)):<!refwrt> array0 (a)

(* ****** ****** *)

fun{a:t0p}
array0_append
  (A1: array0 (a), A2: array0 (a)):<!refwrt> array0 (a)
// end of [array0_append]

(* ****** ****** *)

fun{
a:vt0p}{b:vt0p
} array0_map
  (A: array0 (a), f: (&a) -<cloref1> b): array0 (b)
// end of [array0_map]

fun{
a:vt0p}{b:vt0p
} array0_mapopt
  (A: array0 (a), f: (&a) -<cloref1> Option_vt (b)): array0 (b)
// end of [array0_mapopt]

(* ****** ****** *)

fun{a:vt0p}
array0_tabulate
  (asz: size_t, f: (size_t) -<cloref1> a): array0 (a)
// end of [array0_tabulate]

(* ****** ****** *)

fun{a:vt0p}
array0_foreach
  (A: array0 (a), f: (&a >> _) -<cloref1> void): void
// end of [array0_foreach]

fun{a:vt0p}
array0_iforeach
  (A: array0 (a), f: (size_t, &a >> _) -<cloref1> void): void
// end of [array0_iforeach]

(* ****** ****** *)

fun{a:vt0p}
array0_rforeach
  (A: array0 (a), f: (&a >> _) -<cloref1> void): void
// end of [array0_rforeach]

(* ****** ****** *)

(*
** HX: raising NotFoundExn if no satisfying element is found
*)
fun{a:vt0p}
array0_find_exn
  (A: array0 (a), p: (&a) -<cloref1> bool): size_t
// end of [array0_find_exn]

fun{a:vt0p}
array0_find_opt
  (A: array0 (a), p: (&a) -<cloref1> bool): option0 (size_t)
// end of [array0_find_opt]

(* ****** ****** *)

fun{
res:vt0p}{a:vt0p
} array0_foldleft
(
  A: array0 (a), ini: res, f: (res, &a) -<cloref1> res
) : res // end of [array0_foldleft]

fun{
res:vt0p}{a:vt0p
} array0_ifoldleft
(
  A: array0 (a), ini: res, f: (res, size_t, &a) -<cloref1> res
) : res // end of [array0_ifoldleft]

(* ****** ****** *)

fun{
a:vt0p}{res:vt0p
} array0_foldright
(
  A: array0 (a), f: (&a, res) -<cloref1> res, snk: res
) : res // end of [array0_foldright]

(* ****** ****** *)
//
// Overloading certain symbols
//
(* ****** ****** *)

overload [] with array0_get_at_gint
overload [] with array0_get_at_guint
overload [] with array0_set_at_gint
overload [] with array0_set_at_guint

(* ****** ****** *)

overload .size with array0_get_size

(* ****** ****** *)

overload fprint with fprint_array0
overload fprint with fprint_array0_sep

(* ****** ****** *)

(* end of [array0.sats] *)
