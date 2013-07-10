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
datasort mord =
  | mrow (* row major *)
  | mcol (* column major *)
datatype MORD (mord) =
  | MORDrow (mrow) of () | MORDcol (mcol) of ()
//
(* ****** ****** *)
//
// HX-2013-07:
// generic matrix: element, row, col, ord, ld
abst@ype
gmatrix_t0ype
  (a:t@ype+, m:int, n:int, mo:mord, ld:int)
//
typedef gmatrix
  (a:t0p, m:int, n:int, mo:mord) = gmatrix_t0ype (a, m, n, mo, 1)
typedef gmatrix
  (a:t0p, m:int, n:int, mo:mord, ld:int) = gmatrix_t0ype (a, m, n, mo, ld)
//
(* ****** ****** *)

(* end of [gmatrix.sats] *)