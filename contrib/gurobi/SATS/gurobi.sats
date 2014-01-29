(* ****** ****** *)
//
// API in ATS for GUROBI
//
(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Brandon Barker 
** Authoremail: brandonDOTbarkerATgmailDOTcom)
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi (gmhwxiDOTgmailDOTcom)
*)

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.gurobi" // package name
#define ATS_EXTERN_PREFIX "atscntrb_gurobi_" // prefix for external names"

(* ****** ****** *)

typedef interr(i:int) = int(i)

(* ****** ****** *)
//
absvtype
GRBenvptr (l:addr) = ptr (l)
//
vtypedef GRBenvptr0 = [l:addr] GRBenvptr(l)
vtypedef GRBenvptr1 = [l:addr | l > null] GRBenvptr(l)
//
(* ****** ****** *)
//
absvtype
GRBmodelptr (l:addr) = ptr (l)
//
vtypedef GRBmodelptr0 = [l:addr] GRBmodelptr(l)
vtypedef GRBmodelptr1 = [l:addr | l > null] GRBmodelptr(l)
//
(* ****** ****** *)

fun GRBloadenv
(
  envP: &ptr? >> opt(GRBenvptr1, i==0), logfilename: stropt
) : #[i:nat] interr (i) = "mac#%"

(* ****** ****** *)

fun GRBloadclientenv
(
  envP: &ptr? >> opt(GRBenvptr1, i==0), logfilename: stropt
, server: stropt, port: int, passwd: stropt, priority: int, timeout: double
) : #[i:nat] interr (i) = "mac#%"

(* ****** ****** *)

fun GRBfreeenv (env: GRBenvptr0): void = "mac#%"

(* ****** ****** *)

fun
GRBloadmodel
  {nv,nc:nat}
(
  env		: !GRBenvptr1
, modelP	: &ptr? >> opt(GRBmodelptr1, i==0)
, Pname		: string
, numvars	: int(nv)
, numconstrs	: int(nc)
, objsense	: int // 1(min) or -1(max)
, objcon	: double
, obj		: carrayref0(double, nv)
, sense		: carrayref1(char, nc)
, rhs		: carrayref0(double, nc)
, vbeg		: carrayref1(int, nv)
, vlen		: carrayref1(int, nv)
, vind		: cPtr1 (int)
, vval		: cPtr1 (double)
, lb		: carrayref0(double, nv)
, ub		: carrayref0(double, nv)
, vtype		: carrayref0(char, nv)
, varnames	: carrayref0(string, nv)
, constrnames	: carrayref0(string, nc)
) : #[i:nat] interr (i) = "mac#%"


(* ****** ****** *)

(* end of [gurobi.sats] *)
