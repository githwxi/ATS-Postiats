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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Time: February 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_lintprgm.sats"

(* ****** ****** *)

staload _(*anon*) = "./pats_lintprgm.dats"
staload _(*anon*) = "./pats_lintprgm_print.dats"

(* ****** ****** *)

local
//
#include "./pats_lintprgm_myint_int.dats"
//
in
// nothing
end // end of [local]

(* ****** ****** *)

extern
fun{a:t@ype}
myintvec_combine_at
  {n:int} (
  iv_pos: !myintvec (a, n)
, iv_neg: !myintvec (a, n)
, n: int n, i: intBtw (1, n)
) :<> myintvec (a, n) // end of [myintvec_combine_at]

implement{a}
myintvec_combine_at
  (iv_pos, iv_neg, n, i) = let
  val c_pos = iv_pos[i] // c_pos > 0
  and c_neg = neg_myint (iv_neg[i]) // c_neg > 0
  val iv = myintvec_copy_cff (c_pos, iv_neg, n)
  val () = myintvec_addby_cff (iv, c_neg, iv_pos, n)
  val () = myint_free (c_pos)
  and () = myint_free (c_neg)
in
  iv(*NewlyCreatedVector*)
end // end of [myintvec_combine_at]

(* ****** ****** *)
//
// HX-2012-02:
// ~1/0: CONTRADICTION/UNDECIDED
//
extern
fun{a:t@ype}
myintveclst_split_at
  {n:int} (
  vecs: &myintveclst (a, n), n: int n, i: intBtw (1, n)
) : int(*~1/0*) // end of [myintveclst_split_at]

implement{a}
myintveclst_split_at
  {n} (ivs, n, i) = let
//
stadef iv = myintvec (a, n)
stadef ivs = myintveclst (a, n)
//
fun
auxbeg
(
  ivs: ivs, i: natLt n
, neus: &ivs, poss: &ivs, negs: &ivs
) : void = let
in
//
case+ ivs of
//
| ~list_vt_nil() => ()
//
|  list_vt_cons
    (!p_iv, !p_ivs1) => let
    val sgn =
      myintvec_compare_at (!p_iv, i, 0)
    // end of [val]
    val ivs1 = !p_ivs1
  in
    if sgn > 0 then let
      val () = !p_ivs1 := poss
      val () = poss := ivs
      prval () = fold@ {iv} (poss)
    in
      auxbeg (ivs1, i, neus, poss, negs)
    end else if sgn < 0 then let
      val () = !p_ivs1 := negs
      val () = negs := ivs
      prval () = fold@ {iv} (negs)
    in
      auxbeg (ivs1, i, neus, poss, negs)
    end else let // sgn = 0
      val () = !p_ivs1 := neus
      val () = neus := ivs
      prval () = fold@ {iv} (neus)
    in
      auxbeg (ivs1, i, neus, poss, negs)
    end // end of [if]
  end (* end of [list_vt_cons] *)
//
end // end of [auxbeg]
//
fun
auxcomb
(
//
// ~1/0 means contradiction/undecided
//
  n: int n, i: intBtw (1, n)
, neus: &ivs, poss: &ivs, neg: !iv
) : int(*~1/0*) = let
in
//
case+ poss of
//
| list_vt_nil () => let
    prval () = fold@ (poss) in 0(*UNDECIDED*)
  end // end of [list_vt_nil]
//
| list_vt_cons
    (!p_pos, !p_poss) => let
    val iv_new =
      myintvec_combine_at (!p_pos, neg, n, i)
    // end of [val]
    val sgn = myintvec_inspect_gte (iv_new, n)
    val () = (
      if sgn != 0 then
        myintvec_free (iv_new, n) else let
        val () = myintvec_normalize_gte (iv_new, n)
      in
        neus := list_vt_cons (iv_new, neus)
      end // end of [if]
    ) : void // end of [val]
    in
      if (sgn >= 0) then let
        val ans = auxcomb (n, i, neus, !p_poss, neg)
        prval () = fold@ (poss)
      in
        ans
      end else let
        prval () = fold@ (poss) in ~1(*CONTRADITION*)
      end // end of [if]
    end (* end of [list_vt_cons] *)
//
end // end of [auxcomb]
//
// HX: [~1] is returned if contradiction is reached
//
fun
auxcomblst
(
  n: int n, i: intBtw (1, n)
, neus: &ivs, poss: &ivs, negs: ivs
) : int(*~1/0*) = let
in
//
case+ negs of
| ~list_vt_cons
    (neg, negs) => let
    val ans =
      auxcomb (n, i, neus, poss, neg)
    // end of [val]
    val () = myintvec_free (neg, n)
  in
    if ans >= 0 then
      auxcomblst (n, i, neus, poss, negs)
    else let
      val () = myintveclst_free (negs, n) in ~1(*CONTRADICTION*)
    end // end of [if]
  end (* list_vt_cons *)
| ~list_vt_nil () => 0(*UNDECIDED*)
//
end // end of [auxcomblst]
//
var neus: ivs = list_vt_nil ()
var poss: ivs = list_vt_nil ()
and negs: ivs = list_vt_nil ()
//
val () =
  auxbeg (ivs, i, neus, poss, negs)
val ans =
  auxcomblst (n, i, neus, poss, negs)
val () = myintveclst_free (poss, n)
val () = ivs := neus
//
in
  ans(*~1/0*)
end // end of [myintveclst_split_at]

(* ****** ****** *)

extern
fun
{a:t@ype}
myintvec_get_index_of_absmincff
  {n:pos}
  (iv: !myintvec (a, n), n: int n): intBtw (1, n)
// end of [myintvec_get_index_of_absmincff]
implement
{a}(*tmp*)
myintvec_get_index_of_absmincff
  {n}(iv, n) = let
//
viewtypedef x = myint(a)
//
fun loop
  {k:nat | k <= n}{l:addr} .<k>. (
  pf: !array_v (x, k, l)
| p: ptr l, n: int n, k: int k
, isz: bool, ind: &natLt (n), cff: &x
) : void = let
in
  if k > 0 then let
    prval (pf1, pf2) =
      array_v_uncons {x} (pf)
    val sgn = compare_myint_int (!p, 0)
    val () = (
      if sgn > 0 then (
        if (
          isz || (!p < cff)
        ) then let
          val () = ind := n - k
          val () = myint_free (cff)
        in
          cff := myint_copy (!p)
        end else (
          // nothing
        ) // end of [if]
      ) // end of [if]
    ) : void // end of [val]
    val () = (
      if sgn < 0 then let
        val cff1 = neg1_myint (!p)
      in
        if (
          isz || (cff1 < cff)
        ) then let
          val () = ind := n - k
          val () = myint_free (cff)
        in
          cff := cff1
        end else (
          myint_free (cff1)
        ) // end of [if]
      end // end of [if]
    ) : void // end of [val]
  in
    if sgn = 0 then let
      val () = loop (pf2 | p+sizeof<x>, n, k-1, isz, ind, cff)
    in
      pf := array_v_cons {x} (pf1, pf2)
    end else if cff > 1 then let
      val () = loop (pf2 | p+sizeof<x>, n, k-1, false, ind, cff)
    in
      pf := array_v_cons {x} (pf1, pf2)
    end else (
      pf := array_v_cons {x} (pf1, pf2)
    ) // end of [if]
  end // end of [if]
end // end of [loop]
//
var ind: natLt (n) = 0
var cff: myint (a) = myint_make_int (0)
val (pf | p) = myintvec_takeout (iv)
prval (pf1, pf2) = array_v_uncons {x} (pf)
val () = loop (pf2 | p+sizeof<x>, n, n-1, true(*isz*), ind, cff)
prval () = pf := array_v_cons {x} (pf1, pf2)
prval () = myintvecout_addback (pf | iv)
val () = myint_free (cff)
//
val () = assertloc (ind > 0)
//
in
  ind
end // end of [myintvec_get_index_of_absmincff]

(* ****** ****** *)
//
absvtype indexlst(n:int)
//
(*
extern
fun
fprint_indexlst
  {n:int}(out: FILEref, xs: !indexlst n): void
// end of [fprint_indexlst]
*)
//
extern
fun
indexlst_make
  {n:pos}
(
  xs: indexset (n), n: int n
) : indexlst(n) // end-of-fun
//
extern
fun
indexlst_free
  {n:int}(xs: indexlst n): void
//
extern
fun
indexlst_choose
  {n:pos}(xs: &indexlst n): natLt(n)
//
(* ****** ****** *)

local
//
staload FS = "libats/SATS/funset_listord.sats"
staload _(*anon*) = "libats/DATS/funset_listord.dats"
//
fn cmp (
  x1: int, x2: int
) :<cloref> int = compare_int_int (x1, x2)
//
assume indexset(n:int) = $FS.set(index(n))
assume indexlst(n:int) = List_vt(index (n))
//
in (* in-of-local *)

implement
indexset_nil() = $FS.funset_make_nil ()

implement
indexset_is_member
  (xs, x) = $FS.funset_is_member (xs, x, cmp)
// end of [indexset_is_member]

implement
indexset_add
  (xs, x) = xs where
{
  var xs = xs
  val _(*found*) = $FS.funset_insert (xs, x, cmp)
} (* end of [indexset_add] *)

(* ****** ****** *)

implement
indexlst_make
  {n}(iset, n) = let
//
vtypedef res = List_vt (index (n))
//
fun
loop
{k:nat | k < n} .<k>.
(
  k: int k, res1: res, res2: res
) :<cloref> res =
(
if
k > 0
then let
  val
  ismem =
  indexset_is_member{n}(iset, k)
in
  if ismem
    then loop(k-1, list_vt_cons(k, res1), res2)
    else loop(k-1, res1, list_vt_cons(k, res2))
  // end of [if]
end // end of [then]
else list_vt_append(res1, res2)
//
) (* end of [loop] *)
in
  loop(n-1, list_vt_nil, list_vt_nil)
end // end of [indexlst_make]

implement
indexlst_free(xs) = list_vt_free(xs)

implement
indexlst_choose(xs) =
(
  case+ xs of
  | ~list_vt_cons
      (x, xs1) => (xs := xs1; x)
  |  list_vt_nil() => (fold@(xs); 0) // HX: error indication
) (* end of [indexlst_choose] *)

end // end of [local]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
myintveclst_solve
  {n:pos}
(
  iset: indexset(n), ivs: myintveclst(a, n), n: int(n)
) : Ans2(*~1/0*) // end of [myintveclst_solve]
implement
{a}(*tmp*)
myintveclst_solve
  {n}(iset, ivs, n) = let
(*
val () = begin
  print "myintveclst_solve: ivs =\n"; print_myintveclst (ivs, n); print_newline ();
end // end of [val]
*)
//
viewtypedef ivs = myintveclst (a, n)
//
fun solve (
  ivs: &ivs, ilst: &indexlst (n), n: int n
) : Ans2(*~1/0*) = let
//
val i = indexlst_choose (ilst)
(*
val () = (
  print "myintveclst_solve: solve: i = "; print i; print_newline ();
  print "myintveclst_solve: solve: ivs =\n"; print_myintveclst (ivs, n); print_newline ()
) // end of [val]
*)
in
  if i > 0 then let
    val ans =
      myintveclst_split_at<a> (ivs, n, i)
    // end of [val]
  in
    if ans >= 0 then solve (ivs, ilst, n) else ~1(*solved*)
  end else 0(*UNDECIDED*) // end of [if]
end // end of [solve]
//
var ivs: ivs = ivs
var ilst = indexlst_make (iset, n)
val ans = solve (ivs, ilst, n)
(*
val () = (
  print "myintveclst_solve: ans = "; print ans; print_newline ()
) // end of [val]
*)
val () = myintveclst_free (ivs, n)
val () = indexlst_free (ilst)
//
in
  ans
end // end of [myintveclst_solve]

(* ****** ****** *)

(*
**
** HX-2012-02:
** iveq refers to an equality of the form:
** A[0] + A[1]*x1 + A[2]*x2 + ... + A[n]*xn = 0
**
*)

extern
fun{a:t@ype}
myintvec_elimeq_at {n:int} (
  iv: !myintvec (a, n), iveq: !myintvec (a, n), n: int n, i: intBtw (1, n)
) : void // end of [myintvec_elimeq_at]
extern
fun{a:t@ype}
myintveclst_elimeq_at {n:int} (
  ivs: !myintveclst (a, n), iveq: !myintvec (a, n), n: int n, i: intBtw (1, n)
) : void // end of [myintveclst_elimeq_at]

(* ****** ****** *)

implement{a}
myintvec_elimeq_at
  (iv, iveq, n, i) = let
(*
val () = (
  print "myintvec_elimeq_at: i = "; print_int (i); print_newline ();
  print "myintvec_elimeq_at: iv = "; print_myintvec (iv, n); print_newline ();
  print "myintvec_elimeq_at: iveq = "; print_myintvec (iveq, n); print_newline ()
) // end of [val]
*)
//
val sgn = myintvec_compare_at (iv, i, 0)
//
in
//
if sgn != 0 then let
  var c = iv[i] and ceq = iveq[i]
  val sgn = compare_myint_int (ceq, 0)
in
  if sgn >= 0 then let
    val () = c := neg_myint (c)
    val () = myintvec_scale (ceq, iv, n)
    val () = myintvec_addby_cff (iv, c, iveq, n)
    val () = myint_free (c) and () = myint_free (ceq)
  in
    (*nothing*)
  end else let
    val () = ceq := neg_myint (ceq)
    val () = myintvec_scale (ceq, iv, n)
    val () = myintvec_addby_cff (iv, c, iveq, n)
    val () = myint_free (c) and () = myint_free (ceq)
  in
    (*nothing*)
  end (* end of [if] *)
end else () // end of [if]
//
end // end of [myintvec_elimeq_at]

implement{a}
myintveclst_elimeq_at
  (ivs, iveq, n, i) = (
  case+ ivs of
  | list_vt_cons
      (!p_iv, !p_ivs) => let
      val () = myintvec_elimeq_at (!p_iv, iveq, n, i)
      val () = myintveclst_elimeq_at (!p_ivs, iveq, n, i)
    in
      fold@ (ivs)
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ (ivs)
) // end of [myintveclst_elimeq_at]

(* ****** ****** *)
//
datavtype
myivlst(a:t@ype, int) =
  | {n:int}
    MYIVLSTnil(a, n) of ()
  | {n:int}
    MYIVLSTcons(a, n) of (
      int(*stamp*), myintvec (a, n), myivlst (a, n)
    ) // end of [MYIVLSTcons]
  | {n:int}
    MYIVLSTmark(a, n) of myivlst (a, n)
// end of [myivlst]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
myivlst_free {n:int}
  (i1vs: myivlst (a, n), n: int n): void
// end of [myivlst_free]
//
implement
{a}(*tmp*)
myivlst_free
  (i1vs, n) =
(
  case+ i1vs of
  | ~MYIVLSTnil
      ((*void*)) => ()
  | ~MYIVLSTcons
      (_, iv, i1vs) => let
      val () = myintvec_free (iv, n) in myivlst_free (i1vs, n)
    end // end of [MYIVLSTcons]
  | ~MYIVLSTmark (i1vs) => myivlst_free (i1vs, n)
) (* end of [myivlst_free] *)
//
(* ****** ****** *)

extern
fun
{a:t@ype}
myivlst_mark{n:int}
  (i1vs: myivlst (a, n)): myivlst(a, n)
// end of [myivlst_mark]
implement
{a}(*tmp*)
myivlst_mark{n}(i1vs) = MYIVLSTmark(i1vs)

(* ****** ****** *)

extern
fun{a:t@ype}
myivlst_unmark{n:int}
  (i1vs: myivlst(a, n), n: int n): myivlst(a, n)
// end of [myivlst_unmark]
implement{a}
myivlst_unmark
  (i1vs, n) =
(
//
case+ i1vs of
| ~MYIVLSTnil
    ((*void*)) => MYIVLSTnil()
| ~MYIVLSTcons
    (_, iv, i1vs) => let
    val () = myintvec_free(iv, n) in myivlst_unmark(i1vs, n)
  end // end of [MYIVEQLSTcons]
| ~MYIVLSTmark(i1vs) => (i1vs)
//
) (* end of [myivlst_unmark] *)

(* ****** ****** *)
//
(*
** HX-2012-02:
** this is a poorman's doubly-linked list
** I am somewhat fond of this design. Maybe it should
** be put into libats for general use.
*)
//
datavtype
myiveqlst
(
  a:t@ype, int
) = // myiveqlst
  | {n:int}
    MYIVEQLSTnil(a, n) of ()
  | {n:int}
    {i:int | 0 < i; i < n}
    MYIVEQLSTcons(a, n) of (
      int(*stamp*)
    , myintvec (a, n), int i(*index*)
    , ptr(*prev*)
    , myiveqlst (a, n)
    ) // end of [MYIVEQLSTcons]
  | {n:int}
    MYIVEQLSTmark(a, n) of (ptr(*prev*), myiveqlst (a, n))
// end of [myiveqlst]
//
(* ****** ****** *)
//
(*
** HX: for the purpose of debugging
*)
extern
fun
{a:t@ype}
fprint_myiveqlst
  {n:int}
(
  out: FILEref, xs: !myiveqlst (a, n)
) : void // end of [fprint_myiveqlst]

implement
{a}(*tmp*)
fprint_myiveqlst
  (out, xs) = let
//
macdef
prstr(s) =
fprint_string (out, ,(s))
//
in
//
case+ xs of
| MYIVEQLSTnil
    ((*void*)) => let
    val () = prstr "MYIVEQLSTnil()" in fold@(xs)
  end // end of [MYIVEQLSTnil]
| MYIVEQLSTcons
  (
    _, _, _, _, !p_xs
  ) => {
    val () = prstr "MYIVEQLSTcons("
    val () = fprint_myiveqlst (out, !p_xs)
    val () = prstr ")"
    prval () = fold@ (xs)
  }
| MYIVEQLSTmark
    (_, !p_xs) => {
    val () = prstr "MYIVEQLSTmark("
    val () = fprint_myiveqlst (out, !p_xs)
    val () = prstr ")"
    prval () = fold@ (xs)
  }
//
end // end of [fprint_myiveqlst]

(* ****** ****** *)

extern
fun
{a:t@ype}
myiveqlst_free {n:int}
  (i1vs: myiveqlst (a, n), n: int n): void
// end of [myiveqlst_free]
implement
{a}(*tmp*)
myiveqlst_free
  (i1vs, n) =
(
//
case+ i1vs of
//
| ~MYIVEQLSTnil() => ()
//
| ~MYIVEQLSTcons
    (_, iv, _, _, i1vs) =>
  let
    val () =
    myintvec_free(iv, n) in myiveqlst_free(i1vs, n)
  end // end of [MYIVEQLSTcons]
//
| ~MYIVEQLSTmark(_, i1vs) => myiveqlst_free(i1vs, n)
//
) (* end of [myiveqlst_free] *)

(* ****** ****** *)

extern
castfn myiveqlst2ptr
  {a:t@ype}{n:int} (x: !myiveqlst (a, n)): ptr
// end of [myiveqlst2ptr]

(* ****** ****** *)

fun{a:t@ype}
myiveqlst_get_prev
  {n:int}
(
  x: !myiveqlst (a, n)
) : ptr = (
//
case+ x of
| MYIVEQLSTnil
    ((*void*)) => (fold@ (x); null)
| MYIVEQLSTcons
    (_, _, _, !p_prev, _) => let
    prval () = fold@ (x) in p_prev end
  // end of [MYIVEQLSTcons]
| MYIVEQLSTmark (!p_prev, _) => (fold@ (x); p_prev)
//
) (* end of [myiveqlst_get_prev] *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
myiveqlst_cons
  {n:int}
(
  stamp: int, i: intBtw(1, n)
, i1veq: myintvec(a, n), i1veqs: myiveqlst(a, n)
) : myiveqlst (a, n) // end-of-function
//
implement
{a}(*tmp*)
myiveqlst_cons
(
  stamp, i, i1veq, i1veqs
) = res where
{
//
  val
  p_prev =
    myiveqlst_get_prev(i1veqs)
  // end of [val]
  val
  p_prev = ptr1_of_ptr(p_prev)
//
  val res =
  MYIVEQLSTcons
    (stamp, i1veq, i, null(*prev*), i1veqs)
  // end of [val]
//
  val () =
  if p_prev > null then
    $UN.ptrset<ptr> (p_prev, myiveqlst2ptr(res))
  // end of [if] // end of [val]
//
} (* end of [myiveqlst_cons] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
myiveqlst_mark
  {n:int}
  (i1veqs: myiveqlst(a, n)): myiveqlst (a, n)
//
implement
{a}(*tmp*)
myiveqlst_mark
  {n}(i1veqs) = res where
{
//
val
p_prev =
myiveqlst_get_prev(i1veqs)
val
p_prev = ptr1_of_ptr(p_prev)
//
val res =
MYIVEQLSTmark(null(*prev*), i1veqs)
//
val () =
if p_prev > null then
  $UN.ptrset<ptr> (p_prev, myiveqlst2ptr(res))
// end of [if] // end of [val]
//
} (* end of [myiveqlst_mark] *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
myiveqlst_unmark
  {n:int}
  (i1veqs: myiveqlst(a, n), n: int n): myiveqlst(a, n)
// end of [myiveqlst_unmark]
implement{a}
myiveqlst_unmark
  (i1veqs, n) =
(
//
case+ i1veqs of
| ~MYIVEQLSTnil
    ((*void*)) => MYIVEQLSTnil()
| ~MYIVEQLSTcons
    (_, iv, _, _, i1veqs) => let
    val () = myintvec_free (iv, n) in myiveqlst_unmark(i1veqs, n)
  end // end of [MYIVEQLSTcons]
| ~MYIVEQLSTmark(_, i1veqs) => i1veqs
//
) (* end of [myiveqlst_unmark] *)
//
(* ****** ****** *)

extern
fun
{a:t@ype}
myiveqlst_get_last
  {n:int}(xs: !myiveqlst (a, n)): ptr
// end of [myiveqlst_get_last]

implement
{a}(*tmp*)
myiveqlst_get_last
  {n}(xs) = let
//
viewtypedef vt = myiveqlst (a, n)
//
fun loop
  (prev: ptr, xs: !vt): ptr = let
  val pcur = $UN.castvwtp1{ptr}{vt}(xs)
in
//
case+ xs of
| MYIVEQLSTnil
    ((*void*)) =>
    (fold@ (xs); prev)
  // end of [MYIVEQLSTnil]
| MYIVEQLSTcons
    (_, _, _, _, !p_xs) => let
    val res = loop (pcur, !p_xs) in fold@ (xs); res
  end // end of [MYIVEQLSTcons]
| MYIVEQLSTmark(_, !p_xs) => let
    val res = loop (pcur, !p_xs) in fold@ (xs); res
  end // end of [MYIVEQLSTmark]
//
end // end of [loop]
//
in
  loop (null, xs)
end // end of [myiveqlst_get_last]

(* ****** ****** *)
//
extern
fun
{a:t@ype}
myintvec_elimeqlst
  {n:int}
(
  stamp0: int
, iv: !myintvec (a, n), i1veqs: !myiveqlst (a, n), n: int (n)
) : void // end of [myintvec_elimeqlst]
//
local
//
fun{a:t@ype}
myintvec_elimeqlst_rev {n:int} (
  stamp0: int
, iv: !myintvec (a, n), i1veqs: !myiveqlst (a, n), n: int (n)
) : void = let
//
val prev = (
case+ i1veqs of
//
| MYIVEQLSTnil() => (fold@ (i1veqs); null)
//
| MYIVEQLSTcons
  (
    stamp, !p_i1veq, i, prev, _
  ) => prev where
  {
(*
    val () = (
      print "MYIVEQLSTcons: prev = "; print prev; print_newline ()
    ) // end of [val]
*)
    val () = if
      stamp0 <= stamp then myintvec_elimeq_at (iv, !p_i1veq, n, i)
    // end of [val]
    prval () = fold@ (i1veqs)
  } (* end of [MYIVEQLSTcons] *)
| MYIVEQLSTmark
    (prev, _) => prev where
  {
(*
    val () = (
      print "MYIVEQLSTmark: prev = "; print prev; print_newline ()
    ) // end of [val]
*)
    prval () = fold@ (i1veqs)
  } (* end of [MYIVEQLSTmark] *)
//
) : ptr // end of [val]
//
in
//
if (prev > null) then {
  val _prev = __cast (prev) where {
    extern castfn __cast (_: ptr):<> myiveqlst (a, n)
  } // end of [val]
  val () = myintvec_elimeqlst_rev (stamp0, iv, _prev, n)
  prval () = __free (_prev) where {
    extern praxi __free (_: myiveqlst (a, n)): void
  } // end of [prval]
} (* end of [if] *)
//
end // end of [myintvec_elimeqlst_rev]

in (* in-of-local *)

implement{a}
myintvec_elimeqlst
  {n} (stamp0, iv, i1veqs, n) = let
  val last = myiveqlst_get_last (i1veqs)
in
//
if (last > null) then {
  val i1veqs = __cast (last) where {
    extern castfn __cast (_: ptr): myiveqlst (a, n)
  } // end of [val]
  val () = myintvec_elimeqlst_rev (stamp0, iv, i1veqs, n)
  prval () = __free (i1veqs) where {
    extern praxi __free (_: myiveqlst (a, n)): void
  } // end of [prval]
} (* end of [if] *)
//
end // end of [myintvec_elimeqlst]

end // end of [local]

(* ****** ****** *)

extern
fun{a:t@ype}
myivlst_elimeqlst {n:nat} (
  i1vs: !myivlst (a, n), i1veqs: !myiveqlst (a, n), n: int n
) : myintveclst (a, n) // end of [myivlst_elimeqlst]

implement{a}
myivlst_elimeqlst
  {n} (i1vs, i1veqs, n) = let
//
viewtypedef res = myintveclst (a, n)
//
fun loop (
  i1vs: !myivlst (a, n)
, i1veqs: !myiveqlst (a, n)
, n: int n
, res: &(res?) >> res
) : void = let
in
//
case+ i1vs of
| MYIVLSTnil
    ((*void*)) => let
    val () = res := list_vt_nil()
  in
    fold@ (i1vs)
  end // end of [MYINLSTnil]
| MYIVLSTcons
    (stamp, !p_iv, !p_i1vs) => let
    val iv_new = myintvec_copy<a> (!p_iv, n)
    val () = myintvec_elimeqlst<a> (stamp, iv_new, i1veqs, n)
    val () = res := list_vt_cons {..}{0} (iv_new, ?)
    val+list_vt_cons (_, !p_res) = res
    val () = loop (!p_i1vs, i1veqs, n, !p_res)
    prval () = fold@ (res)
  in
    fold@ (i1vs)
  end // end of [MYIVLSTcons]
| MYIVLSTmark
    (!p_i1vs) => let
    val () = loop (!p_i1vs, i1veqs, n, res)
  in
    fold@ (i1vs)
  end // end of [MYIVLSTmark]
//
end // end of [loop]
//
var res: res // uninitized
val () = loop (i1vs, i1veqs, n, res)
//
in
  res
end // end of [myivlst_elimeqlst]

(* ****** ****** *)

local

extern
fun{
a:t@ype
} auxmain {n:pos}{s:int} (
  stamp: int
, iset: indexset (n)
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt(icnstr (a, n), s)
) : Ans2 (*~1/0*)

extern
fun{
a:t@ype
} auxmain_conj
  {n:pos}{s:int} (
  stamp: int
, iset: indexset (n)
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt (icnstr (a, n), s)
, ics1: &icnstrlst (a, n)
) : Ans2 (*~1/0*)
extern
fun{
a:t@ype
} auxmain_disj
  {n:pos}{s:int} (
  stamp: int
, iset: indexset (n)
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt (icnstr (a, n), s)
, ics1: &icnstrlst (a, n)
, rics1: icnstrlst (a, n)
) : Ans2 (*~1/0*)

(* ****** ****** *)

fun{
a:t@ype
} auxlt {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
) : Ans3 (*~1/0/1*) = let
(*
val () = (
  print "auxlt: stamp = "; print stamp; print_newline ()
) // end of [val]
*)
val () =
  myintvec_elimeqlst<a> (0(*stamp*), iv, i1veqs, n)
val sgn = myintvec_inspect_lt<a> (iv, n)
//
in
//
if sgn = 0 then let
  val () = myintvec_negate (iv, n)
  val () = myintvec_add_int (iv, ~1)
  val () = myintvec_normalize_gte (iv, n)
  val () = i1vs := MYIVLSTcons (stamp, iv, i1vs)
in
  0(*undecided*)
end else let
  val () = myintvec_free<a> (iv, n) in sgn
end // end of [if]
//
end // end of [auxlt]

fun{
a:t@ype
} auxgte {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
) : Ans3 (*~1/0/1*) = let
(*
val () = (
  print "auxgte: stamp = "; print stamp; print_newline ()
) // end of [val]
*)
val () =
  myintvec_elimeqlst<a> (0(*stamp*), iv, i1veqs, n)
val sgn = myintvec_inspect_gte<a> (iv, n)
//
in
//
if sgn = 0 then let
  val () = myintvec_normalize_gte (iv, n)
  val () = i1vs := MYIVLSTcons (stamp, iv, i1vs)
in
  0(*undecided*)
end else let
  val () = myintvec_free<a> (iv, n) in sgn
end // end of [if]
//
end // end of [auxgte]

fun{
a:t@ype
} auxeq {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
) : Ans3 (*~1/0/1*) = let
(*
val () = (
  print "auxeq: iv = ";
  print_myintvec (iv, n); print_newline ()
) // end of [val]
*)
val () =
  myintvec_elimeqlst<a> (0(*stamp*), iv, i1veqs, n)
val sgn = myintvec_inspect_eq<a> (iv, n)  
//
in
//
if sgn = 0 then let
  val i =
    myintvec_get_index_of_absmincff (iv, n)
  val () = i1veqs :=
    myiveqlst_cons (stamp, i, iv, i1veqs)
  // end of [val]
in
  0(*undecided*)
end else let
  val () = myintvec_free<a> (iv, n) in sgn(*contra/tauto*)
end // end of [if]
//
end // end of [auxeq]

fun{
a:t@ype
} auxcont
  {n:pos}{s:int} (
  stamp: int
, iset: indexset (n)
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt(icnstr (a, n), s)
, sgn: int // ~1/0/1
) : Ans2(*~1/0*) = let
(*
val () = (
  print "auxcont: sgn = "; print_int sgn; print_newline ()
) // end of [val]
*)
in
//
case+ 0 of
| _ when sgn < 0 => ~1(*solved*)
| _ when sgn > 0 =>
    auxmain (stamp, iset, i1vs, i1veqs, n, ics)
| _ (*sgn = 0 *) => let
    var ivs = myivlst_elimeqlst (i1vs, i1veqs, n)
    var ans2: Ans2 = myintveclst_inspect_gte (ivs, n)
    val () = (
      if ans2 >= 0 then let
        val () = myintveclst_normalize_gte (ivs, n)
        val () = ans2 := myintveclst_solve (iset, ivs, n)
      in
        // nothing
      end else let
        val () = myintveclst_free (ivs, n) in (*nothing*)
      end // end of [if]
    ) : void // end of [if]
    val () = (
      if ans2 >= 0 then (
        ans2 := auxmain (stamp+1, iset, i1vs, i1veqs, n, ics)
      ) // end of [if]
    ) : void // end of [val]
  in
    ans2
  end // end of [let] // end of [_(sgn=0)]
//
end // end of [auxcont]

fun{a:t@ype}
auxneq {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
, sgn: &int? >> int
) : icnstr (a, n) = let
(*
val () = (
  print "auxneq: iv = ";
  print_myintvec (iv, n); print_newline ()
) // end of [val]
*)
//
val () = // HX: stamp = 0
  myintvec_elimeqlst<a> (0, iv, i1veqs, n)
val () = sgn := myintvec_inspect_neq<a> (iv, n)  
//
in
//
if sgn = 0 then let
  val iv1_new = myintvec_copy (iv, n)
  val () = myintvec_add_int (iv1_new, ~1)
  val cff = myint_make_int (~1)
  val iv2_new = myintvec_copy_cff (cff, iv, n)
  val () = myint_free (cff)
  val () = myintvec_add_int (iv2_new, ~1)
//
  val () = myintvec_free (iv, n)
//
  val knd = (2(*gte*))
  val () = myintvec_normalize_gte (iv1_new, n)
  val () = myintvec_normalize_gte (iv2_new, n)
  val ic1 = ICvec (knd, iv1_new)
  val ic2 = ICvec (knd, iv2_new)
in
  ICveclst (1(*disj*), list_vt_pair (ic1, ic2))
end else let
//
// sgn=~1/1:contra/tauto
//
  val () = myintvec_free<a> (iv, n)
  val knd =
    (if sgn > 0 then 0(*conj*) else 1(*disj*)): nat2
  // end of [val]
in
  ICveclst (knd, list_vt_nil)
end // end of [if]
//
end // end of [auxneq]

implement{a}
auxmain {n}{s} (
  stamp, iset, i1vs, i1veqs, n, ics
) = let
//
viewtypedef ic = icnstr (a, n)
(*
val () = (
  print "auxmain: ics = "; print_icnstrlst (ics, n); print_newline ()
) // end of [val]
*)
in
//
case+ ics of
| list_vt_cons
    (!p_ic, !p_ics) => (
//
case+ !p_ic of
| ICvec (knd, !p_iv) => (
  case 0 of
  | _ when (
      knd = ~2(*lt*)
    ) => let
      val iv_new = myintvec_copy (!p_iv, n)
      prval () = fold@ (!p_ic)
      val ans3 = auxlt (stamp, i1vs, i1veqs, iv_new, n)
      val ans2 = auxcont (stamp, iset, i1vs, i1veqs, n, !p_ics, ans3)
      prval () = fold@ (ics)
    in
      ans2
    end // end of [knd=~2]
  | _ when (
      knd = 2(*gte*)
    ) => let
      val iv_new = myintvec_copy (!p_iv, n)
      prval () = fold@ (!p_ic)
      val ans3 = auxgte (stamp, i1vs, i1veqs, iv_new, n)
      val ans2 = auxcont (stamp, iset, i1vs, i1veqs, n, !p_ics, ans3)
      prval () = fold@ (ics)
    in
      ans2
    end // end of [knd = 2]
  | _ when knd = 1(*eq*) => let
      val iv_new = myintvec_copy (!p_iv, n)
      prval () = fold@ (!p_ic)
      val ans3 = auxeq (stamp, i1vs, i1veqs, iv_new, n)
      val ans2 = auxcont (stamp, iset, i1vs, i1veqs, n, !p_ics, ans3)
      prval () = fold@ (ics)
    in
      ans2
    end // end of [knd = 1]
  | _ (* knd = ~1(neq) *) => let
      var ans3: int // uninitized
      val ic_new =
        auxneq (stamp, i1vs, i1veqs, !p_iv, n, ans3)
      val () = free@ {a}{0} (!p_ic)
      val () =
        !p_ic := ic_new // HX: [ic] is equivalent to [ic_new]
      prval () =
        fold@ (ics) // HX: trying again after folding
      // end of [prval]
    in
      if ans3 >= 0 then
        auxmain (stamp, iset, i1vs, i1veqs, n, ics) else ~1(*solved*)
      // end of [if]
    end // end of [knd = ~1]
  ) // end of [ICvec]
| ICveclst
    (knd, !p_ics1) => (
  case+ 0 of
  | _ when knd = 0 => let
      val ans2 =
        auxmain_conj (
        stamp, iset, i1vs, i1veqs, n, !p_ics, !p_ics1
      ) // end of [val]
      prval () = fold@ (!p_ic); prval () = fold@ (ics)
    in
      ans2
    end // end of [conj]
  | _ (* knd = 1 *) => let
      val ans2 =
        auxmain_disj (
        stamp, iset, i1vs, i1veqs, n, !p_ics, !p_ics1, list_vt_nil
      ) // end of [val]
      prval () = fold@ (!p_ic); prval () = fold@ (ics)
    in
      ans2
    end // end of [disj]
  ) // end of [ICveclst]
| ICerr (loc, s3e) => let
    prval () = fold@ (!p_ic); prval () = fold@ (ics) in 0(*undecided*)
  end // end of [ICerr]
//
) (* end of [list_vt_cons] *)
| list_vt_nil () => let
    prval () = fold@ (ics) in 0(*unsolved*)
  end // end of [list_vt_nil]
//
end // end of [auxmain]

implement{a}
auxmain_conj {n}{s} (
  stamp, iset, i1vs, i1veqs, n, ics, ics1
) = let
//
  viewtypedef ic = icnstr (a, n)
  prval () = list_vt_length_is_nonnegative{ic} (ics)
  prval () = list_vt_length_is_nonnegative{ic} (ics1)
//
  val s1 = list_vt_length (ics1)
  val () = ics := list_vt_append (ics1, ics)
  val ans2 = auxmain (stamp, iset, i1vs, i1veqs, n, ics)
  val () = ics1 := list_vt_split_at (ics, s1)
in
  ans2
end // end of [auxmain_conj]

implement{a}
auxmain_disj {n}{s} (
  stamp, iset, i1vs, i1veqs, n, ics, ics1, rics1
) = let
  viewtypedef ic = icnstr (a, n)
  prval () = list_vt_length_is_nonnegative{ic} (ics)
in
//
case+ ics1 of
| ~list_vt_cons
    (ic1, ics1_next) => let
//
    val () = ics1 := ics1_next
//
//  HX: copying needed for backtracking
    val icsx = icnstrlst_copy (ics, n)
    val icsx = list_vt_cons (ic1, icsx)
//
    val () = i1vs := myivlst_mark (i1vs)
    val () = i1veqs := myiveqlst_mark (i1veqs)
    var icsx = icsx // HX: for call-by-reference
    val ans2 = auxmain (stamp, iset, i1vs, i1veqs, n, icsx)
    val () = i1vs := myivlst_unmark (i1vs, n)
    val () = i1veqs := myiveqlst_unmark (i1veqs, n)
//
    val+~list_vt_cons (ic1, icsx) = icsx
    val () = icnstrlst_free (icsx, n) // HX: [icsx] may have been modified!
    val rics1 = list_vt_cons (ic1, rics1)
//
  in
    if ans2 >= 0 then let
      val () = (ics1 := list_vt_reverse_append<ic> (rics1, ics1))
    in
      0(*unsolved*)
    end else ( // solved and continue
      auxmain_disj (stamp, iset, i1vs, i1veqs, n, ics, ics1, rics1)
    ) // end of [if]
  end // end of [list_vt_cons]
| ~list_vt_nil () => let
    val () = ics1 := list_vt_reverse (rics1) in ~1(*solved*)
  end // end of [list_vt_nil]
//
end // end of [auxmain_disj]

in (* in-of-local *)

implement{a}
icnstrlst_solve
  {n} (iset, ics, n) = let
(*
//
val () = (
  print "icnstrlst_solve: ics =\n";
  fprint_icnstrlst (stdout_ref, ics, n);
  print "icnstrlst_solve: n = "; print n; print_newline ()
) (* end of [val] *)
//
*)
var
i1vs: myivlst (a, n) = MYIVLSTnil()
var
i1veqs: myiveqlst (a, n) = MYIVEQLSTnil()
//
val ans2 =
  auxmain (0(*stamp*), iset, i1vs, i1veqs, n, ics)
//
val () = myivlst_free (i1vs, n)
val () = myiveqlst_free (i1veqs, n)
//
in
  ans2
end // end of [icnstrlst_solve]

end // end of [local]

(* ****** ****** *)

(*

local
//
typedef intknd = int
//
extern
fun icnstrlst_int_solve {n:pos}
  (ics: &icnstrlst (intknd, n), n: int n): int
in
//
implement
icnstrlst_int_solve
  (ics, n) = icnstrlst_solve<intknd> (ics, n)
// end of [icnstrlst_int_solve]
//
end // end of [local]

local
//
typedef intknd = $extype "intinf"
fun icnstrlst_intinf_solve {n:pos}
  (ics: &icnstrlst (intknd, n), n: int n): int
end // end of [local]
//
in
//
implement
icnstrlst_intinf_solve
  (ics, n) = icnstrlst_solve<intknd> (ics, n)
// end of [icnstrlst_intinf_solve]
//
end // end of [local]

*)

(* ****** ****** *)

(* end of [pats_lintprgm_solve.dats] *)
