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

(*
** stream of characters
*)

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

absvtype
cstream_vtype(tkind) = ptr
vtypedef
cstream(tk:tkind) = cstream_vtype(tk)

(* ****** ****** *)

tkindef TKfun = "TKfun"
tkindef TKcloref = "TKcloref"
tkindef TKstring = "TKstring"
tkindef TKstrptr = "TKstrptr"
tkindef TKfileref = "TKfileref"
tkindef TKfileptr = "TKfileptr"

(* ****** ****** *)

vtypedef
cstream = [tk:tkind] cstream(tk)

(* ****** ****** *)

fun cstream_free (cstream): void

(* ****** ****** *)

fun cstream_get_char (!cstream): int

(* ****** ****** *)

fun cstream_make_fun (() -> int): cstream(TKfun)
fun cstream_make_cloref (() -<cloref1> int): cstream(TKcloref)

(* ****** ****** *)

fun cstream_make_string (string): cstream(TKstring)
fun cstream_make_strptr (Strptr1): cstream(TKstrptr)

(* ****** ****** *)
//
fun
cstream_make_fileref (FILEref): cstream(TKfileref)
fun
cstream_make_fileptr
  {l:agz}{m:fmode}
  (file_mode_lte (m, r) | FILEptr(l, m)): cstream(TKfileptr)
//
(* ****** ****** *)

(* end of [cstream.sats] *)
