(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: December, 2016 *)

(* ****** ****** *)
//
typedef
cfun0
(r:vt@ype) = () -<cloref1> r
typedef
cfun1
(a:t@ype, r:vt@ype) = (a) -<cloref1> r
//
typedef
cfun2 (
  a1:t@ype
, a2:t@ype, r:vt@ype
) = (a1, a2) -<cloref1> r
typedef
cfun3 (
  a1:t@ype
, a2:t@ype
, a3: t@ype, r:vt@ype
) = (a1, a2, a3) -<cloref1> r
typedef
cfun4 (
  a1:t@ype
, a2:t@ype
, a3:t@ype
, a4: t@ype, r:vt@ype
) = (a1, a2, a3, a4) -<cloref1> r
//
stadef cfun = cfun0
stadef cfun = cfun1
stadef cfun = cfun2
stadef cfun = cfun3
stadef cfun = cfun4
//
(* ****** ****** *)
//
typedef
parinp(a:t@ype) = stream(a)
//
(* ****** ****** *)
//
datatype parout
  (a:t@ype, res:t@ype) =
  | PAROUT of (Option(res), parinp(a))
//
(* ****** ****** *)
//
typedef
parser(
  a:t@ype, res:t@ype
) = parinp(a) -<cloref1> parout(a, res)
//
(* ****** ****** *)
//
// HX-2016-12: interface
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_fail(): parser(a, t)
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_succeed(x0: t): parser(a, t)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
parser_anyone((*void*)): parser(a, a)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
parser_satisfy
  (test: cfun(a, bool)): parser(a, a)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t:t@ype}
{u:t@ype}
parser_map
  (parser(a, t), cfun(t, u)): parser(a, u)
//
extern
fun
{a:t@ype}
{t1,t2:t@ype}
{u:t@ype}
parser_map2
(
  parser(a, t1), parser(a, t2), cfun(t1, t2, u)
) : parser(a, u) // end of [parser_map2]
//
extern
fun
{a:t@ype}
{t1,t2,t3:t@ype}
{u:t@ype}
parser_map3
(
  parser(a, t1), parser(a, t2), parser(a, t3), cfun(t1, t2, t3, u)
) : parser(a, u) // end of [parser_map3]
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t1,t2:t@ype}
parser_join2
(
  parser(a, t1)
, parser(a, t2)
) : parser(a, @(t1, t2))
extern
fun
{a:t@ype}
{t1,t2,t3:t@ype}
parser_join3
(
  parser(a, t1)
, parser(a, t2)
, parser(a, t3)
) : parser(a, @(t1, t2, t3))
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t1,t2:t@ype}
parser_tup2_fst
(
p1: parser(a, t1), p2: parser(a, t2)
) : parser(a, t1) // end-of-function
extern
fun
{a:t@ype}
{t1,t2:t@ype}
parser_tup2_snd
(
p1: parser(a, t1), p2: parser(a, t2)
) : parser(a, t2) // end-of-function
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_orelse
(
p1: parser(a, t), p2: parser(a, t)
) : parser(a, t) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_repeat0
  (parser(a, t)): parser(a, List0(t)) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_repeat1
  (parser(a, t)): parser(a, List1(t)) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_lazy
  (lp: lazy(parser(a, t))): parser(a, t) = "mac#%"
//
(* ****** ****** *)
//
// HX-2016-12: implementation
//
(* ****** ****** *)
//
implement
{a}{t}
parser_fail() =
  lam(inp) => PAROUT(None(), inp)
//
(* ****** ****** *)
//
implement
{a}{t}
parser_succeed(x0) =
  lam(inp) => PAROUT(Some(x0), inp)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
parser_anyone
  ((*void*)) =
  lam(xs0) =>
(
  case+ !xs0 of
  | stream_nil() =>
    PAROUT(None{a}(), xs0)
  | stream_cons(x1, xs1) =>
    PAROUT(Some{a}(x1), xs1)
) (* end of [parse_anyone] *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
parser_satisfy
  (pred) = lam(xs0) =>
(
  case+ !xs0 of
  | stream_nil() =>
    PAROUT(None{a}(), xs0)
  | stream_cons(x1, xs1) =>
    if pred(x1)
      then PAROUT(Some(x1), xs1)
      else PAROUT(None{a}(), xs0)
    // end of [if[
) (* end of [parse_satisfy] *)
//
(* ****** ****** *)

implement
{a}{t}{u}
parser_map
(
  p0, fopr
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p0(inp0)
//
in
  case+ opt of
  | None() =>
    PAROUT(None{u}(), inp0)
  | Some(x) =>
    PAROUT(Some(fopr(x)), inp1)
end // end of [parser_map]

(* ****** ****** *)

implement
{a}(*tmp*)
{t1,t2}{u3}
parser_map2
(
p1, p2, fopr
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{u3}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{u3}(), inp0)
    | Some(x2) =>
      PAROUT(Some(fopr(x1, x2)), inp2)
  end // end of [Some]
//
end // end of [parser_map2]

(* ****** ****** *)

implement
{a}(*tmp*)
{t1,t2,t3}{u4}
parser_map3
(
p1, p2, p3, fopr
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{u4}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{u4}(), inp0)
    | Some(x2) => let
        val+
        PAROUT(opt, inp3) = p3(inp2)
      in
        case+ opt of
        | None() =>
          PAROUT(None{u4}(), inp0)
        | Some(x3) =>
          PAROUT(Some(fopr(x1, x2, x3)), inp3)
      end
  end // end of [Some]
//
end // end of [parser_map3]

(* ****** ****** *)

implement
{a}{t1,t2}
parser_join2
(
  p1, p2
) = lam(inp0) => let
//
typedef t12 = @(t1, t2)
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t12}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t12}(), inp0)
    | Some(x2) =>
      PAROUT(Some(@(x1, x2)), inp2)
  end // end of [Some]
//
end // end of [parser_join2]

(* ****** ****** *)

implement
{a}(*tmp*)
{t1,t2,t3}
parser_join3
(
  p1, p2, p3
) = lam(inp0) => let
//
typedef t123 = @(t1, t2, t3)
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t123}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t123}(), inp0)
    | Some(x2) => let
        val+
        PAROUT(opt, inp3) = p3(inp2)
      in
        case+ opt of
        | None() =>
          PAROUT(None{t123}(), inp0)
        | Some(x3) =>
          PAROUT(Some{t123}(@(x1, x2, x3)), inp3)
      end // end of [Some]
  end // end of [Some]
//
end // end of [parser_join3]

(* ****** ****** *)

implement
{a}{t1,t2}
parser_tup2_fst
(
  p1, p2
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t1}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t1}(), inp0)
    | Some(x2) =>
      PAROUT(Some{t1}(x1), inp2)
  end // end of [Some]
//
end // end of [parser_tup2_fst]

(* ****** ****** *)

implement
{a}{t1,t2}
parser_tup2_snd
(
  p1, p2
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t2}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t2}(), inp0)
    | Some(x2) =>
      PAROUT(Some{t2}(x2), inp2)
  end // end of [Some]
//
end // end of [parser_tup2_snd]

(* ****** ****** *)

implement
{a}{t}(*tmp*)
parser_repeat0
  (p0) = lam(inp0) => let
//
fun
auxlst
(
  inp: parinp(a), xs: List0_vt(t)
) : parout(a, List0(t)) = let
//
val+PAROUT(opt, inp) = p0(inp)
//
in
  case+ opt of
  | None() => let
      val xs = list_vt_reverse(xs)
    in
      PAROUT(Some(list_vt2t(xs)), inp)
    end // end of [None_vt]
  | Some(x) => auxlst(inp, list_vt_cons(x, xs))
end // end of [auxlst]
//
in
  auxlst(inp0, list_vt_nil((*void*)))
end // end of [parse_repeat0]

(* ****** ****** *)

implement
{a}{t}(*tmp*)
parser_repeat1
  (p0) = lam(inp0) => let
//
typedef ts = List1(t)
//
val+
PAROUT(opt, inp1) = p0(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{ts}(), inp0)
  // end of [None_vt]
| Some(x) => let
    val+
    PAROUT
    (opt, inp2) =
    parser_repeat0(p0)(inp1)
    val-Some(xs) = opt
  in
    PAROUT(Some(list_cons(x, xs)), inp2)
  end // end of [Some]
//
end // end of [parse_repeat1]

(* ****** ****** *)
//
implement
{a}{t}(*tmp*)
parser_lazy(lp) = lam(inp0) => (!lp)(inp0)
//
(* ****** ****** *)

(* end of [parcomb.dats] *)
