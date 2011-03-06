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
//
// HX: array-based resizable queue implementation
//
(* ****** ****** *)

staload Q = "libats/SATS/linqueue_arr.sats"
stadef QUEUE = $Q.QUEUE

(* ****** ****** *)

staload "pats_queueref.sats"

(* ****** ****** *)

absview
queueref_v (
  a:viewt@ype, m:int, n:int, l:addr
) // end of [queueref_v]
viewdef
queueref_v (
  a:viewt@ype, l:addr
) = [m,n:int | m > 0] queueref_v (a, m, n, l)

extern
prfun
queueref_v_takeout
  {a:viewt@ype}
  {m,n:int} {l:addr} (
  pf: queueref_v (a, m, n, l)
) : (
  QUEUE (a, m, n) @ l
, {m,n:int} QUEUE (a, m, n) @ l -<lin,prf> queueref_v (a, m, n, l)
) // end of [queueref_v_takeout]

(* ****** ****** *)

assume
queueref (a:viewt@ype) =
  [l:addr] (queueref_v (a, l) | ptr l)
// end of [queueref]

(* ****** ****** *)

implement{a}
queueref_enque
  (ref, x) = let
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = __assert (!pref) where {
    extern prfun __assert {m,n:int}
      (x: &QUEUE (a, m, n)): [0 <= n; n <= m] void
  } // end of [prval]
  val isnotfull = $Q.queue_isnot_full (!pref)
in
  if isnotfull then let
    val () = $Q.queue_insert<a> (!pref, x)
    prval () = ref.0 := fpfref (pfque)
  in
    // nothing
  end else let
    val m = $Q.queue_cap {a} (!pref)
    val m2 = m + m
    val () = $Q.queue_update_capacity<a> (!pref, m2)
    val () = $Q.queue_insert (!pref, x)
    prval () = ref.0 := fpfref (pfque)
  in
    // nothing
  end (* end of [if] *)
end // end of [queueref_enque]

(* ****** ****** *)

implement{a}
queueref_deque (ref, x) = let
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = $Q.queue_param_lemma (!pref)
  val isnotempty = $Q.queue_isnot_empty (!pref)
in
  if isnotempty then let
    val () = x :=
      $Q.queue_remove<a> (!pref)
    // end of [val]
    prval () = ref.0 := fpfref (pfque)
    prval () = opt_some {a} (x)
  in
    true
  end else let
    prval () = ref.0 := fpfref (pfque)
    prval () = opt_none {a} (x)
  in
    false
  end (* end of [if] *)
end // end of [queueref_deque]

(* ****** ****** *)

implement{a}
queueref_deque_many
  (pf | ref, p_xs, k) = let
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = $Q.queue_param_lemma (!pref)
  val n = $Q.queue_size (!pref)
in
  if k <= n then let
    val () = $Q.queue_remove_many<a> (!pref, k, !p_xs)
    prval () = ref.0 := fpfref (pfque)
    prval () = pf := arrayopt_v_some {a} (pf)
  in
    true
  end else let
    prval () = ref.0 := fpfref (pfque)
    prval () = pf := arrayopt_v_none {a} (pf)
  in
    false
  end (* end of [if] *)
end // end of [queueref_deque_many]

(* ****** ****** *)

(* end of [pats_queueref.dats] *)
