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
//
abstype
monad_type(a:t@ype+) = ptr
typedef
monad(a:t@ype) = monad_type(a)
//
(* ****** ****** *)

fun
{a:t0p}
{b:t0p}
monad_bind
(
  monad(a), cfun(a, monad(b))
) : monad(b) // end-of-function

fun
{a1
,a2:t0p
}{b:t0p}
monad_bind2
(
  monad(a1), monad(a2), cfun(a1, a2, monad(b))
) : monad(b) // end-of-function

fun
{a1
,a2
,a3:t0p
}{b:t0p}
monad_bind3
(
  monad(a1), monad(a2), monad(a3), cfun(a1, a2, a3, monad(b))
) : monad(b) // end-of-function

(* ****** ****** *)

fun{a:t0p}
monad_return(x: a): monad(a)

(* ****** ****** *)

fun{} monad_unit(): monad(unit)

(* ****** ****** *)
//
fun
{a:t0p}
monad_nil(): monad(list0(a))
fun
{a:t0p}
monad_cons
(
  monad(INV(a)), monad(list0(a))
) : monad(list0(a)) // end-of-fun
//
(* ****** ****** *)

fun{
a1,a2:t0p
} monad_seq
(
  m1: monad(INV(a1)), m2: monad(INV(a2))
): monad(a2) // end of [monad_seq]

(* ****** ****** *)

fun{a:t0p}
monad_join(monad(monad(INV(a)))): monad(a)

(* ****** ****** *)

fun
{a:t0p}
{b:t0p}
monad_fmap(cfun(a, b), monad(a)): monad(b)

(* ****** ****** *)

fun
{a:t0p}
{b:t0p}
monad_liftm (cfun(a, b), monad(a)): monad(b)
fun
{a1
,a2:t0p
}{b:t0p}
monad_liftm2
  (cfun(a1, a2, b), monad(a1), monad(a2)): monad(b)
// end of [monad_liftm2]
fun
{a1
,a2
,a3:t0p
}{b:t0p}
monad_liftm3
  (cfun(a1, a2, a3, b), monad(a1), monad(a2), monad(a3)): monad(b)
// end of [monad_liftm3]

(* ****** ****** *)
//
fun
{a:t0p}
{b:t0p}
monad_mapm
  (cfun(a, b), list0(monad(a))): monad(list0(b))
//
fun
{a:t0p}
{b:t0p}
monad_mapm_(cfun(a, monad(b)), list0(a)): monad(unit)
//
(* ****** ****** *)
//
fun{a:t0p}
monad_seqlist
  (list0(monad(INV(a)))): monad(list0(a))
//
fun{a:t0p}
monad_seqlist_(list0(monad(INV(a)))): monad(unit)
//
(* ****** ****** *)

(* end of [monad.hats] *)
