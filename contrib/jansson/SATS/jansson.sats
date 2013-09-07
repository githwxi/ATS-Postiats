(*
** Copyright (C) 2010 Chris Double.
**
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
** Time: September, 2012
** Author Hongwei Xi (gmhwxi AT gmail DOT com)
**
** The API is modified in the hope that it can be used more conveniently.
*)

(* ****** ****** *)

%{#
#include "jansson/CATS/jansson.cats"
%}

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.jansson"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_jansson_" // prefix for external names

(* ****** ****** *)

typedef SHR(x:type) = x // for commenting purpose
typedef NSH(x:type) = x // for commenting purpose

(* ****** ****** *)

typedef charptr = ptr

(* ****** ****** *)
//
abst@ype json_type = $extype"json_type"
//
macdef JSON_OBJECT   = $extval (json_type, "JSON_OBJECT")
macdef JSON_ARRAY    = $extval (json_type, "JSON_ARRAY")
macdef JSON_STRING   = $extval (json_type, "JSON_STRING")
macdef JSON_INTEGER  = $extval (json_type, "JSON_INTEGER")
macdef JSON_REAL     = $extval (json_type, "JSON_REAL")
macdef JSON_TRUE     = $extval (json_type, "JSON_TRUE")
macdef JSON_FALSE    = $extval (json_type, "JSON_FALSE")
macdef JSON_NULL     = $extval (json_type, "JSON_NULL")
//
abst@ype json_t = $extype"json_t" // json_type + refcount
//
typedef
json_error_t =
$extype_struct"json_error_t" of
{
  line= int, column= int, position= int, source= charptr, text= charptr
} // end of [json_error_t]
//
abst@ype
json_int_t = $extype"json_int_t" // largest available int type
//
(* ****** ****** *)

absvtype JSONptr (l:addr) = ptr // json_t*
vtypedef JSONptr0 = [l:addr] JSONptr (l)
vtypedef JSONptr1 = [l:addr | l > null] JSONptr (l)

(* ****** ****** *)

absvtype JSONiter (l1:addr, l2:addr) = ptr
vtypedef JSONiter0 (l1:addr) = [l2:addr] JSONiter (l1, l2)
vtypedef JSONiter1 (l1:addr) = [l2:addr | l2 > null] JSONiter (l1, l2)

(* ****** ****** *)

praxi
JSONptr_is_gtez {l:addr} (x: !JSONptr l): [l >= null] void

(* ****** ****** *)

castfn JSONptr2ptr {l:addr} (x: !JSONptr l):<> ptr (l)
castfn JSONiter2ptr {l1,l2:addr} (x: !JSONiter (l1, l2)):<> ptr (l2)

(* ****** ****** *)

praxi
JSONptr_free_null
  {l:addr | l <= null} (x: JSONptr l): void
// end of [JSONptr_free_null]

(* ****** ****** *)

fun JSONptr_is_null
  {l:addr} (x: !JSONptr l):<> bool (l==null) = "mac#atspre_ptr_is_null"
// end of [JSONptr_is_null]

fun JSONptr_isnot_null
  {l:addr} (x: !JSONptr (l)):<> bool (l > null) = "mac#atspre_ptr_isnot_null"
// end of [JSONptr_isnot_null]

overload ~ with JSONptr_isnot_null

(* ****** ****** *)

fun json_typeof (json: !JSONptr1): int = "mac#%"

(* ****** ****** *)
//
// HX-2012-09:
// these functions currently indeed return 0/1 for false/true
//
fun json_is_null
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
fun json_is_true
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
fun json_is_false
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"

fun json_is_boolean
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
  
fun json_is_integer
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
fun json_is_real
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
fun json_is_number
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"

fun json_is_string
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
fun json_is_array
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"
fun json_is_object
  {l:addr} (json: !JSONptr (l)) : bool = "mac#%"

(* ****** ****** *)

fun json_incref
  {l:agz}
  (json: !JSONptr (l)) : JSONptr (l) = "mac#%"

fun json_decref
  {l:addr} (json: JSONptr (l)) : void = "mac#%"

(* ****** ****** *)

fun json_null () : JSONptr1 = "mac#%"
fun json_true () : JSONptr1 = "mac#%"
fun json_false () : JSONptr1 = "mac#%"

(* ****** ****** *)

fun json_string
  (value: NSH(string)) : JSONptr0 = "mac#%"
// end of [json_string]

fun json_string_nocheck
  (value: NSH(string)) : JSONptr0 = "mac#%"
// end of [json_string_nocheck]

fun json_string_value
  {l1:agz} (
  json: !JSONptr (l1)
) : [l2:agz]
  (minus (JSONptr l1, strptr l2) | strptr l2) = "mac#%"
// end of [json_string_value]

fun json_string_set
  (json: !JSONptr1, value: NSH(string)): int = "mac#"

fun json_string_set_nocheck
  (json: !JSONptr1, value: NSH(string)): int = "mac#%"

(* ****** ****** *)

typedef json_int = json_int_t

castfn int2json_int (x: int): json_int
castfn lint2json_int (x: lint): json_int
castfn llint2json_int (x: llint): json_int

fun json_integer
  (value: json_int) : JSONptr0 = "mac#%"

fun json_integer_value
  (json: !JSONptr1): json_int = "mac#%"

fun json_integer_set
  (json: !JSONptr1, value: json_int): int(*err*) = "mac#%"

(* ****** ****** *)

fun json_real (value: int) : JSONptr0 = "mac#%"

fun json_real_value (json: !JSONptr1): double = "mac#%"

fun json_real_set (json: !JSONptr1, value: double): int = "mac#%"

(* ****** ****** *)

fun json_number_value (json: !JSONptr1): double = "mac#%"

(* ****** ****** *)

fun json_array ((*void*)) : JSONptr0 = "mac#%"

fun json_array_size (json: !JSONptr1) : size_t = "mac#%"

(* ****** ****** *)

fun json_array_get
  {l1:agz} (
  json: !JSONptr (l1), index: size_t
) : [l2:addr]
  (minus (JSONptr l1, JSONptr l2) | JSONptr l2) = "mac#%"
// end of [json_array_get]

fun json_array_get_exnmsg
  {l1:agz} (
  json: !JSONptr (l1), index: size_t, msg: NSH(string)
) : [l2:agz]
  (minus (JSONptr l1, JSONptr l2) | JSONptr l2) = "mac#%"
// end of [json_array_get_exnmsg]

macdef
json_array_get_exnloc (x, i) =
  json_array_get_exnmsg (,(x), ,(i), $mylocation)
// end of [json_array_get_exnloc]

(* ****** ****** *)

fun json_array_get1
  (json: !JSONptr1, index: size_t): JSONptr0 = "mac#%"

fun json_array_get1_exnmsg
  (json: !JSONptr1, index: size_t, msg: NSH(string)): JSONptr1 = "mac#%"

macdef
json_array_get1_exnloc (x, i) =
  json_array_get1_exnmsg (,(x), ,(i), $mylocation)
// end of [json_array_get1_exnloc]

(* ****** ****** *)

fun json_array_set
(
  json: !JSONptr1, index: size_t, value: !JSONptr0(*preserved*)
) : int(*err*) = "mac#%"

fun json_array_set_new
(
  json: !JSONptr1, index: size_t, value: JSONptr0 /*consumed*/
) : int(*err*) = "mac#%"

fun json_array_append
(
  json: !JSONptr1, index: size_t, value: !JSONptr0(*preserved*)
) : int(*err*) = "mac#%"

fun json_array_append_new
(
  json: !JSONptr1, index: size_t, value: JSONptr0 /*consumed*/
) : int(*err*) = "mac#%"

fun json_array_insert
(
  json: !JSONptr1, index: size_t, value: !JSONptr0(*preserved*)
) : int(*err*) = "mac#%"

fun json_array_insert_new
(
  json: !JSONptr1, index: size_t, value: JSONptr0 /*consumed*/
) : int(*err*) = "mac#%"

fun json_array_remove
  (json: !JSONptr1, index: size_t): int(*err*) = "mac#%"

fun json_array_clear (json: !JSONptr1): int(*0*) = "mac#%"

fun json_array_extend
  (json1: !JSONptr1, json2: !JSONptr1): int(*err*) = "mac#%"
// end of [json_array_extend]

(* ****** ****** *)

fun json_object ((*void*)) : JSONptr0 = "mac#%"

fun json_object_size (json: !JSONptr1): size_t = "mac#%"

fun json_object_get
  {l1:agz} (
  json: !JSONptr l1, key: NSH(string)
) : [l2:addr]
  (minus (JSONptr l1, JSONptr l2) | JSONptr l2) = "mac#%"
// end of [json_object_get]

fun
json_object_get_exnmsg {l1:agz}
(
  json: !JSONptr l1, key: NSH(string), msg: NSH(string)
) : [l2:agz]
(
  minus (JSONptr l1, JSONptr l2) | JSONptr l2
) = "mac#%" // end of [json_object_get_exnmsg]

macdef
json_object_get_exnloc (x, k) =
  json_object_get_exnmsg (,(x), ,(k), $mylocation)
// end of [json_object_get_exnloc]

(* ****** ****** *)

fun json_object_get1
  (json: !JSONptr1, key: NSH(string)): JSONptr0 = "mac#%"

fun json_object_get1_exnmsg
  (json: !JSONptr1, key: NSH(string), msg: NSH(string)): JSONptr1 = "mac#%"
// end of [json_object_get1_exnmsg]

macdef
json_object_get1_exnloc (x, k) =
  json_object_get1_exnmsg (,(x), ,(k), $mylocation)
// end of [json_object_get1_exnloc]

(* ****** ****** *)

fun json_object_set
(
  json: !JSONptr1, key: NSH(string), value: !JSONptr0 (*preserved*)
) : int(*err*) = "mac#%" // endfun

fun json_object_set_nocheck
(
  json: !JSONptr1, key: NSH(string), value: !JSONptr0 (*preserved*)
) : int(*err*) = "mac#%"

fun json_object_set_new
(
  json: !JSONptr1, key: NSH(string), value: JSONptr0 /*consumed*/
) : int(*err*) = "mac#%"

fun json_object_set_new_nocheck
(
  json: !JSONptr1, key: NSH(string), value: JSONptr0 /*consumed*/
) : int(*err*) = "mac#%"

fun json_object_del
(
  json: !JSONptr1, key: NSH(string)
) : int(*err*) = "mac#%"

fun json_object_clear (json: !JSONptr1): int(*err*) = "mac#%"

fun json_object_update
  (json1: !JSONptr1, json2: !JSONptr0) : int(*err*) = "mac#%"

fun json_object_update_existing
  (json1: !JSONptr1, json2: !JSONptr0) : int(*err*) = "mac#%"

fun json_object_update_missing
  (json1: !JSONptr1, json2: !JSONptr0) : int(*err*) = "mac#%"
// end of [json_object_update_missing]

(* ****** ****** *)

praxi
JSONiter_is_gtez
  {l1,l2:addr}
  (x: !JSONiter (l1, l2)): [l2 >= null] void
// end of [JSONiter_is_gtez]

praxi
JSONiter_free_null
  {l1,l2:addr | l2 <= null} (x: JSONiter (l1, l2)): void
// end of [JSONiter_free_null]

praxi
JSONiter_return
  {l1,l2:addr}
  (json: !JSONptr l1, iter: JSONiter (l1, l2)): void
// end of [JSONiter_return]

(* ****** ****** *)

fun JSONiter_is_null
  {l1,l2:addr}
  (x: !JSONiter (l1, l2)):<> bool (l2==null) = "mac#atspre_ptr_is_null"
// end of [JSONiter_is_null]

fun JSONiter_isnot_null
  {l1,l2:addr}
  (x: !JSONiter (l1, l2)):<> bool (l2 > null) = "mac#atspre_ptr_isnot_null"
// end of [JSONiter_isnot_null]

overload ~ with JSONiter_isnot_null

(* ****** ****** *)

fun json_object_iter
  {l:agz} (json: !JSONptr (l)) : JSONiter0 (l) = "mac#%"

fun json_object_iter_at
  {l:agz} (json: !JSONptr (l), key: NSH(string)): JSONiter0 (l) = "mac#%"
// end of [json_object_iter_at]

fun json_object_iter_next
  {l1,l2:agz} (
  json: !JSONptr l1, iter: !JSONiter (l1, l2)
) : JSONiter0 (l1) = "mac#%" // endfun

fun json_object_iter_nextret
  {l1,l2:agz} (
  json: !JSONptr l1, iter:  JSONiter (l1, l2)
) : JSONiter0 (l1) = "mac#%" // endfun

(* ****** ****** *)

absvtype
objkey_addr_vtype (l:addr) = ptr
stadef objkey = objkey_addr_vtype

praxi
objkey_return
  {l:addr} (json: !JSONptr l, key: objkey l):<> void
// end of [objkey_return]

fun json_object_iter_key
  {l1,l2:agz} (iter: !JSONiter (l1, l2)): objkey l1 = "mac#%"

fun json_object_iter_value
  {l1,l2:agz} (iter: !JSONiter (l1, l2)): JSONptr1 = "mac#%"

(* ****** ****** *)

fun json_object_iter_set
  {l1,l2,l3:agz} (
  json: !JSONptr l1
, iter: !JSONiter (l1, l2)
, value: !JSONptr l3(*preserved*)
) : int(*err*) = "mac#%" // endfun

fun json_object_iter_set_new
  {l1,l2,l3:agz} (
  json: !JSONptr l1
, iter: !JSONiter (l1, l2)
, value:  JSONptr l3 /*consumed*/
) : int(*err*) = "mac#%" // endfun

(* ****** ****** *)

/*
void *json_object_key_to_iter(const char *key)
*/
fun json_object_key_to_iter
  {l:addr} (key: objkey (l)): JSONiter1 (l) = "mac#%"
// end of [json_object_key_to_iter]

(* ****** ****** *)

macdef JSON_COMPACT = $extval (int, "JSON_COMPACT")
macdef JSON_ENSURE_ASCII = $extval (int, "JSON_ENSURE_ASCII")
macdef JSON_SORT_KEYS = $extval (int, "JSON_SORT_KEYS")
macdef JSON_PRESERVE_ORDER = $extval (int, "JSON_PRESERVE_ORDER")
macdef JSON_ENCODE_ANY = $extval (int, "JSON_ENCODE_ANY")

(* ****** ****** *)

typedef json_err = json_error_t

(* ****** ****** *)

fun json_loads
(
  inp: NSH(string)
, flags: int
, error: &json_err? >> json_err
) : JSONptr0 = "mac#%" // endfun

fun json_loadb
  {lb:addr}
  {n1,n2:int | n1 >= n2}
(
  pf: !bytes(n1) @ lb
| bufp: ptr lb, n2: size_t n2
, flags: int
, error: &json_err? >> json_err
) : JSONptr0 = "mac#%" // endfun

fun json_loadf
(
  inp: FILEref
, flags: int
, error: &json_err? >> json_err
) : JSONptr0 = "mac#%" // endfun

fun json_load_file
(
  path: NSH(string)
, flags: int
, error: &json_err? >> json_err
) : JSONptr0 = "mac#%" // endfun

(* ****** ****** *)

fun json_dumps
  (root: !JSONptr1, flags: int): Strptr0 = "mac#%"
// end of [json_dumps]

fun json_dumpf
(
  root: !JSONptr1, out: FILEref, flags: int
) : int(*err*) = "mac#%"

fun json_dump_file
(
  root: !JSONptr1, path: NSH(string), flags: int
) : int(*err*) = "mac#%"

(* ****** ****** *)
//
// Some convenience functions
//
(* ****** ****** *)

(* end of [jasson.sats] *)
