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
parser_fail(): parser(a, t) = "mac#%"
//
extern
fun
{a:t@ype}
{t:t@ype}
parser_succeed(x0: t): parser(a, t) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
parser_anyone((*void*)): parser(a, a) = "mac#%"
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

(* end of [parcomb.dats] *)
