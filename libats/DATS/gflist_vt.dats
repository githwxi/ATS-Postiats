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
// Authoremail: hwxiATcsDOTbuDOTedu
// Time: October, 2010
//
(* ****** ****** *)
//
// HX:
// generic functional lists (fully indexed)
//
(* ****** ****** *)
//
// HX-2012-11-28:
// ported to ATS/Postiats from ATS/Anairiats
//
(* ****** ****** *)
//
staload
"libats/SATS/ilist_prf.sats"
//
staload "libats/SATS/gflist.sats"
staload "libats/SATS/gflist_vt.sats"
//
(* ****** ****** *)

implement
{a}(*tmp*)
gflist_vt_length(xs) = let
//
fun
loop
{xs:ilist}{j:int} .<xs>.
(
  xs: !gflist_vt(a, xs), j: int j
) :<> [i:nat]
  (LENGTH(xs, i) | int(i+j)) = let
in
//
case+ xs of
| gflist_vt_cons
    (_, xs) => let
    val (pf | res) = loop(xs, j+1)
  in
    (LENGTHcons(pf) | res)
  end // end of [gflist_vt_cons]
| gflist_vt_nil () => (LENGTHnil() | j)
//
end // end of [loop]
//
in
  loop (xs, 0)
end // end of [gflist_vt_length]

(* ****** ****** *)
//
implement
{a}(*tmp*)
gflist_vt_snoc
  {xs}{x0}(xs, x0) = let
//
val (pfapp | res) =
  gflist_vt_append<a> (xs, gflist_vt_sing(x0))
//
extern
praxi
lemma :
{xsx:ilist}
APPEND(xs, ilist_sing(x0), xsx) -> SNOC(xs, x0, xsx)
//
in
  (lemma(pfapp) | res)
end // end of [gflist_vt_snoc]

(* ****** ****** *)

implement
{a}(*tmp*)
gflist_vt_append
  (xs, ys) = let
//
fun loop
{xs:ilist}
{ys:ilist} .<xs>.
(
  xs: gflist_vt(a, xs)
, ys: gflist_vt(a, ys)
, res: &ptr? >> gflist_vt(a, zs)
) :<!wrt>
#[zs:ilist]
 (APPEND (xs, ys, zs) | void) = let
(*
//
val () =
  println!("gflist_vt_append: loop")
//
*)
in
//
case+ xs of
| @gflist_vt_cons
    (x, xs1) => let
    val () = res := xs
    val xs = xs1
    val (pf | ()) = loop(xs, ys, xs1)
    prval () = fold@(res)
  in
    (APPENDcons(pf) | ())
  end // end of [gflist_vt_cons]
| ~gflist_vt_nil () => let
    val () = res := ys in (APPENDnil() | ())
  end // end of [gflist_vt_nil]
//
end // end of [loop]
//
var res: ptr // uninitialized
//
val (pf | ()) = loop(xs, ys, res)
//
in
  (pf | res)
end // end of [gflist_vt_append]

(* ****** ****** *)

implement
{a}(*tmp*)
gflist_vt_revapp
  (xs, ys) = let
in
//
case+ xs of
| @gflist_vt_cons
    (x, xs1) => let
    val xs1_ = xs1
    val () = xs1 := ys
    prval () = fold@ (xs)
    val (pf | res) =
      gflist_vt_revapp(xs1_, xs)
    // end of [val]
  in
    (REVAPPcons(pf) | res)
  end // end of [gflist_vt_cons]
| ~gflist_vt_nil() => (REVAPPnil() | ys)
//
end // end of [gflist_vt_append]

implement
{a}(*tmp*)
gflist_vt_reverse(xs) = gflist_vt_revapp(xs, gflist_vt_nil)

(* ****** ****** *)

local

(*
//
// HX-2012-11-28:
// mergesort on gflist_vt // ported from ATS/Anairiats
//
*)

fun{
a:vt0p
} split
{xs:ilist}
{n,i:nat | i <= n} .<i>.
(
  pflen: LENGTH(xs, n)
| xs: &gflist_vt(a, xs) >> gflist_vt(a, xs1), i: int i
) :
#[xs1,xs2:ilist]
(
  APPEND(xs1, xs2, xs), LENGTH(xs1, i) | gflist_vt(a, xs2)
) =
(
if
(i = 0)
then let
//
  val xs2 = xs
  val () =
    (xs := gflist_vt_nil())
  // end of [val]
prval pfapp = append_unit_left()
//
in
  (pfapp, LENGTHnil() | xs2)
end // end of [else]
else let
//
prval
LENGTHcons(pflen) = pflen
  val @gflist_vt_cons(_, xs1) = xs
  val (pfapp, pf1len | xs2) = split(pflen | xs1, i-1)
prval ((*folded*)) = fold@ (xs)
//
in
  (APPENDcons(pfapp), LENGTHcons(pf1len) | xs2)
end // end of [then]
//
) (* end of [split] *)

(* ****** ****** *)
//
absprop
UNION (
  ys1: ilist, ys2: ilist, res: ilist
) (* end of [absprop] *)
//
(* ****** ****** *)

extern
prfun
union_commute
  {ys1,ys2:ilist} {ys:ilist}
  (pf: UNION(ys1, ys2, ys)): UNION(ys2, ys1, ys)
// end of [union_commute]

extern
prfun
union_nil1{ys:ilist}(): UNION(ilist_nil, ys, ys)
extern
prfun
union_nil2{ys:ilist}(): UNION(ys, ilist_nil, ys)

extern
prfun
union_cons1
  {y:int}
  {ys1,ys2:ilist}
  {ys:ilist}
(
  pf: UNION(ys1, ys2, ys)
) : UNION(ilist_cons(y, ys1), ys2, ilist_cons(y, ys))
// end of [union_cons1]

extern
prfun
union_cons2
  {y:int}
  {ys1,ys2:ilist}
  {ys:ilist}
(
  pf: UNION(ys1, ys2, ys)
) : UNION(ys1, ilist_cons(y, ys2), ilist_cons(y, ys))
// end of [union_cons2]

extern
prfun
isord_union_cons
{y1,y2:int | y1 <= y2}
{ys1,ys2:ilist}{ys:ilist}
(
  pf1: ISORD(ilist_cons(y1, ys1))
, pf2: ISORD(ilist_cons(y2, ys2))
, pf3: UNION(ys1, ilist_cons(y2, ys2), ys)
, pf4: ISORD(ys)
) : ISORD(ilist_cons(y1, ys))

(* ****** ****** *)

fun{
a:vt0p
} merge
  {ys1,ys2:ilist}
(
  pf1ord: ISORD(ys1)
, pf2ord: ISORD(ys2)
| ys1: gflist_vt(a, ys1), ys2: gflist_vt(a, ys2)
, ys: &ptr? >> gflist_vt(a, ys)
) : #[ys:ilist] (UNION(ys1, ys2, ys), ISORD(ys) | void) =
  case+ ys1 of
  | @gflist_vt_cons
      (y1, ys1_tl) =>
    (
    case+ ys2 of
    | @gflist_vt_cons
        (y2, ys2_tl) => let
        val sgn = gflist_vt_mergesort$cmp (y1, y2)
      in
        if sgn <= 0 then let
          val () = ys := ys1; val ys1 = ys1_tl
          prval () = fold@ (ys2)
          prval ISORDcons(pf1ord1, _) = pf1ord
          val (pfuni, pford | ()) = merge(pf1ord1, pf2ord | ys1, ys2, ys1_tl)
          prval pford = isord_union_cons(pf1ord, pf2ord, pfuni, pford)
          prval () = fold@ (ys)
          prval pfuni = union_cons1 (pfuni)
        in
          (pfuni, pford | ())
        end else let
          prval () = fold@ (ys1)
          val () = ys := ys2; val ys2 = ys2_tl
          prval ISORDcons(pf2ord1, _) = pf2ord
          val (pfuni, pford | ()) = merge(pf1ord, pf2ord1 | ys1, ys2, ys2_tl)
          prval pfuni = union_commute(pfuni)
          prval pford = isord_union_cons(pf2ord, pf1ord, pfuni, pford)
          prval () = fold@ (ys)
          prval pfuni = union_cons1 (pfuni)
          prval pfuni = union_commute (pfuni)
        in
          (pfuni, pford | ())
        end // end of [if]
      end // end of [gflist_vt_cons]
    | ~gflist_vt_nil () => let
        val () = fold@ (ys1); val () = ys := ys1 in (union_nil2 (), pf1ord | ())
      end // end of [gflist_vt_nil]
    ) (* end of [gflist_vt_cons] *)
  | ~gflist_vt_nil () => let
      val () = ys := ys2 in (union_nil1(), pf2ord | ())
    end // end of [gflist_vt_nil]
// end of [merge]

(* ****** ****** *)

extern
prfun sort_nilsing
  {xs:ilist} {n:nat | n <= 1} (pf: LENGTH(xs, n)): SORT(xs, xs)
// end of [sort_nilsing]

(* ****** ****** *)

fun{
a:vt0p
} msort
  {xs:ilist}{n:nat} .<n>.
(
  pflen: LENGTH(xs, n)
| xs: gflist_vt(a, xs), n: int n
) :
[ys:ilist]
(
  SORT(xs, ys) | gflist_vt(a, ys)
) = let
in
//
if
(n >= 2)
then let
  var xs = xs
  val n2 = half(n)
  val (pfapp, pf1len | xs2) = split(pflen | xs, n2)
  val xs1 = xs
prval pf2len = length_istot()
prval pflen_alt = lemma_append_length(pfapp, pf1len, pf2len)
prval () = length_isfun(pflen, pflen_alt)
  val (pf1srt | ys1) = msort (pf1len | xs1, n2)
prval (pf1ord, pf1perm) = sort_elim (pf1srt)
  val (pf2srt | ys2) = msort (pf2len | xs2, n-n2)
prval (pf2ord, pf2perm) = sort_elim (pf2srt)
  val (pfuni, pford | ()) = merge (pf1ord, pf2ord | ys1, ys2, xs)
//
  prval
  pfperm =
  lemma
  (
    pfapp, pf1perm, pf2perm, pfuni
  ) where
  {
    extern
    prfun
    lemma
    {xs1,xs2:ilist}{xs:ilist}
    {ys1,ys2:ilist}{ys:ilist}
    (
      APPEND(xs1, xs2, xs)
    , PERMUTE(xs1, ys1), PERMUTE(xs2, ys2), UNION(ys1, ys2, ys)
    ) : PERMUTE(xs, ys) // end of [lemma]
  } (* end of [where] *) // end of [prval]
//
  prval pfsrt = sort_make(pford, pfperm)
//
in
  (pfsrt | xs)
end else
  (sort_nilsing (pflen) | xs)
// end of [if]
//
end // end of [msort]

in (* in of [local] *)

implement
{a}(*tmp*)
gflist_vt_mergesort(xs) = let
  val (pflen | n) = gflist_vt_length<a>(xs) in msort<a>(pflen | xs, n)
end // end of [mergesort]

end // end of [local]

(* ****** ****** *)

(* end of [gflist_vt.dats] *)
