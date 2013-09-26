(*
** a quasi ML-style API in ATS for json-c
*)

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

#define ATS_PACKNAME "ATSCNTRB.jsonc_ML"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_jsonc_ML_" // prefix for external names

(* ****** ****** *)

staload "./../SATS/json.sats"

(* ****** ****** *)

datatype
jsonVal =
  | JSONnul of ()
  | JSONint of (json_int)
  | JSONbool of (json_bool)
  | JSONstring of (string)
  | JSONdouble of (double)
  | {n:nat}
    JSONarray of (arrayref (jsonVal, n), size_t (n))
  | JSONobject of labjsonValist
// end of [jsonVal]

where
json_int = llint
and
labjsonVal = @(string, jsonVal)
and
labjsonValist = List0 (labjsonVal)

(* ****** ****** *)

typedef jsonValist = List0 (jsonVal)
vtypedef jsonValist_vt = List0_vt (jsonValist)

(* ****** ****** *)
//
fun print_jsonVal (jsonVal): void
fun prerr_jsonVal (jsonVal): void
fun fprint_jsonVal (out: FILEref, x: jsonVal): void
//
overload print with print_jsonVal
overload prerr with prerr_jsonVal
overload fprint with fprint_jsonVal
//
(* ****** ****** *)
//
fun fprint_labjsonValist
  (out: FILEref, lxs: labjsonValist): void
//
(* ****** ****** *)

fun jsonVal_ofstring (str: string): jsonVal
fun jsonVal_tostring (jsv: jsonVal): Strptr1

(* ****** ****** *)

fun json_object2val0 (jso: json_object0): jsonVal
fun json_object2val1 (jso: !json_object0): jsonVal

(* ****** ****** *)

(* end of [json_ML.sats] *)
