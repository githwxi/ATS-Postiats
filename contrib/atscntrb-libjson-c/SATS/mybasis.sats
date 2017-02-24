(* ****** ****** *)

(*
** Author: Hongwei Xi
** Start Time: May, 2013
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)

#ifndef
ATSCNTRB_LIBJSONC_MYBASIS_SATS
#define
ATSCNTRB_LIBJSONC_MYBASIS_SATS

(* ****** ****** *)
//
typedef json_bool = int
//
(* ****** ****** *)
//
macdef
json_true = 1 and json_false = 0
//
(* ****** ****** *)
//
fun{}
not_json_bool(tf: json_bool): json_bool
//
(* ****** ****** *)
//
absvtype
lh_entry_vtype (l:addr) = ptr
vtypedef
lh_entry(l:addr) = lh_entry_vtype(l)
//
vtypedef
lh_entry0 = [l:agez] lh_entry(l)
vtypedef
lh_entry1 = [l:addr | l > null] lh_entry(l)
//
(* ****** ****** *)
//
absvtype
lh_table_vtype(l:addr) = ptr
vtypedef
lh_table(l:addr) = lh_table_vtype(l)
//
vtypedef
lh_table0 = [l:agez] lh_table(l)
vtypedef
lh_table1 = [l:addr | l > null] lh_table(l)
//
(* ****** ****** *)
//
absvtype
array_list_vtype(l:addr) = ptr
vtypedef
array_list(l:addr) = array_list_vtype(l)
//
vtypedef
array_list0 = [l:agez] array_list(l)
vtypedef
array_list1 = [l:addr | l > null] array_list(l)
//
(* ****** ****** *)

typedef free_fn_type = (Ptr1(*data*)) -> void

(* ****** ****** *)

(*
typedef
void(lh_entry_free_fn)(struct lh_entry *e)
*)
typedef
lh_entry_free_fn_type = (lh_entry1) -> void

(*
typedef
unsigned long(lh_hash_fn)(const void *k)
*)
typedef lh_hash_fn_type = (Ptr0) -<> ulint

(*
typedef
int(lh_equal_fn)(const void *k1, const void *k2)
*)
typedef
lh_equal_fn_type = (Ptr0, Ptr0) -<> int

(* ****** ****** *)
//
absvtype
printbuf_vtype(l:addr) = ptr
vtypedef
printbuf(l:addr) = printbuf_vtype(l)
//
vtypedef
printbuf0 = [l:agez] printbuf(l)
vtypedef
printbuf1 = [l:addr | l > null] printbuf(l)
//
(* ****** ****** *)
//
typedef json_type = int
//
(*
typedef
enum
json_type
{
/* If you change this, be sure to update json_type_to_name() too */
json_type_null,
json_type_boolean,
json_type_double,
json_type_int,
json_type_object,
json_type_array,
json_type_string,
} json_type ;
*)
//
macdef json_type_null = $extval(json_type, "json_type_null")
macdef json_type_boolean = $extval(json_type, "json_type_boolean")
macdef json_type_int = $extval(json_type, "json_type_int")
macdef json_type_double = $extval(json_type, "json_type_double")
macdef json_type_string = $extval(json_type, "json_type_string")
macdef json_type_array = $extval(json_type, "json_type_array")
macdef json_type_object = $extval(json_type, "json_type_object")
//
(* ****** ****** *)
//
absvtype
json_object_vtype (l:addr) = ptr
vtypedef
json_object(l:addr) = json_object_vtype(l)
//
vtypedef
json_object0 = [l:agez] json_object(l)
vtypedef
json_object1 = [l:addr | l > null] json_object(l)
//
(* ****** ****** *)
//
(*
** HX: the address [l] refers to the address of the object
*)
//
absvt0ype
json_object_iterator_vt0ype
  (l:addr) = $extype"json_object_iterator_struct"
//
vtypedef
json_object_iterator
  (l:addr) = json_object_iterator_vt0ype(l)
//
vtypedef
json_object_iterator = [l:addr] json_object_iterator(l)
//
(* ****** ****** *)

typedef
json_tokener_error = int
macdef json_tokener_success = $extval (int, "json_tokener_success")
macdef json_tokener_continue = $extval (int, "json_tokener_continue")
macdef json_tokener_error_depth = $extval (int, "json_tokener_error_depth")
macdef json_tokener_error_parse_eof = $extval (int, "json_tokener_error_parse_eof,")
macdef json_tokener_error_parse_unexpected = $extval (int, "json_tokener_error_parse_unexpected")
macdef json_tokener_error_parse_null = $extval (int, "json_tokener_error_parse_null")
macdef json_tokener_error_parse_boolean = $extval (int, "json_tokener_error_parse_boolean")
macdef json_tokener_error_parse_number = $extval (int, "json_tokener_error_parse_number,")
macdef json_tokener_error_parse_array = $extval (int, "json_tokener_error_parse_array")
macdef json_tokener_error_parse_object_key_name = $extval (int, "json_tokener_error_parse_object_key_name")
macdef json_tokener_error_parse_object_key_sep = $extval (int, "json_tokener_error_parse_object_key_sep")
macdef json_tokener_error_parse_object_value_sep = $extval (int, "json_tokener_error_parse_object_value_sep,")
macdef json_tokener_error_parse_string = $extval (int, "json_tokener_error_parse_string")
macdef json_tokener_error_parse_comment = $extval (int, "json_tokener_error_parse_comment")

(* ****** ****** *)
           
typedef
json_tokener_state = int
macdef json_tokener_state_eatws = $extval (int, "json_tokener_state_eatws")
macdef json_tokener_state_start = $extval (int, "json_tokener_state_start")
macdef json_tokener_state_finish = $extval (int, "json_tokener_state_finish")
macdef json_tokener_state_null = $extval (int, "json_tokener_state_null,")
macdef json_tokener_state_comment_start = $extval (int, "json_tokener_state_comment_start")
macdef json_tokener_state_comment = $extval (int, "json_tokener_state_comment")
macdef json_tokener_state_comment_eol = $extval (int, "json_tokener_state_comment_eol")
macdef json_tokener_state_comment_end = $extval (int, "json_tokener_state_comment_end")
macdef json_tokener_state_string = $extval (int, "json_tokener_state_string")
macdef json_tokener_state_string_escape = $extval (int, "json_tokener_state_string_escape")
macdef json_tokener_state_escape_unicode = $extval (int, "json_tokener_state_escape_unicode")
macdef json_tokener_state_boolean = $extval (int, "json_tokener_state_boolean")
macdef json_tokener_state_number = $extval (int, "json_tokener_state_number")
macdef json_tokener_state_array = $extval (int, "json_tokener_state_array")
macdef json_tokener_state_array_add = $extval (int, "json_tokener_state_array_add")
macdef json_tokener_state_array_sep = $extval (int, "json_tokener_state_array_sep")
macdef json_tokener_state_object_field_start = $extval (int, "json_tokener_state_object_field_start")
macdef json_tokener_state_object_field = $extval (int, "json_tokener_state_object_field")
macdef json_tokener_state_object_field_end = $extval (int, "json_tokener_state_object_field_end")
macdef json_tokener_state_object_value = $extval (int, "json_tokener_state_object_value")
macdef json_tokener_state_object_value_add = $extval (int, "json_tokener_state_object_value_add")
macdef json_tokener_state_object_sep = $extval (int, "json_tokener_state_object_sep")
macdef json_tokener_state_array_after_sep = $extval (int, "json_tokener_state_array_after_sep")
macdef json_tokener_state_object_field_start_after_sep = $extval (int, "json_tokener_state_object_field_start_after_sep")

(* ****** ****** *)
//
absvtype
json_tokener_vtype(l:addr) = ptr
vtypedef
json_tokener(l:addr) = json_tokener_vtype(l)
//
(* ****** ****** *)
//
vtypedef
json_tokener0 = [l:agez] json_tokener(l)
vtypedef
json_tokener1 = [l:addr | l > null] json_tokener(l)
//
(* ****** ****** *)

#endif // end of #ifndef(LIBJSONC_MYBASIS_SATS)

(* ****** ****** *)

(* end of [mybasis.sats] *)
