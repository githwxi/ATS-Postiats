/*
** API for json-c in ATS
*/

/* ****** ****** */

/*
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
*/

/* ****** ****** */

/*
** Start Time: May, 2013
** Author Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
*/

/* ****** ****** */

#ifndef JSONC_JSON_CATS
#define JSONC_JSON_CATS

/* ****** ****** */

#include <../json-c/json.h>

/* ****** ****** */

#define \
atscntrb_jsonc_json_c_version() ((char*)(json_c_version()))
#define \
atscntrb_jsonc_json_c_version_num() ((int)(json_c_version_num()))

/* ****** ****** */

typedef 
struct
json_object_iterator
json_object_iterator_struct ;

/* ****** ****** */

#define atscntrb_jsonc_array_list_new array_list_new
#define atscntrb_jsonc_array_list_free array_list_free
#define atscntrb_jsonc_array_list_length array_list_length
#define atscntrb_jsonc_array_list_add array_list_add
#define atscntrb_jsonc_array_list_put_idx array_list_put_idx
#define atscntrb_jsonc_array_list_get_idx array_list_get_idx
#define atscntrb_jsonc_array_list_sort array_list_sort

/* ****** ****** */

ATSinline()
atstype_ptr
atscntrb_jsonc_lh_entry_get_key (atstype_ptr ent)
{
  return (atstype_ptr)(((struct lh_entry*)ent)->k) ;
}
ATSinline()
atstype_ptr
atscntrb_jsonc_lh_entry_get_val (atstype_ptr ent)
{
  return (atstype_ptr)(((struct lh_entry*)ent)->v) ;
}

/* ****** ****** */
//
#define atscntrb_jsonc_lh_table_new lh_table_new
//
#define atscntrb_jsonc_lh_char_hash lh_char_hash
#define atscntrb_jsonc_lh_char_equal lh_char_equal
#define atscntrb_jsonc_lh_kchar_table_new(size, name, free_fn) \
  lh_kchar_table_new(size, name, (lh_entry_free_fn*)free_fn)
//
#define atscntrb_jsonc_lh_ptr_hash lh_ptr_hash
#define atscntrb_jsonc_lh_ptr_equal lh_ptr_equal
#define atscntrb_jsonc_lh_kptr_table_new(size, name, free_fn) \
  lh_kptr_table_new(size, name, (lh_entry_free_fn*)free_fn)
//
#define atscntrb_jsonc_lh_table_free lh_table_free
//
#define atscntrb_jsonc_lh_table_length lh_table_length
//
#define atscntrb_jsonc_lh_table_insert lh_table_insert
//
#define atscntrb_jsonc_lh_table_delete lh_table_delete
#define atscntrb_jsonc_lh_table_delete_entry lh_table_delete_entry
//
#define atscntrb_jsonc_lh_table_lookup(t, k) ((void*)(lh_table_lookup(t, k)))
#define atscntrb_jsonc_lh_table_lookup_ex(t, k, v) lh_table_lookup_ex(t, k, v)
#define atscntrb_jsonc_lh_table_lookup_entry(t, k) lh_table_lookup_entry(t, k)
//
#define atscntrb_jsonc_lh_table_resize lh_table_resize
//
/* ****** ****** */

#define atscntrb_jsonc_json_object_from_file json_object_from_file
#define atscntrb_jsonc_json_object_to_file json_object_to_file
#define atscntrb_jsonc_json_object_to_file_ext json_object_to_file_ext
#define atscntrb_jsonc_json_parse_int64 json_parse_int64
#define atscntrb_jsonc_json_parse_double json_parse_double
#define atscntrb_jsonc_json_type_to_name(type) ((void*)(json_type_to_name(type)))

/* ****** ****** */

#define atscntrb_jsonc_json_hex_chars json_hex_chars
#define atscntrb_jsonc_json_number_chars json_number_chars

/* ****** ****** */

#define atscntrb_jsonc_json_object_new json_object_new
#define atscntrb_jsonc_json_object_get json_object_get
#define atscntrb_jsonc_json_object_put json_object_put
#define atscntrb_jsonc_json_object_is_type json_object_is_type
#define atscntrb_jsonc_json_object_get_type json_object_get_type
#define atscntrb_jsonc_json_object_to_json_string(jso) ((void*)(json_object_to_json_string(jso)))
#define atscntrb_jsonc_json_object_to_json_string_ext(jso, flags) ((void*)(json_object_to_json_string_ext(jso, flags)))

/* ****** ****** */

#define atscntrb_jsonc_json_object_new_boolean json_object_new_boolean
#define atscntrb_jsonc_json_object_get_boolean json_object_get_boolean

#define atscntrb_jsonc_json_object_new_int json_object_new_int
#define atscntrb_jsonc_json_object_get_int json_object_get_int

#define atscntrb_jsonc_json_object_new_int64 json_object_new_int64
#define atscntrb_jsonc_json_object_get_int64 json_object_get_int64

#define atscntrb_jsonc_json_object_new_double json_object_new_double
#define atscntrb_jsonc_json_object_get_double json_object_get_double

/* ****** ****** */

#define atscntrb_jsonc_json_object_new_string json_object_new_string
#define atscntrb_jsonc_json_object_new_string_len json_object_new_string_len

#define atscntrb_jsonc_json_object_get_string(jso) ((char*)(json_object_get_string(jso)))
#define atscntrb_jsonc_json_object_get_string_len json_object_get_string_len
 
/* ****** ****** */

ATSinline()
int
json_object_array_add2
(
  struct json_object *jso
, struct json_object *val
) {
  int err ;
  err = json_object_array_add(jso, val) ;
  if (err < 0) { json_object_put (val) ; }
  return err ;
}
ATSinline()
int
json_object_array_put2_idx
(
  struct json_object *jso
, int idx, struct json_object *val
) {
  int err ;
  err = json_object_array_put_idx(jso, idx, val) ;
  if (err < 0) { json_object_put (val) ; }
  return err ;
}

/* ****** ****** */

#define atscntrb_jsonc_json_object_new_array json_object_new_array
#define atscntrb_jsonc_json_object_get_array json_object_get_array
#define atscntrb_jsonc_json_object_array_length json_object_array_length
#define atscntrb_jsonc_json_object_array_add json_object_array_add
#define atscntrb_jsonc_json_object_array_add2 json_object_array_add2
#define atscntrb_jsonc_json_object_array_put_idx json_object_array_put_idx
#define atscntrb_jsonc_json_object_array_put2_idx json_object_array_put2_idx
#define atscntrb_jsonc_json_object_array_get_idx json_object_array_get_idx

/* ****** ****** */

#define atscntrb_jsonc_json_object_new_object json_object_new_object
#define atscntrb_jsonc_json_object_get_object json_object_get_object
#define atscntrb_jsonc_jsob_object_object_length jsob_object_object_length
#define atscntrb_jsonc_json_object_object_add json_object_object_add
#define atscntrb_jsonc_json_object_object_del json_object_object_del
#define atscntrb_jsonc_json_object_object_get json_object_object_get

/* ****** ****** */

ATSinline()
atsvoid_t0ype
atscntrb_jsonc_json_object_iter_clear
  (void* jso, void *jsi) { return ; }
// end of [json_object_iter_clear]

ATSinline()
atstype_bool
atscntrb_jsonc_json_object_iter_equal
  (void *jsi1, void *jsi2)
{
  int equal = json_object_iter_equal(jsi1, jsi2) ;
  return (equal != 0 ? 1 : 0) ;
}
ATSinline()
atstype_bool
atscntrb_jsonc_json_object_iter_notequal
  (void *jsi1, void *jsi2)
{
  int equal = json_object_iter_equal(jsi1, jsi2) ;
  return (equal != 0 ? 0 : 1) ;
}

#define atscntrb_jsonc_json_object_iter_begin json_object_iter_begin
#define atscntrb_jsonc_json_object_iter_end json_object_iter_end
#define atscntrb_jsonc_json_object_iter_next json_object_iter_next
#define atscntrb_jsonc_json_object_iter_peek_name(jsi) ((void*)(json_object_iter_peek_name(jsi)))
#define atscntrb_jsonc_json_object_iter_peek_value(jsi) ((void*)(json_object_iter_peek_value(jsi)))

/* ****** ****** */

ATSinline()
atstype_int
atscntrb_jsonc_json_tokener_get_char_offset
  (void *tok)
{
  return ((json_tokener*)tok)->char_offset ;
}

/* ****** ****** */

#define \
atscntrb_jsonc_json_tokener_error_desc json_tokener_error_desc
#define atscntrb_jsonc_json_tokener_get_error json_tokener_get_error

#define atscntrb_jsonc_json_tokener_new json_tokener_new
#define atscntrb_jsonc_json_tokener_new_ex json_tokener_new_ex

#define atscntrb_jsonc_json_tokener_free json_tokener_free

#define atscntrb_jsonc_json_tokener_reset json_tokener_reset

#define atscntrb_jsonc_json_tokener_parse json_tokener_parse
#define atscntrb_jsonc_json_tokener_parse_verbose json_tokener_parse_verbose
#define atscntrb_jsonc_json_tokener_parse_ex json_tokener_parse_ex

#define atscntrb_jsonc_json_tokener_set_flags json_tokener_set_flags

/* ****** ****** */

#endif // ifndef JSONC_JSON_CATS

/* ****** ****** */

/* end of [json.cats] */
