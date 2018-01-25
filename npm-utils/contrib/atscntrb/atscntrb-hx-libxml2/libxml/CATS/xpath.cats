/*
** API for libxml2 in ATS
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
** Author: Hongwei Xi
** Start Time: December, 2013
** Authoremail: gmhwxiATgmailDOTcom
*/

/* ****** ****** */

#ifndef LIBXML2_XPATH_CATS
#define LIBXML2_XPATH_CATS

/* ****** ****** */

#include <libxml/xpath.h>

/* ****** ****** */

#define \
atscntrb_libxml2_xmlXPathConvertNumber xmlXPathConvertNumber
#define \
atscntrb_libxml2_xmlXPathConvertString xmlXPathConvertString
#define \
atscntrb_libxml2_xmlXPathConvertBoolean xmlXPathConvertBoolean

/* ****** ****** */

#define atscntrb_libxml2_xmlXPathFreeObject xmlXPathFreeObject

/* ****** ****** */

#define atscntrb_libxml2_xmlXPathNewContext xmlXPathNewContext
#define atscntrb_libxml2_xmlXPathFreeContext xmlXPathFreeContext

/* ****** ****** */

#endif // ifndef LIBXML2_XPATH_CATS

/* ****** ****** */

/* end of [xpath.cats] */
