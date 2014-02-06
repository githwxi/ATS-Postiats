(*
** Copyright (C) 2011 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** Manipulating Singly-Linked Lists
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

dataview
slseg_v (
  a:t@ype+ // covariant argument
, addr(*beg*)
, addr(*end*)
, int(*len*)
) =
  | {l:addr}
    slseg_v_nil (a, l, l, 0) of ()
  | {l_fst:agz}{l_nxt,l_end:addr}{n:nat}
    slseg_v_cons (a, l_fst, l_end, n+1) of
      ((a, ptr l_nxt) @ l_fst, slseg_v (a, l_nxt, l_end, n))
// end of [slseg]_v

viewdef sllst_v
  (a:t@ype, l:addr, n:int) = slseg_v (a, l, null, n)
// end of [sllst_v]

(* ****** ****** *)

fn{a:t@ype}
sllst_ptr_length
  {l:addr}{n:nat}
(
  pflst: !sllst_v (a, l, n) | p: ptr l
) : int (n) = let
  fun loop
    {l:addr}{i,j:nat} .<i>.
  (
    pflst: !sllst_v (a, l, i) | p: ptr l, j: int (j)
  ) : int (i+j) =
    if p > 0 then let
      prval slseg_v_cons (pfat, pf1lst) = pflst
      val res = loop (pf1lst | !p.1, j+1) // !p.1 points to the tail
      prval () = pflst := slseg_v_cons (pfat, pf1lst)
    in
      res
    end else let // the length of a null list is 0
      prval slseg_v_nil () = pflst in pflst := slseg_v_nil (); j
    end (* end of [if] *)
  // end of [loop]
in
  loop (pflst | p, 0)
end // end of [sllst_ptr_length]

(* ****** ****** *)

fn{a:t@ype}
sllst_ptr_reverse
  {l:addr}{n:nat}
(
  pflst: sllst_v (a, l, n) | p: ptr l
) : [l:addr] (sllst_v (a, l, n) | ptr l) = let
  fun loop
    {n1,n2:nat}
    {l1,l2:addr} .<n1>. (
    pf1lst: sllst_v (a, l1, n1)
  , pf2lst: sllst_v (a, l2, n2)
  | p1: ptr l1, p2: ptr l2
  ) : [l:addr] (sllst_v (a, l, n1+n2) | ptr l) =
    if p1 > 0 then let
      prval slseg_v_cons (pf1at, pf1lst) = pf1lst
      val p1_nxt = !p1.1
      val () = !p1.1 := p2
    in
      loop (pf1lst, slseg_v_cons (pf1at, pf2lst) | p1_nxt, p1)
    end else let
      prval slseg_v_nil () = pf1lst in (pf2lst | p2)
    end // end of [if]
in
  loop (pflst, slseg_v_nil | p, the_null_ptr)
end // end of [sllst_ptr_reverse]

(* ****** ****** *)

fn{a:t@ype}
sllst_ptr_append
  {l1,l2:addr}{n1,n2:nat}
(
  pf1lst: sllst_v (a, l1, n1)
, pf2lst: sllst_v (a, l2, n2)
| p1: ptr l1, p2: ptr l2
) : [l:addr] (sllst_v (a, l, n1+n2) | ptr l) = let
  fun loop
    {n1,n2:nat}
    {l1,l2:addr | l1 > null} .<n1>. (
    pf1lst: sllst_v (a, l1, n1)
  , pf2lst: sllst_v (a, l2, n2)
  | p1: ptr l1, p2: ptr l2
  ) : (sllst_v (a, l1, n1+n2) | void) = let
    prval slseg_v_cons (pf1at, pf1lst) = pf1lst
    val p1_nxt = !p1.1
  in
    if p1_nxt > 0 then let
      val (pflst | ()) = loop (pf1lst, pf2lst | p1_nxt, p2)
    in
      (slseg_v_cons (pf1at, pflst) | ())
    end else let
      val () = !p1.1 := p2
      prval slseg_v_nil () = pf1lst
    in
      (slseg_v_cons (pf1at, pf2lst) | ())
    end (* end of [if] *)
  end // end of [loop]
in
  if p1 > 0 then let
    val (pflst | ()) = loop (pf1lst, pf2lst | p1, p2)
  in
    (pflst | p1)
  end else let
    prval slseg_v_nil () = pf1lst in (pf2lst | p2)
  end (* end of [if] *)
end // end of [sllst_ptr_append]

(* ****** ****** *)

extern
prfun slseg_v_unsplit
  {a:t@ype}
  {l1,l2,l3:addr}{n1,n2:nat}
(
  pf1lst: slseg_v (a, l1, l2, n1), pf2lst: slseg_v (a, l2, l3, n2)
) : slseg_v (a, l1, l3, n1+n2)

primplement
slseg_v_unsplit
  {a}(pf1lst, pf2lst) = let
  prfun unsplit
    {l1,l2,l3:addr}{n1,n2:nat} .<n1>.
  (
    pf1lst: slseg_v (a, l1, l2, n1), pf2lst: slseg_v (a, l2, l3, n2)
  ) : slseg_v (a, l1, l3, n1+n2) =
    sif n1 > 0 then let
      prval slseg_v_cons (pf1at, pf1lst) = pf1lst
    in
      slseg_v_cons (pf1at, unsplit (pf1lst, pf2lst))
    end else let
      prval slseg_v_nil () = pf1lst in pf2lst
    end // end of [sif]
in
  unsplit (pf1lst, pf2lst)
end // end of [slseg_v_unsplit]

(* ****** ****** *)

extern
fun{a:t@ype}
sllst_ptr_getend
  {l:agz}{n:nat}
(
  pflst: !sllst_v (a, l, n) >> slseg_v (a, l, l_end, n-1) | p: ptr l
) : #[l_end:agz | n > 0] ((a, ptr null) @ l_end | ptr l_end)

(* ****** ****** *)

fn{a:t@ype}
sllst_ptr_append
  {l1,l2:addr}{n1,n2:nat}
(
  pf1lst: sllst_v (a, l1, n1)
, pf2lst: sllst_v (a, l2, n2)  
| p1: ptr l1, p2: ptr l2
) : [l:addr] (sllst_v (a, l, n1+n2) | ptr l) =
  if p1 > 0 then let
    val (pfat | p1_end) = sllst_ptr_getend (pf1lst | p1)
    val () = !p1_end.1 := p2
  in
    (slseg_v_unsplit (pf1lst, slseg_v_cons (pfat, pf2lst)) | p1)
  end else let
    prval slseg_v_nil () = pf1lst in (pf2lst | p2)
  end // end of [if]
// end of[sllst_ptr_append]

(* ****** ****** *)

(* end of [sllst.dats] *)
