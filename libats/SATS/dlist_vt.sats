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
(* Start time: February, 2012 *)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

(*
**
** HX-2012-02-29:
** dlist_vt (a, f, r) means that there are f elements in
** front of the current one while r-1 elements after it. So the
** total number of elements is f+r. If f=r=0, then the list is
** empty.
**
*)
absvtype
dlist_vtype
  (a: viewt@ype+, f: int, r: int) = ptr // HX: f: front; r: rear
stadef dlist_vt = dlist_vtype

(* ****** ****** *)

praxi
lemma1_dlist_vt_param {a:vt0p}
  {f,r:int} (xs: !dlist_vt (INV(a), f, r)): [f >= 0;r >= 0] void
// end of [lemma_dlist_vt_param]

praxi
lemma2_dlist_vt_param
  {a:vt0p} {f,r:int | f > 0} (xs: !dlist_vt (INV(a), f, r)): [r > 0] void
// end of [lemma2_dlist_vt_param]

praxi
lemma3_dlist_vt_param
  {a:vt0p} {f:int} (xs: !dlist_vt (INV(a), f, 0)): [f == 0] void
// end of [lemma3_dlist_vt_param]

(* ****** ****** *)

fun{}
dlist_vt_nil {a:vt0p} ():<> dlist_vt (a, 0, 0)

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_sing (x: a):<!wrt> dlist_vt (a, 0, 1)

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_cons {r:int}
  (x: a, xs: dlist_vt (INV(a), 0, r)):<!wrt> dlist_vt (a, 0, r+1)
// end of [dlist_vt_cons]

fun{a:vt0p}
dlist_vt_uncons {r:int | r > 0}
  (xs: &dlist_vt (INV(a), 0, r) >> dlist_vt (a, 0, r-1)):<!wrt> (a)
// end of [dlist_vt_uncons]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_snoc {f:int}
  (xs: dlist_vt (INV(a), f, 1), x: a):<!wrt> dlist_vt (a, f+1, 1)
// end of [dlist_vt_snoc]

fun{a:vt0p}
dlist_vt_unsnoc {f:int | f > 0}
  (xs: &dlist_vt (INV(a), f, 1) >> dlist_vt (a, f-1, 1)):<!wrt> (a)
// end of [dlist_vt_unsnoc]

(* ****** ****** *)

fun{a:t0p}
dlist_vt_make_list
  {n:int} (xs: list (INV(a), n)):<!wrt> dlist_vt (a, 0, n)
// end of [dlist_vt_make_list]

(* ****** ****** *)

fun{
} dlist_vt_is_nil
  {a:vt0p}{f,r:int} (xs: !dlist_vt (a, f, r)):<> bool (r==0)
// end of [dlist_vt_is_nil]

fun{
} dlist_vt_is_cons
  {a:vt0p}{f,r:int} (xs: !dlist_vt (a, f, r)):<> bool (r > 0)
// end of [dlist_vt_is_cons]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_is_atbeg
  {f,r:int}
  (xs: !dlist_vt (INV(a), f, r)):<> bool (f==0)
// end of [dlist_vt_is_atbeg]
fun{a:vt0p}
dlist_vt_is_atend
  {f,r:int | r > 0}
  (xs: !dlist_vt (INV(a), f, r)):<> bool (r==1)
// end of [dlist_vt_is_atend]

fun{a:vt0p}
rdlist_vt_is_atbeg
  {f,r:int | r > 0}
  (xs: !dlist_vt (INV(a), f, r)):<> bool (r==1)
// end of [rdlist_vt_is_atend]
fun{a:vt0p}
rdlist_vt_is_atend
  {f,r:int}
  (xs: !dlist_vt (INV(a), f, r)):<> bool (f==0)
// end of [rdlist_vt_is_atend]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_getref_elt
  {f,r:int | r > 0} (xs: !dlist_vt (INV(a), f, r)):<> Ptr1
// end of [dlist_vt_getref_elt]

fun{a:vt0p}
dlist_vt_getref_prev
  {f,r:int | r > 0} (xs: !dlist_vt (INV(a), f, r)):<> Ptr1
// end of [dlist_vt_getref_prev]

fun{a:vt0p}
dlist_vt_getref_next
  {f,r:int | r > 0} (xs: !dlist_vt (INV(a), f, r)):<> Ptr1
// end of [dlist_vt_getref_next]

(* ****** ****** *)

fun{a:t0p}
dlist_vt_get
  {f,r:int | r > 0} (xs: !dlist_vt (INV(a), f, r)): a
// end of [dlist_vt_get]

fun{a:t0p}
dlist_vt_set
  {f,r:int | r > 0} (xs: !dlist_vt (INV(a), f, r), x0: a): void
// end of [dlist_vt_set]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_length
  {f,r:int} (xs: !dlist_vt (INV(a), f, r)):<> int (r)
fun{a:vt0p}
rdlist_vt_length
  {f,r:int} (xs: !dlist_vt (INV(a), f, r)):<> int (f)

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_move
  {f,r:int | r > 1}
  (xs: dlist_vt (INV(a), f, r)):<> dlist_vt (a, f+1, r-1)
fun{a:vt0p}
dlist_vt_move_all
  {f,r:int | r > 0}
  (xs: dlist_vt (INV(a), f, r)):<> dlist_vt (a, f+r-1, 1)
// end of [dlist_vt_move_all]

(* ****** ****** *)

fun{a:vt0p}
rdlist_vt_move
  {f,r:int | f > 0}
  (xs: dlist_vt (INV(a), f, r)):<> dlist_vt (a, f-1, r+1)
fun{a:vt0p}
rdlist_vt_move_all
  {f,r:int | r >= 0}
  (xs: dlist_vt (INV(a), f, r)):<> dlist_vt (a, 0(*front*), f+r)
// end of [rdlist_vt_move_all]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_insert
  {f,r:int | r > 0}
  (xs: dlist_vt (INV(a), f, r), x0: a):<!wrt> dlist_vt (a, f, r+1)
// end of [dlist_vt_insert]

fun{a:vt0p}
dlist_vt_insert_next
  {f,r:int | r > 0}
  (xs: dlist_vt (INV(a), f, r), x0: a):<!wrt> dlist_vt (a, f+1, r)
// end of [dlist_vt_insert_next]

fun{a:vt0p}
dlist_vt_remove
  {f,r:int | r > 1}
  (xs: &dlist_vt (INV(a), f, r) >> dlist_vt (a, f, r-1)):<!wrt> (a)
// end of [dlist_vt_remove]

(* ****** ****** *)

fun{a:vt0p}
rdlist_vt_insert
  {f,r:int | r > 0}
  (xs: dlist_vt (INV(a), f, r), x0: a):<!wrt> dlist_vt (a, f+1, r)
// end of [rdlist_vt_insert]

fun{a:vt0p}
rdlist_vt_remove
  {f,r:int | f > 0}
  (xs: &dlist_vt (INV(a), f, r) >> dlist_vt (a, f-1, r)):<!wrt> (a)
// end of [rdlist_vt_remove]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_append
  {f1,r1:int}{f2,r2:int} (
  xs1: dlist_vt (INV(a), f1, r1), xs2: dlist_vt (a, f2, r2)
) :<!wrt> dlist_vt (a, f1, r1+f2+r2) // end of [dlist_vt_append]

fun{a:vt0p}
rdlist_vt_append
  {f1,r1:int}{f2,r2:int | r2 > 0} (
  xs1: dlist_vt (INV(a), f1, r1), xs2: dlist_vt (a, f2, r2)
) :<!wrt> dlist_vt (a, f1+r1+f2, r2) // end of [rdlist_vt_append]

(* ****** ****** *)

fun{a:vt0p}
dlist_vt_reverse
  {f,r:int} (xs: dlist_vt (INV(a), f, r)):<!wrt> dlist_vt (INV(a), f, r)
// end of [dlist_vt_reverse]

fun{a:vt0p}
rdlist_vt_reverse
  {f,r:int} (xs: dlist_vt (INV(a), f, r)):<!wrt> dlist_vt (INV(a), f, r)
// end of [rdlist_vt_reverse]

(* ****** ****** *)

fun{a:t0p}
dlist_vt_free {r:int} (xs: dlist_vt (INV(a), 0, r)):<!wrt> void

fun{a:vt0p}
dlist_vt_freelin$clear (x: &a >> a?):<!wrt> void
fun{a:vt0p}
dlist_vt_freelin {r:int} (xs: dlist_vt (INV(a), 0, r)):<!wrt> void

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} dlist_vt_foreach$fwork (x: &a, env: &env): void

fun{a:vt0p}
dlist_vt_foreach
  {f,r:int} (xs: !dlist_vt (INV(a), f, r)): void
// end of [dlist_vt_foreach]

fun{
a:vt0p}{env:vt0p
} dlist_vt_foreach_env
  {f,r:int} (xs: !dlist_vt (INV(a), f, r), env: &env): void
// end of [dlist_vt_foreach_env]

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} rdlist_vt_foreach$fwork (x: &a, env: &env): void

fun{a:vt0p}
rdlist_vt_foreach
  {f,r:int} (xs: !dlist_vt (INV(a), f, r)): void
// end of [rdlist_vt_foreach]

fun{
a:vt0p}{env:vt0p
} rdlist_vt_foreach_env
  {f,r:int} (xs: !dlist_vt (INV(a), f, r), env: &env): void
// end of [rdlist_vt_foreach_env]

(* ****** ****** *)

fun{}
fprint_dlist_vt$sep (out: FILEref): void
fun{a:vt0p}
fprint_dlist_vt
  {f,r:int} (out: FILEref, xs: !dlist_vt (INV(a), f, r)): void
// end of [fprint_dlist_vt]

fun{}
fprint_rdlist_vt$sep (out: FILEref): void
fun{a:vt0p}
fprint_rdlist_vt
  {f,r:int} (out: FILEref, xs: !dlist_vt (INV(a), f, r)): void
// end of [fprint_rdlist_vt]

(* ****** ****** *)

(* end of [dlist_vt.sats] *)
