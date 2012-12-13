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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: October, 2010
//
(* ****** ****** *)
//
// HX: reasoning about integer sequences
//
(* ****** ****** *)
//
// HX-2012-12: starting to implement proofs
//
(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats"

(* ****** ****** *)

(*
prfun ilisteq_elim
  {xs1,xs2:ilist} (pf: ilisteq (xs1, xs2)): ILISTEQ (xs1, xs2)
// end of [ilisteq_elim]
*)
primplmnt
ilisteq_elim (pf) = let
//
prfun lemma
  {xs1,xs2:ilist} .<xs1>.
  (pf: ilisteq (xs1, xs2)): ILISTEQ (xs1, xs2) = let
in
  case+ pf of
  | ilisteq_cons (pf) => let
      prval ILISTEQ () = lemma (pf) in ILISTEQ ()
    end // end of [ILISTEQ_cons]
  | ilisteq_nil () => ILISTEQ ()
end // end of [lemma]
//
in
  lemma (pf)
end // end of [ilisteq_elim]

(* ****** ****** *)

(*
prfun length_istot {xs:ilist} (): [n:nat] LENGTH (xs, n)
*)
primplmnt
length_istot {xs} () = let
//
prfun lemma
  {xs:ilist} .<xs>. (): [n:nat] LENGTH (xs, n) = (
  scase xs of
  | ilist_cons (x, xs) => LENGTHcons (lemma {xs} ()) | ilist_nil () => LENGTHnil ()
) // end of [lemma]
//
in
  lemma {xs} ()
end // end of [length_istot]

(* ****** ****** *)

(*
prfun length_isfun {xs:ilist} {n1,n2:int}
  (pf1: LENGTH (xs, n1), pf2: LENGTH (xs, n2)): [n1==n2] void
// end of [length_isfun]
*)
primplmnt
length_isfun {xs} (pf1, pf2) = let
//
prfun lemma
  {xs:ilist} {n1,n2:int} .<xs>. (
  pf1: LENGTH (xs, n1), pf2: LENGTH (xs, n2)
) : [n1==n2] void = let
in
//
case+ (pf1, pf2) of
| (LENGTHcons (pf1),
   LENGTHcons (pf2)) => lemma (pf1, pf2)
| (LENGTHnil (), LENGTHnil ()) => ()
//
end // end of [length_isfun]
//
in
  lemma (pf1, pf2)
end // end of [length_isfun]

(* ****** ****** *)

(*
prfun length_isnat
  {xs:ilist} {n:int} (pf: LENGTH (xs, n)): [n>=0] void
// end of [length_isnat]
*)
primplmnt
length_isnat (pf) = (
  case+ pf of LENGTHcons _ => () | LENGTHnil () => ()
) // end of [length_isnat]

(* ****** ****** *)

(*
prfun lemma_snoc_length
  {xs:ilist} {x:int} {xsx:ilist} {n:nat}
  (pf1: SNOC (xs, x, xsx), pf2: LENGTH (xs, n)): LENGTH (xsx, n+1)
// end of [lemma_snoc_length]
*)
primplmnt
lemma_snoc_length
  (pf1, pf2) = let
//
prfun lemma
  {xs:ilist}
  {x:int}
  {xsx:ilist}
  {n:nat} .<xs>. (
  pf1: SNOC (xs, x, xsx), pf2: LENGTH (xs, n)
) : LENGTH (xsx, n+1) = let
in
//
case+ pf1 of
| SNOCnil () => let
    prval LENGTHnil () = pf2 in LENGTHcons (LENGTHnil ())
  end // end of [SNOCnil]
| SNOCcons (pf1) => let
    prval LENGTHcons (pf2) = pf2 in LENGTHcons (lemma (pf1, pf2))
  end // end of [SNOCcons]
//
end // end of [lemma]
//
in
  lemma (pf1, pf2)
end // end of [lemma_snoc_length]

(* ****** ****** *)

primplmnt
append_unit_left () = APPENDnil ()

primplmnt
append_unit_right {xs} () = let
//
prfun lemma
  {xs:ilist} .<xs>. (
) : APPEND (xs, ilist_nil, xs) =
  scase xs of
  | ilist_cons (x, xs) => APPENDcons (lemma {xs} ())
  | ilist_nil () => APPENDnil ()
//
in
  lemma {xs} ()
end // end of [append_unit_right]

(* ****** ****** *)

(*
prfun
lemma_append_length
  {xs1,xs2:ilist}
  {xs:ilist}
  {n1,n2:int} (
  pf: APPEND (xs1, xs2, xs), pf1len: LENGTH (xs1, n1), pf2len: LENGTH (xs2, n2)
) : LENGTH (xs, n1+n2) // end of [lemma_append_length]
*)
primplmnt
lemma_append_length
  (pf, pf1len, pf2len) = let
//
prfun lemma
  {xs1,xs2:ilist}
  {xs:ilist}
  {n1,n2:nat} .<xs1>. (
  pf: APPEND (xs1, xs2, xs), pf1len: LENGTH (xs1, n1), pf2len: LENGTH (xs2, n2)
) : LENGTH (xs, n1+n2) = let
in
//
case+ pf of
| APPENDnil () => let
    prval LENGTHnil () = pf1len in pf2len
  end // end of [APPENDnil]
| APPENDcons (pf) => let
    prval LENGTHcons (pf1len) = pf1len in LENGTHcons (lemma (pf, pf1len, pf2len))
  end // end of [APPENDcons]
//
end // end of [lemma]
//
prval () = length_isnat (pf1len)
prval () = length_isnat (pf2len)
//
in
  lemma (pf, pf1len, pf2len)
end // end of [lemma_append_length]

(* ****** ****** *)

(*
prfun
lemma_append_snoc
  {xs1:ilist}
  {x:int}
  {xs2:ilist}
  {xs1x:ilist}
  {xs:ilist} (
  pf1: APPEND (xs1, ilist_cons (x, xs2), xs)
, pf2: SNOC (xs1, x, xs1x)
) : APPEND (xs1x, xs2, xs) // end of [lemma_append_snoc]
*)
primplmnt
lemma_append_snoc
  (pf1, pf2) = let
//
prfun
lemma
  {xs1:ilist}
  {x:int}
  {xs2:ilist}
  {xs1x:ilist}
  {xs:ilist} .<xs1>. (
  pf1: APPEND (xs1, ilist_cons (x, xs2), xs)
, pf2: SNOC (xs1, x, xs1x)
) : APPEND (xs1x, xs2, xs) = let
in
//
case+ pf1 of
| APPENDnil () => let
    prval SNOCnil () = pf2 in APPENDcons (APPENDnil)
  end // end of [APPENDnil]
| APPENDcons (pf1) => let
    prval SNOCcons (pf2) = pf2 in APPENDcons (lemma (pf1, pf2))
  end // end of [APPENDcons]
//
end // end of [lemma]
//
in
  lemma (pf1, pf2)
end // end of [lemma_append_snoc]

(* ****** ****** *)

(* end of [ilist_prf.dats] *)
