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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: May, 2012 *)

(* ****** ****** *)

staload "libats/SATS/funralist_nested.sats"

(* ****** ****** *)

datatype node
  (a:t@ype+, int(*d*)) =
  | N1 (a, 0) of (a) // singleton
  | {d:nat}
    N2 (a, d+1) of (node (a, d), node (a, d))
// end of [node]

datatype ralist
  (a:t@ype+, int(*d*), int(*n*)) =
  | {d:nat}
    RAnil (a, d, 0) of ()
  | {d:nat}{n:pos}
    RAevn (a, d, n+n) of ralist (a, d+1, n)
  | {d:nat}{n:nat}
    RAodd (a, d, n+n+1) of (node (a, d), ralist (a, d+1, n))
// end of [ralist]

(* ****** ****** *)

typedef ra0list
  (a:t@ype, n:int) = ralist (a, 0, n)
assume ralist_t0ype_int_type = ra0list

(* ****** ****** *)

implement{}
funralist_nil{a} () = RAnil{a}{0} ()

(* ****** ****** *)

implement
funralist_length {a} (xs) = let
//
prval () = lemma_ralist_param (xs)
//
fun length
  {d:nat}{n:nat} .<n>.
  (xs: ralist (a, d, n)):<> int (n) =
  case+ xs of
  | RAevn (xxs) => let
      val n2 = length (xxs) in 2 * n2
    end // end of [RAevn]
  | RAodd (_, xxs) => let
      val n2 = length (xxs) in 2 * n2 + 1
    end // end of [RAodd]
  | RAnil () => 0
// end of [length]
in
  length (xs)
end // end of [funralist_length]

(* ****** ****** *)

implement{a}
funralist_cons (x, xs) = let
//
prval () = lemma_ralist_param (xs)
//
fun cons
  {d:nat}{n:nat} .<n>. (
  x0: node (a, d), xs: ralist (a, d, n)
) :<> ralist (a, d, n+1) =
  case+ xs of
  | RAevn (xxs) => RAodd (x0, xxs)
  | RAodd (x1, xxs) => let
      val x0x1 = N2 (x0, x1) in RAevn (cons (x0x1, xxs))
    end // end of [RAodd]
  | RAnil () => RAodd (x0, RAnil)
// end of [cons]
in
  cons (N1(x), xs)
end // end of [funralist]

(* ****** ****** *)

(* end of [funralist_nested.dats] *)
