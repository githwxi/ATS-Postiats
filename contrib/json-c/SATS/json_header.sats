(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#ifndef JSON_JSON_HEADER_HATS
#define JSON_JSON_HEADER_HATS

(* ****** ****** *)

typedef json_bool = int

(* ****** ****** *)

absvtype array_list_vtype (l:addr) = ptr
vtypedef array_list (l) = array_list_vtype (l)
vtypedef
array_list0 = [l:addr | l >= null] array_list (l)
vtypedef
array_list1 = [l:addr | l >  null] array_list (l)

typedef free_fn_type = (Ptr1(*data*)) -> void

(* ****** ****** *)

absvtype lh_entry_vtype (l:addr) = ptr
vtypedef lh_entry (l:addr) = lh_entry_vtype (l)
vtypedef
lh_entry0 = [l:addr | l >= null] lh_entry (l)
vtypedef
lh_entry1 = [l:addr | l >  null] lh_entry (l)

absvtype lh_table_vtype (l:addr) = ptr
vtypedef lh_table (l:addr) = lh_table_vtype (l)
vtypedef
lh_table0 = [l:addr | l >= null] lh_table (l)
vtypedef
lh_table1 = [l:addr | l >  null] lh_table (l)

(* ****** ****** *)

(*
typedef
void(lh_entry_free_fn)(struct lh_entry *e)
*)
typedef
lh_entry_free_fn_type = (lh_entry1) -> void

(*
typedef
int(lh_equal_fn)(const void *k1, const void *k2)
*)
typedef
lh_equal_fn_type = (Ptr0, Ptr0) -<> int

(*
typedef
unsigned long(lh_hash_fn)(const void *k)
*)
typedef lh_hash_fn_type = (Ptr0) -<> ulint

(* ****** ****** *)

absvtype printbuf_vtype (l:addr) = ptr
vtypedef printbuf (l) = printbuf_vtype (l)
vtypedef
printbuf0 = [l:addr | l >= null] printbuf (l)
vtypedef
printbuf1 = [l:addr | l >  null] printbuf (l)

(* ****** ****** *)

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
} json_type;
*)

abst@ype json_type_type = int
typedef json_type = json_type_type
//
macdef json_type_null = $extval(json_type, "json_type_null")
macdef json_type_boolean = $extval(json_type, "json_type_boolean")
macdef json_type_double = $extval(json_type, "json_type_double")
macdef json_type_int = $extval(json_type, "json_type_int")
macdef json_type_object = $extval(json_type, "json_type_object")
macdef json_type_array = $extval(json_type, "json_type_array")
macdef json_type_string = $extval(json_type, "json_type_string")
//
(* ****** ****** *)

absvtype json_object_vtype (l:addr) = ptr
vtypedef json_object (l) = json_object_vtype (l)
vtypedef
json_object0 = [l:addr | l >= null] json_object (l)
vtypedef
json_object1 = [l:addr | l >  null] json_object (l)

(* ****** ****** *)

#endif // end of [JSON_JSON_HEADER_HATS]

(* ****** ****** *)

(* end of [json_header.sats] *)
