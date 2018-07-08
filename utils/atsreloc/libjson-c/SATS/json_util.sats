(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#include "./mybasis.sats"

(* ****** ****** *)

(*
struct json_object*
json_object_from_file (const char *filename)
*)
fun json_object_from_file
  (filename: string): json_object0 = "mac#%"
// end of [json_object_from_file]

(* ****** ****** *)

(*
** HX-2013-07:
** this one is in extension
*)
fun{
} json_objlst_from_file
  (filename: string): List0_vt (json_object0)
// end of [json_objlst_from_file]
fun{
} json_objlst_from_file_delim
  (filename: string, delim: string): List0_vt (json_object0)
// end of [json_objlst_from_file_delim]

(* ****** ****** *)

(*
int json_object_to_file
  (char *filename, struct json_object *obj)
*)
fun json_object_to_file
  (filename: string, !json_object0): int(*err*) = "mac#%"

(*
int json_object_to_file_ext
  (char *filename, struct json_object *obj, int flags)
*)
fun json_object_to_file_ext
  (filename: string, !json_object0, flags: int): int(*err*) = "mac#%"

(* ****** ****** *)

(*
int json_parse_int64
  (const char *buf, int64_t *retval)
*)
fun json_parse_int64
(
  buf: string, retval: &int64? >> opt(int64, i==0)
) : #[i:int | i >= 0] int(i) = "mac#%"

(*
int json_parse_double
  (const char *buf, double *retval)
*)
fun json_parse_double
(
  buf: string, retval: &double? >> opt(double, i==0)
) : #[i:int | i >= 0] int(i) = "mac#%"
     
(* ****** ****** *)

fun json_type_to_name (type: json_type): string = "mac#%"

(* ****** ****** *)

(* end of [json_util.sats] *)
