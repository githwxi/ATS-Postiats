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
prfun
ILISTEQ2_elim
  {xs1,xs2:ilist}
  (pf: ILISTEQ2(xs1, xs2)): ILISTEQ(xs1, xs2)
// end of [ILISTEQ2_elim]
*)
primplmnt
ILISTEQ2_elim (pf) = let
//
prfun lemma
  {xs1,xs2:ilist} .<xs1>.
(
  pf: ILISTEQ2(xs1, xs2)
) : ILISTEQ(xs1, xs2) = let
in
//
case+ pf of
| ILISTEQ2nil() => ILISTEQ()
| ILISTEQ2cons(pf) => let
    prval ILISTEQ () = lemma (pf) in ILISTEQ ()
  end // end of [ILISTEQ_cons]
//
end // end of [lemma]
//
in
  lemma (pf)
end // end of [ILISTEQ2_elim]

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
prfun
lemma_snoc_length
  {xs:ilist}{x:int}{xsx:ilist}{n:int}
  (pf1: SNOC (xs, x, xsx), pf2: LENGTH (xs, n)): LENGTH (xsx, n+1)
// end of [lemma_snoc_length]
*)
primplmnt
lemma_snoc_length
  (pf1, pf2) = let
//
prfun
lemma
  {xs:ilist}
  {x:int}
  {xsx:ilist}
  {n:int} .<xs>. (
  pf1: SNOC (xs, x, xsx), pf2: LENGTH (xs, n)
) : LENGTH (xsx, n+1) = let
in
//
case+ pf1 of
//
| SNOCnil () => let
    prval LENGTHnil () = pf2 in LENGTHcons (LENGTHnil ())
  end // end of [SNOCnil]
//
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
append_istot
  {xs,ys} () = let
//
prfun
istot {xs,ys:ilist} .<xs>.
  () : [zs:ilist] APPEND (xs, ys, zs) =
  scase xs of
  | ilist_nil () => APPENDnil ()
  | ilist_cons (x, xs) => APPENDcons (istot {xs,ys} ())
// end of [istot]
in
  istot {xs,ys} ()
end // end of [append_istot]

primplmnt
append_isfun
  (pf1, pf2) = let
//
prfun isfun
  {xs,ys:ilist}
  {zs1,zs2:ilist} .<xs>. (
  pf1: APPEND (xs, ys, zs1), pf2: APPEND (xs, ys, zs2)
) : ILISTEQ (zs1, zs2) = (
  case+ (pf1, pf2) of
  | (APPENDnil (), APPENDnil ()) => ILISTEQ ()
  | (APPENDcons (pf1), APPENDcons (pf2)) => let
      prval ILISTEQ () = isfun (pf1, pf2) in ILISTEQ ()
    end // end of [...]
) // end of [isfun]
in
  isfun (pf1, pf2)
end // end of [append_isfun]

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

primplmnt
append_sing () = APPENDcons (APPENDnil ())

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

(*
prfun
lemma_append_assoc
  {xs1,xs2,xs3:ilist}
  {xs12,xs23:ilist}
  {xs12_3,xs1_23:ilist} (
  pf12: APPEND (xs1, xs2, xs12), pf23: APPEND (xs2, xs3, xs23)
, pf12_3: APPEND (xs12, xs3, xs12_3), pf1_23: APPEND (xs1, xs23, xs1_23)
) : ILISTEQ (xs12_3, xs1_23) // end of [lemma_append_assoc]
*)
primplmnt
lemma_append_assoc (
  pf12, pf23, pf12_3, pf1_23
) = let
//
prfun
lemma
  {xs1,xs2,xs3:ilist}
  {xs12,xs23:ilist}
  {xs12_3,xs1_23:ilist} .<xs1>. (
  pf12: APPEND (xs1, xs2, xs12), pf23: APPEND (xs2, xs3, xs23)
, pf12_3: APPEND (xs12, xs3, xs12_3), pf1_23: APPEND (xs1, xs23, xs1_23)
) : ILISTEQ (xs12_3, xs1_23) = let
in
//
case+ pf12 of
| APPENDnil () => let
    prval APPENDnil () = pf1_23
    prval ILISTEQ () = append_isfun (pf23, pf12_3)
  in
    ILISTEQ ()
  end // end of [APPENDnil]
| APPENDcons (pf12) => let
    prval APPENDcons (pf12_3) = pf12_3
    prval APPENDcons (pf1_23) = pf1_23
    prval ILISTEQ () = lemma (pf12, pf23, pf12_3, pf1_23)
  in
    ILISTEQ ()
  end // end of [APPENDcons]
//
end // end of [lemma]
//
in
  lemma (pf12, pf23, pf12_3, pf1_23)
end // end of [lemma_append_assoc]

(* ****** ****** *)

(*
prfun
lemma_nth_ilisteq
  {xs1,xs2:ilist}{n:int}
(
  pf1len: LENGTH (xs1, n), pf2len: LENGTH (xs2, n)
, fpf: {x:int}{i:int | i < n} NTH (x, xs1, i) -> NTH (x, xs2, i)
) : ILISTEQ (xs1, xs2) =
*)
primplmnt
lemma_nth_ilisteq
  (pf1len, pf2len, fpf) = let
//
prval () = length_isnat(pf1len)
//
prfun
lemma
  {xs1,xs2:ilist}
  {n:nat} .<n>. (
  pf1len: LENGTH (xs1, n)
, pf2len: LENGTH (xs2, n)
, fpf: {x:int}{i:int | i < n} NTH (x, xs1, i) -> NTH (x, xs2, i)
) : ILISTEQ (xs1, xs2) = let
in
//
sif n > 0 then let
  prval
  LENGTHcons{x1}{xs11} pf11len = pf1len
  prval
  LENGTHcons{x2}{xs21} pf21len = pf2len
  prval NTHbas () = fpf {x1}{0} (NTHbas ())
  prfn fpf1
    {x:int}{i:int | i < n-1}
    (pf: NTH (x, xs11, i)): NTH (x, xs21, i) = let
    prval _ = lemma_nth_param(pf)
    prval NTHind (pfres) = fpf(NTHind(pf))
  in
    pfres
  end // end of [fpf1]
  prval ILISTEQ () = lemma (pf11len, pf21len, fpf1)
in
  ILISTEQ ()
end else let
  prval LENGTHnil () = pf1len and LENGTHnil () = pf2len
in
  ILISTEQ ()
end // end of [sif]
//
end // end of [lemma]
//
in
  lemma (pf1len, pf2len, fpf)
end // end of [lemma_nth_ilisteq]

(* ****** ****** *)

primplmnt
lemma_length_nth
  (pflen) = let
//
prfun
lemma
{xs:ilist}
{n:int}{i:nat | i < n}
  .<xs>.
(
  pflen: LENGTH(xs, n)
) : [x:int] NTH(x, xs, i) = let
//
prval
LENGTHcons(pflen1) = pflen
//
in
//
sif
(i==0)
then NTHbas()
else NTHind(lemma{..}{..}{i-1}(pflen1))
//
end (* end of [lemma] *)
//
in
  lemma(pflen)
end // end of [lemma_length_nth]

(* ****** ****** *)

primplmnt
revapp_istot
  {xs,ys} () = let
//
prfun
istot
{xs,ys:ilist} .<xs>.
(
// argumentless
) : [zs:ilist] REVAPP (xs, ys, zs) =
  scase xs of
  | ilist_nil () => REVAPPnil ()
  | ilist_cons (x, xs) =>
      REVAPPcons (istot {xs,ilist_cons (x,ys)} ())
    // end of [ilist_cons]
// end of [istot]
in
  istot {xs,ys} ()
end // end of [revapp_istot]

primplmnt
revapp_isfun
  (pf1, pf2) = let
//
prfun isfun
  {xs,ys:ilist}
  {zs1,zs2:ilist} .<xs>. (
  pf1: REVAPP (xs, ys, zs1), pf2: REVAPP (xs, ys, zs2)
) : ILISTEQ (zs1, zs2) = (
  case+ (pf1, pf2) of
  | (REVAPPnil (), REVAPPnil ()) => ILISTEQ ()
  | (REVAPPcons (pf1), REVAPPcons (pf2)) => let
      prval ILISTEQ () = isfun (pf1, pf2) in ILISTEQ ()
    end // end of [...]
) // end of [isfun]
in
  isfun (pf1, pf2)
end // end of [revapp_isfun]

(* ****** ****** *)

(*
prfun
lemma_revapp_length
  {xs,ys,zs:ilist}{m,n:int} .<xs>. (
  pf1: REVAPP (xs, ys, zs), pf2: LENGTH (xs, m), pf3: LENGTH (ys, n)
) : LENGTH (zs, m+n) // end of [lemma_revapp_length]
*)
primplmnt
lemma_revapp_length
  (pf, pf1len, pf2len) = let
//
prfun
lemma
  {xs,ys,zs:ilist}
  {m,n:nat} .<xs>. (
  pf: REVAPP (xs, ys, zs)
, pf1len: LENGTH (xs, m), pf2len: LENGTH (ys, n)
) : LENGTH (zs, m+n) = let
in
//
case+ pf of
| REVAPPnil () => let
    prval
    LENGTHnil () = pf1len in pf2len
  end // end of[REVAPPnil]
| REVAPPcons (pf) => let
    prval
    LENGTHcons(pf1len) = pf1len
  in
    lemma (pf, pf1len, LENGTHcons(pf2len))
  end // end of [REVAPPcons]
//
end // end of [revapp_length_lemma]
//
prval () = length_isnat (pf1len)
prval () = length_isnat (pf2len)
//
in
  lemma (pf, pf1len, pf2len)
end // end of [lemma_revapp_length]

(* ****** ****** *)

primplmnt
reverse_istot() = revapp_istot()
primplmnt
reverse_isfun(pf1, pf2) = revapp_isfun(pf1, pf2)

(* ****** ****** *)
//
primplmnt
lemma_reverse_length
  (pfrev, pflen) = lemma_revapp_length(pfrev, pflen, LENGTHnil())
//
(* ****** ****** *)

(*
prfun
lemma1_revapp_nth
  {xs,ys,zs:ilist}{n:int}{x:int}{i:int} (
  pf: REVAPP (xs, ys, zs), pflen: LENGTH (xs, n), pfnth: NTH (x, ys, i)
) : NTH (x, zs, n+i) // end of [lemma1_revapp_nth]
*)
primplmnt
lemma1_revapp_nth
  (pf, pflen, pfnth) = let
//
prfun
lemma
  {xs,ys,zs:ilist}
  {n:int}{x:int}{i:int} .<xs>. (
  pf: REVAPP (xs, ys, zs), pflen: LENGTH (xs, n), pfnth: NTH (x, ys, i)
) : NTH (x, zs, n+i) = let
//
prval _ = lemma_nth_param(pfnth)
//
in
//
case+ pf of
| REVAPPnil () => let
    prval LENGTHnil () = pflen in pfnth
  end // end of [REVAPPnil]
| REVAPPcons (pf) => let
    prval LENGTHcons (pflen) = pflen in lemma (pf, pflen, NTHind (pfnth))
  end // end of[REVAPPcons]
//
end // end of [lemma1_revapp_nth]
//
in
  lemma (pf, pflen, pfnth)
end // end of [lemma1_revapp_nth]

(* ****** ****** *)

(*
prfun
lemma2_revapp_nth
  {xs,ys,zs:ilist}{n:int}{x:int}{i:int} (
  pf: REVAPP (xs, ys, zs), pflen: LENGTH (xs, n), pfnth: NTH (x, xs, i)
) : NTH (x, zs, n-1-i) // end of [lemma2_revapp_nth]
*)
primplmnt
lemma2_revapp_nth
  (pf, pflen, pfnth) = let
//
prval _ = lemma_nth_param(pfnth)
//
prfun lemma
  {xs,ys,zs:ilist}
  {n:int}{x:int}{i:nat} .<i>.
(
  pf: REVAPP (xs, ys, zs)
, pflen: LENGTH (xs, n), pfnth: NTH (x, xs, i)
) : NTH (x, zs, n-1-i) = let
in
//
case+ pfnth of
//
| NTHbas () => let
    prval REVAPPcons (pf) = pf
    prval LENGTHcons pflen = pflen
  in
    lemma1_revapp_nth (pf, pflen, NTHbas ())
  end // end of [NTHbas]
//
| NTHind (pfnth) => let
    prval REVAPPcons (pf) = pf
    prval LENGTHcons (pflen) = pflen in lemma (pf, pflen, pfnth)
  end // end of [NTHind]
//
end // end of [lemma]
//
in
  lemma (pf, pflen, pfnth)
end // end of [lemma2_revapp_nth]

(* ****** ****** *)

primplmnt
lemma_reverse_nth
  (pf, pflen, pfnth) = lemma2_revapp_nth (pf, pflen, pfnth)
// end of [lemma_reverse_nth]    

(* ****** ****** *)

primplmnt
lemma_reverse_symm{xs,ys}(pf) = let
//
prval
[n:int]
pflen_xs = length_istot {xs} ()
prval
pflen_ys = lemma_revapp_length (pf, pflen_xs, LENGTHnil ())
prval
[zs:ilist]
pfrev_zs = revapp_istot {ys,ilist_nil} ()
prval
pflen_zs = lemma_revapp_length (pfrev_zs, pflen_ys, LENGTHnil ())
//
prfun
fpf
{x:int}
{i:int | i < n} .<>.
  (pfnth: NTH (x, xs, i)): NTH (x, zs, i) = let
  prval pf2nth = lemma_reverse_nth (pf, pflen_xs, pfnth)
in
  lemma_reverse_nth (pfrev_zs, pflen_ys, pf2nth)
end // end of [fpf]
//
prval
ILISTEQ () = lemma_nth_ilisteq (pflen_xs, pflen_zs, fpf)
//
in
  pfrev_zs
end // end of [lemma_reverse_symm]

(* ****** ****** *)

(*
prfun
lemma_insert_length
  {x0:int}{xs:ilist}{i:int}{ys:ilist}{n:int}
  (pf1: INSERT (x0, xs, i, ys), pf2: LENGTH (xs, n)): LENGTH (ys, n+1)
// end of [lemma_insert_length]
*)
primplmnt
lemma_insert_length
  (pf1, pf2) = let
//
prfun
lemma
  {x0:int}{xs:ilist}{i:int}{ys:ilist}{n:int} .<xs>.
  (pf1: INSERT (x0, xs, i, ys), pf2: LENGTH (xs, n)): LENGTH (ys, n+1) = let
in
//
case+ pf1 of
| INSERTbas () => let
    prval () = length_isnat (pf2) in LENGTHcons (pf2)
  end // end of [INSERTbas]
| INSERTind (pf1) => let
    prval LENGTHcons (pf2) = pf2 in LENGTHcons (lemma (pf1, pf2))
  end // end of [INSERTind]
//
end // end of [lemma]  
//
in
  lemma (pf1, pf2)
end // end of [lemma_insert_length]

(* ****** ****** *)

(*
prfun lemma_insert_nth_at
  {x0:int}{xs:ilist}{i:int}{ys:ilist}
  (pf: INSERT (x0, xs, i, ys)): NTH (x0, ys, i)
// end of [lemma_insert_nth_eq]
*)
primplmnt
lemma_insert_nth_at (pf) = let
//
prfun
lemma
  {x0:int}{xs:ilist}{i:int}{ys:ilist} .<xs>.
  (pf: INSERT (x0, xs, i, ys)): NTH (x0, ys, i) = let
in
  case+ pf of
  | INSERTbas () => NTHbas () | INSERTind (pf) => NTHind (lemma (pf))
end // end of [lemma]  
//
in
  lemma (pf)
end // end of [lemma_insert_nth_at]

(* ****** ****** *)

(*
prfun lemma_insert_nth_lt
  {x0:int}{xs:ilist}{i:int}{ys:ilist}{x:int}{j:int | j < i}
  (pf1: INSERT (x0, xs, i, ys), pf2: NTH (x, xs, j)): NTH (x, ys, j)
// end of [lemma_insert_nth_lt]
*)
primplmnt
lemma_insert_nth_lt
  (pf1, pf2) = let
//
prfun lemma
  {x0:int}{xs:ilist}{i:int}{ys:ilist}{x:int}{j:int | j < i} .<xs>.
  (pf1: INSERT (x0, xs, i, ys), pf2: NTH (x, xs, j)): NTH (x, ys, j) = let
in
//
case+ pf2 of
| NTHbas () => let
    prval INSERTind (pf1) = pf1 in NTHbas ()
  end // end of [NTHbas]
| NTHind (pf2) => let
    prval INSERTind (pf1) = pf1 in NTHind (lemma (pf1, pf2))
  end // end of [NTHind]
//
end // end of [lemma]
//
in
  lemma (pf1, pf2)
end // end of [lemma_insert_nth_lt]

(* ****** ****** *)

(*
prfun lemma_insert_nth_gte
  {x0:int}{xs:ilist}{i:int}{ys:ilist}{x:int}{j:int | j >= i}
  (pf1: INSERT (x0, xs, i, ys), pf2: NTH (x, xs, j)): NTH (x, ys, j+1)
// end of [lemma_insert_nth_lt]
*)
primplmnt
lemma_insert_nth_gte
  (pf1, pf2) = let
//
prfun lemma
  {x0:int}{xs:ilist}{i:int}{ys:ilist}{x:int}{j:int | j >= i} .<xs>.
  (pf1: INSERT (x0, xs, i, ys), pf2: NTH (x, xs, j)): NTH (x, ys, j+1) = let
//
in
//
case+ pf1 of
| INSERTbas () => NTHind (pf2)
| INSERTind (pf1) => let
    prval NTHind (pf2) = pf2 in NTHind (lemma (pf1, pf2))
  end // end of [INSERTind]
//
end // end of [lemma]
//
in
  lemma (pf1, pf2)
end // end of [lemma_insert_nth_gte]

(* ****** ****** *)

(*
prfun lemma_nth_insert
  {x:int} {xs:ilist} {n:int}
  (pf: NTH (x, xs, n)): [ys:ilist] INSERT (x, ys, n, xs)
// end of [lemma_nth_insert]
*)
primplmnt
lemma_nth_insert (pf) = let
//
prfun lemma
  {x:int} {xs:ilist} {n:int} .<xs>.
  (pf: NTH (x, xs, n)): [ys:ilist] INSERT (x, ys, n, xs) = let
in
//
case+ pf of
| NTHbas () => INSERTbas () | NTHind (pf) => INSERTind (lemma (pf))
//
end
//
in
  lemma (pf)
end // end of [lemma_nth_insert]

(* ****** ****** *)

(* end of [ilist_prf.dats] *)
