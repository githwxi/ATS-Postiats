(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#ifndef JSON_JSON_HEADER_HATS
#define JSON_JSON_HEADER_HATS

(* ****** ****** *)

typedef json_bool = bool

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

#endif // end of [JSON_JSON_HEADER_HATS]

(* ****** ****** *)

(* end of [json_header.sats] *)
