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

#ifndef JSONC_PRINTBUF_CATS
#define JSONC_PRINTBUF_CATS

/* ****** ****** */

#include <../json-c/printbuf.h>

/* ****** ****** */

ATSinline()
atstype_ptr
atscntrb_jsonc_printbuf_get_buf
  (atstype_ptr pb)
{
  return ((struct printbuf*)pb)->buf ;
} // end of [atscntrb_jsonc_printbuf_get_buf]

ATSinline()
atstype_int
atscntrb_jsonc_printbuf_get_size
  (atstype_ptr pb)
{
  return ((struct printbuf *)pb)->size ;
} // end of [atscntrb_jsonc_printbuf_get_size]

/* ****** ****** */

#define atscntrb_jsonc_printbuf_new printbuf_new
#define atscntrb_jsonc_printbuf_free printbuf_free
#define atscntrb_jsonc_printbuf_reset printbuf_reset
#define atscntrb_jsonc_printbuf_length printbuf_length
#define atscntrb_jsonc_printbuf_memappend printbuf_memappend
#define atscntrb_jsonc_printbuf_memset printbuf_memset
/*
#define atscntrb_jsonc_sprintbuf sprintbuf
*/

/* ****** ****** */

#endif // ifndef JSONC_PRINTBUF_CATS

/* ****** ****** */

/* end of [printbuf.cats] */
