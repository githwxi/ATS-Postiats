/*
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
*/

/* ****** ****** */

/*
** Time: September, 2012
** Author Hongwei Xi (gmhwxi AT gmail DOT com)
**
** The API is simplied a bit in the hope that it can be used more easily.
*/

/* ****** ****** */

#ifndef JANSSON_JANSSON_CATS
#define JANSSON_JANSSON_CATS

/* ****** ****** */

#include <jansson.h>

/* ****** ****** */

typedef json_t *JSONptr ;
typedef const json_t *JSONconstptr ;

/* ****** ****** */

#define atscntrb_jansson_json_typeof json_typeof

/* ****** ****** */

#define \
atscntrb_jansson_json_is_null(x) json_is_null((JSONptr)x)
#define \
atscntrb_jansson_json_is_true(x) json_is_true((JSONptr)x)
#define \
atscntrb_jansson_json_is_false(x) json_is_false((JSONptr)x)

#define \
atscntrb_jansson_json_is_boolean(x) json_is_boolean((JSONptr)x)

#define \
atscntrb_jansson_json_is_integer(x) json_is_integer((JSONptr)x)
#define \
atscntrb_jansson_json_is_real(x) json_is_real((JSONptr)x)
#define \
atscntrb_jansson_json_is_number(x) json_is_number((JSONptr)x)

#define \
atscntrb_jansson_json_is_string(x) json_is_string((JSONptr)x)

#define \
atscntrb_jansson_json_is_array(x) json_is_array((JSONptr)x)

#define \
atscntrb_jansson_json_is_object(x) json_is_object((JSONptr)x)

/* ****** ****** */

#define atscntrb_jansson_json_incref json_incref
#define atscntrb_jansson_json_decref json_decref

/* ****** ****** */

#define atscntrb_jansson_json_null json_null
#define atscntrb_jansson_json_true json_true
#define atscntrb_jansson_json_false json_false

/* ****** ****** */

#define atscntrb_jansson_json_integer json_integer
#define atscntrb_jansson_json_integer_value json_integer_value
#define atscntrb_jansson_json_integer_set json_integer_set

/* ****** ****** */

#define atscntrb_jansson_json_real json_real
#define atscntrb_jansson_json_real_value json_real_value
#define atscntrb_jansson_json_real_set json_real_set

/* ****** ****** */

#define atscntrb_jansson_json_number_value json_number_value

/* ****** ****** */

#define atscntrb_jansson_json_string json_string
#define atscntrb_jansson_json_string_nocheck json_string_nocheck

#define \
atscntrb_jansson_json_string_value(x) ((char*)json_string_value(x))

#define atscntrb_jansson_json_string_set json_string_set
#define atscntrb_jansson_json_string_set_nocheck json_string_set_nocheck

/* ****** ****** */

#define atscntrb_jansson_json_array json_array

#define atscntrb_jansson_json_array_size json_array_size

/* ****** ****** */

#define atscntrb_jansson_json_array_get json_array_get

/* ****** ****** */

ATSinline()
atstype_ptr
atscntrb_jansson_json_array_get_exnmsg
(
 atstype_ptr json, atstype_size ind, atstype_ptr msg
) {
  JSONptr itm ;
  itm = atscntrb_jansson_json_array_get (json, ind) ;
  if (!itm) {
    fprintf (stderr, "exit(ATS): json_array_get: %s\n", (char*)msg) ; exit (1);
  } // end of [if]
  return itm ;
} // end of [atscntrb_jansson_json_array_get_exnmsg]

/* ****** ****** */

ATSinline()
atstype_ptr
atscntrb_jansson_json_array_get1
(
  atstype_ptr json, atstype_size ind
) {
  JSONptr itm ;
  itm = json_array_get((JSONptr)json, ind);
  if (itm) json_incref(itm) ;
  return (itm) ;
} // end of [atscntrb_jansson_json_array_get1]

ATSinline()
atstype_ptr
atscntrb_jansson_json_array_get1_exnmsg
(
  atstype_ptr json, atstype_size ind, atstype_ptr msg
) {
  JSONptr itm ;
  itm = atscntrb_jansson_json_array_get1 (json, ind) ;
  if (!itm) {
    fprintf (stderr, "exit(ATS): json_array_get1: %s\n", (char*)msg) ; exit (1);
  } // end of [if]
  return (itm) ;
} // end of [atscntrb_jansson_json_array_get1_exnmsg]

/* ****** ****** */

#define atscntrb_jansson_json_array_set json_array_set
#define atscntrb_jansson_json_array_set_new json_array_set_new

#define atscntrb_jansson_json_array_append json_array_append
#define atscntrb_jansson_json_array_append_new json_array_append_new

#define atscntrb_jansson_json_array_insert json_array_insert
#define atscntrb_jansson_json_array_insert_new json_array_insert_new

#define atscntrb_jansson_json_array_remove json_array_remove

#define atscntrb_jansson_json_array_clear json_array_clear

#define atscntrb_jansson_json_array_extend json_array_extend

/* ****** ****** */

#define atscntrb_jansson_json_object json_object

#define atscntrb_jansson_json_object_size json_object_size

/* ****** ****** */

#define atscntrb_jansson_json_object_get json_object_get

ATSinline()
atstype_ptr
atscntrb_jansson_json_object_get_exnmsg
(
 atstype_ptr json, atstype_ptr key, atstype_ptr msg
) {
  JSONptr itm ;
  itm = atscntrb_jansson_json_object_get (json, key) ;
  if (!itm) {
    fprintf (stderr, "exit(ATS): json_object_get: %s\n", (char*)msg) ; exit (1);
  } // end of [if]
  return itm ;
} // end of [atscntrb_jansson_json_object_get_exnmsg]

/* ****** ****** */

ATSinline()
atstype_ptr
atscntrb_jansson_json_object_get1
(
  atstype_ptr json, atstype_ptr key
) {
  JSONptr itm ;
  itm = atscntrb_jansson_json_object_get (json, key) ;
  if (itm) json_incref(itm) ;
  return (itm) ;
} // end of [atscntrb_jansson_json_object_get1]

ATSinline()
atstype_ptr
atscntrb_jansson_json_object_get1_exnmsg
(
  atstype_ptr json, atstype_ptr key, atstype_ptr msg
) {
  JSONptr itm ;
  itm = atscntrb_jansson_json_object_get1 (json, key) ;
  if (!itm) {
    fprintf (stderr, "exit(ATS): json_object_get1: %s\n", (char*)msg) ; exit (1);
  } // end of [if]
  return (itm) ;
} // end of [atscntrb_jansson_json_object_get1_exnmsg]

/* ****** ****** */

#define atscntrb_jansson_json_object_set json_object_set
#define atscntrb_jansson_json_object_set_nocheck json_object_set_nocheck
#define atscntrb_jansson_json_object_set_new json_object_set_new
#define atscntrb_jansson_json_object_set_new_nocheck json_object_set_new_nocheck

#define atscntrb_jansson_json_object_del json_object_del

#define atscntrb_jansson_json_object_clear json_object_clear

#define atscntrb_jansson_json_object_update json_object_update
#define atscntrb_jansson_json_object_update_existing json_object_update_existing
#define atscntrb_jansson_json_object_update_missing json_object_update_missing

/* ****** ****** */

#define atscntrb_jansson_json_object_iter json_object_iter
#define atscntrb_jansson_json_object_iter_at json_object_iter_at
#define atscntrb_jansson_json_object_iter_next json_object_iter_next
#define atscntrb_jansson_json_object_iter_nextret json_object_iter_nextret

/* ****** ****** */

#define atscntrb_jansson_json_object_iter_key json_object_iter_key
#define atscntrb_jansson_json_object_iter_value json_object_iter_value

#define atscntrb_jansson_json_object_iter_set json_object_iter_set
#define atscntrb_jansson_json_object_iter_set_new json_object_iter_set_new

#define atscntrb_jansson_json_object_key_to_iter json_object_key_to_iter

/* ****** ****** */

#define atscntrb_jansson_json_loads json_loads
#define atscntrb_jansson_json_loadb json_loadb
#define atscntrb_jansson_json_loadf json_loadf
#define atscntrb_jansson_json_load_file json_load_file

#define atscntrb_jansson_json_dumps json_dumps
#define atscntrb_jansson_json_dumpf json_dumpf
#define atscntrb_jansson_json_dump_file json_dump_file

/* ****** ****** */

#endif // ifndef JANSSON_JANSSON_CATS

/* ****** ****** */

/* end of [jansson.cats] */
