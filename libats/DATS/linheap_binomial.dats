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
(* Start time: November, 2011 *)

(* ****** ****** *)
//
// HX: Note that this implementation is largely of
// functional-style and only supports mergeable-heap
// operations; it particular it does not support the
// decrease-key operation.
//
(* ****** ****** *)
//
// HX-2012-12: ported to ATS/Postiats
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.linheap_binomial"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linheap_binomial.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)
//
// HX-2012-12-21:
// the file should be included here
// before [heap_vtype] is assumed
//
#include "./SHARE/linheap.hats" // code reuse
//
(* ****** ****** *)
//
// binomial trees:
// btree(a, n) is for a binomial tree of rank(n)
//
datavtype
btree (
a:vt@ype+, int(*rank*)
) = // btree
  | {n:nat}
    btnode (a, n) of (int (n), a, btreelst (a, n))
// end of [btree]

and btreelst
(
  a:vt@ype+, int(*rank*)
) =
  | {n:nat}
    btlst_cons (a, n+1) of (btree (a, n), btreelst (a, n))
  | btlst_nil (a, 0)
// end of [btreelst]

(* ****** ****** *)

datavtype
bheap (
  a:vt@ype+, int(*rank*), int(*size*)
) = // bheap
  | {n:nat}
    bheap_nil (a, n, 0) of ()
  | {n:nat}{p:int}{sz:nat}{n1:int | n1 > n}
    bheap_cons (a, n, p+sz) of (EXP2 (n, p) | btree (a, n), bheap (a, n1, sz))
// end of [bheap]

(* ****** ****** *)

fun{
a:vt0p
} btree_rank
  {n:int} .<>. (
  bt: !btree (a, n)
) :<> int (n) = let
  val btnode (n, _, _) = bt in n
end // end of [btree_rank]

(* ****** ****** *)

extern
fun{
} pow2 {n:nat}
  (n: int n):<> [p:int] (EXP2 (n, p) | size_t p)
// end of [pow2]

implement{}
pow2 {n} (n) = let
  val res =
    g0uint_lsl_size ((i2sz)1, n)
  val [p:int] res = g1ofg0_uint (res)
  prval pf = __assert () where
  {
    extern praxi __assert (): EXP2 (n, p)
  } // end of [where] // end of [prval]
in
  (pf | res)
end // end of [pow2]

(* ****** ****** *)

fun{
a:vt0p
} btree_size
  {n:int} .<>.
(
  bt: !btree (a, n)
) :<> [p:int]
(
  EXP2 (n, p) | size_t (p)
) = let
  val btnode (n, _, _) = bt in pow2 (n)
end // end of [btree_size]

(* ****** ****** *)

fun{
a:vt0p
} bheap_size
  {n:int}{sz:int}
(
  hp: !bheap (a, n, sz)
) : size_t (sz) = let
in
//
case+ hp of
| bheap_cons
    (pf | bt, hp) => let
    val (pf2 | p) = btree_size<a> (bt)
    prval () = exp2_isfun (pf, pf2)
  in
    p + bheap_size<a> (hp)
  end // end of [bheap_cons]
| bheap_nil ((*void*)) => g1int2uint (0)
//
end // end of [bheap_size]

(* ****** ****** *)

fun{
a:t0p
} btree_free
  {n:nat} .<n,1>.
  (bt: btree (a, n)) :<!wrt> void = let 
  val ~btnode (_, _, bts) = bt in btreelst_free<a> (bts)
end // end of [btree_free]

and
btreelst_free
  {n:nat} .<n,0>.
(
  bts: btreelst (a, n)
) :<!wrt> void = let
in
//
case+ bts of
| ~btlst_cons
    (bt, bts) => let
    val () = btree_free<a> (bt) in btreelst_free<a> (bts)
  end // end of [btlst_cons]
|  ~btlst_nil () => ()
end // end of [btreelst_free]

(* ****** ****** *)

fun{a:vt0p}
btree_btree_merge
  {n:nat} .<>. (
  bt1: btree (a, n)
, bt2: btree (a, n)
) :<!wrt> btree (a, n+1) = let
  val @btnode (n1, x1, bts1) = bt1
  val @btnode (n2, x2, bts2) = bt2
  val sgn = compare_elt_elt<a> (x1, x2)
in
  if sgn <= 0 then let
    prval () = fold@ (bt2)
    val () = n1 := n1 + 1
    val () = bts1 := btlst_cons{a}(bt2, bts1)
  in
    fold@ (bt1); bt1
  end else let
    prval () = fold@ (bt1)
    val () = n2 := n2 + 1
    val () = bts2 := btlst_cons{a}(bt1, bts2)
  in
    fold@ (bt2); bt2
  end // end of [if]
end // end of [btree_btree_merge]

(* ****** ****** *)

fun{a:vt0p}
btree_bheap_merge
  {n:nat}
  {n1:int | n <= n1}
  {sz:nat}{p:int} .<sz>.
(
  pf: EXP2 (n, p)
| bt: btree (a, n), n: int (n), hp: bheap (a, n1, sz)
) :<!wrt> [n2:int | n2 >= min(n, n1)] bheap (a, n2, sz+p) =
  case+ hp of
  | ~bheap_nil () =>
      bheap_cons{a}(pf | bt, bheap_nil {a} {n+1} ())
    // end of [bheap_nil]
  | @bheap_cons (pf1 | bt1, hp1) => let
      val n1 = btree_rank<a> (bt1)
    in
      if n < n1 then let
        prval () = fold@ (hp) in bheap_cons{a}(pf | bt, hp)
      end else if n > n1 then let
        val () = hp1 := btree_bheap_merge<a> (pf | bt, n, hp1)
        prval () = fold@ (hp) 
      in
        hp
      end else let
        prval () = exp2_ispos (pf1)
        prval () = exp2_isfun (pf, pf1)
        val bt = btree_btree_merge<a> (bt, bt1)
        val hp1 = hp1
        val () = free@{a}{0}{0}{0}{1}(hp)
      in
        btree_bheap_merge<a> (EXP2ind (pf) | bt, n+1, hp1)
      end // end of [if]
    end (* end of [bheap_cons] *)
// end of [btree_bheap_merge]

(* ****** ****** *)

fun{a:vt0p}
bheap_bheap_merge
  {n1,n2:nat}
  {sz1,sz2:nat} .<sz1+sz2>. (
  hp1: bheap (a, n1, sz1), hp2: bheap (a, n2, sz2)
) :<!wrt>
  [n:int | n >= min(n1, n2)] bheap (a, n, sz1+sz2) = let
in
//
case+ hp1 of
| ~bheap_nil () => hp2
| @bheap_cons (pf1 | bt1, hp11) => (
  case+ hp2 of
  | ~bheap_nil () => (fold@ (hp1); hp1)
  | @bheap_cons (pf2 | bt2, hp21) => let
//
      prval pf1 = pf1 and pf2 = pf2
      prval () = exp2_ispos (pf1) and () = exp2_ispos (pf2)
//
      val n1 = btree_rank<a> (bt1)
      and n2 = btree_rank<a> (bt2)
    in
      if n1 < n2 then let
        prval () = fold@ (hp2)
        val () = hp11 := bheap_bheap_merge<a> (hp11, hp2)
        prval () = fold@ (hp1)
      in
        hp1
      end else if n1 > n2 then let
        prval () = fold@ (hp1)
        val () = hp21 := bheap_bheap_merge<a> (hp1, hp21)
        prval () = fold@ (hp2)
      in
        hp2
      end else let
        prval () = exp2_isfun (pf1, pf2)
        val bt12 = btree_btree_merge<a> (bt1, bt2)
        val hp11 = hp11 and hp21 = hp21
        val () = free@{a}{0}{0}{0}{1}(hp1)
        val () = free@{a}{0}{0}{0}{1}(hp2)
      in
        btree_bheap_merge<a> (EXP2ind (pf1) | bt12, n1+1, bheap_bheap_merge<a> (hp11, hp21))
      end // end of [if]
    end (* end of [bheap_cons] *)
  ) // end of [bheap_cons]
end // end of [bheap_bheap_merge]

(* ****** ****** *)

fun{a:vt0p}
bheap_search_ref
  {n:nat}{sz:pos} .<>.
(
  hp0: !bheap (a, n, sz)
) :<> cPtr1(a) = let
//
fun search
  {n:nat}{sz:nat} .<sz>.
(
  hp0: !bheap (a, n, sz), p_x0: Ptr1
) :<> Ptr1 = let
in
//
case+ hp0 of
| @bheap_cons
    (pf | bt, hp) => let
    prval () = exp2_ispos (pf)
    val @btnode (_, x, _) = bt
    val (
      pf, fpf | p_x0
    ) = $UN.ptr_vtake{a}(p_x0)
    val sgn = compare_elt_elt<a> (!p_x0, x)
    prval () = fpf (pf)
    val res =
    (
      if sgn > 0 then search (hp, addr@(x)) else search (hp, p_x0)
    ) : Ptr1 // end of [val]
    prval () = fold@ (bt)
    prval () = fold@ (hp0)
  in
    res
  end // end of [bheap_cons]
| bheap_nil () => p_x0
//
end (* end of [search] *)
//
val+ @bheap_cons
  (pf0 | bt0, hp1) = hp0
val+ @btnode (_, x0, _) = bt0
prval () = fold@ (bt0)
val res = search (hp1, addr@(x0))
prval () = fold@ (hp0)
//
in
  $UN.ptr2cptr{a}(res)
end // end of [bheap_search_ref]

(* ****** ****** *)

fun{a:vt0p}
bheap_remove
  {n:nat}{sz:pos} .<>.
(
  hp0: &bheap (a, n, sz) >> bheap (a, n1, sz-p)
) :<!wrt> #[
  n1,n2,p:int | n1 >= n; n2 >= n; sz >= p
] (
  EXP2 (n2, p) | btree (a, n2)
) = let
//
// HX: [search] and [remove] can be merged into one
//
fun search
  {n:nat}{sz:nat} .<sz>. (
  hp0: !bheap (a, n, sz), x0: &a, pos: &Nat >> _
) :<!wrt> void = let
in
//
case+ hp0 of
| @bheap_cons
    (pf | bt, hp) => let
    prval () = exp2_ispos (pf)
    val+ @btnode (_, x, _) = bt
    val sgn = compare_elt_elt<a> (x0, x)
    val () =
      if sgn > 0 then let
      val p_x0 = addr@ (x0) and p_x = addr@ (x)
      val () = $UN.ptr0_set<a> (p_x0, $UN.ptr0_get<a>(p_x))
      val () = pos := pos + 1
    in
      // nothing
    end // end of [val]
    prval () = fold@ (bt)
    val () = search (hp, x0, pos)
    prval () = fold@ (hp0)
  in
    // nothing
  end // [bheap_cons]
| bheap_nil () => ()
//
end // end of [search]
//
val+ @bheap_cons
  (pf0 | bt0, hp1) = hp0
val+ @btnode (_, x, _) = bt0
val p_x = addr@ (x); prval () = fold@ {a} (bt0)
var x0: a = $UN.ptr0_get<a> (p_x) and pos: Nat = 0
val () = search (hp1, x0, pos)
prval () =
  __clear (x0) where {
  extern praxi __clear (x: &a >> a?): void
} (* end of [prval] *)
prval () = fold@ {a} (hp0)
//
fun remove
  {n:nat}{sz:nat}
  {pos:nat} .<pos>. (
  hp0: &bheap (a, n, sz) >> bheap (a, n1, sz-p)
, pos: int (pos)
, btmin: &btree(a, 0)? >> btree (a, n2)
) :<!wrt> #[
  n1,n2,p:int | n1 >= n; n2 >= n; sz >= p
] (
  EXP2 (n2, p) | void
) = let
//
  prval (
  ) = __assert () where
  {
    extern praxi __assert (): [sz > 0] void
  } // end of [prval]
//
  val+ @bheap_cons (pf | bt, hp) = hp0
//
  prval pf = pf
  prval () = exp2_ispos (pf)
in
//
if pos > 0 then let
  val (pfmin | ()) = remove (hp, pos-1, btmin)
  prval () = fold@ (hp0)
in
  (pfmin | ())
end else let
  val () = btmin := bt
  val hp = hp
  val () = free@{a}{0}{0}{0}{1}(hp0)
  val () = hp0 := hp
in
  (pf | ())
end // end of [if]
//
end (* end of [remove] *)
//
var btmin: btree (a, 0)?
val (pf | ()) = remove (hp0, pos, btmin)
//
in
  (pf | btmin)
end // end of [bheap_remove]

(* ****** ****** *)

assume
heap_vtype
  (a:vt0p) = [n,sz:nat] bheap (a, n, sz)
// end of [heap_vtype]

(* ****** ****** *)

implement{}
linheap_nil {a} () = bheap_nil{a}{0}()
implement{}
linheap_make_nil {a} () = bheap_nil{a}{0}()

(* ****** ****** *)

implement{}
linheap_is_nil (hp) = let
in
//
case+ hp of
| bheap_cons (_ | _, _) => false | bheap_nil () => true
//
end // end of [linheap_is_nil]

implement{}
linheap_isnot_nil (hp) = let
in
//
case+ hp of
| bheap_cons (_ | _, _) => true | bheap_nil () => false
//
end // end of [linheap_is_cons]

(* ****** ****** *)

implement{a}
linheap_size (hp) = $effmask_all (bheap_size<a> (hp))

(* ****** ****** *)

implement{a}
linheap_insert
  (hp0, x0) = let
  val bt = btnode{a}(0, x0, btlst_nil()) in
  hp0 := btree_bheap_merge<a> (EXP2bas () | bt, 0, hp0)
end // end of [linheap_insert]

(* ****** ****** *)

implement{a}
linheap_getmin_ref (hp0) = let
(*
val () = (
  print ("linheap_getmin_ref: enter"); print_newline ()
) // end of [val]
*)
in
//
case+ hp0 of
| bheap_cons
    (pf | _, _) => let
    prval (
    ) = exp2_ispos (pf)
  in
    bheap_search_ref<a> (hp0)
  end // end of [bheap_cons]
| bheap_nil ((*void*)) => cptr_null{a}((*void*))
//
end // end of [linheap_getmin_ref]

(* ****** ****** *)

implement{a}
linheap_delmin
  (hp0, res) = let
(*
val () = (
  print ("linheap_delmin: enter"); print_newline ()
) // end of [val]
*)
in
//
case+ hp0 of
| bheap_cons
    (pf0 | _, _) => let
    prval () = exp2_ispos (pf0)
    val (_(*pf*) | btmin) = bheap_remove<a> (hp0)
    val ~btnode (_, x, bts) = btmin
    val () = res := x
    prval () = opt_some{a}(res)
    val hp1 = hp1 where {
      fun loop
        {n:nat}{sz:nat} .<n>.
      (
        bts: btreelst (a, n), hp: bheap (a, n, sz)
      ) :<> [sz:nat] bheap (a, 0, sz) =
        case+ bts of
        | ~btlst_cons (bt, bts) => let
            prval pf = exp2_istot () in loop (bts, bheap_cons{a}(pf | bt, hp))
          end // end of [btlst_cons]
        | ~btlst_nil () => hp
      // end of [loop]
      val hp1 = loop (bts, bheap_nil)
    } // end of [val]
    val () = hp0 := bheap_bheap_merge<a> (hp0, hp1)
  in
    true
  end // end of [bheap_cons]
| bheap_nil () => let
    prval () = opt_none{a}(res) in false
  end // end of [bheap_nil]
// end of [case]
//
end // end of [linheap_delmin]

(* ****** ****** *)

implement{a}
linheap_merge
  (hp1, hp2) = bheap_bheap_merge<a> (hp1, hp2)
// end of [linheap_merge]

(* ****** ****** *)

implement{a}
linheap_free (hp0) = let
in
//
case+ hp0 of
| ~bheap_cons
    (_ | bt, hp) => let
    val () = btree_free<a> (bt) in linheap_free (hp)
  end // end of [bheap]
| ~bheap_nil () => ()
//
end // end of [linheap_free]

(* ****** ****** *)

implement{a}
linheap_free_ifnil
  (hp0) = let
  vtypedef hp = heap (a)
in
//
case+ hp0 of
| bheap_cons
    (_ | _, _) => let
    prval () = opt_some{hp}(hp0) in true
  end // end of [bheap_cons]
| bheap_nil () => let
    prval () = __assert (hp0) where
    {
      extern
      praxi __assert {n:int} (hp: !bheap (a, n, 0) >> ptr): void
    } // end of [prval]
    prval () = opt_none{hp}(hp0) in false
  end // end of [bheap_nil]
//
end // end of [linheap_free_vt]

(* ****** ****** *)

(* linheap_binomial.dats *)
