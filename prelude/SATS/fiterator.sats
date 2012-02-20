(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fiterator.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

absviewt@ype
fiterator (
  xs: t@ype, x: t@ype+, f: int, r: int
) // end of [absviewt@ype]

prfun lemma_iterator_params
  {xs:t@ype}{x:t@ype}{f,r:int}
  (iter: !fiterator (xs, x, f, r)): [f>=0;r>=0] void
// end of [lemma_iterator_params]

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} iter_make (xs: xs):<> [r:nat] fiterator (xs, x, 0, r)

fun{
xs:t@ype}{x:t@ype
} iter_free {f,r:int} (iter: fiterator (xs, x, f, r)):<> void

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} iter_is_atend {f,r:int}
  (iter: &fiterator (xs, x, f, r)):<> bool (r==0)
// end of [iter_is_atend]

fun{
xs:t@ype}{x:t@ype
} iter_isnot_atend {f,r:int}
  (iter: &fiterator (xs, x, f, r)):<> bool (r > 0)
// end of [iter_isnot_atend]

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} iter_get_at
  {f,r:int | r > 0} (iter: &fiterator (xs, x, f, r)):<> x
// end of [iter_get_at]

fun{
xs:t@ype}{x:t@ype
} iter_getinc_at
  {f,r:int | r > 0}
  (iter: &fiterator (xs, x, f, r) >> fiterator (xs, x, f+1, r-1)):<> x
// end of [iter_getinc_at]

fun{
xs:t@ype}{x:t@ype
} iter_getdec_at
  {f,r:int | f > 0; r > 0}
  (iter: &fiterator (xs, x, f, r) >> fiterator (xs, x, f-1, r+1)):<> x
// end of [iter_getdec_at]

(* ****** ****** *)

fun{
xs:t@ype}{x:t@ype
} iter_inc {f,r:int | r > 0} (
  iter: &fiterator (xs, x, f, r) >> fiterator (xs, x, f+1, r-1)
) :<> void // end of [iter_inc]

fun{
xs:t@ype}{x:t@ype
} iter_dec {f,r:int | f > 0} (
  iter: &fiterator (xs, x, f, r) >> fiterator (xs, x, f-1, r+1)
) :<> void // end of [iter_dec]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [fiterator.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [fiterator.sats] *)
