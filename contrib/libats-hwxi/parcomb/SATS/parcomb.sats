(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
**
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
** Parsing combinators
*)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Time: December, 2008
//
(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-10
//
(* ****** ****** *)

fun{t:t0p}
stream_get_item (tks: &stream t): Option_vt (t)

(* ****** ****** *)
//
abstype parser_type (t@ype, t@ype) = ptr
//
typedef parser (a:t0p, t:t0p) = parser_type (a, t)
//
(* ****** ****** *)

fun lzeta {a:t0p}{t:t0p}
  (p: lazy (parser (a, t))):<> parser (a, t)

(* ****** ****** *)

fun{a:t0p} any_parser (): parser (a, a)
fun{a:t0p} anyopt_parser (): parser (Option a, a)

(* ****** ****** *)

fun{} fail_parser {a:t0p}{t:t0p} (): parser (a, t)

(* ****** ****** *)
//
// HX: this one does not consume any tokens
//
fun{a:t0p}{t:t0p}
neg_parser (p: parser (a, t)): parser (unit, t)
overload ~ with neg_parser

(* ****** ****** *)

symintr return
fun{a:t0p}{t:t0p}
return_parser (x: a):<> parser (a, t)
overload return with return_parser

(* ****** ****** *)
//
// symintr alt // infix
//
fun{
a:t0p}{t:t0p
} alt_parser_parser
(
  p1: parser (a, t), p2: parser (a, t)
) :<> parser (a, t)
// overload || with alt_parser_parser

(* ****** ****** *)
//
// symintr seq // infix
//
fun{
a1,a2:t0p}{t:t0p
} seq_parser_parser
(
  p1: parser (a1, t), p2: parser (a2, t)
) :<> parser (@(a1,a2), t)
// overload && with seq_parser_parser

(* ****** ****** *)

symintr wth // infix

fun{
a,b:t0p}{t:t0p
} seq1wth_parser_fun
(
  p1: parser (a, t), f: (a) -<fun> b
) :<> parser (b, t)
overload wth with seq1wth_parser_fun

fun{
a,b:t0p}{t:t0p
} seq1wth_parser_cloref (
  p1: parser (a, t), f: (a) -<cloref> b
) :<> parser (b, t)
overload wth with seq1wth_parser_cloref

(* ****** ****** *)

fun{
a1,a2,b:t0p}{t:t0p
} seq2wth_parser_fun
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, f: (a1, a2) -<fun> b
) :<> parser (b, t)
// end of [seq2wth_parser_fun]

fun{
a1,a2,b:t0p}{t:t0p
} seq2wth_parser_cloref
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, f: (a1, a2) -<cloref> b
) :<> parser (b, t)
// end of [seq2wth_parser_cloref]

(* ****** ****** *)

fun{
a1,a2,
a3,b:t0p}{t:t0p
} seq3wth_parser_fun
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, f: (a1, a2, a3) -<fun> b
) :<> parser (b, t)
// end of [seq3wth_parser_fun]

fun{
a1,a2,
a3,b:t0p}{t:t0p
} seq3wth_parser_cloref
(
    p1: parser (a1, t)
  , p2: parser (a2, t)
  , p3: parser (a3, t)  
  , f: (a1, a2, a3) -<cloref> b
  ) :<> parser (b, t)
// end of [seq3wth_parser_cloref]

(* ****** ****** *)

fun{
a1,a2,
a3,a4,b:t0p}{t:t0p
} seq4wth_parser_fun (
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, f: (a1, a2, a3, a4) -<fun> b
) :<> parser (b, t)
// end of [seq4wth_parser_fun]

fun{
a1,a2,
a3,a4,b:t0p}{t:t0p
} seq4wth_parser_cloref
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, f: (a1, a2, a3, a4) -<cloref> b
) :<> parser (b, t)
// end of [seq4wth_parser_cloref]

(* ****** ****** *)

fun{
a1,a2,
a3,a4,
a5,b:t0p}{t:t0p
} seq5wth_parser_fun
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)  
, f: (a1, a2, a3, a4, a5) -<fun> b
) :<> parser (b, t)
// end of [seq5wth_parser_fun]

fun{
a1,a2,
a3,a4,
a5,b:t0p}{t:t0p
} seq5wth_parser_cloref
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)  
, f: (a1, a2, a3, a4, a5) -<cloref> b
) :<> parser (b, t)
// end of [seq5wth_parser_cloref]

(* ****** ****** *)

fun{
a1,a2,
a3,a4,
a5,a6,b:t0p}{t:t0p
} seq6wth_parser_fun
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)
, p6: parser (a6, t)
, f: (a1, a2, a3, a4, a5, a6) -<fun> b
) :<> parser (b, t)
// end of [seq6wth_parser_fun]

fun{
a1,a2,
a3,a4,
a5,a6,b:t0p}{t:t0p
} seq6wth_parser_cloref
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)
, p6: parser (a6, t)
, f: (a1, a2, a3, a4, a5, a6) -<cloref> b
) :<> parser (b, t)
// end of [seq6wth_parser_cloref]

(* ****** ****** *)

fun{
a1,a2,
a3,a4,
a5,a6,
a7,b:t0p}{t:t0p
} seq7wth_parser_fun
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)
, p6: parser (a6, t)
, p7: parser (a7, t)
, f: (a1, a2, a3, a4, a5, a6, a7) -<fun> b
) :<> parser (b, t)
// end of [seq7wth_parser_fun]

fun{
a1,a2,
a3,a4,
a5,a6,
a7,b:t0p}{t:t0p
} seq7wth_parser_cloref
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)
, p6: parser (a6, t)
, p7: parser (a7, t)
, f: (a1, a2, a3, a4, a5, a6, a7) -<cloref> b
) :<> parser (b, t)
// end of [seq7wth_parser_cloref]

(* ****** ****** *)

fun{
a1,a2,
a3,a4,
a5,a6,
a7,a8,b:t0p}{t:t0p
} seq8wth_parser_fun
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)
, p6: parser (a6, t)
, p7: parser (a7, t)
, p8: parser (a8, t)
, f: (a1, a2, a3, a4, a5, a6, a7, a8) -<fun> b
) :<> parser (b, t)
// end of [seq8wth_parser_fun]

fun{
a1,a2,
a3,a4,
a5,a6,
a7,a8,b:t0p}{t:t0p
} seq8wth_parser_cloref
(
  p1: parser (a1, t)
, p2: parser (a2, t)
, p3: parser (a3, t)  
, p4: parser (a4, t)  
, p5: parser (a5, t)
, p6: parser (a6, t)
, p7: parser (a7, t)
, p8: parser (a8, t)
, f: (a1, a2, a3, a4, a5, a6, a7, a8) -<cloref> b
) :<> parser (b, t)
// end of [seq8wth_parser_cloref]

(* ****** ****** *)

// << (fst) and >> (snd)

fun{
a1,a2:t0p}{t:t0p
} proj1_parser_parser
  (p1: parser (a1, t), p2: parser (a2, t)):<> parser (a1, t)
overload << with proj1_parser_parser

fun{
a1,a2:t0p}{t:t0p
} proj2_parser_parser
  (p1: parser (a1, t), p2: parser (a2, t)):<> parser (a2, t)
overload >> with proj2_parser_parser

(* ****** ****** *)

symintr sat // infix

fun{a:t0p}{t:t0p} sat_parser_fun
  (p: parser (a, t), f: a -<fun> bool):<> parser (a, t)
overload sat with sat_parser_fun

fun{a:t0p}{t:t0p} sat_parser_cloref
  (p: parser (a, t), f: a -<cloref> bool):<> parser (a, t)
overload sat with sat_parser_cloref

(* ****** ****** *)

fun{a:t0p}{t:t0p}
discard_one_parser (p: parser (a, t)):<> parser (unit, t)
fun{a:t0p}{t:t0p}
discard_many_parser (p: parser (a, t)):<> parser (unit, t)

(* ****** ****** *)

symintr ^? ^* ^+ // postfix

fun{a:t0p}{t:t0p} optional_parser
  (p: parser (a, t)):<> parser (Option a, t)
overload ^? with optional_parser

fun{a:t0p}{t:t0p} repeat0_parser
  (p: parser (a, t)):<> parser (List a, t)
overload ^* with repeat0_parser

viewtypedef List1 (a: t0p) = [n:int | n > 0] list (a, n)

fun{a:t0p}{t:t0p} repeat1_parser
  (p: parser (a, t)):<> parser (List1 a, t)
overload ^+ with repeat1_parser

(* ****** ****** *)

fun{
a,b:t0p}{t:t0p
} repeat0_sep_parser
  (p: parser (a, t), sep: parser (b, t)):<> parser (List a, t)
// end of [repeat0_sep_parser]

fun{
a,b:t0p}{t:t0p
} repeat1_sep_parser
  (p: parser (a, t), sep: parser (b, t)):<> parser (List1 a, t)
// end of [repeat1_sep_parser]

(* ****** ****** *)

fun{
a:t0p}{t:t0p
} apply_parser (
  p: parser (a, t), tks: &stream t, ncur: &int, nmax: &int
) :<!laz> Option_vt a // end of [apply_parser]

(* ****** ****** *)

(* end of [parcomb.sats] *)
