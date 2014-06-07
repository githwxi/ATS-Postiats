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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: February, 2012 *)

(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.dllist"

(* ****** ****** *)

typedef SHR(a:type) = a // for commenting purpose
typedef NSH(a:type) = a // for commenting purpose

(* ****** ****** *)
(*
**
** HX-2012-02-29:
** dllist (a, f, r) means that there are f elements in
** front of the current one while r-1 elements after it. So the
** total number of elements is f+r. If f=r=0, then the list is
** empty.
**
*)
absvtype
dllist_vtype
  (a: viewt@ype+, f: int, r: int) = ptr // HX: f: front; r: rear
stadef dllist = dllist_vtype
//
vtypedef Dllist (a) = [f,r:int] dllist (a, f, r)
vtypedef Dllist0 (a) = [f,r:int | r >= 0] dllist (a, f, r)
vtypedef Dllist1 (a) = [f,r:int | r >= 1] dllist (a, f, r)
//
(* ****** ****** *)

castfn
dllist2ptr {a:vt0p} (xs: !Dllist (INV(a))):<> Ptr0
castfn
dllist2ptr1 {a:vt0p} (xs: !Dllist1 (INV(a))):<> Ptr1

(* ****** ****** *)

praxi
lemma1_dllist_param {a:vt0p}
  {f,r:int} (xs: !dllist (INV(a), f, r)): [f >= 0;r >= 0] void
// end of [lemma_dllist_param]

praxi
lemma2_dllist_param
  {a:vt0p} {f,r:int | f > 0} (xs: !dllist (INV(a), f, r)): [r > 0] void
// end of [lemma2_dllist_param]

praxi
lemma3_dllist_param
  {a:vt0p} {f,r:int | r <= 0} (xs: !dllist (INV(a), f, r)): [f == 0] void
// end of [lemma3_dllist_param]

(* ****** ****** *)

fun{}
dllist_nil {a:vt0p} ():<> dllist (a, 0, 0)

(* ****** ****** *)

praxi
dllist_free_nil
  {a:vt0p}{f:int} (xs: dllist (INV(a), f, 0)): void
// end of [dllist_free_nil]

(* ****** ****** *)

fun{a:vt0p}
dllist_sing (x: a):<!wrt> dllist (a, 0, 1)

(* ****** ****** *)

fun{a:vt0p}
dllist_cons{r:int}
  (x: a, xs: dllist (INV(a), 0, r)):<!wrt> dllist (a, 0, r+1)
// end of [dllist_cons]

fun{a:vt0p}
dllist_uncons{r:int | r > 0}
  (xs: &dllist (INV(a), 0, r) >> dllist (a, 0, r-1)):<!wrt> (a)
// end of [dllist_uncons]

(* ****** ****** *)

fun{a:vt0p}
dllist_snoc{f:int}
  (xs: dllist (INV(a), f, 1), x: a):<!wrt> dllist (a, f+1, 1)
// end of [dllist_snoc]

fun{a:vt0p}
dllist_unsnoc{f:int | f > 0}
  (xs: &dllist (INV(a), f, 1) >> dllist (a, f-1, 1)):<!wrt> (a)
// end of [dllist_unsnoc]

(* ****** ****** *)

fun{a:t0p}
dllist_make_list
  {n:int} (xs: list (INV(a), n)):<!wrt> dllist (a, 0, n)
// end of [dllist_make_list]

(* ****** ****** *)

fun{
} dllist_is_nil
  {a:vt0p}{f,r:int} (xs: !dllist (INV(a), f, r)):<> bool (r==0)
// end of [dllist_is_nil]

fun{
} dllist_is_cons
  {a:vt0p}{f,r:int} (xs: !dllist (INV(a), f, r)):<> bool (r > 0)
// end of [dllist_is_cons]

(* ****** ****** *)

fun{a:vt0p}
dllist_is_atbeg
  {f,r:int}
  (xs: !dllist (INV(a), f, r)):<> bool (f==0)
// end of [dllist_is_atbeg]
fun{a:vt0p}
dllist_is_atend
  {f,r:int | r > 0}
  (xs: !dllist (INV(a), f, r)):<> bool (r==1)
// end of [dllist_is_atend]

fun{a:vt0p}
rdllist_is_atbeg
  {f,r:int | r > 0}
  (xs: !dllist (INV(a), f, r)):<> bool (r==1)
// end of [rdllist_is_atend]
fun{a:vt0p}
rdllist_is_atend
  {f,r:int}
  (xs: !dllist (INV(a), f, r)):<> bool (f==0)
// end of [rdllist_is_atend]

(* ****** ****** *)

fun{a:vt0p}
dllist_getref_elt (xs: !Dllist1 (INV(a))):<> cPtr1 (a)

(* ****** ****** *)

fun{a:vt0p}
dllist_getref_next (xs: !Dllist1 (INV(a))):<> Ptr1
fun{a:vt0p}
dllist_getref_prev (xs: !Dllist1 (INV(a))):<> Ptr1

(* ****** ****** *)

fun{a:t0p}
dllist_get_elt (xs: !Dllist1 (INV(a))): a

fun{a:t0p}
dllist_set_elt (xs: !Dllist1 (INV(a)), x0: a): void

(* ****** ****** *)

fun{a:vt0p}
dllist_length
  {f,r:int} (xs: !dllist (INV(a), f, r)):<> int (r)
// end of [dllist_length]

fun{a:vt0p}
rdllist_length
  {f,r:int} (xs: !dllist (INV(a), f, r)):<> int (f)
// end of [rdllist_length]

(* ****** ****** *)

fun{a:vt0p}
dllist_move
  {f,r:int | r > 1}
  (xs: dllist (INV(a), f, r)):<> dllist (a, f+1, r-1)
fun{a:vt0p}
dllist_move_all
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r)):<> dllist (a, f+r-1, 1)
// end of [dllist_move_all]

(* ****** ****** *)

fun{a:vt0p}
rdllist_move
  {f,r:int | f > 0}
  (xs: dllist (INV(a), f, r)):<> dllist (a, f-1, r+1)
fun{a:vt0p}
rdllist_move_all
  {f,r:int | r >= 0}
  (xs: dllist (INV(a), f, r)):<> dllist (a, 0(*front*), f+r)
// end of [rdllist_move_all]

(* ****** ****** *)

fun{a:vt0p}
dllist_insert_next
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r), x0: a):<!wrt> dllist (a, f, r+1)
// end of [dllist_insert_next]

fun{a:vt0p}
dllist_insert_prev
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r), x0: a):<!wrt> dllist (a, f, r+1)
// end of [dllist_insert]

(* ****** ****** *)

fun{a:vt0p}
dllist_takeout
  {f,r:int | r > 1}
  (xs: &dllist (INV(a), f, r) >> dllist (a, f, r-1)):<!wrt> (a)
// end of [dllist_takeout]

fun{a:vt0p}
dllist_takeout_next
  {f,r:int | r > 1}
  (xs: &dllist (INV(a), f, r) >> dllist (a, f, r-1)):<!wrt> (a)
// end of [dllist_takeout_next]

(* ****** ****** *)

fun{a:vt0p}
rdllist_insert
  {f,r:int | r > 0}
  (xs: dllist (INV(a), f, r), x0: a):<!wrt> dllist (a, f+1, r)
// end of [rdllist_insert]

fun{a:vt0p}
rdllist_takeout
  {f,r:int | f > 0}
  (xs: &dllist (INV(a), f, r) >> dllist (a, f-1, r)):<!wrt> (a)
// end of [rdllist_takeout]

(* ****** ****** *)

fun{a:vt0p}
dllist_append
  {f1,r1:int}{f2,r2:int} (
  xs1: dllist (INV(a), f1, r1), xs2: dllist (a, f2, r2)
) :<!wrt> dllist (a, f1, r1+f2+r2) // end of [dllist_append]

fun{a:vt0p}
rdllist_append
  {f1,r1:int}{f2,r2:int | r2 > 0} (
  xs1: dllist (INV(a), f1, r1), xs2: dllist (a, f2, r2)
) :<!wrt> dllist (a, f1+r1+f2, r2) // end of [rdllist_append]

(* ****** ****** *)

fun{a:vt0p}
dllist_reverse
  {f,r:int} (xs: dllist (INV(a), f, r)):<!wrt> dllist (a, f, r)
// end of [dllist_reverse]

fun{a:vt0p}
rdllist_reverse
  {f,r:int} (xs: dllist (INV(a), f, r)):<!wrt> dllist (a, f, r)
// end of [rdllist_reverse]

(* ****** ****** *)

fun{a:t0p}
dllist_free
  {r:int} (xs: dllist (INV(a), 0, r)):<!wrt> void
// end of [dllist_free]

fun{a:vt0p}
dllist_freelin$clear (x: &a >> a?):<!wrt> void
fun{a:vt0p}
dllist_freelin {r:int} (xs: dllist (INV(a), 0, r)):<!wrt> void

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} dllist_foreach$cont (x: &a, env: &env): bool
fun{
a:vt0p}{env:vt0p
} dllist_foreach$fwork (x: &a, env: &env >> _): void

fun{a:vt0p}
dllist_foreach (xs: !Dllist (INV(a))): void
fun{
a:vt0p}{env:vt0p
} dllist_foreach_env
  (xs: !Dllist (INV(a)), env: &env >> _): void
// end of [dllist_foreach_env]

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} rdllist_foreach$cont (x: &a, env: &env): bool
fun{
a:vt0p}{env:vt0p
} rdllist_foreach$fwork (x: &a, env: &env >> _): void

fun{a:vt0p}
rdllist_foreach (xs: !Dllist (INV(a))): void
fun{
a:vt0p}{env:vt0p
} rdllist_foreach_env
  (xs: !Dllist (INV(a)), env: &env >> _): void
// end of [rdllist_foreach_env]

(* ****** ****** *)
//
fun{}
fprint_dllist$sep (out: FILEref): void
fun{a:vt0p}
fprint_dllist (out: FILEref, xs: !Dllist (INV(a))): void
//
overload fprint with fprint_dllist
//
(* ****** ****** *)
//
fun{}
fprint_rdllist$sep (out: FILEref): void
fun{a:vt0p}
fprint_rdllist (out: FILEref, xs: !Dllist (INV(a))): void
//
(* ****** ****** *)
//
// HX-2013-05: functions of ngc-version
//
(* ****** ****** *)

staload "libats/SATS/gnode.sats"

(* ****** ****** *)

stadef mytkind = $extkind"libats_dllist"

(* ****** ****** *)

typedef g2node0 (a:vt0p) = gnode0 (mytkind, a)
typedef g2node1 (a:vt0p) = gnode1 (mytkind, a)

(* ****** ****** *)

fun{a:vt0p}
dllist_cons_ngc{r:int}
  (x: g2node1 (a), xs: dllist (INV(a), 0, r)):<!wrt> dllist (a, 0, r+1)
// end of [dllist_cons_ngc]

fun{a:vt0p}
dllist_uncons_ngc{r:int | r > 0}
  (xs: &dllist (INV(a), 0, r) >> dllist (a, 0, r-1)):<!wrt> g2node1 (a)
// end of [dllist_uncons_ngc]

(* ****** ****** *)

fun{a:vt0p}
dllist_snoc_ngc{f:int}
  (xs: dllist (INV(a), f, 1), nx: g2node1 (a)):<!wrt> dllist (a, f+1, 1)
// end of [dllist_snoc_ngc]

fun{a:vt0p}
dllist_unsnoc_ngc{f:int | f > 0}
  (xs: &dllist (INV(a), f, 1) >> dllist (a, f-1, 1)):<!wrt> g2node1 (a)
// end of [dllist_unsnoc_ngc]

(* ****** ****** *)

(* end of [dllist.sats] *)
