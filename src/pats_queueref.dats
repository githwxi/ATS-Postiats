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

#define ATS_DYNLOADFLAG 0 // no dynloading at run-time

(* ****** ****** *)

staload Q = "libats/SATS/linqueue_arr.sats"
stadef QUEUE = $Q.QUEUE
stadef QUEUE0 = $Q.QUEUE0

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
queueref (a:viewt@ype) = [l:addr] (queueref_v (a, l) | ptr l)

(* ****** ****** *)

implement
queueref_size
  (ref) = n where {
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  val n = $Q.queue_size (!pref)
  prval () = ref.0 := fpfref (pfque)
} // end of [queueref_size]

(* ****** ****** *)

implement{a}
queueref_make
  {m} (m) = let
  typedef QUEUE0 = QUEUE0(a)?
  val [l:addr] (
    pfgc, pfat | p
  ) = ptr_alloc<QUEUE0> ()
  val () = $Q.queue_initialize<a> (!p, m)
  prval pfqref =
    __assert (pfgc, pfat) where {
    extern prfun __assert (
      pfgc: free_gc_v (QUEUE0, l), pfat: QUEUE (a, m, 0) @ l
    ) : queueref_v (a, m, 0, l)
  } // end of [prval]
in
  (pfqref | p)
end // end of [queueref_make]

(* ****** ****** *)

implement
queueref_free
  {a} (ref) = let
  typedef QUEUE0 = QUEUE0(a)?
  val pref = ref.1
  prval (pfgc, pfat) =
    __assert (ref.0) where {
    extern prfun __assert {m,n:int} {l:addr} (
      pf: queueref_v (a, m, n, l)
    ) : (free_gc_v (QUEUE0, l), QUEUE (a, m, n) @ l)
  } // end of [prval]
  val () = $Q.queue_uninitialize {a} (!pref)
  val () = ptr_free {QUEUE0} (pfgc, pfat | pref)
in
  // nothing
end // end of [queueref_free]

(* ****** ****** *)

implement{a}
queueref_get_elt_at_exn
  (ref, i) = let
  val i = size1_of_size (i)
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = $Q.queue_param_lemma (!pref)
  val n = $Q.queue_size (!pref)
in
  if i < n then let
    val x = $Q.queue_get_elt_at<a> (!pref, i)
    prval () = ref.0 := fpfref (pfque)
  in
    x
  end else let
    prval () = ref.0 := fpfref (pfque)
  in
    $raise Subscript ()
  end (* end of [if] *)
end // end of [queueref_get_elt_at_exn]

implement{a}
queueref_set_elt_at_exn
  (ref, i, x) = let
  val i = size1_of_size (i)
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = $Q.queue_param_lemma (!pref)
  val n = $Q.queue_size (!pref)
in
  if i < n then let
    val () = $Q.queue_set_elt_at<a> (!pref, i, x)
    prval () = ref.0 := fpfref (pfque)
  in
    // nothing
  end else let
    prval () = ref.0 := fpfref (pfque)
    val () = $raise Subscript ()
  in
    // nothing
  end (* end of [if] *)
end // end of [queueref_set_elt_at_exn]

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
queueref_enque_many
  (ref, k, xs) = let
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = $Q.queue_param_lemma (!pref)
  val m = $Q.queue_cap {a} (!pref)
  val n = $Q.queue_size {a} (!pref)  
in
  if n + k <= m then let
    val () = $Q.queue_insert_many (!pref, k, xs)
    prval () = ref.0 := fpfref (pfque)
  in
    // nothing
  end else let
    fun loop
      {m,n:nat | m > 0} {k:nat} (
      m: size_t m, n: size_t n, k: size_t k
    ) : [m:pos | m >= n] size_t (m) =
      if n + k <= m then m else loop (m+m, n, k)
    // end of [val]
    val m2 = loop (m+m, n, k)
    val () = $Q.queue_update_capacity<a> (!pref, m2)
    prval () = ref.0 := fpfref (pfque)
  in
    queueref_enque_many<a> (ref, k, xs)
  end // end of [if]
end (* end of [queueref_enque_many] *)

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

implement{a}
queueref_clear
  (ref, k) = let
  val k = size1_of_size (k)
  val pref = ref.1
  prval (
    pfque, fpfref
  ) = queueref_v_takeout (ref.0)
  prval () = $Q.queue_param_lemma (!pref)
  val n = $Q.queue_size (!pref)
in
  if k < n then let
    val () = $Q.queue_clear<a> (!pref, k)
    prval () = ref.0 := fpfref (pfque)
  in
    // nothing
  end else let
    val () = $Q.queue_clear_all {a} (!pref)
    prval () = ref.0 := fpfref (pfque)
  in
    // nothing
  end (* end of [if] *)
end // end of [queueref_clear]

(* ****** ****** *)

(* end of [pats_queueref.dats] *)
