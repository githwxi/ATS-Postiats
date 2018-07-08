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

(* Author: Hongwei Xi *)
(* Start time: July, 2013 *)
(* Authoremail: gmmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
// HX: shared by monad_list
// HX: shared by monad_maybe
//
(* ****** ****** *)

implement
{}(*tmp*)
monad_unit() = monad_return<unit>(unit)

(* ****** ****** *)

implement
{a}(*tmp*)
monad_nil((*void*)) =
  monad_return<list0(a)>(list0_nil{a}())
// end of [monad_nil]

implement
{a}(*tmp*)
monad_cons(m, ms) =
(
monad_liftm2<a,list0(a)><list0(a)>
  (lam (x, xs) => list0_cons{a}(x, xs), m, ms)
) // end of [monad_cons]

(* ****** ****** *)
//
implement
{a1,a2}
monad_seq
  (m1, m2) =
  monad_bind<a1><a2> (m1, lam _ => m2)
//
(* ****** ****** *)

implement
{a}(*tmp*)
monad_join(mm) =
monad_bind<monad(a)><a>(mm, lam m => m)

(* ****** ****** *)

implement
{a}{b}
monad_fmap(f, m) =
(
  monad_bind<a><b>
    (m, lam x => monad_return<b>(f(x)))
  // monad_bind
) // end of [monad_fmap]

(* ****** ****** *)

implement
{a}{b}
monad_liftm(f, m) =
  monad_bind<a><b>
    (m, lam x => monad_return<b>(f(x)))
// end of [monad_liftm]

(* ****** ****** *)

implement
{a1,a2}{b}
monad_liftm2
  (f, m1, m2) =
(
  monad_bind2<a1,a2><b>
  ( m1, m2
  , lam (x1, x2) => monad_return<b>(f(x1, x2))
  ) (* monad_liftm2 *)
) // end of [monad_liftm2]

implement
{a1,a2,a3}{b}
monad_liftm3
  (f, m1, m2, m3) =
(
  monad_bind3<a1,a2,a3><b>
  ( m1, m2, m3
  , lam (x1, x2, x3) => monad_return<b>(f(x1, x2, x3))
  ) (* monad_bind3 *)
) // end of [monad_liftm3]

(* ****** ****** *)

implement
{a}{b}
monad_mapm(f, ms) = let
in
//
case+ ms of
| list0_nil
    () => monad_nil<b>()
| list0_cons
    (m, ms) => let
    val m = monad_fmap<a><b>(f, m)
    val ms = monad_mapm<a><b>(f, ms)
  in
    monad_cons<b> (m, ms)
  end // list0_cons
//
end // end of [monad_mapm]

(* ****** ****** *)

implement
{a}{b}
monad_mapm_(f, xs) = let
in
//
case+ xs of
| list0_nil
    () => monad_unit()
| list0_cons
    (x, xs) => let
    val m = f(x)
    val mu = monad_mapm_<a><b>(f, xs)
  in
    monad_seq<b,unit>(m, mu)
  end // end of [list0_cons]
//
end // end of [monad_mapm_]

(* ****** ****** *)

implement
{a}(*tmp*)
monad_seqlist(ms) = monad_mapm<a><a>(lam x => x, ms)
implement
{a}(*tmp*)
monad_seqlist_(ms) = monad_mapm_<monad(a)><a>(lam m => m, ms)

(* ****** ****** *)

(* end of [monad.hats] *)
