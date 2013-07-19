(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
(*
**
** A functional concatenable deque implementation based on fingertrees.
** Please see the JFP paper by Hinze and Paterson on fingertrees for more
** details on this interesting data structure.
**
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Contributed by Robbie Harwood (rharwood AT cs DOT bu DOT edu)
**
** Time: November, 2010
**
*)
(* ****** ****** *)
(*
** Ported to ATS2 by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: May, 2012
*)
(* ****** ****** *)
//
// License: LGPL 3.0 (available at http://www.gnu.org/licenses/lgpl.txt)
//
(* ****** ****** *)

#define
ATS_DYNLOADFLAG 0 // no static loading at run-time

(* ****** ****** *)
//
staload INT = "prelude/DATS/integer.dats"
//
(* ****** ****** *)

staload "libats/SATS/fundeque_fingertree.sats"

(* ****** ****** *)

datatype
ftnode
(
  a:t@ype+, int(*dpth*), int(*size*)
) = (* ftnode *)
  | FTN1 (a, 0, 1) of (a) // singleton
  | {d:nat} {n1,n2:nat}
    FTN2 (a, d+1, n1+n2) of
    (
      ftnode (a, d, n1), ftnode (a, d, n2)
    ) // end of [FTN2]
  | {d:nat} {n1,n2,n3:nat}
    FTN3 (a, d+1, n1+n2+n3) of
    (
      ftnode (a, d, n1), ftnode (a, d, n2), ftnode (a, d, n3)
    ) // end of [FTN3]
// end of [ftnode] // end of [datatype]

(* ****** ****** *)

datatype
ftdigit
(
  a:t@ype+, int(*dpth*), int(*size*)
) = (* ftdigit *)
  | {d:nat} {n:nat}
    FTD1 (a, d, n) of ftnode (a, d, n)
  | {d:nat} {n1,n2:nat}
    FTD2 (a, d, n1+n2) of (
      ftnode (a, d, n1), ftnode (a, d, n2)
    ) // end of [FTD2]
  | {d:nat} {n1,n2,n3:nat}
    FTD3 (a, d, n1+n2+n3) of (
      ftnode (a, d, n1), ftnode (a, d, n2), ftnode (a, d, n3)
    ) // end of [FTD3]
  | {d:nat} {n1,n2,n3,n4:nat}
    FTD4 (a, d, n1+n2+n3+n4) of (
      ftnode (a, d, n1), ftnode (a, d, n2), ftnode (a, d, n3), ftnode (a, d, n4)
    ) // end of [FTD4]
// end of [ftdigit]

(* ****** ****** *)

datatype
fingertree
(
  a:t@ype, int(*d*), int(*n*)
) = (* fingertree *)
  | {d:nat}
    FTemp (a, d, 0) of ()
  | {d:nat}
    {n:int}
    FTsing (a, d, n) of ftnode (a, d, n)
  | {d:nat}
    {npr,nm,nsf:nat}
    FTdeep (a, d, npr+nm+nsf) of
    (
      ftdigit(a, d, npr), fingertree (a, d+1, nm), ftdigit (a, d, nsf)
    ) // end of [FTdeep]
// end of [fingertree]

(* ****** ****** *)

extern
fun{a:t0p}
fprint_fingertree{d:int}{n:int}
(
  out: FILEref, xt: fingertree (INV(a), d, n)
) : void // end of [fprint_fingertree]

(* ****** ****** *)

local

fun{a:t0p}
fprint_ftnode{d:int}{n:int}
(
  out: FILEref, xn: ftnode (INV(a), d, n)
) : void = let
//
macdef prstr (str) = fprint_string (out, ,(str))
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
fprint_ftdigit{d:int}{n:int}
(
  out: FILEref, xn: ftdigit (INV(a), d, n)
) : void = let
//
macdef prstr (str) = fprint_string (out, ,(str))
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

implement{a}
fprint_fingertree
  (out, xt) = let
//
macdef prstr (str) = fprint_string (out, ,(str))
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
    val () = fprint_fingertree (out, xt2)
    val () = prstr ", "
    val () = fprint_ftdigit (out, xn3)
    val () = prstr ")"
  }
//
end // end of [fprint_fingertree]

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
  | FTN2 (xn1, xn2) => {
      prval () = ftnode_prop_szpos (xn1)
      prval () = ftnode_prop_szpos (xn2)
    } // end of [FTN2]
  | FTN3 (xn1, xn2, xn3) => {
      prval () = ftnode_prop_szpos (xn1)
      prval () = ftnode_prop_szpos (xn2)
      prval () = ftnode_prop_szpos (xn3)
    } // end of [FTN3]
// end of [ftnode_prop_szpos]

(* ****** ****** *)

prfun
ftdigit_prop_szpos
  {a:t0p}
  {d:int}
  {n:int} .<>.
  (xd: ftdigit (a, d, n)): [n > 0] void =
  case+ xd of
  | FTD1 (xn1) => ftnode_prop_szpos (xn1)
  | FTD2 (xn1, _) => ftnode_prop_szpos (xn1)
  | FTD3 (xn1, _, _) => ftnode_prop_szpos (xn1)
  | FTD4 (xn1, _, _, _) => ftnode_prop_szpos (xn1)
// end of [ftdigit_prop_szpos]

(* ****** ****** *)

prfun
fingertree_prop1_sznat
  {a:t0p}
  {d:int}
  {n:int} .<>.
  (xt: fingertree (a, d, n)): [n >= 0] void =
  case+ xt of
  | FTemp () => ()
  | FTsing (xn) => ftnode_prop_szpos (xn)
  | FTdeep (pr, m, sf) => {
      val () = ftdigit_prop_szpos (pr) and () = ftdigit_prop_szpos (sf)
    } // end of [FTdeep]
// end of [fingertree_prop1_sznat]

(* ****** ****** *)

fun
ftnode_size
  {a:t0p}
  {d:int}
  {n:nat} .<n>.
(
  xn: ftnode (a, d, n)
) :<> size_t (n) = let
  #define nsz(x) ftnode_size(x)
in
  case+ xn of
  | FTN1 _ => g1i2u(1)
  | FTN2 (xn1, xn2) => let
      prval () = ftnode_prop_szpos (xn1)
      prval () = ftnode_prop_szpos (xn2)
    in
      nsz (xn1) + nsz (xn2)
    end // end of [FTN2]
  | FTN3 (xn1, xn2, xn3) => let
      prval () = ftnode_prop_szpos (xn1)
      prval () = ftnode_prop_szpos (xn2)
      prval () = ftnode_prop_szpos (xn3)
    in
      nsz (xn1) + nsz (xn2) + nsz (xn3)
    end // endof [FTN3]
end // end of [ftnode_size]

(* ****** ****** *)

fun
ftdigit_size
  {a:t0p}
  {d:int}
  {n:int} .<>.
(
  xd: ftdigit (a, d, n)
) :<> size_t (n) = let
  #define nsz(x) ftnode_size(x)
in
  case+ xd of
  | FTD1 (xn1) => nsz (xn1)
  | FTD2 (xn1, xn2) => nsz (xn1) + nsz (xn2)
  | FTD3 (xn1, xn2, xn3) => nsz (xn1) + nsz (xn2) + nsz (xn3)
  | FTD4 (xn1, xn2, xn3, xn4) => nsz (xn1) + nsz (xn2) + nsz (xn3) + nsz (xn4)
end // end of [ftdigit_size]

(* ****** ****** *)

fun ftnode2ftdigit
  {a:t0p} {d:pos} {n:int} .<>.
  (xn: ftnode (a, d, n)):<> ftdigit (a, d-1, n) =
  case+ xn of
  | FTN2 (xn1, xn2) => FTD2 (xn1, xn2)
  | FTN3 (xn1, xn2, xn3) => FTD3 (xn1, xn2, xn3)
// end of [ftnode2ftdigit]

(* ****** ****** *)

fun ftdigit2fingertree
  {a:t0p} {d:nat} {n:int} .<>.
  (xd: ftdigit (a, d, n)):<> fingertree (a, d, n) =
  case+ xd of
  | FTD1 (xn1) => FTsing (xn1)
  | FTD2 (xn1, xn2) => FTdeep (FTD1 (xn1), FTemp(), FTD1 (xn2))
  | FTD3 (xn1, xn2, xn3) => FTdeep (FTD2 (xn1, xn2), FTemp(), FTD1 (xn3))
  | FTD4 (xn1, xn2, xn3, xn4) => FTdeep (FTD2 (xn1, xn2), FTemp(), FTD2 (xn3, xn4))
// end of [ftdigit2fingertree]

(* ****** ****** *)

extern
fun fingertree_cons
  {a:t0p}{d:nat}{n1,n2:int} (
  xn: ftnode (a, d, n1), xt: fingertree (a, d, n2)
) :<> fingertree (a, d, n1+n2) // end of [fingertree_cons]

implement
fingertree_cons{a}
  (xn, xt) = cons (xn, xt) where
{
//
fun cons {d:nat}
  {n1,n2:int | n2 >= 0} .<n2>. (
  xn: ftnode (a, d, n1), xt: fingertree (a, d, n2)
) :<> fingertree (a, d, n1+n2) = let
  prval () = ftnode_prop_szpos (xn) in
  case+ xt of
  | FTemp () => FTsing (xn)
  | FTsing (xn1) => let
      prval () = ftnode_prop_szpos (xn1)
    in
      FTdeep (FTD1(xn), FTemp(), FTD1(xn1))
    end // end [FTsing]
  | FTdeep (pr, m, sf) => (case+ pr of
    | FTD1 (xn1) => FTdeep (FTD2 (xn, xn1), m, sf) 
    | FTD2 (xn1, xn2) => FTdeep (FTD3 (xn, xn1, xn2), m, sf)
    | FTD3 (xn1, xn2, xn3) => FTdeep (FTD4 (xn, xn1, xn2, xn3), m, sf)
    | FTD4 (xn1, xn2, xn3, xn4) => let
        val pr = FTD2 (xn, xn1)
//
        prval () = ftdigit_prop_szpos (sf)
        prval () = fingertree_prop1_sznat (m)
//
        val m = cons (FTN3 (xn2, xn3, xn4), m)
      in
        FTdeep (pr, m, sf)
      end // end of [FTD4]
    ) // end of [FTdeep]
end // end of [cons]
//
prval () = fingertree_prop1_sznat (xt)
//
} // end of [fingertree_cons]

(* ****** ****** *)

extern
fun fingertree_uncons
  {a:t0p}{d:nat}{n:pos} (
  xt: fingertree (a, d, n), r: &ptr? >> ftnode (a, d, n1)
) :<!wrt> #[n1:nat] fingertree (a, d, n-n1)
// end of [fingertree_uncons]

implement
fingertree_uncons{a}
  (xt, r) = uncons (xt, r) where
{
//
fun uncons
  {d:nat}{n:pos} .<n>. (
  xt: fingertree (a, d, n)
, r: &ptr? >> ftnode (a, d, n1)
) :<!wrt> #[n1:nat | n1 <= n] fingertree (a, d, n-n1) =
  case+ xt of
  | FTsing (xn) => let
      val () = r := xn in FTemp ()
    end // end of [Single]
  | FTdeep (pr, m, sf) => (case+ pr of
    | FTD1 (xn) => let
        val () = r := xn
        prval () = ftdigit_prop_szpos (pr)
        prval () = ftdigit_prop_szpos (sf)
      in
        case+ m of
        | FTemp () => ftdigit2fingertree (sf)
        | FTsing (xn1) => FTdeep (ftnode2ftdigit (xn1), FTemp (), sf)
        | FTdeep (pr1, m1, sf1) => let
            var r1: ptr?
            prval () = ftdigit_prop_szpos (pr1)
            prval () = fingertree_prop1_sznat (m1)
            prval () = ftdigit_prop_szpos (sf1)
            val m = uncons (m, r1)
          in
            FTdeep (ftnode2ftdigit (r1), m, sf)
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
} // end of [fingertree_uncons]

(* ****** ****** *)

extern
fun fingertree_get_atbeg
  {a:t0p}{d:nat}{n:pos}
  (xt: fingertree (a, d, n)) :<> [n1:nat] ftnode (a, d, n1)
// end of [fingertree_get_atbeg]

implement
fingertree_get_atbeg
  (xt) = (case+ xt of
  | FTsing (xn) => xn
  | FTdeep (pr, m, sf) => (
    case+ pr of
    | FTD1 (xn) => xn
    | FTD2 (xn, xn1) => xn
    | FTD3 (xn, xn1, xn2) => xn
    | FTD4 (xn, xn1, xn2, xn3) => xn
    ) // end of [FTdeep]
) // end of [fingertree_get_atbeg]

(* ****** ****** *)

extern
fun fingertree_snoc
  {a:t0p}{d:nat}{n1,n2:int} (
  xt: fingertree (a, d, n2), xn: ftnode (a, d, n1)
) :<> fingertree (a, d, n1+n2) // end of [fingertree_snoc]

implement
fingertree_snoc{a}
  (xt, xn) = snoc (xt, xn) where
{
//
fun snoc {d:nat}
  {n1,n2:int | n2 >= 0} .<n2>. (
  xt: fingertree (a, d, n2), xn: ftnode (a, d, n1)
) :<> fingertree (a, d, n1+n2) = let
  prval () = ftnode_prop_szpos (xn) in
  case+ xt of
  | FTemp () => FTsing (xn)
  | FTsing (xn1) => let
      prval () = ftnode_prop_szpos (xn1)
    in
      FTdeep (FTD1(xn1), FTemp(), FTD1(xn))
    end // end [FTsing]
  | FTdeep (pr, m, sf) => (case+ sf of
    | FTD1 (xn1) => FTdeep (pr, m, FTD2 (xn1, xn))
    | FTD2 (xn1, xn2) => FTdeep (pr, m, FTD3 (xn1, xn2, xn))
    | FTD3 (xn1, xn2, xn3) => FTdeep (pr, m, FTD4 (xn1, xn2, xn3, xn))
    | FTD4 (xn1, xn2, xn3, xn4) => let
        val sf = FTD2 (xn4, xn)
//
        prval () = ftdigit_prop_szpos (pr)
        prval () = fingertree_prop1_sznat (m)
//
        val m = snoc (m, FTN3 (xn1, xn2, xn3))
      in
        FTdeep (pr, m, sf)
      end // end of [FTD4]
    ) // end of [FTdeep]
end // end of [snoc]
//
prval () = fingertree_prop1_sznat (xt)
//
} // end of [fingertree_snoc]

(* ****** ****** *)

extern
fun fingertree_unsnoc
  {a:t0p}{d:nat}{n:pos} (
  xt: fingertree (a, d, n), r: &ptr? >> ftnode (a, d, n1)
) :<!wrt> #[n1:nat] fingertree (a, d, n-n1)
// end of [fingertree_unsnoc]

implement
fingertree_unsnoc{a}
  (xt, r) = unsnoc (xt, r) where
{
//
fun unsnoc
  {d:nat}{n:pos} .<n>. (
  xt: fingertree (a, d, n)
, r: &ptr? >> ftnode (a, d, n1)
) :<!wrt> #[n1:nat | n1 <= n] fingertree (a, d, n-n1) =
  case+ xt of
  | FTsing (xn) => let
      val () = r := xn in FTemp ()
    end // end of [Single]
  | FTdeep (pr, m, sf) => (case+ sf of
    | FTD1 (xn) => let
        val () = r := xn
        prval () = ftdigit_prop_szpos (pr)
        prval () = ftdigit_prop_szpos (sf)
      in
        case+ m of
        | FTemp () => ftdigit2fingertree (pr)
        | FTsing (xn1) => FTdeep (pr, FTemp (), ftnode2ftdigit (xn1))
        | FTdeep (pr1, m1, sf1) => let
            var r1: ptr?
            prval () = ftdigit_prop_szpos (pr1)
            prval () = fingertree_prop1_sznat (m1)
            prval () = ftdigit_prop_szpos (sf1)
            val m = unsnoc (m, r1)
          in
            FTdeep (pr, m, ftnode2ftdigit (r1))
          end // end of [_]
      end // end of [FTD1]
    | FTD2 (xn1, xn) => let
        val () = r := xn in FTdeep (pr, m, FTD1 (xn1))
      end // end of [FTD2]
    | FTD3 (xn1, xn2, xn) => let
        val () = r := xn in FTdeep (pr, m, FTD2 (xn1, xn2))
      end // end of [FTD3]
    | FTD4 (xn1, xn2, xn3, xn) => let
        val () = r := xn in FTdeep (pr, m, FTD3 (xn1, xn2, xn3))
      end // end of [FTD4]
    ) // end of [FTdeep]
// end of [unsnoc]
} // end of [fingertree_unsnoc]

(* ****** ****** *)

extern
fun fingertree_get_atend
  {a:t0p}{d:nat}{n:pos}
  (xt: fingertree (a, d, n)) :<> [n1:nat] ftnode (a, d, n1)
// end of [fingertree_get_atend]

implement
fingertree_get_atend
  (xt) = (case+ xt of
  | FTsing (xn) => xn
  | FTdeep (pr, m, sf) => (
    case+ sf of
    | FTD1 (xn) => xn
    | FTD2 (xn1, xn) => xn
    | FTD3 (xn1, xn2, xn) => xn
    | FTD4 (xn1, xn2, xn3, xn) => xn
    ) // end of [FTdeep]
) // end of [fingertree_get_atend]

(* ****** ****** *)

assume
deque_t0ype_int_type
  (a:t0p, n:int) = fingertree (a, 0, n)
// end of [deque_t0ype_int_type]

(* ****** ****** *)

primplmnt
lemma_deque_param
  (xs) = fingertree_prop1_sznat (xs)
// end of [lemma_deque_param]

(* ****** ****** *)

implement{}
fundeque_nil () = FTemp ((*void*))

(* ****** ****** *)

implement{a}
fundeque_cons (x0, xs) =
  fingertree_cons (FTN1{a}(x0), xs)
// end of [fundeque_cons]

implement{a}
fundeque_uncons
  (xs) = x0 where
{
  var xn: ptr?
  val () = xs := fingertree_uncons (xs, xn)
  val+ FTN1 (x0) = xn
} // end of [fundeque_uncons]

(* ****** ****** *)

implement{a}
fundeque_snoc (xs, xn) =
  fingertree_snoc (xs, FTN1{a}(xn))
// end of [fundeque_snoc]

implement{a}
fundeque_unsnoc
  (xs) = x0 where
{
  var xn: ptr?
  val () = xs := fingertree_unsnoc (xs, xn)
  val+ FTN1 (x0) = xn
} // end of [fundeque_unsnoc]

(* ****** ****** *)

implement{}
fundeque_is_nil (xs) =
  case+ xs of
  | FTemp () => true
  | FTsing (xn) => let
      prval () = ftnode_prop_szpos (xn) in false
    end // end of [FTsing]
  | FTdeep (pr, _, _) => let
      prval () = ftdigit_prop_szpos (pr) in false
    end // end of [FTdeep]
// end of [fundeque_is_nil]

implement{}
fundeque_is_cons (xs) = let
  prval () = lemma_deque_param (xs) in ~fundeque_is_nil<> (xs)
end // end of [fundeque_is_cons]

(* ****** ****** *)

implement
fundeque_size
  {a} (xs) = let
//
fun size
  {d:int}{n:nat} .<n>.
(
  xt: fingertree (a, d, n)
) :<> size_t (n) = let
in
//
case+ xt of
| FTemp () => g1i2u(0)
| FTsing (xn) => ftnode_size (xn)
| FTdeep (pr, m, sf) => let
    prval () = ftdigit_prop_szpos (pr)
  in
    ftdigit_size (pr) + size (m) + ftdigit_size (sf)
  end // end of [FTdeep]
//
end (* end of [size] *)
//
prval () = lemma_deque_param (xs)
//
in
  size (xs)
end // end of [fundeque_size]

(* ****** ****** *)

implement{a}
fundeque_get_atbeg (xs) = let
  val+ FTN1 (x) = fingertree_get_atbeg{a}(xs) in (x)
end // end of [fundeque_get_atbeg]

implement{a}
fundeque_get_atend (xs) = let
  val+ FTN1 (x) = fingertree_get_atend{a}(xs) in (x)
end // end of [fundeque_get_atend]

(* ****** ****** *)

local

symintr ++
infix (+) ++
overload ++ with fingertree_cons
overload ++ with fingertree_snoc

fun ftapp0
  {a:t0p}
  {d:int}
  {n1,n2:nat} (
  xt1: fingertree (a, d, n1)
, xt2: fingertree (a, d, n2)
) : fingertree (a, d, n1+n2) =
  case+ (xt1, xt2) of
  | (FTemp (), _) => xt2
  | (_, FTemp ()) => xt1
  | (FTsing xn1, _) => xn1 ++ xt2
  | (_, FTsing xn2) => xt1 ++ xn2
  | (FTdeep (pr1, m1, sf1),
     FTdeep (pr2, m2, sf2)) =>
      FTdeep (pr1, ftadd0 (m1, sf1, pr2, m2), sf2)
// end of [ftapp0]

and ftadd0
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat} (
  m1: fingertree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, pr2: ftdigit (a, d, npr2)
, m2: fingertree (a, d+1, nm2)
) : fingertree (a, d+1, nm1+nsf1+npr2+nm2) =
  case+ sf1 of
  | FTD1 (xn1) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp1 (m1, FTN2 (xn1, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp1 (m1, FTN3 (xn1, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp2 (m1, FTN2 (xn1, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp2 (m1, FTN3 (xn1, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD1]
  | FTD2 (xn1, xn2) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp1 (m1, FTN3 (xn1, xn2, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN2 (xn1, xn2), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp2 (m1, FTN3 (xn1, xn2, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp2 (m1, FTN3 (xn1, xn2, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD2]
  | FTD3 (xn1, xn2, xn3) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN2 (xn1, xn2), FTN2 (xn3, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn_1, xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD3]
  | FTD4 (xn1, xn2, xn3, xn4) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xn4, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xn4, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD4]
// end of [ftadd0]

and ftapp1
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na:nat} (
  xt1: fingertree (a, d, n1)
, xna: ftnode (a, d, na)
, xt2: fingertree (a, d, n2)
) : fingertree (a, d, n1+na+n2) =
  case+ (xt1, xt2) of
  | (FTemp (), _) => xna ++ xt2
  | (_, FTemp ()) => xt1 ++ xna
  | (FTsing xn1, _) => xn1 ++ (xna ++ xt2)
  | (_, FTsing xn2) => (xt1 ++ xna) ++ xn2
  | (FTdeep (pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
      FTdeep (pr1, ftadd1 (m1, sf1, xna, pr2, m2), sf2)
// end of [ftapp1]

and ftadd1
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na:nat} (
  m1: fingertree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, pr2: ftdigit (a, d, npr2)
, m2: fingertree (a, d+1, nm2)
) : fingertree (a, d+1, nm1+nsf1+na+npr2+nm2) =
  case+ sf1 of
  | FTD1 (xn1) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp1 (m1, FTN3 (xn1, xna, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN2 (xn1, xna), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp2 (m1, FTN3 (xn1, xna, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp2 (m1, FTN3 (xn1, xna, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD1]
  | FTD2 (xn1, xn2) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN2 (xn1, xn2), FTN2 (xna, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xn2, xna), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp2 (m1, FTN3 (xn1, xn2, xna), FTN3 (xn_1, xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN2 (xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD2]
  | FTD3 (xn1, xn2, xn3) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xna, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xna, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD3]
  | FTD4 (xn1, xn2, xn3, xn4) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xn4, xna), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD4]
// end of [ftadd1]

and ftapp2
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na,nb:nat} (
  xt1: fingertree (a, d, n1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xt2: fingertree (a, d, n2)
) : fingertree (a, d, n1+na+nb+n2) =
  case+ (xt1, xt2) of
  | (FTemp (), _) => xna ++ (xnb ++ xt2)
  | (_, FTemp ()) => (xt1 ++ xna) ++ xnb
  | (FTsing xn1, _) => xn1 ++ (xna ++ (xnb ++ xt2))
  | (_, FTsing xn2) => ((xt1 ++ xna) ++ xnb) ++ xn2
  | (FTdeep (pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
      FTdeep (pr1, ftadd2 (m1, sf1, xna, xnb, pr2, m2), sf2)
// end of [ftapp2]

and ftadd2
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na,nb:nat} (
  m1: fingertree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, pr2: ftdigit (a, d, npr2)
, m2: fingertree (a, d+1, nm2)
) : fingertree (a, d+1, nm1+nsf1+na+nb+npr2+nm2) =
  case+ sf1 of
  | FTD1 (xn1) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN2 (xn1, xna), FTN2 (xnb, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xna, xnb), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp2 (m1, FTN3 (xn1, xna, xnb), FTN3 (xn_1, xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xna, xnb), FTN2 (xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD1]
  | FTD2 (xn1, xn2) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xn2, xna), FTN2 (xnb, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN2 (xnb, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD2]
  | FTD3 (xn1, xn2, xn3) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xna, xnb), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD3]
  | FTD4 (xn1, xn2, xn3, xn4) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xn4, xna), FTN2 (xnb, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN3 (xn_1, xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN2 (xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD4]
// end of [ftadd2]

and ftapp3
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na,nb,nc:nat} (
  xt1: fingertree (a, d, n1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, xt2: fingertree (a, d, n2)
) : fingertree (a, d, n1+na+nb+nc+n2) =
  case+ (xt1, xt2) of
  | (FTemp (), _) => xna ++ (xnb ++ (xnc ++ xt2))
  | (_, FTemp ()) => ((xt1 ++ xna) ++ xnb) ++ xnc
  | (FTsing xn1, _) => xn1 ++ (xna ++ (xnb ++ (xnc ++ xt2)))
  | (_, FTsing xn2) => (((xt1 ++ xna) ++ xnb) ++ xnc) ++ xn2
  | (FTdeep (pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
      FTdeep (pr1, ftadd3 (m1, sf1, xna, xnb, xnc, pr2, m2), sf2)
// end of [ftapp3]

and ftadd3
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na,nb,nc:nat} (
  m1: fingertree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, pr2: ftdigit (a, d, npr2)
, m2: fingertree (a, d+1, nm2)
) : fingertree (a, d+1, nm1+nsf1+na+nb+nc+npr2+nm2) =
  case+ sf1 of
  | FTD1 (xn1) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xna, xnb), FTN2 (xnc, xn_1), m2)
    | FTD2 (xn_1, xn_2) => ftapp2 (m1, FTN3 (xn1, xna, xnb), FTN3 (xnc, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xna, xnb), FTN2 (xnc, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xna, xnb), FTN3 (xnc, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD1]
  | FTD2 (xn1, xn2) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xnc, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN2 (xnb, xnc), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xnc, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xnc, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD2]
  | FTD3 (xn1, xn2, xn3) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN2 (xna, xnb), FTN2 (xnc, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN3 (xn_1, xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN2 (xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD3]
  | FTD4 (xn1, xn2, xn3, xn4) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN2 (xnc, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN3 (xnc, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN2 (xnc, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN3 (xnc, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD4]
// end of [ftadd3]

and ftapp4
  {a:t0p}
  {d:int}
  {n1,n2:nat}
  {na,nb,nc,nd:nat} (
  xt1: fingertree (a, d, n1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, xnd: ftnode (a, d, nd)
, xt2: fingertree (a, d, n2)
) : fingertree (a, d, n1+na+nb+nc+nd+n2) =
  case+ (xt1, xt2) of
  | (FTemp (), _) => xna ++ (xnb ++ (xnc ++ (xnd ++ xt2)))
  | (_, FTemp ()) => (((xt1 ++ xna) ++ xnb) ++ xnc) ++ xnd
  | (FTsing xn1, _) => xn1 ++ (xna ++ (xnb ++ (xnc ++ (xnd ++ xt2))))
  | (_, FTsing xn2) => ((((xt1 ++ xna) ++ xnb) ++ xnc) ++ xnd) ++ xn2
  | (FTdeep (pr1, m1, sf1), FTdeep (pr2, m2, sf2)) =>
      FTdeep (pr1, ftadd4 (m1, sf1, xna, xnb, xnc, xnd, pr2, m2), sf2)
// end of [ftapp4]

and ftadd4
  {a:t0p}
  {d:int}
  {nm1,nm2:nat}
  {nsf1,npr2:nat}
  {na,nb,nc,nd:nat} (
  m1: fingertree (a, d+1, nm1)
, sf1: ftdigit (a, d, nsf1)
, xna: ftnode (a, d, na)
, xnb: ftnode (a, d, nb)
, xnc: ftnode (a, d, nc)
, xnd: ftnode (a, d, nd)
, pr2: ftdigit (a, d, npr2)
, m2: fingertree (a, d+1, nm2)
) : fingertree (a, d+1, nm1+nsf1+na+nb+nc+nd+npr2+nm2) =
  case+ sf1 of
  | FTD1 (xn1) => (case+ pr2 of
    | FTD1 (xn_1) => ftapp2 (m1, FTN3 (xn1, xna, xnb), FTN3 (xnc, xnd, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xna, xnb), FTN2 (xnc, xnd), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xna, xnb), FTN3 (xnc, xnd, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp3 (m1, FTN3 (xn1, xna, xnb), FTN3 (xnc, xnd, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD1]
  | FTD2 (xn1, xn2) => (case+ pr2 of
    | FTD1 (xn_1) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN2 (xnb, xnc), FTN2 (xnd, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xnc, xnd), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xnc, xnd), FTN3 (xn_1, xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xna), FTN3 (xnb, xnc, xnd), FTN2 (xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD2]
  | FTD3 (xn1, xn2, xn3) => (case+ pr2 of
    | FTD1 (xn_1) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN2 (xnd, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN3 (xnd, xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN2 (xnd, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xna, xnb, xnc), FTN3 (xnd, xn_1, xn_2), FTN2 (xn_3, xn_4), m2)
    ) // end of [FTD3]
  | FTD4 (xn1, xn2, xn3, xn4) => (case+ pr2 of
    | FTD1 (xn_1) =>
        ftapp3 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN3 (xnc, xnd, xn_1), m2)
    | FTD2 (xn_1, xn_2) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN2 (xnc, xnd), FTN2 (xn_1, xn_2), m2)
    | FTD3 (xn_1, xn_2, xn_3) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN3 (xnc, xnd, xn_1), FTN2 (xn_2, xn_3), m2)
    | FTD4 (xn_1, xn_2, xn_3, xn_4) =>
        ftapp4 (m1, FTN3 (xn1, xn2, xn3), FTN3 (xn4, xna, xnb), FTN3 (xnc, xnd, xn_1), FTN3 (xn_2, xn_3, xn_4), m2)
    ) // end of [FTD4]
// end of [ftadd4]

in (* in of [local] *)

implement
fundeque_append
  (xs1, xs2) = let
//
prval () = lemma_deque_param (xs1)
prval () = lemma_deque_param (xs2)
//
in
  $effmask_all (ftapp0 (xs1, xs2))
end // end of [fundeque_append]

end // end of [local]

(* ****** ****** *)

implement{a}
fprint_fundeque
  (out, xs) = fprint_fingertree<a> (out, xs)
// end of [fprint_fundeque]

(* ****** ****** *)

typedef ftnode
  (a:t0p, d:int) = [n:int] ftnode (a, d, n)
// end of [ftnode]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

local

extern fun __free (p: ptr):<!wrt> void = "mac#ats_free_gc"

fun foreach
  {a:t0p}
  {d:nat}
  {n:nat} .<n>. (
  xt: fingertree (a, d, n)
, f: ftnode (a, d) -<cloref> void
) :<> void = let
in
//
case+ xt of
| FTemp () => ()
| FTsing (xn) => f (xn)
| FTdeep (pr, m, sf) => let
//
    prval () = ftdigit_prop_szpos (pr)
    prval () = ftdigit_prop_szpos (sf)
//
    val () = (
      case+ pr of
      | FTD1 (xn1) => f (xn1)
      | FTD2 (xn1, xn2) => (f (xn1); f (xn2))
      | FTD3 (xn1, xn2, xn3) => (f (xn1); f (xn2); f (xn3))
      | FTD4 (xn1, xn2, xn3, xn4) =>
          (f (xn1); f (xn2); f (xn3); f (xn4))
    ) : void // end of [val]
    val () = (
      case+ m of
      | FTemp () => ()
      | _ => let
          val f1 = lam
            (xn_1: ftnode (a, d+1)): void =<cloref> let
          in
            case+ xn_1 of
            | FTN2 (xn1, xn2) => (f (xn1); f (xn2))
            | FTN3 (xn1, xn2, xn3) => (f (xn1); f (xn2); f (xn3))
          end // end of [lam] // end of [val]
          val () = foreach (m, f1)
          val () = $effmask_wrt (__free ($UN.cast2ptr(f1)))
        in
          // nothing          
        end // end of [_]
    ) : void // end of [val]
    val () = (case+ sf of
      | FTD1 (xn1) => f (xn1)
      | FTD2 (xn1, xn2) => (f (xn1); f (xn2))
      | FTD3 (xn1, xn2, xn3) => (f (xn1); f (xn2); f (xn3))
      | FTD4 (xn1, xn2, xn3, xn4) =>
          (f (xn1); f (xn2); f (xn3); f (xn4))
    ) : void // end of [val]
  in
    // nothing
  end // end of [FTdeep]
end // end of [foreach]

in (* in of [local] *)

implement{a}
fundeque_foreach (xs) = let
  var env: void = () in fundeque_foreach_env (xs, env)
end // end of [fundeque_foreach]

implement{a}{env}
fundeque_foreach_env
  (xs, env) = let
//
prval () = fingertree_prop1_sznat (xs)
//
typedef ftnode = ftnode (a, 0)
//
val p_env = addr@ (env)
//
val f = lam
  (xn: ftnode): void =<cloref> let
  val+ FTN1 (x) = xn
  val (pf, fpf | p_env) = $UN.ptr_vtake{env}(p_env)
  val () = $effmask_all (fundeque_foreach$fwork<a> (x, !p_env))
  prval () = fpf (pf)
in
  // nothing
end // end of [val]
//
val () = foreach (xs, f)
prval () = $effmask_wrt (__free ($UN.cast2ptr(f)))
//
in
  // nothing
end // end of [fundeque_foreach_env]

end // end of [local]

(* ****** ****** *)

local

extern fun __free (p: ptr):<!wrt> void = "mac#ats_free_gc"

fun rforeach
  {a:t0p}
  {d:nat}
  {n:nat} .<n>. (
  xt: fingertree (a, d, n)
, f: (ftnode (a, d)) -<cloref> void
) :<> void = let
in
//
case+ xt of
| FTemp () => ()
| FTsing (xn) => f (xn)
| FTdeep (pr, m, sf) => let
//
    prval () = ftdigit_prop_szpos (pr)
    prval () = ftdigit_prop_szpos (sf)
//
    val () = (case+ sf of
      | FTD1 (xn1) => f (xn1)
      | FTD2 (xn1, xn2) => (f (xn2); f (xn1))
      | FTD3 (xn1, xn2, xn3) => (f (xn3); f (xn2); f (xn1))
      | FTD4 (xn1, xn2, xn3, xn4) =>
          (f (xn4); f (xn3); f (xn2); f (xn1))
    ) : void // end of [val]
    val () = (case+ m of
      | FTemp () => ()
      | _ => let
          val f1 = lam
            (xn_1: ftnode (a, d+1)): void =<cloref> let
          in
            case+ xn_1 of
            | FTN2 (xn1, xn2) => (f (xn2); f (xn1))
            | FTN3 (xn1, xn2, xn3) => (f (xn3); f (xn2); f (xn1))
          end // end of [val]
          val () = rforeach (m, f1)
          val () = $effmask_wrt (__free ($UN.cast2ptr(f1)))
        in
          // nothing          
        end // end of [_]
    ) : void // end of [val]
    val () = (case+ pr of
      | FTD1 (xn1) => f (xn1)
      | FTD2 (xn1, xn2) => (f (xn2); f (xn1))
      | FTD3 (xn1, xn2, xn3) => (f (xn3); f (xn2); f (xn1))
      | FTD4 (xn1, xn2, xn3, xn4) =>
          (f (xn4); f (xn3); f (xn2); f (xn1))
    ) : void // end of [val]
  in
    // nothing
  end // end of [FTdeep]
//
end // end of [rforeach]

in (* in of [local] *)

implement{a}
fundeque_rforeach (xs) = let
  var env: void = () in fundeque_rforeach_env (xs, env)
end // end of [fundeque_rforeach]

implement{a}{env}
fundeque_rforeach_env
  (xs, env) = let
//
prval () = fingertree_prop1_sznat (xs)
//
typedef ftnode = ftnode (a, 0)
//
val p_env = addr@ (env)
//
val f = lam
  (xn: ftnode): void =<cloref> let
  val+ FTN1 (x) = xn
  val (pf, fpf | p_env) = $UN.ptr_vtake{env}(p_env)
  val () = $effmask_all (fundeque_rforeach$fwork<a> (x, !p_env))
  prval () = fpf (pf)
in
  // nothing
end // end of [val]
//
val () = rforeach (xs, f)
prval () = $effmask_wrt (__free ($UN.cast2ptr(f)))
//
in
  // nothing
end // end of [fundeque_rforeach_env]

end // end of [local]

(* ****** ****** *)

(* end of [fundeque_fingertree.dats] *)
