(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: August, 2013 *)

(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.ML"
#define ATS_EXTERN_PREFIX "atslib_ML_" // prefix for external names

(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)

#include "./SHARE/monad.hats"

(* ****** ****** *)
//
fun{a:t0p}
monad_maybe_none(): monad(a)
fun{a:t0p}
monad_maybe_some(x0: a): monad(a)
//
(* ****** ****** *)
//
fun{a:t0p}
monad_maybe_optize
  (m0: monad(INV(a))): Option(a)
//
(* ****** ****** *)
//
fun
{a:t0p}
fprint_monad
  (out: FILEref, m: monad(INV(a))): void
//
overload fprint with fprint_monad
//
(* ****** ****** *)

(* end of [monad_maybe.sats] *)
