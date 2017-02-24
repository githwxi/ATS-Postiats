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
#define
ATS_PACKNAME "ATSCNTRB.HX.jsonats"
//
(* ****** ****** *)
//
// HX-2014-05-09:
// Some convenience functions for parsing JSON data
//
(* ****** ****** *)

datatype token =
//
  | TOKint of int
//
  | TOKident of string
//
  | TOKstring of string
//
  | TOKcolon of () // ':'
  | TOKcomma of () // ','
//
  | TOKlbrace of () // '{'
  | TOKrbrace of () // '}'
//
  | TOKlbracket of () // '['
  | TOKrbracket of () // ']'
//
  | TOKerr of (int)
//
  | TOKeof of ((*void*))
// end of [token]

(* ****** ****** *)
//
fun print_token (x: token): void
fun prerr_token (x: token): void
fun fprint_token (out: FILEref, x: token): void
//
overload print with print_token
overload prerr with prerr_token
overload fprint with fprint_token
//
(* ****** ****** *)

datatype
jsonval =
 | JSONnul of ()
//
 | JSONbool of (bool)
//
 | JSONint of (int)
 | JSONfloat of (double)
//
 | JSONstring of (string)
//
 | JSONarray of (jsonvalist)
 | JSONobject of (labjsonvalist)
//
// end of [jsonval]

where
jsonvalist = List0 (jsonval)
and
labjsonval = @(string, jsonval)
and
labjsonvalist = List0 (labjsonval)

vtypedef
jsonvalist_vt = List0_vt (jsonval)
vtypedef
labjsonvalist_vt = List0_vt (labjsonval)

(* ****** ****** *)
//
fun print_jsonval (jsonval): void
fun prerr_jsonval (jsonval): void
//
fun fprint_jsonval (FILEref, jsonval): void
fun fprint_jsonvalist (FILEref, jsonvalist): void
fun fprint_labjsonvalist (FILEref, labjsonvalist): void
//
overload print with print_jsonval
overload prerr with prerr_jsonval
//
overload fprint with fprint_jsonval
//
(* ****** ****** *)
//
fun{}
jsonval_array_get_at
  (jsonval, intGte(0)): Option_vt(jsonval)
fun{}
jsonval_object_get_key
  (jsonval, key: string): Option_vt(jsonval)
//
(* ****** ****** *)
//
fun{}
jsonats_parsexn_string (inp: string): jsonval
fun{}
jsonats_parsexnlst_string (inp: string): jsonvalist
//
fun{}
jsonats_parsexn_fileref (inp: FILEref): jsonval
fun{}
jsonats_parsexnlst_fileref (inp: FILEref): jsonvalist
//
(* ****** ****** *)

(* end of [jsonats.sats] *)
