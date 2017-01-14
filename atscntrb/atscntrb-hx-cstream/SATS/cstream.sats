(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Start Time: January, 2014
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

(*
** cstream:
** stream of characters
*)

(* ****** ****** *)
//
staload
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)
//
absvtype
cstream_vtype(tkind) = ptr
//
vtypedef
cstream(tk:tkind) = cstream_vtype(tk)
vtypedef cstream = [tk:tkind] cstream(tk)
//
(* ****** ****** *)

tkindef TKfun = "TKfun"
tkindef TKcloref = "TKcloref"
tkindef TKstring = "TKstring"
tkindef TKstrptr = "TKstrptr"
tkindef TKfileref = "TKfileref"
tkindef TKfileptr = "TKfileptr"

(* ****** ****** *)

fun{}
cstream_get_char (!cstream): int

(* ****** ****** *)

fun{tk:tk}
cstream_getv_char{n:nat}
  (!cstream(tk), &bytes(n) >> _, n: int(n)): natLte(n)
// end of [cstream_getv_char]

(* ****** ****** *)
//
// HX-2014-01:
// read at most n chars if n >= 0
// read the rest of chars if n < 0
//
fun{}
cstream_get_charlst (!cstream, n: int): List0_vt(char)
//
(* ****** ****** *)

fun cstream_free (cstream): void

(* ****** ****** *)

fun cstream_make_fun (() -> int): cstream(TKfun)

(* ****** ****** *)

fun
cstream_make_cloref (() -<cloref1> int): cstream(TKcloref)

(* ****** ****** *)
//
symintr
cstream_get_range
//
fun
cstream_string_get_range
  {i,j:nat | i <= j}
  (!cstream(TKstring), int i, int j): Strptr1
fun
cstream_strptr_get_range
  {i,j:nat | i <= j}
  (!cstream(TKstrptr), int i, int j): Strptr1
//
overload
cstream_get_range with cstream_string_get_range 
overload
cstream_get_range with cstream_strptr_get_range 
//
(* ****** ****** *)

fun
cstream_make_string (string): cstream(TKstring)
fun
cstream_make_strptr (Strptr1): cstream(TKstrptr)

(* ****** ****** *)
//
fun
cstream_make_fileref (FILEref): cstream(TKfileref)
//
fun
cstream_make_fileptr
  {l:agz}{m:fmode}
  (file_mode_lte(m, r) | FILEptr(l, m)): cstream(TKfileptr)
//
(* ****** ****** *)
//
// HX-2014-05-08:
// Convenience functions
// for performing tokenization
//
(* ****** ****** *)
//
staload
SBF = "libats/SATS/stringbuf.sats"
//
vtypedef stringbuf = $SBF.stringbuf
//
fun{}
cstream_tokenize_uint
  (!cstream, c0: &int >> _): uint
//
fun{}
cstream_tokenize_ident
  (!cstream, c0: &int >> _, !stringbuf): Strptr1
//
fun{}
cstream_tokenize_string
  (!cstream, c0: &int >> _, !stringbuf): Strptr1
//
(* ****** ****** *)

(* end of [cstream.sats] *)
