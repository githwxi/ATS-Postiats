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
(*
**
** A functional concatenable deque implementation
** based on finger-trees. Please see the JFP paper
** by Hinze and Paterson on finger-trees for more
** details on this interesting data structure.
**
** Contributed by Hongwei Xi (hwxiATcsDOTbuDOTedu)
** Contributed by Robbie Harwood (rharwoodATcsDOTbuDOTedu)
**
** Time: November, 2010
**
*)
(* ****** ****** *)
(*
** Ported to ATS2
** by Hongwei Xi (gmhwxiATgmailDOTcom)
** Time: May, 2012
*)
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSLIB.libats.fundeque_fngtree"
#define
ATS_DYNLOADFLAG 0 // no dynamic loading
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
_(*anon*) = "prelude/DATS/integer.dats"
staload
_(*anon*) = "prelude/DATS/integer_size.dats"

(* ****** ****** *)
//
staload "libats/SATS/fundeque_fngtree.sats"
//
(* ****** ****** *)
//
#include "./SHARE/fundeque.hats" // code reuse
//
(* ****** ****** *)

datatype
ftnode
(
  a:t@ype+, int(*dpth*), int(*size*)
) = (* ftnode *)
  | FTN1(a, 0, 1) of (a) // singleton
  | {d:nat}
    {n1,n2:nat}
    FTN2(a, d+1, n1+n2) of
    (
      ftnode(a, d, n1), ftnode(a, d, n2)
    ) // end of [FTN2]
  | {d:nat}
    {n1,n2,n3:nat}
    FTN3(a, d+1, n1+n2+n3) of
    (
      ftnode(a, d, n1), ftnode(a, d, n2), ftnode(a, d, n3)
    ) // end of [FTN3]
// end of [ftnode] // end of [datatype]

(* ****** ****** *)

datatype
ftdigit
(
  a:t@ype+, int(*dpth*), int(*size*)
) = (* ftdigit *)
  | {d:nat}
    {n:nat}
    FTD1
    (
      a, d, n
    ) of ftnode(a, d, n)
  | {d:nat}
    {n1,n2:nat}
    FTD2
    (
      a, d, n1+n2
    ) of
    (
      ftnode(a, d, n1), ftnode(a, d, n2)
    ) (* end of [FTD2] *)
  | {d:nat}
    {n1,n2,n3:nat}
    FTD3
    (
      a, d, n1+n2+n3
    ) of (
      ftnode(a, d, n1), ftnode(a, d, n2), ftnode(a, d, n3)
    ) (* end of [FTD3] *)
  | {d:nat}
    {n1,n2,n3,n4:nat}
    FTD4
    (
      a, d, n1+n2+n3+n4
    ) of (
      ftnode(a, d, n1), ftnode(a, d, n2), ftnode(a, d, n3), ftnode(a, d, n4)
    ) (* end of [FTD4] *)
// end of [ftdigit]

(* ****** ****** *)

datatype
fngtree (
  a:t@ype, int(*d*), int(*n*)
) = (* fngtree *)
  | {d:nat}
    FTemp(a, d, 0) of ()
  | {d:nat}
    {n:int}
    FTsing(a, d, n) of ftnode(a, d, n)
  | {d:nat}
    {npr,nm,nsf:nat}
    FTdeep(a, d, npr+nm+nsf) of
    (
      ftdigit(a, d, npr), fngtree(a, d+1, nm), ftdigit(a, d, nsf)
    ) // end of [FTdeep]
// end of [fngtree]

(* ****** ****** *)
//
extern
fun
{a:t0p}
fprint_fngtree
  {d:int}{n:int}
  (out: FILEref, xt: fngtree (INV(a), d, n)): void
//
(* ****** ****** *)

local

fun
{a:t0p}
fprint_ftnode
  {d:int}{n:int}
(
  out: FILEref, xn: ftnode (INV(a), d, n)
) : void = let
//
macdef
prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ xn of
| FTN1 (x) =>
  {
    val () = prstr "FTN1("
    val () = fprint_val<a> (out, x)
    val () = prstr ")"
  }
| FTN2 (xn1, xn2) =>
  {
    val () = prstr "FTN2("
    val () = fprint_ftnode (out, xn1)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn2)
    val () = prstr ")"
  }
| FTN3 (xn1, xn2, xn3) =>
  {
    val () = prstr "FTN3("
    val () = fprint_ftnode (out, xn1)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn2)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn3)
    val () = prstr ")"
  }
//
end // end of [fprint_ftnode]

fun{a:t0p}
fprint_ftdigit
  {d:int}{n:int}
(
  out: FILEref, xn: ftdigit (INV(a), d, n)
) : void = let
//
macdef
prstr (str) = fprint_string (out, ,(str))
//
in
//
case+ xn of
| FTD1 (xn1) =>
  {
    val () = prstr "FTD1("
    val () = fprint_ftnode (out, xn1)
    val () = prstr ")"
  }
| FTD2 (xn1, xn2) =>
  {
    val () = prstr "FTD2("
    val () = fprint_ftnode (out, xn1)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn2)
    val () = prstr ")"
  }
| FTD3 (xn1, xn2, xn3) =>
  {
    val () = prstr "FTD2("
    val () = fprint_ftnode (out, xn1)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn2)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn3)
    val () = prstr ")"
  }
| FTD4 (xn1, xn2, xn3, xn4) =>
  {
    val () = prstr "FTD2("
    val () = fprint_ftnode (out, xn1)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn2)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn3)
    val () = prstr ", "
    val () = fprint_ftnode (out, xn4)
    val () = prstr ")"
  }
//
end // end of [fprint_ftdigit]

in (* in of [local] *)

implement
{a}(*tmp*)
fprint_fngtree
  (out, xt) = let
//
macdef
prstr(str) =
  fprint_string(out, ,(str))
//
in
//
case+ xt of
| FTemp () => prstr "FTemp()"
| FTsing (xn) =>
  {
    val () = prstr "FTsing("
    val () = fprint_ftnode (out, xn)
    val () = prstr ")"
  }
| FTdeep (xn1, xt2, xn3) =>
  {
    val () = prstr "FTdeep("
    val () = fprint_ftdigit (out, xn1)
    val () = prstr ", "
    val () = fprint_fngtree (out, xt2)
    val () = prstr ", "
    val () = fprint_ftdigit (out, xn3)
    val () = prstr ")"
  }
//
end // end of [fprint_fngtree]

end // end of [local]

(* ****** ****** *)

prfun
ftnode_prop_szpos
  {a:t0p}
  {d:int}
  {n:int} .<d \nsub 0>.
  (xn: ftnode (a, d, n)): [n > 0] void =
  case+ xn of
  | FTN1 _ => ()
  | FTN2(xn1, xn2) =>
    {
      prval () = ftnode_prop_szpos(xn1)
      prval () = ftnode_prop_szpos(xn2)
    } (* end of [FTN2] *)
  | FTN3(xn1, xn2, xn3) =>
    {
      prval () = ftnode_prop_szpos(xn1)
      prval () = ftnode_prop_szpos(xn2)
      prval () = ftnode_prop_szpos(xn3)
    } (* end of [FTN3] *)
// end of [ftnode_prop_szpos]

(* ****** ****** *)

prfun
ftdigit_prop_szpos
  {a:t0p}
  {d:int}
  {n:int} .<>.
  (xd: ftdigit(a, d, n)): [n > 0] void =
  case+ xd of
  | FTD1(xn1) => ftnode_prop_szpos(xn1)
  | FTD2(xn1, _) => ftnode_prop_szpos(xn1)
  | FTD3(xn1, _, _) => ftnode_prop_szpos(xn1)
  | FTD4(xn1, _, _, _) => ftnode_prop_szpos(xn1)
// end of [ftdigit_prop_szpos]

(* ****** ****** *)

prfun
fngtree_prop1_sznat
  {a:t0p}
  {d:int}
  {n:int} .<>.
  (xt: fngtree(a, d, n)): [n >= 0] void =
  case+ xt of
  | FTemp() => ()
  | FTsing(xn) => ftnode_prop_szpos(xn)
  | FTdeep(pr, m, sf) =>
    {
      val () = ftdigit_prop_szpos(pr) and () = ftdigit_prop_szpos(sf)
    } (* end of [FTdeep] *)
// end of [fngtree_prop1_sznat]

(* ****** ****** *)
//
extern
fun
ftnode_size
  {a:t0p}
  {d:int}
  {n:nat} // .<n>.
  (xn: ftnode(a, d, n)) :<> size_t(n)
//
implement
ftnode_size(xn) = let
//
#define nsz(x) ftnode_size(x)
//
in
//
case+ xn of
| FTN1 _ => g1i2u(1)
| FTN2(xn1, xn2) => let
    prval () =
      ftnode_prop_szpos(xn1)
    prval () =
      ftnode_prop_szpos(xn2) in nsz(xn1) + nsz(xn2)
  end // end of [FTN2]
| FTN3(xn1, xn2, xn3) => let
    prval () =
      ftnode_prop_szpos(xn1)
    prval () =
      ftnode_prop_szpos(xn2)
    prval () =
      ftnode_prop_szpos(xn3) in nsz(xn1) + nsz(xn2) + nsz(xn3)
  end // endof [FTN3]
//
end // end of [ftnode_size]
//
(* ****** ****** *)
//
extern
fun
ftdigit_size
  {a:t0p}
  {d:int}
  {n:int} // .<>.
  (xd: ftdigit (a, d, n)):<> size_t(n)
//
implement
ftdigit_size(xd) = let
//
#define nsz(x) ftnode_size(x)
//
in
//
case+ xd of
| FTD1(xn1) =>
    nsz(xn1)
| FTD2(xn1, xn2) =>
    nsz(xn1) + nsz(xn2)
| FTD3(xn1, xn2, xn3) =>
    nsz(xn1) + nsz(xn2) + nsz(xn3)
| FTD4(xn1, xn2, xn3, xn4) =>
    nsz(xn1) + nsz(xn2) + nsz(xn3) + nsz(xn4)
//
end // end of [ftdigit_size]
//
(* ****** ****** *)
//
extern
fun
ftnode2ftdigit
  {a:t0p}{d:pos}{n:int} // .<>.
  (xn: ftnode(a, d, n)):<> ftdigit(a, d-1, n)
//
implement
ftnode2ftdigit(xn) =
(
case+ xn of
  | FTN2(xn1, xn2) => FTD2(xn1, xn2)
  | FTN3(xn1, xn2, xn3) => FTD3(xn1, xn2, xn3)
) (* end of [ftnode2ftdigit] *)
//
(* ****** ****** *)
//
extern
fun
ftdigit2fngtree
  {a:t0p}{d:nat}{n:int} // .<>.
  (xd: ftdigit(a, d, n)):<> fngtree(a, d, n)
//
implement
ftdigit2fngtree
  (xd) = 
(
case+ xd of
| FTD1(xn1) =>
    FTsing(xn1)
| FTD2(xn1, xn2) =>
    FTdeep(FTD1(xn1), FTemp(), FTD1(xn2))
| FTD3(xn1, xn2, xn3) =>
    FTdeep(FTD2(xn1, xn2), FTemp(), FTD1(xn3))
| FTD4(xn1, xn2, xn3, xn4) =>
    FTdeep(FTD2(xn1, xn2), FTemp(), FTD2(xn3, xn4))
) (* end of [ftdigit2fngtree] *)
//
(* ****** ****** *)
//
extern
fun
fngtree_cons
  {a:t0p}{d:nat}{n1,n2:int}
(
  xn: ftnode (a, d, n1), xt: fngtree (a, d, n2)
) :<> fngtree (a, d, n1+n2) // end of [fngtree_cons]
//
implement
fngtree_cons{a}
  (xn, xt) = cons(xn, xt) where
{
//
fun
cons{d:nat}
  {n1,n2:int | n2 >= 0} .<n2>.
(
  xn: ftnode(a, d, n1), xt: fngtree(a, d, n2)
) :<> fngtree(a, d, n1+n2) = let
//
prval () =
  ftnode_prop_szpos (xn)
//
in
//
case+ xt of
| FTemp() => FTsing(xn)
| FTsing(xn1) => let
    prval () =
      ftnode_prop_szpos (xn1)
    // end of [prval]
  in
    FTdeep(FTD1(xn), FTemp(), FTD1(xn1))
  end // end [FTsing]
| FTdeep(pr, m, sf) =>
  (
    case+ pr of
    | FTD1(xn1) =>
        FTdeep(FTD2(xn, xn1), m, sf) 
    | FTD2(xn1, xn2) =>
        FTdeep(FTD3(xn, xn1, xn2), m, sf)
    | FTD3(xn1, xn2, xn3) =>
        FTdeep(FTD4(xn, xn1, xn2, xn3), m, sf)
    | FTD4(xn1, xn2, xn3, xn4) => let
//
        val pr = FTD2(xn, xn1)
//
        prval () = ftdigit_prop_szpos(sf)
        prval () = fngtree_prop1_sznat(m)
//
        val m2 = cons(FTN3(xn2, xn3, xn4), m) in FTdeep(pr, m2, sf)
      end // end of [FTD4]
    // end of [case]
  ) (* end of [FTdeep] *)
//
end // end of [cons]
//
prval () = fngtree_prop1_sznat(xt)
//
} (* end of [fngtree_cons] *)
//
(* ****** ****** *)
//
extern
fun
fngtree_uncons
{a:t0p}{d:nat}{n:pos}
(
  xt: fngtree(a, d, n), r: &ptr? >> ftnode(a, d, n1)
) :<!wrt> #[n1:nat] fngtree(a, d, n-n1)
//
implement
fngtree_uncons{a}
  (xt, r) = uncons(xt, r) where
{
//
fun uncons
  {d:nat}{n:pos} .<n>.
(
  xt: fngtree (a, d, n)
, r: &ptr? >> ftnode (a, d, n1)
) :<!wrt> #[n1:nat | n1 <= n] fngtree (a, d, n-n1) =
  case+ xt of
  | FTsing (xn) => let
      val () = r := xn in FTemp ()
    end // end of [Single]
  | FTdeep (pr, m, sf) => (case+ pr of
    | FTD1 (xn) => let
        val () = r := xn
        prval () = ftdigit_prop_szpos(pr)
        prval () = ftdigit_prop_szpos(sf)
      in
        case+ m of
        | FTemp () =>
            ftdigit2fngtree(sf)
        | FTsing (xn1) =>
            FTdeep(ftnode2ftdigit(xn1), FTemp(), sf)
        | FTdeep (pr1, m1, sf1) => let
            var r1: ptr?
            prval () = ftdigit_prop_szpos (pr1)
            prval () = fngtree_prop1_sznat (m1)
            prval () = ftdigit_prop_szpos (sf1)
            val m = uncons (m, r1)
          in
            FTdeep(ftnode2ftdigit(r1), m, sf)
          end // end of [_]
      end // end of [FTD1]
    | FTD2 (xn, xn1) => let
        val () = r := xn in FTdeep (FTD1 (xn1), m, sf)
      end // end of [FTD2]
    | FTD3 (xn, xn1, xn2) => let
        val () = r := xn in FTdeep (FTD2 (xn1, xn2), m, sf)
      end // end of [FTD3]
    | FTD4 (xn, xn1, xn2, xn3) => let
        val () = r := xn in FTdeep (FTD3 (xn1, xn2, xn3), m, sf)
      end // end of [FTD4]
    ) // end of [FTdeep]
// end of [uncons]
} (* end of [fngtree_uncons] *)
//
(* ****** ****** *)
//
extern
fun
fngtree_get_atbeg
{a:t0p}{d:nat}{n:pos}
(
xt: fngtree (a, d, n)
) :<> [n1:nat] ftnode (a, d, n1)
//
implement
fngtree_get_atbeg
  (xt) = (case+ xt of
  | FTsing (xn) => xn
  | FTdeep (pr, m, sf) =>
    (
    case+ pr of
    | FTD1 (xn) => xn
    | FTD2 (xn, xn1) => xn
    | FTD3 (xn, xn1, xn2) => xn
    | FTD4 (xn, xn1, xn2, xn3) => xn
    ) (* end of [FTdeep] *)
) (* end of [fngtree_get_atbeg] *)
//
(* ****** ****** *)
//
extern
fun
fngtree_snoc
  {a:t0p}{d:nat}{n1,n2:int}
(
  xt: fngtree (a, d, n2), xn: ftnode (a, d, n1)
) :<> fngtree (a, d, n1+n2) // end of [fngtree_snoc]
//
implement
fngtree_snoc{a}
  (xt, xn) = snoc(xt, xn) where
{
//
fun
snoc{d:nat}
{n1,n2:int | n2 >= 0} .<n2>.
(
  xt: fngtree (a, d, n2), xn: ftnode (a, d, n1)
) :<> fngtree (a, d, n1+n2) = let
//
prval () = ftnode_prop_szpos (xn)
//
in
//
case+ xt of
| FTemp() => FTsing(xn)
| FTsing(xn1) => let
    prval () =
      ftnode_prop_szpos (xn1)
    // end of [prval]
  in
    FTdeep(FTD1(xn1), FTemp(), FTD1(xn))
  end // end [FTsing]
| FTdeep(pr, m, sf) =>
  ( case+ sf of
    | FTD1(xn1) =>
        FTdeep(pr, m, FTD2(xn1, xn))
    | FTD2(xn1, xn2) =>
        FTdeep(pr, m, FTD3(xn1, xn2, xn))
    | FTD3(xn1, xn2, xn3) =>
        FTdeep(pr, m, FTD4(xn1, xn2, xn3, xn))
    | FTD4(xn1, xn2, xn3, xn4) => let
        val sf = FTD2 (xn4, xn)
//
        prval () = ftdigit_prop_szpos(pr)
        prval () = fngtree_prop1_sznat(m)
//
        val m2 = snoc(m, FTN3 (xn1, xn2, xn3)) in FTdeep (pr, m2, sf)
      end // end of [FTD4]
      // end of [case]
    ) (* end of [FTdeep] *)
//
end // end of [snoc]
//
prval () = fngtree_prop1_sznat (xt)
//
} (* end of [fngtree_snoc] *)

(* ****** ****** *)

extern
fun
fngtree_unsnoc
  {a:t0p}{d:nat}{n:pos}
(
  xt: fngtree (a, d, n), r: &ptr? >> ftnode (a, d, n1)
) :<!wrt> #[n1:nat] fngtree (a, d, n-n1)
// end of [fngtree_unsnoc]

implement
fngtree_unsnoc{a}
  (xt, r) = unsnoc (xt, r) where
{
//
fun
unsnoc
{d:nat}{n:pos} .<n>.
(
  xt: fngtree(a, d, n)
, r: &ptr? >> ftnode(a, d, n1)
) :<!wrt> #[n1:nat | n1 <= n] fngtree(a, d, n-n1) =
(
//
case+ xt of
| FTsing(xn) => let
    val () = r := xn in FTemp ()
  end // end of [FTsing]
| FTdeep(pr, m, sf) =>
  (
  case+ sf of
  | FTD1(xn) => let
      val () = r := xn
      prval () = ftdigit_prop_szpos(pr)
      prval () = ftdigit_prop_szpos(sf)
    in
      case+ m of
      | FTemp() =>
          ftdigit2fngtree(pr)
      | FTsing(xn1) =>
          FTdeep(pr, FTemp(), ftnode2ftdigit(xn1))
      | FTdeep(pr1, m1, sf1) => let
          var r1: ptr?
          prval () = ftdigit_prop_szpos(pr1)
          prval () = fngtree_prop1_sznat(m1)
          prval () = ftdigit_prop_szpos(sf1)
          
        in
          let val m = unsnoc(m, r1) in FTdeep(pr, m, ftnode2ftdigit(r1)) end
        end // end of [FTdeep]
    end // end of [FTD1]
  | FTD2 (xn1, xn) => let
      val () = r := xn in FTdeep(pr, m, FTD1(xn1))
    end // end of [FTD2]
  | FTD3 (xn1, xn2, xn) => let
      val () = r := xn in FTdeep(pr, m, FTD2(xn1, xn2))
    end // end of [FTD3]
  | FTD4 (xn1, xn2, xn3, xn) => let
      val () = r := xn in FTdeep(pr, m, FTD3(xn1, xn2, xn3))
    end // end of [FTD4]
  ) (* end of [FTdeep] *)
//
) (* end of [unsnoc] *)
} (* end of [fngtree_unsnoc] *)

(* ****** ****** *)
//
extern
fun
fngtree_get_atend
{a:t0p}{d:nat}{n:pos}
(
  xt: fngtree (a, d, n)
) :<> [n1:nat] ftnode (a, d, n1)
//
implement
fngtree_get_atend
  {a}(xt) =
(
  case+ xt of
  | FTsing (xn) => xn
  | FTdeep (pr, m, sf) =>
    ( case+ sf of
      | FTD1 (xn) => xn
      | FTD2 (xn1, xn) => xn
      | FTD3 (xn1, xn2, xn) => xn
      | FTD4 (xn1, xn2, xn3, xn) => xn
    ) (* end of [FTdeep] *)
) (* end of [fngtree_get_atend] *)
//
(* ****** ****** *)
//
assume
deque_type
  (a:t@ype, n:int) =
  fngtree(a, 0(*depth*), n)
//
(* ****** ****** *)

primplmnt
lemma_deque_param
  (xs) = fngtree_prop1_sznat(xs)
// end of [lemma_deque_param]

(* ****** ****** *)
//
implement
{}(*tmp*)
fundeque_nil () = FTemp((*void*))
implement
{}(*tmp*)
fundeque_make_nil () = FTemp((*void*))
//
(* ****** ****** *)

implement
{a}(*tmp*)
fundeque_cons (x0, xs) =
  fngtree_cons (FTN1{a}(x0), xs)
// end of [fundeque_cons]

implement
{a}(*tmp*)
fundeque_uncons
  (xs) = x0 where
{
  var xn: ptr?
  val () = xs := fngtree_uncons(xs, xn)
  val+FTN1 (x0) = xn
} // end of [fundeque_uncons]

(* ****** ****** *)

implement
{a}(*tmp*)
fundeque_snoc (xs, xn) =
  fngtree_snoc (xs, FTN1{a}(xn))
// end of [fundeque_snoc]

implement
{a}(*tmp*)
fundeque_unsnoc
  (xs) = x0 where
{
  var xn: ptr?
  val () = xs := fngtree_unsnoc(xs, xn)
  val+FTN1 (x0) = xn
} // end of [fundeque_unsnoc]

(* ****** ****** *)

implement
{}(*tmp*)
fundeque_is_nil (xs) = let
in
//
case+ xs of
| FTemp () => true
| FTsing (xn) => let
    prval () = ftnode_prop_szpos (xn) in false
  end // end of [FTsing]
| FTdeep (pr, _, _) => let
    prval () = ftdigit_prop_szpos (pr) in false
  end // end of [FTdeep]
//
end // end of [fundeque_is_nil]

implement
{}(*tmp*)
fundeque_is_cons (xs) = let
  prval () = lemma_deque_param (xs) in ~fundeque_is_nil<> (xs)
end // end of [fundeque_is_cons]

(* ****** ****** *)

extern
fun
fngtree_size
{a:t0p}
{d:int}
{n:nat}
  (xt: fngtree(a, d, n)):<> size_t(n)
//
implement
{a}(*tmp*)
fundeque_size
  (xs) = let
//
prval () = lemma_deque_param(xs)
//
in
  fngtree_size(xs)
end // end of [fundeque_size]
//
implement
fngtree_size
  (xt) = (
//
case+ xt of
| FTemp () => g1i2u(0)
| FTsing (xn) => ftnode_size(xn)
| FTdeep (pr, m, sf) => let
    prval () = ftdigit_prop_szpos(pr)
  in
    ftdigit_size(pr) + fngtree_size(m) + ftdigit_size(sf)
  end // end of [FTdeep]
//
) (* end of [fngtree_size] *)

(* ****** ****** *)

implement
{a}(*tmp*)
fundeque_get_atbeg
  (xs) = let
  val+FTN1 (x) = fngtree_get_atbeg{a}(xs) in (x)
end // end of [fundeque_get_atbeg]

implement
{a}(*tmp*)
fundeque_get_atend
  (xs) = let
  val+FTN1 (x) = fngtree_get_atend{a}(xs) in (x)
end // end of [fundeque_get_atend]

(* ****** ****** *)
//
extern
fun
fngtree_append
  {a:t0p}
  {d:int}
  {n1,n2:nat}
(
  fngtree(a, d, n1), fngtree(a, d, n2)
) : fngtree(a, d, n1+n2) // end-of-function
//
implement
{a}(*tmp*)
fundeque_append
  (xs1, xs2) = let
//
prval () = lemma_deque_param(xs1)
prval () = lemma_deque_param(xs2)
//
in
  $effmask_all(fngtree_append(xs1, xs2))
end // end of [fundeque_append]
//
(* ****** ****** *)

local
//
symintr ++
//
infix (+) ++
//
overload ++ with fngtree_cons
overload ++ with fngtree_snoc

fun
ftapp0
  {a:t0p}
  {d:int}
  {n1,n2:nat}
(
  xt1: fngtree (a, d, n1)
, xt2: fngtree (a, d, n2)
) : fngtree (a, d, n1+n2) =
(
  case+ (xt1, xt2) of
  | (FTemp(), _) => xt2
  | (_, FTemp()) => xt1
  | (FTsing xn1, _) => xn1 ++ xt2
  | (_, FTsing xn2) => xt1 ++ xn2
  | (FTdeep(pr1, m1, sf1),
     FTdeep(pr2, m2, sf2)) => FTdeep(pr1, ftadd0(m1, sf1, pr2, m2), sf2)
) // end of [ftapp0]

and
ftadd0
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
(
  m1: fngtree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, pr2: ftdigit (a, d, npr2)
, m2: fngtree (a, d+1, nm2)
) : fngtree (a, d+1, nm1+nsf1+npr2+nm2) = let
in
//
case+ sf1 of
| FTD1 (xn1) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp1 (m1, FTN2(xn1, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp1 (m1, FTN3(xn1, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp2 (m1, FTN2(xn1, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
      ftapp2 (m1, FTN3(xn1, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD1]
| FTD2 (xn1, xn2) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp1(m1, FTN3(xn1, xn2, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN2(xn1, xn2), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp2(m1, FTN3(xn1, xn2, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp2(m1, FTN3(xn1, xn2, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD2]
| FTD3(xn1, xn2, xn3) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN2(xn1, xn2), FTN2(xn3, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
     ftapp2(m1, FTN3(xn1, xn2, xn3), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp2(m1, FTN3(xn1, xn2, xn3), FTN3(xn_1, xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD3]
| FTD4(xn1, xn2, xn3, xn4) =>
 (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xn2, xn3), FTN2(xn4, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
     ftapp2(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xn4, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD4]
//
end // end of [ftadd0]

and
ftapp1
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na:nat}
(
  xt1: fngtree (a, d, n1)
, xna: ftnode (a, d, na)
, xt2: fngtree (a, d, n2)
) : fngtree (a, d, n1+na+n2) =
(
//
case+ (xt1, xt2) of
  | (FTemp(), _) => xna ++ xt2
  | (_, FTemp()) => xt1 ++ xna
  | (FTsing xn1, _) => xn1 ++ (xna ++ xt2)
  | (_, FTsing xn2) => (xt1 ++ xna) ++ xn2
  | (FTdeep(pr1, m1, sf1), FTdeep(pr2, m2, sf2)) =>
     FTdeep(pr1, ftadd1(m1, sf1, xna, pr2, m2), sf2)
//
) (* end of [ftapp1] *)

and
ftadd1
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na:nat}
(
  m1: fngtree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, pr2: ftdigit (a, d, npr2)
, m2: fngtree (a, d+1, nm2)
) : fngtree (a, d+1, nm1+nsf1+na+npr2+nm2) = let
in
//
case+ sf1 of
| FTD1(xn1) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp1(m1, FTN3(xn1, xna, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN2(xn1, xna), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp2(m1, FTN3(xn1, xna, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp2(m1, FTN3(xn1, xna, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD1]
| FTD2(xn1, xn2) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN2(xn1, xn2), FTN2(xna, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN3(xn1, xn2, xna), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp2(m1, FTN3(xn1, xn2, xna), FTN3(xn_1, xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN2(xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD2]
| FTD3(xn1, xn2, xn3) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xn2, xn3), FTN2(xna, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xna, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD3]
| FTD4(xn1, xn2, xn3, xn4) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xn4, xna), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD4]
//
end // end of [ftadd1]

and
ftapp2
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na,nb:nat}
(
  xt1: fngtree (a, d, n1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xt2: fngtree (a, d, n2)
) : fngtree (a, d, n1+na+nb+n2) =
(
  case+ (xt1, xt2) of
  | (FTemp (), _) => xna ++ (xnb ++ xt2)
  | (_, FTemp ()) => (xt1 ++ xna) ++ xnb
  | (FTsing xn1, _) => xn1 ++ (xna ++ (xnb ++ xt2))
  | (_, FTsing xn2) => ((xt1 ++ xna) ++ xnb) ++ xn2
  | (FTdeep (pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
     FTdeep (pr1, ftadd2(m1, sf1, xna, xnb, pr2, m2), sf2)
) // end of [ftapp2]

and
ftadd2
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na,nb:nat}
(
  m1: fngtree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, pr2: ftdigit (a, d, npr2)
, m2: fngtree (a, d+1, nm2)
) : fngtree (a, d+1, nm1+nsf1+na+nb+npr2+nm2) = let
in
//
case+ sf1 of
| FTD1(xn1) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN2(xn1, xna), FTN2(xnb, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN3(xn1, xna, xnb), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp2(m1, FTN3(xn1, xna, xnb), FTN3(xn_1, xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xna, xnb), FTN2(xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD1]
| FTD2(xn1, xn2) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xn2, xna), FTN2(xnb, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN2(xnb, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD2]
| FTD3(xn1, xn2, xn3) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xna, xnb), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD3]
| FTD4(xn1, xn2, xn3, xn4) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xn4, xna), FTN2(xnb, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN3(xn_1, xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN2(xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD4]
//
end // end of [ftadd2]

and
ftapp3
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na,nb,nc:nat}
(
  xt1: fngtree (a, d, n1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, xt2: fngtree (a, d, n2)
) : fngtree (a, d, n1+na+nb+nc+n2) =
(
  case+ (xt1, xt2) of
  | (FTemp(), _) => xna ++ (xnb ++ (xnc ++ xt2))
  | (_, FTemp()) => ((xt1 ++ xna) ++ xnb) ++ xnc
  | (FTsing xn1, _) => xn1 ++ (xna ++ (xnb ++ (xnc ++ xt2)))
  | (_, FTsing xn2) => (((xt1 ++ xna) ++ xnb) ++ xnc) ++ xn2
  | (FTdeep(pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
     FTdeep(pr1, ftadd3(m1, sf1, xna, xnb, xnc, pr2, m2), sf2)
) // end of [ftapp3]

and
ftadd3
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na,nb,nc:nat}
(
  m1: fngtree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, pr2: ftdigit (a, d, npr2)
, m2: fngtree (a, d+1, nm2)
) : fngtree (a, d+1, nm1+nsf1+na+nb+nc+npr2+nm2) = let
in
//
case+ sf1 of
| FTD1(xn1) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xna, xnb), FTN2(xnc, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp2(m1, FTN3(xn1, xna, xnb), FTN3(xnc, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xna, xnb), FTN2(xnc, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xna, xnb), FTN3(xnc, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD1]
| FTD2(xn1, xn2) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xnc, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN2(xnb, xnc), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xnc, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xnc, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD2]
| FTD3(xn1, xn2, xn3) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN2(xna, xnb), FTN2(xnc, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN3(xn_1, xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN2(xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD3]
| FTD4(xn1, xn2, xn3, xn4) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN2(xnc, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN3(xnc, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN2(xnc, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN3(xnc, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD4]
//
end // end of [ftadd3]

and
ftapp4
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na,nb,nc,nd:nat}
(
  xt1: fngtree (a, d, n1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, xnd: ftnode (a, d, nd)
, xt2: fngtree (a, d, n2)
) : fngtree (a, d, n1+na+nb+nc+nd+n2) =
(
  case+ (xt1, xt2) of
  | (FTemp(), _) => xna ++ (xnb ++ (xnc ++ (xnd ++ xt2)))
  | (_, FTemp()) => (((xt1 ++ xna) ++ xnb) ++ xnc) ++ xnd
  | (FTsing xn1, _) => xn1 ++ (xna ++ (xnb ++ (xnc ++ (xnd ++ xt2))))
  | (_, FTsing xn2) => ((((xt1 ++ xna) ++ xnb) ++ xnc) ++ xnd) ++ xn2
  | (FTdeep(pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
     FTdeep(pr1, ftadd4(m1, sf1, xna, xnb, xnc, xnd, pr2, m2), sf2)
) // end of [ftapp4]

and
ftadd4
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na,nb,nc,nd:nat}
(
  m1: fngtree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, xnd: ftnode (a, d, nd)
, pr2: ftdigit (a, d, npr2)
, m2: fngtree (a, d+1, nm2)
) : fngtree (a, d+1, nm1+nsf1+na+nb+nc+nd+npr2+nm2) = let
in
//
case+ sf1 of
| FTD1(xn1) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp2(m1, FTN3(xn1, xna, xnb), FTN3(xnc, xnd, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xna, xnb), FTN2(xnc, xnd), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xna, xnb), FTN3(xnc, xnd, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp3(m1, FTN3(xn1, xna, xnb), FTN3(xnc, xnd, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD1]
| FTD2(xn1, xn2) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN2(xnb, xnc), FTN2(xnd, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xnc, xnd), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp3(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xnc, xnd), FTN3(xn_1, xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp4(m1, FTN3(xn1, xn2, xna), FTN3(xnb, xnc, xnd), FTN2(xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD2]
| FTD3(xn1, xn2, xn3) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN2(xnd, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN3(xnd, xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN2(xnd, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xna, xnb, xnc), FTN3(xnd, xn_1, xn_2), FTN2(xn_3, xn_4), m2)
  ) // end of [FTD3]
| FTD4(xn1, xn2, xn3, xn4) =>
  (
  case+ pr2 of
  | FTD1(xn_1) =>
      ftapp3(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN3(xnc, xnd, xn_1), m2)
  | FTD2(xn_1, xn_2) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN2(xnc, xnd), FTN2(xn_1, xn_2), m2)
  | FTD3(xn_1, xn_2, xn_3) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN3(xnc, xnd, xn_1), FTN2(xn_2, xn_3), m2)
  | FTD4(xn_1, xn_2, xn_3, xn_4) =>
      ftapp4(m1, FTN3(xn1, xn2, xn3), FTN3(xn4, xna, xnb), FTN3(xnc, xnd, xn_1), FTN3(xn_2, xn_3, xn_4), m2)
  ) // end of [FTD4]
//
end // end of [ftadd4]

in (* in of [local] *)

implement
fngtree_append(xt1, xt2) = ftapp0(xt1, xt2)

end // end of [local]

(* ****** ****** *)
//
typedef
ftnode(a:t0p, d:int) = [n:int] ftnode(a, d, n)
//
(* ****** ****** *)

local

extern
fun
__free(p: ptr):<!wrt> void = "mac#ATS_MFREE"

extern
fun
foreach
{a:t0p}{d:nat}{n:nat}
(
  xt: fngtree(a, d, n), f: ftnode(a, d) -<cloref> void
) :<> void // end of [foreach]

implement
foreach
{a}{d}{n}
  (xt, fopr) = let
in
//
case+ xt of
| FTemp() => ()
| FTsing(xn) => fopr(xn)
| FTdeep(pr, m, sf) => let
//
    prval () = ftdigit_prop_szpos(pr)
    prval () = ftdigit_prop_szpos(sf)
//
    val () =
    ( case+ pr of
      | FTD1(xn1) =>
          fopr(xn1)
      | FTD2(xn1, xn2) =>
          (fopr(xn1); fopr(xn2))
      | FTD3(xn1, xn2, xn3) =>
          (fopr(xn1); fopr(xn2); fopr(xn3))
      | FTD4(xn1, xn2, xn3, xn4) =>
          (fopr(xn1); fopr(xn2); fopr(xn3); fopr(xn4))
    ) : void // end of [val]
//
    val () =
    ( case+ m of
      | FTemp() => ()
      | _ (*non-FTemp*) => let
          val
          fopr1 = lam
            (xn_1: ftnode(a, d+1)): void =<cloref> let
          in
            case+ xn_1 of
            | FTN2(xn1, xn2) =>
                (fopr(xn1); fopr(xn2))
            | FTN3(xn1, xn2, xn3) =>
                (fopr(xn1); fopr(xn2); fopr(xn3))
          end // end of [lam] // end of [val]
          val () = foreach(m, fopr1)
          val () = $effmask_wrt(__free ($UN.cast2ptr(fopr1)))
        in
          // nothing          
        end // end of [_]
    ) : void // end of [val]
    val () =
    ( case+ sf of
      | FTD1(xn1) =>
          fopr(xn1)
      | FTD2(xn1, xn2) =>
          (fopr(xn1); fopr(xn2))
      | FTD3(xn1, xn2, xn3) =>
          (fopr(xn1); fopr(xn2); fopr(xn3))
      | FTD4(xn1, xn2, xn3, xn4) =>
          (fopr(xn1); fopr(xn2); fopr(xn3); fopr(xn4))
    ) : void // end of [val]
  in
    // nothing
  end // end of [FTdeep]
end // end of [foreach]

in (* in of [local] *)

implement
{a}(*tmp*)
fundeque_foreach(xs) = let
  var env: void = () in fundeque_foreach_env<a><void>(xs, env)
end // end of [fundeque_foreach]

implement
{a}{env}
fundeque_foreach_env
  (xs, env) = let
//
typedef
ftnode0 = ftnode(a, 0)
//
prval () = fngtree_prop1_sznat (xs)
//
val p_env = addr@(env)
//
val
fopr = lam
(
xn: ftnode0
) : void =<cloref> let
//
  val+FTN1(x) = xn
//
  val
  (
    pf, fpf | p_env
  ) = $UN.ptr_vtake{env}(p_env)
//
  val () =
  $effmask_all
  (
    fundeque_foreach$fwork<a><env>(x, !p_env)
  ) (* end of [val] *)
//
  prval((*returned*)) = fpf (pf)
//
in
  // nothing
end // end of [val]
//
val () = foreach(xs, fopr)
val () = $effmask_wrt(__free($UN.cast2ptr(fopr)))
//
in
  // nothing
end // end of [fundeque_foreach_env]

end // end of [local]

(* ****** ****** *)

local

extern
fun
__free(p: ptr):<!wrt> void = "mac#ATS_MFREE"

extern
fun
rforeach
{a:t0p}{d:nat}{n:nat}
(
  xt: fngtree(a, d, n), fopr: (ftnode(a, d)) -<cloref> void
) :<> void // end of [rforeach]

implement
rforeach
{a}{d}{n}
  (xt, fopr) = let
in
//
case+ xt of
| FTemp() => ()
| FTsing(xn) => fopr(xn)
| FTdeep(pr, m, sf) => let
//
    prval () = ftdigit_prop_szpos(pr)
    prval () = ftdigit_prop_szpos(sf)
//
    val () =
    ( case+ sf of
      | FTD1(xn1) =>
          fopr(xn1)
      | FTD2(xn1, xn2) =>
          (fopr(xn2); fopr(xn1))
      | FTD3(xn1, xn2, xn3) =>
          (fopr(xn3); fopr(xn2); fopr(xn1))
      | FTD4(xn1, xn2, xn3, xn4) =>
          (fopr(xn4); fopr(xn3); fopr(xn2); fopr(xn1))
    ) : void // end of [val]
    val () = 
    ( case+ m of
      | FTemp() => ()
      | _ (*non-FTemp*) => let
          val
          fopr1 = lam
            (xn_1: ftnode (a, d+1)): void =<cloref> let
          in
            case+ xn_1 of
            | FTN2(xn1, xn2) =>
                (fopr(xn2); fopr(xn1))
            | FTN3(xn1, xn2, xn3) =>
                (fopr(xn3); fopr(xn2); fopr(xn1))
          end // end of [val]
          val () = rforeach(m, fopr1)
          val () = $effmask_wrt(__free($UN.cast2ptr(fopr1)))
        in
          // nothing          
        end // end of [_]
    ) : void // end of [val]
    val () =
    ( case+ pr of
      | FTD1(xn1) =>
          fopr(xn1)
      | FTD2(xn1, xn2) =>
          (fopr(xn2); fopr(xn1))
      | FTD3(xn1, xn2, xn3) =>
          (fopr(xn3); fopr(xn2); fopr(xn1))
      | FTD4(xn1, xn2, xn3, xn4) =>
          (fopr(xn4); fopr(xn3); fopr(xn2); fopr(xn1))
    ) : void // end of [val]
  in
    // nothing
  end // end of [FTdeep]
//
end // end of [rforeach]

in (* in of [local] *)

implement{a}
fundeque_rforeach(xs) = let
  var env: void = () in fundeque_rforeach_env<a><void>(xs, env)
end // end of [fundeque_rforeach]

implement
{a}{env}
fundeque_rforeach_env
  (xs, env) = let
//
typedef
ftnode0 = ftnode(a, 0)
//
prval () = fngtree_prop1_sznat(xs)
//
val p_env = addr@(env)
//
val
fopr = lam
(
xn: ftnode0
) : void =<cloref> let
//
  val+FTN1 (x) = xn
//
  val (
    pf, fpf | p_env
  ) = $UN.ptr_vtake{env}(p_env)
//
  val () =
  $effmask_all
  (
    fundeque_rforeach$fwork<a><env>(x, !p_env)
  ) (* end of [val] *)
//
  prval ((*returned*)) = fpf(pf)
//
in
  // nothing
end // end of [val]
//
val () = rforeach(xs, fopr)
val () = $effmask_wrt(__free($UN.cast2ptr(fopr)))
//
in
  // nothing
end // end of [fundeque_rforeach_env]

end // end of [local]

(* ****** ****** *)

(* end of [fundeque_fngtree.dats] *)
