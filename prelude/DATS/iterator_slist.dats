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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: May, 2012
//
(* ****** ****** *)
//
// HX-2012-05-25:
//
// for iterators based on singly-linked lists
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

(*
staload "prelude/SATS/iterator.sats" // HX: preloaded
*)

(* ****** ****** *)

sortdef t0p = t@ype
sortdef vt0p = viewt@ype
stadef itrknd = iter_slist_kind
stadef itrkpm = iter_slist_param

(* ****** ****** *)

dataviewtype
iterk (
  a:viewt@ype+, int(*f*), int(*r*)
) = {f,r:int} ITR (a, f, r) of (list_vt (a, f+r), Ptr1)

(* ****** ****** *)

extern
castfn iterk2iter
  {x:t0p}{n:int}
  (xs: iterk (x, 0, n)):<> iterator (itrknd, itrkpm(), x, 0, n)
// end of [iterk2iter]

extern
castfn iter2iterk
  {x:t0p}{f,r:int}
  (itr: iterator (itrknd, itrkpm(), x, f, r)):<> iterk (x, f, r)
// end of [iter2iterk]

(* ****** ****** *)

implement{x}
iter_make_list_vt
  {n} (xs) = let
  val itr = ITR {x}{0,n} (xs, _)
  val+ ITR (xs, p) = itr
  val () = p := $UN.cast2Ptr1 (addr@ (xs))
  prval () = fold@ (itr)
in
  iterk2iter (itr)
end // end of [iter_make_list_vt]

implement
iter_free_list_vt (itr) = let
  val+ ~ITR (xs, _) = iter2iterk (itr) in xs
end // end of [iter_free_list_vt]

(* ****** ****** *)

extern
praxi encode
  {kpm:tk}{x:t0p}{f,r:int}
  (xs: !iterk (x, f, r) >> iterator (itrknd, kpm, x, f, r)): void
// end of [encode]

extern
praxi decode
  {kpm:tk}{x:t0p}{f,r:int}
  (itr: !iterator (itrknd, kpm, x, f, r) >> iterk (x, f, r)): void
// end of [decode]

(* ****** ****** *)

implement(x)
iter_is_atbeg<itrknd><x>
  {kpm}{f,r} (itr) = let
//
  prval () = decode (itr)
  val+ @ITR (xs0, p) = itr
  val p_xs0 = addr@ (xs0)
  val p = p
  prval () = fold@ (itr)
  prval () = encode (itr)
//
  extern castfn
    __cast {b:bool} (bool(b)):<> [b==(f==0)] bool (b)
  // end of [extern]
in
  if p_xs0 = p then __cast(true) else __cast(false)
end // end of [iter_is_atbeg]

(* ****** ****** *)

implement(x)
iter_is_atend<itrknd><x>
  {kpm}{f,r} (itr) = let
//
  viewtypedef vt = list_vt (x, r)
//
  prval () = decode (itr)
  val+ ITR (_, p) = itr
  prval () = encode (itr)
  val xs = $UN.ptr_get<vt> (p)
  val isnil = list_vt_is_nil (xs)
  prval () = __free (xs) where {
    extern praxi __free (xs: vt): void // returned back to [!p]
  } // end of [prval]
in
  isnil
end // end of [iter_is_atend]

(* ****** ****** *)

implement(x)
iter_getref<itrknd><x>
  {kpm}{f,r} (itr) = let
//
  viewtypedef vt = list_vt (x, r)
//
  prval () = decode (itr)
  val+ ITR (_, p) = itr
  prval () = encode (itr)
//
  val xs = $UN.ptr_get<vt> (p)
  val @list_vt_cons (x, _) = xs
  val p_x = addr@ (x)
  prval () = fold@ (xs)
  prval () = __free (xs) where {
    extern praxi __free (xs: vt): void // returned back to [!p]
  } // end of [prval]
in
  $UN.cast2Ptr1 (p_x)
end // end of [iter_getref]

(* ****** ****** *)

implement(x)
iter_inc<itrknd><x>
  {kpm}{f,r} (itr) = let
//
  viewtypedef vt = list_vt (x, r)
//
  prval () = decode (itr)
  val+ @ITR (_, p) = itr
  val xs = $UN.ptr_get<vt> (p)
  val+ @list_vt_cons (_, xs1) = xs
  val () = p := $UN.cast2Ptr1 (addr@ (xs1))
  val () = fold@ (itr)
  prval () = encode (itr)
//
  prval () = fold@ (xs)
  prval () = __free (xs) where {
    extern praxi __free (xs: vt): void // returned back to [!p]
  } // end of [prval]
in
  // nothing
end // end of [iter_inc]

(* ****** ****** *)

implement(x)
iter_getref_inc<itrknd><x>
  {kpm}{f,r} (itr) = let
//
  viewtypedef vt = list_vt (x, r)
//
  prval () = decode (itr)
  val+ @ITR (_, p) = itr
  val xs = $UN.ptr_get<vt> (p)
  val+ @list_vt_cons (x, xs1) = xs
  val p_x = addr@ (x)
  val () = p := $UN.cast2Ptr1 (addr@ (xs1))
  val () = fold@ (itr)
  prval () = encode (itr)
//
  prval () = fold@ (xs)
  prval () = __free (xs) where {
    extern praxi __free (xs: vt): void // returned back to [!p]
  } // end of [prval]
in
  $UN.cast2Ptr1 (p_x)
end // end of [iter_getref_inc]

(* ****** ****** *)

implement(x)
iter_ins<itrknd><x>
  {kpm}{f,r} (itr, x) = let
//
  prval () =
    lemma_iterator_param (itr)
  (* end of [prval] *)
//
  viewtypedef vt = list_vt (x, r)
  viewtypedef vt1 = list_vt (x, r+1)
  prval () = decode (itr)
  val+ @ITR (xs0, p) = itr
  val xs = $UN.ptr_get<vt> (p)
  val () = $UN.ptr_set<vt1> (p, list_vt_cons (x, xs))
  prval () = let
    extern praxi __assert
      (xs0: !list_vt (x, f+r) >> list_vt (x, f+r+1)): void
    // end of [extern]
  in
    __assert (xs0)
  end // end of [prval]
  prval () = fold@ (itr)
  prval () = encode (itr)
in
  // nothing
end // end of [iter_ins]

(* ****** ****** *)

implement(x)
iter_rmv<itrknd><x>
  {kpm}{f,r} (itr) = let
//
  viewtypedef vt = list_vt (x, r)
  viewtypedef vt1 = list_vt (x, r-1)
//
  prval () = decode (itr)
  val+ @ITR (xs0, p) = itr
  val xs = $UN.ptr_get<vt> (p)
  val+ ~list_vt_cons (x, xs1) = xs
  val () = $UN.ptr_set<vt1> (p, xs1)
  prval () = let
    extern praxi __assert
      (xs0: !list_vt (x, f+r) >> list_vt (x, f+r-1)): void
    // end of [extern]
  in
    __assert (xs0)
  end // end of [prval]
  prval () = fold@ (itr)
  prval () = encode (itr)
//
in
  x
end // end of [iter_rmv]

(* ****** ****** *)

(* end of [iterator_slist.dats] *)
