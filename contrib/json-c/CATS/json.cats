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

#ifndef JSON_JSON_CATS
#define JSON_JSON_CATS

/* ****** ****** */

#include <json.h>

/* ****** ****** */

#define atscntrb_array_list_new array_list_new
#define atscntrb_array_list_free array_list_free
#define atscntrb_array_list_length array_list_length
#define atscntrb_array_list_add array_list_add
#define atscntrb_array_list_get_idx array_list_get_idx
#define atscntrb_array_list_set_idx array_list_set_idx
#define atscntrb_array_list_sort array_list_sort

/* ****** ****** */

#endif // ifndef JSON_JSON_CATS

/* ****** ****** */

/* end of [json.cats] */
