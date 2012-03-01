(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Anairiats - Unleashing the Potential of Types!
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
// Time: February 2012
//
(* ****** ****** *)

staload UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_lintprgm.sats"

(* ****** ****** *)

staload _(*anon*) = "pats_lintprgm.dats"

(* ****** ****** *)

local
//
#include "pats_lintprgm_myint_int.dats"
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
fun auxbeg (
  ivs: ivs, i: natLt n
, neus: &ivs, poss: &ivs, negs: &ivs
) : void = let
in
//
case+ ivs of
| list_vt_cons (!p_iv, !p_ivs1) => let
    val ivs1 = !p_ivs1
    val sgn = myintvec_compare_at (!p_iv, i, 0)
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
| ~list_vt_nil () => ()
//
end // end of [auxbeg]
//
fun auxcomb ( // [~1] is returned if contradiction is reached
  n: int n, i: intBtw (1, n)
, neus: &ivs, poss: &ivs, neg: !iv
) : int(*~1/0*) = let
in
//
case+ poss of
| list_vt_cons (!p_pos, !p_poss) => let
    val iv_new =
      myintvec_combine_at (!p_pos, neg, n, i)
    val ans = myintvec_inspect_gte (iv_new, n)
    val () = (
      if ans != 0 then
        myintvec_free (iv_new, n)
      else
        neus := list_vt_cons (iv_new, neus)
      // end of [if]
    ) : void // end of [val]
    in
      if (ans >= 0) then let
        val ans = auxcomb (n, i, neus, !p_poss, neg)
        prval () = fold@ (poss)
      in
        ans
      end else let
        prval () = fold@ (poss) in ~1(*CONTRADITION*)
      end // end of [if]
    end (* end of [list_vt_cons] *)
  | list_vt_nil () => let
      prval () = fold@ (poss) in 0(*UNDECIDED*)
    end // end of [list_vt_nil]
//
end // end of [auxcomb]
//
// HX: [~1] is returned if contradiction is reached
//
fun auxcomblst (
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
// end of [val]
val ans = auxcomblst (n, i, neus, poss, negs)
val () = myintveclst_free (poss, n)
val () = ivs := neus
//
in
  ans(*~1/0*)
end // end of [myintveclst_split_at]

(* ****** ****** *)

(*
abstype indexset
*)

extern
fun{a:t@ype}
myintvec_get_index_of_absmincff
  {n:pos} (iv: !myintvec (a, n), n: int n): intBtw (1, n)
// end of [myintvec_get_index_of_absmincff]

extern
fun{a:t@ype}
myintveclst_select_index
  {n:pos} (
  ivs: !myintveclst (a, n), n: int n
) : natLt(n) // end of [myintveclst_select_index]

(* ****** ****** *)

extern
fun{a:t@ype}
myintveclst_solve
  {n:pos} (
  ivs: myintveclst (a, n), n: int n
) : int(*~1/0*) // end of [myintveclst_solve]
implement{a}
myintveclst_solve
  {n} (ivs, n) = let
//
viewtypedef ivs = myintveclst (a, n)
//
fun solve (
  ivs: &ivs, n: int n
) : int(*~1/0*) = let
  val i = myintveclst_select_index (ivs, n)
(*
  val inds = indexes_remove (inds, i)
*)
in
  if i > 0 then let
    val ans = myintveclst_split_at<a> (ivs, n, i)
  in
    if ans >= 0 then solve (ivs, n) else ~1
  end else 0(*UNDECIDED*)
end // end of [solve]
(*
val () = begin
  print "myintveclst_solve: ivs =\n"; print_myintveclst (ivs, n); print_newline ();
end // end of [val]
*)
var ivs: ivs = ivs
val ans = solve (ivs, n)
val () = myintveclst_free (ivs, n)
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
  val sgn = myintvec_compare_at (iv, i, 0)
in
//
if sgn = 0 then () else let
  var c = iv[i] and ceq = iveq[i]
  val sgn = compare_myint_int (ceq, 0)
in
  if sgn >= 0 then let
    val () = c := ~c
    val () = myintvec_scale (ceq, iv, n)
    val () = myintvec_addby_cff (iv, c, iveq, n)
    val () = myint_free (c) and () = myint_free (ceq)
  in
    (*nothing*)
  end else let
    val () = ceq := ~ceq
    val () = myintvec_scale (ceq, iv, n)
    val () = myintvec_addby_cff (iv, c, iveq, n)
    val () = myint_free (c) and () = myint_free (ceq)
  in
    (*nothing*)
  end (* end of [if] *)
end // end of [if]
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

dataviewtype
myivlst (a:t@ype, int) =
  | {n:int}
    MYIVLSTcons (a, n) of (
      int(*stamp*), myintvec (a, n), myivlst (a, n)
    ) // end of [MYIVLSTcons]
  | {n:int} MYIVLSTmark (a, n) of myivlst (a, n)
  | {n:int} MYIVLSTnil (a, n) of ()
// end of [myivlst]

(* ****** ****** *)

extern
fun{a:t@ype}
myivlst_free {n:int}
  (i1vs: myivlst (a, n), n: int n): void
// end of [myivlst_free]
implement{a}
myivlst_free (i1vs, n) = (
  case+ i1vs of
  | ~MYIVLSTcons
      (_, iv, i1vs) => let
      val () = myintvec_free (iv, n) in myivlst_free (i1vs, n)
    end // end of [MYIVLSTcons]
  | ~MYIVLSTmark (i1vs) => myivlst_free (i1vs, n)
  | ~MYIVLSTnil () => ()
) // end of [myivlst_free]

(* ****** ****** *)

extern
fun{a:t@ype}
myivlst_mark {n:int}
  (i1vs: myivlst (a, n)): myivlst (a, n)
// end of [myivlst_mark]
implement{a}
myivlst_mark
  {n} (i1vs) = MYIVLSTmark (i1vs)
// end of [myiveqlst_mark]

extern
fun{a:t@ype}
myivlst_unmark {n:int}
  (i1vs: myivlst (a, n), n: int n): myivlst (a, n)
// end of [myivlst_unmark]
implement{a}
myivlst_unmark
  (i1vs, n) = (
  case+ i1vs of
  | ~MYIVLSTcons
      (_, iv, i1vs) => let
      val () = myintvec_free (iv, n) in myivlst_unmark (i1vs, n)
    end // end of [MYIVEQLSTcons]
  | ~MYIVLSTmark (i1vs) => i1vs
  | ~MYIVLSTnil () => MYIVLSTnil ()
) // end of [myivlst_unmark]

(* ****** ****** *)
(*
** HX-2012-02:
** this is a poorman's doubly-linked list
** I am somewhat fond of this design. Maybe it should
** be put into libats for general use.
*)
dataviewtype
myiveqlst (a:t@ype, int) =
  | {n:int}
    {i:int | 0 < i; i < n}
    MYIVEQLSTcons (a, n) of (
      int(*stamp*)
    , myintvec (a, n), int i(*index*)
    , ptr(*prev*)
    , myiveqlst (a, n)
    ) // end of [MYIVEQLSTcons]
  | {n:int}
    MYIVEQLSTmark (a, n) of (ptr(*prev*), myiveqlst (a, n))
  | {n:int} MYIVEQLSTnil (a, n) of ()
// end of [myiveqlst]

(* ****** ****** *)

extern
fun{a:t@ype}
myiveqlst_free {n:int}
  (i1vs: myiveqlst (a, n), n: int n): void
// end of [myiveqlst_free]
implement{a}
myiveqlst_free (i1vs, n) = (
  case+ i1vs of
  | ~MYIVEQLSTcons
      (_, iv, _, _, i1vs) => let
      val () = myintvec_free (iv, n) in myiveqlst_free (i1vs, n)
    end // end of [MYIVEQLSTcons]
  | ~MYIVEQLSTmark (_, i1vs) => myiveqlst_free (i1vs, n)
  | ~MYIVEQLSTnil () => ()
) // end of [myiveqlst_free]

extern
castfn
myiveqlst2ptr
  {a:t@ype}{n:int} (x: !myiveqlst (a, n)): ptr
// end of [myiveqlst2ptr]

fun{a:t@ype}
myiveqlst_get_prev
  {n:int} (x: !myiveqlst (a, n)): ptr =
  case+ x of
  | MYIVEQLSTcons
      (_, _, _, !p_prev, _) => let
      prval () = fold@ (x) in p_prev end
    // end of [MYIVEQLSTcons]
  | MYIVEQLSTmark (!p_prev, _) => (fold@ (x); p_prev)
  | MYIVEQLSTnil () => (fold@ (x); null)
// end of [myiveqlst_get_prev]

(* ****** ****** *)

extern
fun{a:t@ype}
myiveqlst_cons {n:int} (
  stamp: int, i: intBtw (1, n)
, iv: myintvec (a, n), i1vs: myiveqlst (a, n)
) : myiveqlst (a, n)

implement{a}
myiveqlst_cons
  {n} (stamp, i, iv, i1vs) = let
  val p_prev =
    myiveqlst_get_prev (i1vs)
  // end of [val]
  val res = MYIVEQLSTcons (stamp, iv, i, null(*prev*), i1vs)
  val () = if p_prev > null then
    $UN.ptrset<ptr> (p_prev, myiveqlst2ptr (res))
  // end of [val]
in
  res
end // end of [myiveqlst_cons]

(* ****** ****** *)

extern
fun{a:t@ype}
myiveqlst_mark {n:int}
  (i1vs: myiveqlst (a, n)): myiveqlst (a, n)
// end of [myiveqlst_mark]
implement{a}
myiveqlst_mark
  {n} (i1vs) = let
  val p_prev =
    myiveqlst_get_prev (i1vs)
  // end of [val]
  val res = MYIVEQLSTmark (null(*prev*), i1vs)
  val () = if p_prev > null then
    $UN.ptrset<ptr> (p_prev, myiveqlst2ptr (res))
  // end of [val]
in
  res
end // end of [myiveqlst_mark]

extern
fun{a:t@ype}
myiveqlst_unmark {n:int}
  (i1vs: myiveqlst (a, n), n: int n): myiveqlst (a, n)
// end of [myiveqlst_unmark]
implement{a}
myiveqlst_unmark
  (i1vs, n) = (
  case+ i1vs of
  | ~MYIVEQLSTcons
      (_, iv, _, _, i1vs) => let
      val () = myintvec_free (iv, n) in myiveqlst_unmark (i1vs, n)
    end // end of [MYIVEQLSTcons]
  | ~MYIVEQLSTmark (_, i1vs) => i1vs
  | ~MYIVEQLSTnil () => MYIVEQLSTnil ()
) // end of [myiveqlst_unmark]

(* ****** ****** *)

extern
fun{a:t@ype}
myiveqlst_get_last
  {n:int} (i1vs: !myiveqlst (a, n)): ptr
// end of [myiveqlst_get_last]

implement{a}
myiveqlst_get_last
  {n} (i1vs) = loop (i1vs, null) where {
  fun loop (
    i1vs: !myiveqlst (a, n), prev: ptr
  ) : ptr =
    case+ i1vs of
    | MYIVEQLSTcons (
        _, _, _, prev, !p_i1vs
      ) => let
        val last =
          loop (!p_i1vs, prev)
        prval () = fold@ (i1vs)
      in
        last
      end // end of [MYIVEQLSTcons]
    | MYIVEQLSTmark
        (prev, !p_i1vs) => let
        val last =
          loop (!p_i1vs, prev)
        prval () = fold@ (i1vs) in last
      end // end of [MYIVEQLSTcons]
    | MYIVEQLSTnil () => (fold@ (i1vs); prev)
  // end of [loop]
} // end of [myiveqlst_get_last]

(* ****** ****** *)

extern
fun{a:t@ype}
myintvec_elimeqlst {n:int} ( // ri1vs: starting at the end!
  stamp: int, iv: !myintvec (a, n), i1veqs: !myiveqlst (a, n), n: int n
) : void // end of [myintvec_elimeqlst]

implement{a}
myintvec_elimeqlst
  {n} (stamp0, iv, i1veqs, n) = let
in
//
case+ i1veqs of
| MYIVEQLSTcons
    (stamp, !p_i1veq, i, prev, _) => let
    val () = if
      stamp0 <= stamp then
      myintvec_elimeq_at (iv, !p_i1veq, n, i)
    // end of [val]
    val i1veqs_prev = __cast (prev) where {
      extern castfn __cast (p: ptr):<> myiveqlst (a, n)
    } // end of [val]
    val () = myintvec_elimeqlst (stamp0, iv, i1veqs_prev, n)
    prval () = __free (i1veqs_prev) where {
      extern praxi __free (i1veqs: myiveqlst (a, n)): void
    } // end of [prval]
    prval () = fold@ (i1veqs)
  in
    (*nothing*)
  end // end of [MYIVEQLSTcons]
| MYIVEQLSTmark (prev, _) => let
    val i1veqs_prev = __cast (prev) where {
      extern castfn __cast (p: ptr):<> myiveqlst (a, n)
    } // end of [val]
    val () = myintvec_elimeqlst (stamp0, iv, i1veqs_prev, n)
    prval () = __free (i1veqs_prev) where {
      extern praxi __free (i1veqs: myiveqlst (a, n)): void
    } // end of [prval]
    prval () = fold@ (i1veqs)
  in
    (*nothing*)
  end // end of [MYIVEQLSTmark]
| MYIVEQLSTnil () => fold@ (i1veqs)
//
end // end of [myintvec_elimeqlst]

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
| MYIVLSTcons
    (stamp, !p_iv, !p_i1vs) => let
    val iv_new = myintvec_copy<a> (!p_iv, n)
    val () = myintvec_elimeqlst<a> (stamp, iv_new, i1veqs, n)
    val () = res := list_vt_cons {..}{0} (iv_new, ?)
    val+ list_vt_cons (_, !p_res) = res
    val () = loop (!p_i1vs, i1veqs, n, !p_res)
    prval () = fold@ (res)
  in
    fold@ (i1vs)
  end // end of [INTVECLST1cons]
| MYIVLSTmark
    (!p_i1vs) => let
    prval () = fold@ (i1vs)
  in
    loop (i1vs, i1veqs, n, res)
  end // end of [INTVECLST1mark]
| MYIVLSTnil () => let
    val () = res := list_vt_nil () in fold@ (i1vs)
  end // end of [MYINLSTnil]
//
end // end of [loop]
//
var res: res // uninitialized
val () = loop (i1vs, i1veqs, n, res)
//
in
  res
end // end of [myivlst_elimeqlst]

(* ****** ****** *)

extern
fun{a:t@ype}
auxmain_conj
  {n:pos}{s:int} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt (icnstr (a, n), s)
, ics1: &icnstrlst (a, n)
) : int (*~1/0*)
extern
fun{a:t@ype}
auxmain_disj
  {n:pos}{s:int} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt (icnstr (a, n), s)
, ics1: &icnstrlst (a, n)
, rics1: icnstrlst (a, n)
) : int (*~1/0*)

local

extern
fun{a:t@ype}
auxmain {n:pos}{s:int} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt(icnstr (a, n), s)
) : int (*~1/0*)

fun{a:t@ype}
auxgte {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
) : int (*~1/0/1*) = let
//
val () =
  myintvec_elimeqlst<a> (0(*stamp*), iv, i1veqs, n)
val ans = myintvec_inspect_gte<a> (iv, n)
//
in
//
if ans = 0 then let
  val () = i1vs :=
    MYIVLSTcons (stamp, iv, i1vs)
  // end of [val]
in
  0(*undecided*)
end else let
  val () = myintvec_free<a> (iv, n) in ans
end // end of [if]
//
end // end of [auxgte]

fun{a:t@ype}
auxeq {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
) : int (*~1/0/1*) = let
//
val () =
  myintvec_elimeqlst<a> (0(*stamp*), iv, i1veqs, n)
val ans = myintvec_inspect_eq<a> (iv, n)  
//
in
//
if ans = 0 then let
  val i =
    myintvec_get_index_of_absmincff (iv, n)
  val () = i1veqs :=
    myiveqlst_cons (stamp, i, iv, i1veqs)
  // end of [val]
in
  0(*undecided*)
end else let
  val () = myintvec_free<a> (iv, n) in ans
end // end of [if]
//
end // end of [auxeq]

fun{a:t@ype}
auxcont
  {n:pos}{s:int} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, n: int n
, ics: &list_vt(icnstr (a, n), s)
, sgn: int // ~1/0/1
) : int(*~1/0*) = (
  if sgn > 0 then let
    val ans = auxmain
      (stamp, i1vs, i1veqs, n, ics)
    // end of [val]
  in
    ans
  end else if sgn < 0 then ~1(*solved*)
  else let // sgn = 0
    var ivs =
      myivlst_elimeqlst (i1vs, i1veqs, n)
    var ans: int =
      myintveclst_inspect_gte (ivs, n)
    val () = (
      if ans >= 0 then (
        ans := myintveclst_solve (ivs, n)
      ) else myintveclst_free (ivs, n)
    ) : void // end of [if]
    val () = if ans >= 0 then {
      val () = ans :=
        auxmain (stamp+1, i1vs, i1veqs, n, ics)
      // end of [val]
    } // end of [val]
  in
    ans
  end // end of [if]
) // end of [auxcont]

fun{a:t@ype}
auxneq {n:pos} (
  stamp: int
, i1vs: &myivlst (a, n)
, i1veqs: &myiveqlst (a, n)
, iv: myintvec (a, n)
, n: int n
) : icnstrlst (a, n) = let
//
  fn pred (
    x: &myint(a)
  ) : void = x := pred_myint (x)
//
  val iv1_new = myintvec_copy (iv, n)
  val (pf1 | p1) = myintvec_takeout {a} (iv1_new)
  prval (pf11, pf12) = array_v_uncons {myint(a)} (pf1)
  val () = !p1 := pred_myint (!p1)
  prval () = pf1 := array_v_cons {myint(a)} (pf11, pf12)
  val () = myintvecout_addback (pf1 | iv1_new)
//
  val cff = myint_make_int (~1)
  val iv2_new = myintvec_copy_cff (cff, iv, n)
  val () = myint_free (cff)
  val (pf2 | p2) = myintvec_takeout {a} (iv2_new)
  prval (pf21, pf22) = array_v_uncons {myint(a)} (pf2)
  val () = !p2 := pred_myint (!p2)
  prval () = pf2 := array_v_cons {myint(a)} (pf21, pf22)
  val () = myintvecout_addback (pf2 | iv2_new)
//
  val () = myintvec_free (iv, n)
//
  val knd = (2(*gte*))
  val ic1 = ICvec (knd, iv1_new)
  val ic2 = ICvec (knd, iv2_new)
//
in
  list_vt_pair (ic1, ic2)
end // end of [auxneq]

implement{a}
auxmain {n}{s} (
  stamp, i1vs, i1veqs, n, ics
) = let
  viewtypedef ic = icnstr (a, n)
in
//
case+ ics of
| list_vt_cons (!p_ic, !p_ics) => (
  case+ !p_ic of
  | ICvec (knd, !p_iv) => (
    case 0 of
    | _ when (
        knd = 2(*gte*) orelse knd = ~2(*lt*)
      ) => let
        val iv_new = (
          if knd > 0 then
            myintvec_copy (!p_iv, n)
          else let
            val cff = myint_make_int (~1)
            val iv_new = myintvec_copy_cff (cff, !p_iv, n)
            val () = myint_free (cff)
          in
            iv_new
          end // end of [if]
        ) : myintvec (a, n) // end of [val]
        prval () = fold@ (!p_ic)
        val sgn = auxgte (stamp, i1vs, i1veqs, iv_new, n)
        val ans = auxcont (stamp, i1vs, i1veqs, n, !p_ics, sgn)
      in
        fold@ (ics); ans
      end // end of [knd = 2/~2]
    | _ when knd = 1 => let
        val iv_new = myintvec_copy (!p_iv, n)
        prval () = fold@ (!p_ic)
        val sgn = auxeq (stamp, i1vs, i1veqs, iv_new, n)
        val ans = auxcont (stamp, i1vs, i1veqs, n, !p_ics, sgn)
      in
        fold@ (ics); ans
      end // end of [knd = 1]
    | _ (* knd = ~1 *) => let
        var ics1 = auxneq (stamp, i1vs, i1veqs, !p_iv, n)
        val () = free@ {a}{0} (!p_ic)
        val ans = auxmain_disj (stamp, i1vs, i1veqs, n, !p_ics, ics1, list_vt_nil)
        val () = !p_ic := ICveclst (1(*disj*), ics1)
      in
        fold@ (ics); ans
      end // end of [knd = ~1]
    ) // end of [ICvec]
  | ICveclst (knd, !p_ics1) => (
    case+ 0 of
    | _ when knd = 0 => let
        val ans = auxmain_conj
          (stamp, i1vs, i1veqs, n, !p_ics, !p_ics1)
        prval () = fold@ (!p_ic); prval () = fold@ (ics)
      in
        ans
      end // end of [conj]
    | _ (* knd = 1 *) => let
        val ans = auxmain_disj
          (stamp, i1vs, i1veqs, n, !p_ics, !p_ics1, list_vt_nil)
        prval () = fold@ (!p_ic); prval () = fold@ (ics)
      in
        ans
      end // end of [disj]
    ) // end of [ICveclst]
  ) (* end of [list_vt_cons] *)
| list_vt_nil () => (fold@ (ics); 0(*unsolved*))
//
end // end of [auxmain]

implement{a}
auxmain_conj {n}{s} (
  stamp, i1vs, i1veqs, n, ics, ics1
) = ans where {
  prval () =
    list_vt_length_is_nonnegative (ics)
  prval () =
    list_vt_length_is_nonnegative (ics1)
  val s1 = list_vt_length (ics1)
  val () = ics := list_vt_append (ics1, ics)
  val ans = auxmain (stamp, i1vs, i1veqs, n, ics)
  val () = ics1 := list_vt_split_at (ics, s1)
} // end of [auxmain_conj]

implement{a}
auxmain_disj {n}{s} (
  stamp, i1vs, i1veqs, n, ics, ics1, rics1
) = let
  viewtypedef ic = icnstr (a, n)
  val () = list_vt_length_is_nonnegative{ic} (ics)
in
//
case+ ics1 of
| list_vt_cons
    (_(*ic1*), !p_ics1) => let
//
    val ics1_next = !p_ics1
    val () = !p_ics1 := ics
    val () = ics := ics1
    prval () = fold@ {ic}{s} (ics)
    val () = ics1 := ics1_next
//
    val () = i1vs := myivlst_mark (i1vs)
    val () = i1veqs := myiveqlst_mark (i1veqs)
    val ans = auxmain (stamp, i1vs, i1veqs, n, ics)
    val () = i1vs := myivlst_unmark (i1vs, n)
    val () = i1veqs := myiveqlst_unmark (i1veqs, n)
//
    val+ list_vt_cons (_, !p_ics) = ics
    val ics_orig = !p_ics;
    val () = !p_ics := rics1
    prval () = fold@ (ics)
    val rics1 = ics; val () = ics := ics_orig
//
  in
    if ans >= 0 then let
      val () = ics1 :=
        list_vt_reverse_append<ic> (rics1, ics1)
      // end of [val]
    in
      0(*unsolved*)
    end else // solved and continue
      auxmain_disj (stamp, i1vs, i1veqs, n, ics, ics1, rics1)
    // end of [if]
  end // end of [list_vt_cons]
| ~list_vt_nil () => let
    val () = ics1 := list_vt_reverse (rics1) in ~1(*solved*)
  end // end of [list_vt_nil]
//
end // end of [auxmain_disj]

in // in of [local]

implement{a}
icnstrlst_solve
  {n} (ics, n) = let
//
var i1vs: myivlst (a, n) = MYIVLSTnil ()
var i1veqs: myiveqlst (a, n) = MYIVEQLSTnil ()
val ans = auxmain (0(*stamp*), i1vs, i1veqs, n, ics)
val () = myivlst_free (i1vs, n)
val () = myiveqlst_free (i1veqs, n)
//
in
  ans
end // end of [icnstrlst_solve]

end // end of [local]

(* ****** ****** *)

implement
icnstrlst_int_solve
  (ics, n) = icnstrlst_solve<int> (ics, n)
// end of [icnstrlst_int_solve]

(* ****** ****** *)

(*
local
//
staload
INTINF = "pats_intinf.sats"
typedef intinf = $INTINF.intinf
//
in
implement
icnstrlst_intinf_solve
  (ics, n) = icnstrlst_solve<intinf> (ics, n)
// end of [icnstrlst_intinf_solve]
end // end of [local]
*)

(* ****** ****** *)

(* end of [pats_lintprgm_solver.dats] *)
