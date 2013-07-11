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
//
viewdef
gmatrix_v
  (a:t0p, l:addr, m:int, n:int, mo:mord) = gmatrix(a, m, n, mo, 1) @ l
viewdef
gmatrix_v
  (a:t0p, l:addr, m:int, n:int, mo:mord, ld:int) = gmatrix(a, m, n, mo, ld) @ l
//
(* ****** ****** *)  
stadef GM = gmatrix
stadef GM_v = gmatrix_v

(* ****** ****** *)

prfun
gmatrix2array_v
  {a:t0p}{l:addr}{m,n:int}{mo:mord}
  (pf: GM_v (a, l, m, n, mo)):<prf> array_v (a, l, m*n)
prfun
gmatrix2array_v
  {a:t0p}{l:addr}{m,n:int}{mo:mord}{ld:int}
  (pf: GM_v (a, l, m, n, mo, ld)):<prf> array_v (a, l, m*n)  
// end [gmatrix2array_v]

prfun
array2gmatrix_v
  {a:t0p}{l:addr}{m,n:int}{mo:mord}
  (pf: array_v (a, l, m*n)):<prf> GM_v (a, l, m, n, mo)
prfun
array2gmatrix_v
  {a:t0p}{l:addr}{m,n:int}{mo:mord}{ld:int}
  (pf: array_v (a, l, m*n)):<prf> GM_v (a, l, m, n, mo, ld)  
// end [array2gmatrix_v]

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} gmatrix_foreach$fwork (x: &a >> _, env: &(env) >> _): void
fun{
a:t0p
} gmatrix_foreach{m,n:int}{mo:mord}
(
  A: &gmatrix(a, m, n, mo) >> _, m: size_t m, n: size_t n
) : void // end of [gmatrix_foreach]
fun{
a:t0p}{env:vt0p
} gmatrix_foreach_env{m,n:int}{mo:mord}
(
  A: &gmatrix(a, m, n, mo) >> _, m: size_t m, n: size_t n, env: &(env) >> _
) : void // end of [gmatrix_foreach_env]

(* ****** ****** *)

fun{
a:t0p}{env:vt0p
} gmatrix_foreachrow$fwork{n:int}
  (x: &array (a, n) >> _, n: size_t n, env: &(env) >> _): void
// end of [gmatrix_foreachrow$fwork]

fun{
a:t0p
} gmatrix_foreachrow{m,n:int}{mo:mord}
(
  A: &gmatrix(a, m, n, mo) >> _, m: size_t m, n: size_t n
) : void // end of [gmatrix_foreachrow]
fun{
a:t0p}{env:vt0p
} gmatrix_foreachrow_env{m,n:int}{mo:mord}
(
  A: &gmatrix(a, m, n, mo) >> _, m: size_t m, n: size_t n, env: &(env) >> _
) : void // end of [gmatrix_foreachrow_env]

(* ****** ****** *)

//
// BB: tensor product
// BB: outer product
//
// TODO: add col-major version as a wrapper,
// or always require specification of mord?
//
// TODO: implement -- foreach method doesn't 
// seem to be memory efficient for this, so probably need 
// to construct matrix explicitly: A_ij = v1_i*v2_j
//
fun{a:t0p}
mulo_gvector_gvector
  {n:int}{d1,d2:int}{l:addr}{mo:mord}
(
  vec1: &gvector (a, n, d1)
, vec2: &gvector (a, n, d2)
, mat1: &gmatrix (a?, l, n, n, mo) >> gmatrix(a, l, n, n, mo)
, n: int(n), d1: int(d1), d2: int(d2)
) : void (* end of [mulo_gvector_gvector] *)

(* ****** ****** *)

(* end of [gmatrix.sats] *)