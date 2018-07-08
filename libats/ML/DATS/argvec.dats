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
(* Start time: March, 2018 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/argvec.sats"

(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

implement
listize_argc_argv
{n}(argc, argv) = let
//
fun
loop
{i:nat | i <= n}
( i: int(i)
,
argv: !argv(n)
,
args: list0(string)): list0(string) =
if
(i >= 1)
then let
  val
  arg = argv[i-1]
in
  loop
  (i-1, argv, list0_cons(arg, args))
end else args
//
in
  loop(argc, argv, list0_nil((*void*)))
end // end of [listize_argc_argv]

(* ****** ****** *)

(* end of [argvec.dats] *)
