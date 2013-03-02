(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2011 Hongwei Xi, Boston University
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

(* Author: Hanwen Wu *)
(* Authoremail: hwwu AT cs DOT bu DOT edu *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: November, 2011 *)

(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gnode.sats"
staload "libats/SATS/linheap_fibonacci.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)
//
postfix (~) SZ
//
macdef SZ (i) = g1int2uint<int_kind,size_kind> (,(i))
//
(* ****** ****** *)

stadef
mytkind = $extkind"atslib_linheap_fibonacci"

(* ****** ****** *)

typedef mynode
  (a:vt0p, l:addr) = gnode (mytkind, a, l)
// end of [mynode]
typedef mynode0 (a:vt0p) = gnode0 (mytkind, a)
typedef mynode1 (a:vt0p) = gnode1 (mytkind, a)

(* ****** ****** *)

extern
fun{a:vt0p}
mynode_make_elt (x: a):<!wrt> mynode1 (a)
implement{a}
mynode_make_elt (x) = gnode_make_elt<mytkind><a> (x)

extern
fun{a:vt0p}
mynode_get_rank (nx: mynode1 (INV(a))):<> int
extern
fun{a:vt0p}
mynode_set_rank (nx: mynode1 (INV(a)), d: int):<!wrt> void

extern
fun{a:vt0p}
mynode_get_marked (nx: mynode1 (INV(a))):<> bool
extern
fun{a:vt0p}
mynode_set_marked (nx: mynode1 (INV(a)), mark: bool):<!wrt> void

(* ****** ****** *)

datavtype
fibheap (a:vt@ype+) =
  | FIBHEAP (a) of (mynode0 (a), size_t(*size*))
// end of [fibheap]

(* ****** ****** *)

assume heap_vtype (a:vt0p) = fibheap (a)

(* ****** ****** *)

implement{}
linheap_is_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx, _) => gnode_is_null (nx)
//
end // end of [linheap_is_nil]

implement{}
linheap_isnot_nil (hp) = let
in
case+ hp of
| FIBHEAP (nx, _) => gnode_isnot_null (nx)
//
end // end of [linheap_isnot_nil]

(* ****** ****** *)

implement{a}
linheap_size (hp) =
  case+ hp of FIBHEAP (_, N) => N
// end of [linheap_size]

(* ****** ****** *)
//
// HX: implementing mergeable-heap operations
//
(* ****** ****** *)

extern
fun{a:vt0p}
compare_elt_mynode
  (x1: &a, nx2: mynode0 (a)):<> int
implement{a}
compare_elt_mynode
  (x1, nx2) = let
in
//
if gnode2ptr (nx2) > 0 then let
  val [l2:addr]
    p_x2 = gnode_getref_elt (nx2)
  prval (pf, fpf) =
    __assert (p_x2) where {
    extern praxi __assert : ptr l2 -<prf> (a@l2, a@l2 -<lin,prf> void)
  } // end of [prval]
  val sgn = compare_elt_elt (x1, !p_x2)
  prval () = fpf (pf)
in
  sgn
end else ~1 // end of [if]
//
end // end of [compare_elt_mynode]

extern
fun{a:vt0p}
compare_mynode_mynode
  (nx1: mynode0 (a), nx2: mynode0 (a)):<> int
// end of [compare_mynode_mynode]

(* ****** ****** *)

implement{a}
linheap_insert
  (hp, x0) = let
//
val @FIBHEAP (nx0, N) = hp
//
var x0: a = x0
val sgn = compare_elt_mynode<a> (x0, nx0)
//
val nx2 = mynode_make_elt<a> (x0)
val () =
  if gnode2ptr (nx0) > 0 then
    gnode_insert_next (nx0, nx2) else gnode_link11 (nx2, nx2)
  // end of [if]
//
val () = if :(nx0: mynode0 (a)) => sgn < 0 then nx0 := nx2
val () = N := succ (N)
//
prval () = fold@ (hp)
//
in
  // nothing
end // end of [linheap_insert]

(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp) =
  case+ hp of FIBHEAP (nx, _) => gnode2ptr (nx)
// end of [linheap_getmin_ref]

(* ****** ****** *)

extern
fun{a:vt0p}
mynode_insert_next_circlst
  (nx1: mynode1 (a), nxs2: mynode0 (a)): void
// end of [mynode_insert_prev_circlst]

extern
fun{a:vt0p}
mynode_insert_prev_circlst
  (nx1: mynode1 (a), nxs2: mynode0 (a)): void
// end of [mynode_insert_prev_circlst]

(* ****** ****** *)

implement{a}
linheap_merge
  (hp1, hp2) = hp1 where {
//
val @FIBHEAP (nx1, N1) = hp1
val ~FIBHEAP (nx2, N2) = hp2
//
val sgn = compare_mynode_mynode<a> (nx1, nx2)
val () =
  if gnode2ptr (nx1) > 0 then
    mynode_insert_next_circlst (nx1, nx2) else ()
  // end of [if]
//
val () = if :(nx1: mynode0 (a)) => (sgn > 0) then nx1 := nx2
val () = N1 := N1 + N2
//
prval () = fold@ (hp1)
//
} // end of [linheap_merge]

(* ****** ****** *)

extern
fun{a:vt0p}
mynodelst_set_parent_null (nxs: mynode0 (a)): void

(* ****** ****** *)

extern
fun{a:vt0p}
mynodelst_consolidate (nxs: mynode0 (a)): mynode0 (a)

(* ****** ****** *)

extern
fun{a:vt0p}
join_mynode_mynode
  (nx1: mynode1 (a), nx2: mynode1 (a)):<!wrt> void
implement{a}
join_mynode_mynode
  (nx1, nx2) = let
  val r = mynode_get_rank (nx1)
(*
  val () = assertloc_debug (r = mynode_get_rank (nx2))
*)
  val () = mynode_set_rank (nx1, r+1)
  val () = gnode_set_parent (nx2, nx1)
  val () = mynode_set_marked (nx2, false)
  val () = gnode_link10 (nx2, gnode_get_children (nx1))
  val () = gnode_set_children (nx1, nx2)
in
  // nothing
end // end of [join_mynode_mynode]

extern
fun{a:vt0p}
merge_mynode_mynode
  (nx1: mynode1 (a), nx2: mynode1 (a)):<!wrt> mynode1 (a)
implement{a}
merge_mynode_mynode
  (nx1, nx2) = let
//
val sgn = compare_mynode_mynode (nx1, nx2)
//
in
  if sgn < 0 then let
    val () = gnode_link11 (nx1, nx2) in nx1
  end else let
    val () = gnode_link11 (nx2, nx1) in nx2
  end // end of [if]
end // end of [merge_mynode_mynode]

(* ****** ****** *)

local

extern
fun{a:vt0p}
rank2mynode_takeout (r: int): mynode0 (a)

extern
fun{a:vt0p}
rank2mynode_putinto (r: int, nx: mynode0 (a)): void

in // in of [local]

implement{a}
mynodelst_consolidate (nxs) = let
//
fun aux (
  nx: mynode1 (a), r: int
) : int = let
  val nx2 = rank2mynode_takeout (r)
in
  if gnode2ptr (nx2) > 0 then let
    val nx = merge_mynode_mynode (nx, nx2)
  in
    aux (nx, r+1)
  end else let
    val () = rank2mynode_putinto (r, nx) in r
  end // end of [if]
end // end of [aux]
//
fun auxlst (
  nxs: mynode0 (a), r0: int
) : int = let
  val iscons = gnodelst_is_cons (nxs)
in
//
if iscons then let
  val nx = nxs
  val nxs =
    gnode_get_next (nxs)
  // end of [val]
  val r = mynode_get_rank (nx)
  val r = aux (nx, r)
  val r0 = (if r > r0 then r else r0): int
in
  auxlst (nxs, r0)
end else r0 // end of [if]
//
end // end of [auxlst]
//
fun auxlink (r0: int): mynode1 (a) = let
//
fun loop (
  r0: int, r: int
) : mynode1 (a) = let
  val nx = rank2mynode_takeout (r)
  val isnot = gnode_isnot_null (nx)
in
  if isnot 
    then loop2 (r0, r+1, nx, nx, nx) else loop (r0, r+1)
  // end of [if]
end // end of [loop]

and loop2 (
  r0: int, r: int
, nx1: mynode1 (a), nx2: mynode1 (a), nx_min: mynode1 (a)
) : mynode1 (a) = let
in
  if r > r0 then let
    val () = gnode_link11 (nx2, nx1)
  in
    nx_min
  end else let
    val nx21 = rank2mynode_takeout (r)
    val isnot = gnode_isnot_null (nx21)
  in
    if isnot then let
      val sgn =
        compare_mynode_mynode (nx21, nx_min)
      // end of [val]
      val nx_min =
        (if sgn < 0 then nx21 else nx_min): mynode1 (a)
      // end of [val]
    in
      loop2 (r0, r, nx1, nx21, nx_min)
    end else
      loop2 (r0, r, nx1, nx2, nx_min)
    // end of [if]
  end // end of [if]
end // end of [loop2]
//
in
  loop (r0, 0)
end // end of [auxlink]
//
val iscons = gnodelst_is_cons (nxs)
//
in
//
if iscons then let
  val nx = nxs
  val nx_prev = gnode_get_prev (nx)
  val nx_prev = $UN.cast{mynode1(a)}(nx_prev)
  val () = gnode_set_next_null (nx_prev)
  val r0 = auxlst (nxs, 0)
in
  auxlink (r0)
end else
  gnode_null ()
// end of [if]
//
end // end of [mynodelst_consolidate]

end // end of [local]

(* ****** ****** *)

implement{a}
linheap_delmin
  (hp0, res) = let
//
val @FIBHEAP (nx0_ref, N) = hp0
//
in
//
if N > 0SZ then let
  val nx0 = nx0_ref
  val nx0 = $UN.cast{mynode1(a)}(nx0)
  val nxs2 = gnode_get_children (nx0)
  val () = mynodelst_set_parent_null (nxs2)
//
  val () = mynode_insert_next_circlst (nx0, nxs2)
//
  val nx1 = gnode_get_next (nx0)
  val () = gnode_free_elt (nx0, res)
  val nx1 = mynodelst_consolidate (nx1)
//
  val () = N := pred (N)
  val () = nx0_ref := nx1
//
  prval () = opt_some {a} (res)
  prval () = fold@ (hp0)
//
in
  true (*removed*)
end else let
  prval () = opt_none {a} (res)
  prval () = fold@ (hp0)
in
  false (*~removed*)
end // end of [if]
//
end // end of [linheap_delmin]

(* ****** ****** *)

(* linheap_fibonacci.dats *)
