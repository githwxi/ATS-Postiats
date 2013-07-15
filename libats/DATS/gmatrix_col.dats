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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/gmatrix.sats"
staload "libats/SATS/gmatrix_col.sats"

(* ****** ****** *)

implement{a}
gmatcol_getref_at
  (M, ld, i, j) = let
//
val p = $UN.cast2Ptr1(ptr_add<a> (addr@M, i+j*ld))
//
in
  $UN.ptr2cptr{a}(p)
end // end of [gmatcol_getref_at]

(* ****** ****** *)

implement{a}
gmatcol_getref_row_at
  {m,n}{ld}(M, i) = let
//
val prow = $UN.cast2Ptr1(ptr_add<a> (addr@M, i))
//
in
  $UN.ptr2cptr{GVT(a,n,ld)}(prow)
end // end of [gmatcol_getref_row_at]

implement{a}
gmatcol_getref_col_at
  {m,n}{ld}(M, ld, j) = let
//
val pcol = $UN.cast2Ptr1(ptr_add<a> (addr@M, j*ld))
//
in
  $UN.ptr2cptr{GVT(a,m,1(*d*))}(pcol)
end // end of [gmatcol_getref_col_at]

(* ****** ****** *)


implement{a}
gmatcol_LUdec_Crout
  {n}{ld}(M, n, ld) = let
// Loosely based on NR3 textbook example
//
// TODO: need to return a proof of:
// non-singularity,
// LU-decomposed,
// read-only view.
//
val TINY = 1e-40
// Make proofs based on these?: 
var SINGULAR = 0
var row_parity = 1 //1 is even, ~1 is odd
//
implement 
array_tabulate$fopr<a> (i) = (   0   )
val (pfvs1, pfvs2 | pvs) = array_ptr_tabulate<a> (i2sz(n))
//
// permutation index array
implement 
array_tabulate$fopr<size_t> (i) = (   i2sz(0)   )
val (pfpi1, pfpi2 | ppi) = array_ptr_tabulate<size_t> (i2sz(n))
fun get_scale
  {i:nat} .<i>. (i:int) = 
if i >= 0 then let
// loop over columns to find largest pivot in row
fun loop 
  {j:nat} .<j>. (j: int, big: a): a = 
if j >= 0 then let 
val pM_ij = gmatcol_getref_at(M,i,j)
val big = (if gabs_val<a>(!pM_ij) < big then !pM_ij else big): a
in // of [loop]
   loop(pred(j), big)
end else 
  big 
end // of [loop]      
//
//
(* how best to convert type(1) or type(0)-->a? 
   probably need gzero_val<a> and gone_val<a>
*)
val () = pvs[i] = gdiv_val<a>(1,loop(n-1,0.0)) 
in // of [get_scale]
  get_scale(pred(i))
end else 
  ()
end // end of [get_scale]
//
val () = get_scale(n-1)
//
// outer loop (k in NR3)
fun loopk 
  {k:nat} .<k>. (k: int): void = 
if k >= 0 then let

// pivot if necessary
fun loop_piv 
  {i:nat} .<i>. (i: int, imax:int, big: a): (int, int) =
if i >= k then let
val pM_ik = gmatcol_getref_at(M,i,k)
val temp = pvs[i]*gabs_val<a>(!pM_ik)
in // of [loop_piv] 
if temp > big then loop_piv(pred(i), i, temp) 
else loop_piv(pred(i), imax, big)
end else 
  (imax, big)  
end // of [loop_piv]
//
val (imax, big) = loop_piv(n-1, k, 0.0)
//
// Check to see if rows need to be interchanged
val () = if k <> imax then let
  val pM_k = gmatcol_getref_row_at(M, k)
  val pM_imax = gmatcol_getref_row_at(M, imax)
  val () = row_parity := ~row_parity  
  val t = pvs[imax]
  val () = pvs[imax] = pvs[k]
  val () = pvs[k] = t
in                
blas_swap(!pM_k, !pM_imax, n, ??, ??)
else () end
ppi[k] = imax

// Check for singularity
val pM_kk = gmatcol_getref_at(M,k,k)
val () = SINGULAR := (if !pM_kk = 0.0) 
  then (!pM_kk = TINY; 1): int

// Divide by the pivot element
fun loopi1
  {i:nat} .<i>. (i: int): void = 
if i > k then let
val pM_ik = gmatcol_getref_at(M,i,k)
val () = !pM_ik := !pM_ik/!pM_kk
in 
  loopi1(pred(i)) 
end else () end // of [loopi1]
//
val () = loopi1(n-1)

// 
fun loopj
  {j:nat} .<j>. (j: int): void =
if j > k then let
// 
fun loopi2
  {i:nat} .<i>. (i: int): void = 
if i > k then let
val pM_kj = gmatcol_getref_at(M,k,j)
val pM_ij = gmatcol_getref_at(M,i,j)
val () = !pM_ij = pvs[k]*(!pM_ij - !pM_kj)
in 
  loopi2(pred(i)) 
end else () end // of [loopi2]
//
val () = loopi2(n-1)
in 
  loopj(pred(j)) 
end else () end // of [loopj]
in // of [loopk]
  loopk(pred(k))
end else  () end // of [loopk]  
//
val () = loopk(n-1)   

val () = array_ptr_free (pfvs1, pfvs2 | pvs)
//
in // of [gmatcol_LUdec_Crout]
  (pfpi1, pfpi2 | ppi)
end // of [gmatcol_LUdec_Crout] 

(* end of [gmatrix_col.dats] *)

