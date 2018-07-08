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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: December, 2012
//
(* ****** ****** *)
//
// HX: generic arrays (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-30: ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.gfarray"

(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats" // for handling integer sequences

(* ****** ****** *)

(*
// HX: [stamped_vt] is introduced in prelude/basics_pre.sats
*)

(* ****** ****** *)

dataview
gfarray_v
(
  a:vt@ype+, addr, ilist
) =
  | {l:addr}
    gfarray_v_nil (a, l, ilist_nil) of ()
  | {x:int}{xs:ilist}{l:addr}
    gfarray_v_cons (a, l, ilist_cons (x, xs)) of
      (stamped_vt (a, x) @ l, gfarray_v (a, l+sizeof(a), xs))
    // end of [gfarray_v_cons]
// end of [gfarray_v]

(* ****** ****** *)

prfun
gfarray2array_v
  {a:vt@ype}{xs:ilist}{l:addr}
  (pf: gfarray_v (a, l, xs)): [n:nat] (LENGTH (xs, n), array_v (a, l, n))
// end of [gfarray2array_v]

(* ****** ****** *)

prfun
gfarray_v_sing
  {a:vt@ype}{l:addr}{x:int}
  (pf: stamped_vt (a, x) @ l): gfarray_v (a, l, ilist_sing(x))
// end of [gfarray_v_sing]

prfun
gfarray_v_unsing
  {a:vt@ype}{l:addr}{x:int}
  (pf: gfarray_v (a, l, ilist_sing(x))): stamped_vt (a, x) @ l
// end of [gfarray_v_unsing]

(* ****** ****** *)

prfun
gfarray_v_split
  {a:vt0p}
  {l:addr}
  {xs:ilist}
  {n:int}
  {i:nat | i <= n}
(
  pflen: LENGTH (xs, n)
, pfarr: gfarray_v (a, l, xs)
) : [xs1,xs2:ilist]
(
  LENGTH (xs1, i)
, LENGTH (xs2, n-i)
, APPEND (xs1, xs2, xs)
, gfarray_v (a, l, xs1)
, gfarray_v (a, l+i*sizeof(a), xs2)
) // end of [gfarray_v_split]

(* ****** ****** *)

prfun
gfarray_v_unsplit
  {a:vt0p}
  {l:addr}
  {xs1,xs2:ilist}
  {n1:int} (
  pflen: LENGTH (xs1, n1)
, pfarr1: gfarray_v (a, l, xs1)
, pfarr2: gfarray_v (a, l+n1*sizeof(a), xs2)
) : [xs:ilist]
(
  APPEND (xs1, xs2, xs), gfarray_v (a, l, xs)
) // end of [gfarray_v_unsplit]

(* ****** ****** *)

prfun
gfarray_v_extend
  {a:vt0p}
  {l:addr}
  {xs:ilist}{x:int}{xsx:ilist}
  {n:nat}
(
  pflen: LENGTH (xs, n)
, pfsnoc: SNOC (xs, x, xsx)
, pfat: stamped_vt (a, x) @ l+n*sizeof(a)
, pfarr: gfarray_v (a, l, xs)
) : gfarray_v (a, l, xsx) // endfun

(* ****** ****** *)

prfun
gfarray_v_unextend
  {a:vt0p}
  {l:addr}
  {xs:ilist}
  {n:int | n > 0}
(
  pflen: LENGTH (xs, n)
, pfarr: gfarray_v (a, l, xs)
) : [xsf:ilist;x:int] // xsf: the front
(
  SNOC (xsf, x, xs)
, stamped_vt (a, x) @ l+(n-1)*sizeof(a), gfarray_v (a, l, xsf)
) (* end of [gfarray_v_unextend] *)

(* ****** ****** *)

fun
{a:t0p}
gfarray_get_at
  {l:addr}
  {x0:int}{xs:ilist}
  {i0:int}
(
  pf1: NTH(x0, xs, i0)
, pf2: !gfarray_v (a, l, xs)
| gp0: ptr (l), i0: size_t (i0)
) :<> stamped_t (a, x0) // end

(* ****** ****** *)

fun
{a:t0p}
gfarray_set_at
  {l:addr}
  {x0:int}{xs1:ilist}{xs2:ilist}
  {i0:int}
(
  pf1: UPDATE(x0, xs1, i0, xs2)
, pf2: !gfarray_v(a, l, xs1) >> gfarray_v(a, l, xs2)
| gp0: ptr (l), i0: size_t (i0), x0: stamped_t (a, x0)
) :<!wrt> void // end of [gfarray_set_at]

(* ****** ****** *)

fun
{a:vt0p}
gfarray_exch_at
  {l:addr}
  {x0:int}{x1:int}
  {xs1:ilist}{xs2:ilist}
  {i:int}
(
  pf1: NTH(x1, xs1, i)
, pf2: UPDATE(x0, xs1, i, xs2)
, pf3: !gfarray_v (a, l, xs1) >> gfarray_v (a, l, xs2)
| p: ptr l, i: size_t i, x0: &stamped_vt (a, x0) >> stamped_vt (a, x1)
) :<!wrt> void // end of [gfarray_exch_at]

(* ****** ****** *)

(* end of [gfarray.sats] *)
