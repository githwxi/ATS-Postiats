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
(* Start time: July, 2013 *)

(* ****** ****** *)
//
// HX: shared by monad_list
// HX: shared by monad_maybe
//
(* ****** ****** *)

implement
{a1,a2}
monad_seq (m1, m2) = monad_bind<a1><a2> (m1, lam _ => m2)

(* ****** ****** *)

implement
{a}(*tmp*)
monad_join (mm) = monad_bind<monad(a)><a> (mm, lam m => m)

(* ****** ****** *)

implement
{a}{b}
monad_fmap (f, m) =
  monad_bind<a><b> (m, lam x => monad_return<b> (f(x)))
// end of [monad_fmap]

(* ****** ****** *)

implement
{a}{b}
monad_liftm (f, m) =
  monad_bind<a><b> (m, lam x => monad_return<b> (f(x)))
// end of [monad_liftm]

(* ****** ****** *)

implement
{a}(*tmp*)
monad_seqlist (ms) = monad_mapm<a><a> (lam x => x, ms)
implement
{a}(*tmp*)
monad_seqlist_ (ms) = monad_mapm_<monad(a)><a> (lam m => m, ms)

(* ****** ****** *)

(* end of [monad.hats] *)
