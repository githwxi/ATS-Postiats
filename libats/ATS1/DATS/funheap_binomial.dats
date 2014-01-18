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

#define ATS_DYNLOADFLAG 0 // no dynloading

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ATS1/SATS/funheap_binomial.sats"

(* ****** ****** *)
//
implement{a}
compare_elt_elt (x1, x2, cmp) = cmp (x1, x2)
//
(* ****** ****** *)

(*
** binomial trees:
** btree(a, n) is for a binomial tree of rank(n)
*)
datatype
btree (a:t@ype+, int(*rank*)) =
  | {n:nat} btnode (a, n) of (int (n), a, btreelst (a, n))
// end of [btree]

and
btreelst (a:t@ype+, int(*rank*)) =
  | btlst_nil (a, 0) of ((*void*))
  | {n:nat} btlst_cons (a, n+1) of (btree (a, n), btreelst (a, n))
// end of [btreelst]

(* ****** ****** *)

fun{
a:t0p
} btree_rank
  {n:nat} .<>. (
  bt: btree (a, n)
) :<> int (n) = let
  val btnode (n, _, _) = bt in n
end // end of [btree_rank]

(* ****** ****** *)

datatype
bheap (
  a:t@ype+, int(*rank*), int(*size*)
) =
  | {n:nat}
    bheap_nil (a, n, 0) of ()
  | {n:nat}{p:int}{sz:nat}{n1:int | n1 > n}
    bheap_cons (a, n, p+sz) of (EXP2 (n, p) | btree (a, n), bheap (a, n1, sz))
// end of [bheap]

(* ****** ****** *)

fun{a:t0p}
btree_btree_merge
  {n:nat} .<>. (
  bt1: btree (a, n)
, bt2: btree (a, n)
, cmp: cmp a
) :<> btree (a, n+1) = let
  val+btnode (n, x1, bts1) = bt1
  val+btnode (n, x2, bts2) = bt2
  val sgn = compare_elt_elt<a> (x1, x2, cmp)
in
  if sgn <= 0 then
    btnode{a}(n+1, x1, btlst_cons{a}(bt2, bts1))
  else
    btnode{a}(n+1, x2, btlst_cons{a}(bt1, bts2))
  // end of [if]
end // end of [btree_btree_merge]

(* ****** ****** *)

fun{a:t0p}
btree_bheap_merge{sz:nat}
  {n,n1:nat | n <= n1}{p:int} .<sz>.
(
  pf: EXP2 (n, p)
| bt: btree (a, n), n: int (n), hp: bheap (a, n1, sz)
, cmp: cmp (a)
) :<> [n2:int | n2 >= min(n, n1)] bheap (a, n2, sz+p) =
  case+ hp of
  | bheap_cons
      (pf1 | bt1, hp1) => let
      val n1 = btree_rank<a> (bt1)
    in
      if n < n1 then let
        // nothing
      in
        bheap_cons{a}(pf | bt, hp)
      end else if n > n1 then let
        val hp1 =
          btree_bheap_merge<a> (pf | bt, n, hp1, cmp)
        // end of [val]
      in
        bheap_cons{a}(pf1 | bt1, hp1)
      end else let
        prval () = exp2_ispos (pf1)
        prval () = exp2_isfun (pf, pf1)
        val bt = btree_btree_merge<a> (bt, bt1, cmp)
      in
        btree_bheap_merge<a> (EXP2ind (pf) | bt, n+1, hp1, cmp)
      end // end of [if]
    end (* end of [bheap_cons] *)
  | bheap_nil () =>
      bheap_cons{a}(pf | bt, bheap_nil{a}{n+1}())
    // end of [bheap_nil]
// end of [btree_bheap_merge]

(* ****** ****** *)

fun{a:t0p}
bheap_bheap_merge
  {n1,n2:nat}
  {sz1,sz2:nat} .<sz1+sz2>.
(
  hp1: bheap (a, n1, sz1)
, hp2: bheap (a, n2, sz2)
, cmp: cmp a
) :<> [n:int | n >= min(n1, n2)] bheap (a, n, sz1+sz2) =
(
  case+ hp1 of
  | bheap_cons
      (pf1 | bt1, hp11) => (
    case+ hp2 of
    | bheap_nil () => hp1
    | bheap_cons (pf2 | bt2, hp21) => let
//
        prval () = exp2_ispos (pf1)
        prval () = exp2_ispos (pf2)
//
        val n1 = btree_rank<a> (bt1)
        val n2 = btree_rank<a> (bt2)
      in
        if n1 < n2 then
          bheap_cons{a}(pf1 | bt1, bheap_bheap_merge<a> (hp11, hp2, cmp))
        else if n1 > n2 then
          bheap_cons{a}(pf2 | bt2, bheap_bheap_merge<a> (hp1, hp21, cmp))
        else let
          prval () = exp2_isfun (pf1, pf2)
          val bt12 = btree_btree_merge<a> (bt1, bt2, cmp)
        in
          btree_bheap_merge<a> (EXP2ind (pf1) | bt12, n1+1, bheap_bheap_merge<a> (hp11, hp21, cmp), cmp)
        end // end of [if]
      end (* end of [bheap_cons] *)
    ) // end of [bheap_cons]
  | bheap_nil ((*void*)) => hp2
) (* end of [bheap_bheap_merge] *)

(* ****** ****** *)

fun{a:t0p}
bheap_find_min
  {n:nat}{sz:pos} .<>. (
  hp0: bheap (a, n, sz), cmp: cmp a
) :<!wrt> a = x0 where
{
//
fun find
  {n:nat}
  {sz:nat} .<sz>.
(
  hp: bheap (a, n, sz), x0: &a, cmp: cmp a
) :<!wrt> void =
(
  case+ hp of
  | bheap_cons
      (pf | bt, hp) => let
      prval () = exp2_ispos (pf)
      val+btnode (_, x, _) = bt
      val ((*void*)) =
        if compare_elt_elt<a> (x0, x, cmp) > 0 then (x0 := x)
      // end of [val]
    in
      find (hp, x0, cmp)
    end
  | bheap_nil ((*void*)) => ()
) (* end of [find] *)
//
val+bheap_cons
  (pf0 | bt0, hp1) = hp0
val+btnode (_, x0, _) = bt0
var x0: a = x0
val () = find (hp1, x0, cmp)
//
} (* end of [bheap_find_min] *)

(* ****** ****** *)

fun{a:t0p}
bheap_remove_min
  {n:nat}{sz:pos} .<>. (
  hp0: bheap (a, n, sz), cmp: cmp a
) :<!wrt> [
  n1,n2,p:int | n1 >= n; n2 >= n;sz >= p
] (
  EXP2 (n2, p)
| bheap (a, n1, sz-p), btree (a, n2)
) = let
//
  val+bheap_cons
    (pf0 | bt0, hp1) = hp0
  val+btnode (_, x0, _) = bt0
//
// HX: [find] and [remove] can be merged into one
//
  fun find
    {n:nat}{sz:nat} .<sz>.
  (
    hp0: bheap (a, n, sz)
  , x0: &a, pos: &intGte(0) >> _, cmp: cmp a
  ) :<!wrt> void =
    case+ hp0 of
    | bheap_cons (pf | bt, hp) => let
        prval () = exp2_ispos (pf)
        val+ btnode (_, x, _) = bt
        val sgn = compare_elt_elt<a> (x0, x, cmp)
        val () = if sgn > 0 then (x0 := x; pos := pos+1)
      in
        find (hp, x0, pos, cmp)
      end // [bheap_cons]
    | bheap_nil ((*void*)) => ()
  (* end of [find] *)
//
  var x0: a = x0 and pos: Nat = 0
  val () = find (hp1, x0, pos, cmp)
//
  fun remove
    {n:nat}{sz:nat}
    {pos:nat} .<pos>. (
    hp0: bheap (a, n, sz), pos: int (pos)
  , btmin: &btree(a, 0)? >> btree (a, n2)
  ) :<!wrt> #[
    n1,n2,p:int | n1 >= n; n2 >= n; sz >= p
  ] (
    EXP2 (n2, p) | bheap (a, n1, sz-p)
  ) = let
//
    prval () = __assert () where {
      extern praxi __assert (): [sz > 0] void
    } // end of [prval]
//
    val+ bheap_cons (pf | bt, hp) = hp0
    prval () = exp2_ispos (pf)
  in
    if pos > 0 then let
      val (pfmin | hp) = remove (hp, pos-1, btmin)
    in
      (pfmin | bheap_cons{a}(pf | bt, hp))
    end else let
      val () = btmin := bt in (pf | hp)
    end // end of [if]
  end (* end of [remove] *)
//
  var btmin: btree (a, 0)?
  val (pf | hp) = remove (hp0, pos, btmin)
//
in
  (pf | hp, btmin)
end // end of [bheap_remove_min]

(* ****** ****** *)

assume
heap_t0ype_type (a:t0p) = [n,sz:nat] bheap (a, n, sz)

(* ****** ****** *)

implement{}
funheap_make_nil{a}((*void*)) = bheap_nil{a}{0}()

(* ****** ****** *)

local

fun{}
pow2{n:nat} .<>.
(
  n: int n
) :<> [p:pos] (EXP2 (n, p) | size_t (p)) = let
//
val res = (1 << n)
val [p:int] res = $UN.cast{sizeGt(0)}(res)
//
in
  ($UN.castview0{EXP2(n, p)}(0) | res)
end // end of [pow2]

in (* in of [local] *)

implement{a}
funheap_size (hp) = let
//
  fun aux
    {n:nat}{sz:nat} .<sz>.
    (hp: bheap (a, n, sz)):<> size_t (sz) =
    case+ hp of
    | bheap_cons (pf | bt, hp) => let
        val btnode (n, _, _) = bt; val (pf1 | p) = pow2 (n)
        prval () = exp2_isfun (pf, pf1)
      in
        p + aux (hp)
      end // end of [bheap_cons]
    | bheap_nil ((*void*)) => i2sz(0)
  (* end of [aux] *)
//
in
  aux (hp)
end // end of [funheap_size]

end // end of [local]

(* ****** ****** *)

implement{a}
funheap_insert
  (hp, x0, cmp) = let
  val bt = btnode{a}(0, x0, btlst_nil ())
in
  hp := btree_bheap_merge<a> (EXP2bas () | bt, 0, hp, cmp)
end // end of [funheap_insert]

(* ****** ****** *)

implement
funheap_is_empty{a}(hp) =
(
  case+ hp of
  | bheap_cons (_ | _, _) => false | bheap_nil () => true
) // end of [funheap_is_empty]

implement
funheap_isnot_empty{a}(hp) =
(
  case+ hp of
  | bheap_cons (_ | _, _) => true | bheap_nil () => false
) // end of [funheap_isnot_empty]

(* ****** ****** *)

implement{a}
funheap_getmin
  (hp0, cmp, res) = let
in
//
case+ hp0 of
| bheap_cons
    (pf0 | _, _) => let
    prval () = exp2_ispos (pf0)
    val () = res := bheap_find_min<a> (hp0, cmp)
    prval () = opt_some{a}(res)
  in
    true
  end // end of [bheap_cons]
| bheap_nil () => let
    prval () = opt_none{a}(res) in false
  end // end of [bheap_nil]
//
end // end of [funheap_getmin]

(* ****** ****** *)

implement{a}
funheap_delmin
  (hp0, cmp, res) = let
in
//
case+ hp0 of
| bheap_cons
    (pf0 | _, _) => let
    prval () = exp2_ispos (pf0)
    val (_ | hp_new, btmin) =
      bheap_remove_min<a> (hp0, cmp)
    val btnode (_, x, bts) = btmin
    val ((*void*)) = res := x
    prval ((*void*)) = opt_some{a}(res)
    val hp1 = let
      fun loop
        {n:nat}{sz:nat} .<n>.
      (
        bts: btreelst (a, n), hp: bheap (a, n, sz)
      ) :<> [sz:nat] bheap (a, 0, sz) =
      (
        case+ bts of
        | btlst_cons
            (bt, bts) => let
            prval pf = exp2_istot ()
          in
            loop (bts, bheap_cons{a}(pf | bt, hp))
          end // end of [btlst_cons]
        | btlst_nil ((*void*)) => (hp)
      ) (* end of [loop] *)
    in
      loop (bts, bheap_nil)
    end // end of [val]
    val ((*void*)) =
      hp0 := bheap_bheap_merge<a> (hp_new, hp1, cmp)
    // end of [val]
  in
    true
  end // end of [bheap_cons]
| bheap_nil () => let
    prval () = opt_none{a}(res) in false
  end // end of [bheap_nil]
// end of [case]
//
end // end of [funheap_delmin]

(* ****** ****** *)

implement{a}
funheap_delmin_opt
  (hp0, cmp) = let
//
var res: a? // uninitized
val ans = funheap_delmin<a> (hp0, cmp, res)
//
in
//
if ans
  then let
    prval () = opt_unsome{a}(res) in Some_vt{a}(res)
  end // end of [then]
  else let
    prval () = opt_unnone{a}(res) in None_vt{a}(*void*)
  end // end of [else]
// end of [if]
//
end // end of [funheap_delmin_opt]

(* ****** ****** *)

implement{a}
funheap_merge
  (hp1, hp2, cmp) = bheap_bheap_merge<a> (hp1, hp2, cmp)
// end of [funheap_merge]

(* ****** ****** *)

(* end of [funheap_binomail.dats] *)
