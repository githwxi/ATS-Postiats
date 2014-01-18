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
// HX-2014-01-17: start
//
(* ****** ****** *)

(*
** filename for lexing
*)

(* ****** ****** *)

staload "./../SATS/filename.sats"

(* ****** ****** *)

assume
filename_type = '{
  fname_givename= string
, fname_partname= string, fname_fullname= string
} (* end of [filename] *)

(* ****** ****** *)

implement
filename_make
  (given, part, full) = $rec
{
  fname_givename= given, fname_partname= part, fname_fullname= full
} (* end of [filename_make] *)

(* ****** ****** *)
//
implement
print_filename_full
  (fil) = fprint_filename_full (stdout_ref, fil)
implement
prerr_filename_full
  (fil) = fprint_filename_full (stderr_ref, fil)
//
(* ****** ****** *)

implement
fprint_filename_full
  (out, fil) = fprint_string (out, fil.fname_fullname)
// end of [fprint_filename_full]

(* ****** ****** *)

implement
filename_equal
  (f1, f2) = f1.fname_fullname = f2.fname_fullname
// end of [filename_equal]

(* ****** ****** *)

(* end of [filename.dats] *)
