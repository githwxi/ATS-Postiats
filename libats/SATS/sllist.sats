(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: March, 2013 *)

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

(*
**
** HX-2013-03:
** sllist (a, n) means that there are n elements in the list.
**
*)
absvtype
sllist_vtype (a:viewt@ype+, n:int) = ptr
stadef sllist = sllist_vtype // HX: shorthand
//
vtypedef Sllist (a:vt0p) = [n:int] sllist (a, n)
vtypedef Sllist0 (a:vt0p) = [n:int | n >= 0] sllist (a, n)
vtypedef Sllist1 (a:vt0p) = [n:int | n >= 1] sllist (a, n)
//
(* ****** ****** *)

castfn
sllist2ptr {a:vt0p} (xs: !Sllist (INV(a))):<> Ptr0
castfn
sllist2ptr1 {a:vt0p} (xs: !Sllist1 (INV(a))):<> Ptr1

(* ****** ****** *)

praxi
lemma_sllist_param {a:vt0p}
  {n:int} (xs: !sllist (INV(a), n)): [n >= 0] void
// end of [lemma_sllist_param]

(* ****** ****** *)

fun{}
sllist_nil {a:vt0p} ():<> sllist (a, 0)

(* ****** ****** *)

praxi
sllist_free_nil
  {a:vt0p} (xs: sllist (INV(a), 0)): void

(* ****** ****** *)

fun{a:vt0p}
sllist_sing (x: a):<!wrt> sllist (a, 1)

(* ****** ****** *)

fun{a:vt0p}
sllist_cons {n:int}
  (x: a, xs: sllist (INV(a), n)):<!wrt> sllist (a, n+1)
// end of [sllist_cons]

fun{a:vt0p}
sllist_uncons {n:int | n > 0}
  (xs: &sllist (INV(a), n) >> sllist (a, n-1)):<!wrt> (a)
// end of [sllist_uncons]

(* ****** ****** *)

fun{a:t0p}
sllist_make_list
  {n:int} (xs: list (INV(a), n)):<!wrt> sllist (a, n)
// end of [sllist_make_list]

(* ****** ****** *)

fun{
} sllist_is_nil
  {a:vt0p}{n:int} (xs: !sllist (INV(a), n)):<> bool (n==0)
// end of [sllist_is_nil]

fun{
} sllist_is_cons
  {a:vt0p}{n:int} (xs: !sllist (INV(a), n)):<> bool (n > 0)
// end of [sllist_is_cons]

(* ****** ****** *)

fun{a:vt0p}
sllist_getref_elt (xs: !Sllist1 (INV(a))):<> Ptr1

fun{a:vt0p}
sllist_getref_next (xs: !Sllist1 (INV(a))):<> Ptr1

(* ****** ****** *)

fun{a:t0p}
sllist_get_elt (xs: !Sllist1 (INV(a))): a

fun{a:t0p}
sllist_set_elt (xs: !Sllist1 (INV(a)), x0: a): void

(* ****** ****** *)

fun{a:vt0p}
sllist_length
  {n:int} (xs: !sllist (INV(a), n)):<> int (n)
// end of [sllist_length]

(* ****** ****** *)

fun{a:vt0p}
sllist_append
  {n1,n2:int} (
  xs1: sllist (INV(a), n1), xs2: sllist (a, n2)
) :<!wrt> sllist (a, n1+n2) // end of [sllist_append]

(* ****** ****** *)

fun{a:vt0p}
sllist_reverse
  {n:int} (xs: sllist (INV(a), n)):<!wrt> sllist (a, n)
// end of [sllist_reverse]

(* ****** ****** *)

fun{a:t0p}
sllist_free (xs: Sllist (INV(a))):<!wrt> void

fun{a:vt0p}
sllist_freelin$clear (x: &a >> a?):<!wrt> void
fun{a:vt0p}
sllist_freelin (xs: Sllist (INV(a))):<!wrt> void

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} sllist_foreach$cont (x: &a, env: &env): bool
fun{
a:vt0p}{env:vt0p
} sllist_foreach$fwork (x: &a, env: &env >> _): void

fun{a:vt0p}
sllist_foreach (xs: !Sllist (INV(a))): void
fun{
a:vt0p}{env:vt0p
} sllist_foreach_env
  (xs: !Sllist (INV(a)), env: &env >> _): void
// end of [sllist_foreach_env]

(* ****** ****** *)
//
fun{}
fprint_sllist$sep (out: FILEref): void
//
fun{a:vt0p}
fprint_sllist
  (out: FILEref, xs: !Sllist (INV(a))): void
// end of [fprint_sllist]
//
(* ****** ****** *)

(* end of [sllist.sats] *)
