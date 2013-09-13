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
// Author: Hongwei Xi
// Authoremail: hwxi AT gmail DOT com
// Start Time: February, 2013
//
(* ****** ****** *)
//
// HX-2013-02:
// A package for multiple-precision integers
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libats-hwxi.intinf"

(* ****** ****** *)
//
abstype intinf_type (i:int) = ptr
absvtype intinf_vtype (i:int) = ptr
//
(* ****** ****** *)

castfn
intinf_vt2t{i:int}
  (x: intinf_vtype (i)):<> intinf_type (i)
// end of [intinf_vt2t]

(* ****** ****** *)

castfn
intinf_takeout
  {i:int} (x: intinf_type (i)):<> vttakeout0 (intinf_vtype (i))
// end of [intinf_takeout]

(* ****** ****** *)

castfn
intinf_vcopy
  {i:int} (x: !intinf_vtype (i)):<> vttakeout0 (intinf_vtype (i))
// end of [intinf_vcopy]

(* ****** ****** *)

(* end of [intinf.sats] *)
