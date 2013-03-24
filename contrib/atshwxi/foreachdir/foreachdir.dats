(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)
//
// HX-2013-02:
// A package for traversing directories
//
(* ****** ****** *)

staload "libc/SATS/dirent.sats"

(* ****** ****** *)

extern
fun{} foreachdir (dirp: !DIRptr0): void
extern
fun{} foreachdir1 (dirp: !DIRptr1): void

(* ****** ****** *)

absvtype direntp_vtype = ptr
vtypedef direntp = direntp_vtype
absvtype direntplst_vtype = ptr
vtypedef direntplst = direntplst_vtype

(* ****** ****** *)
//
extern
fun{} direntplst_insert
  (xs: direntplst, x: direntp): direntplst
//
extern
fun{} direntplst_takeout (xs: &direntplst >> _): direntp
//
(* ****** ****** *)
//
extern
fun{} direntparr_sort
  {n:int} (A: !arrayptr (direntp, n), n: size_t n): void
//
(* ****** ****** *)

implement{}
foreachdir (dirp) =
  if DIRptr2ptr (dirp) > 0 then foreachdir1 (dirp) else ()
// end of [foreachdir]

(* ****** ****** *)

extern
fun{} foreach_direntp (x: direntp): void
extern
fun{} foreach_direntplst (xs: direntplst): void

(* ****** ****** *)

(* end of [foreachdir.dats] *)
