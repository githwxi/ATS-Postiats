/*
** For Simple Dynamic Strings:
** https://github.com/antirez/sds/
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

#ifndef SDSTRING_CATS
#define SDSTRING_CATS

/* ****** ****** */

#include "atscntrb-sdstring/H/sds.h"

/* ****** ****** */

#define \
atscntrb_sdstring_sdsnew sdsnew
#define \
atscntrb_sdstring_sdsnewlen sdsnewlen

/* ****** ****** */

#define \
atscntrb_sdstring_sdsempty sdsempty

/* ****** ****** */

#define atscntrb_sdstring_sdsdup sdsdup

/* ****** ****** */

#define atscntrb_sdstring_sdsfree sdsfree

/* ****** ****** */

#define atscntrb_sdstring_sdscmp sdscmp

/* ****** ****** */

#define atscntrb_sdstring_sdslen sdslen
#define atscntrb_sdstring_sdsavail sdsavail

/* ****** ****** */

#define \
atscntrb_sdstring_sdsgrowzero sdsgrowzero

/* ****** ****** */
//
#define \
atscntrb_sdstring_sdscat(sds, str) \
  sdscat(sds, (const char*)str)
#define \
atscntrb_sdstring_sdscatsds(sds1, sds2) \
  sdscatsds(sds1, (const sds)sds2)
#define \
atscntrb_sdstring_sdscatlen(sds, str, size) \
  sdscatlen(sds, (const char*)str, size)
/*
fun sdscatrepr(sds0, string, size_t): sds0
fun sdscatprintf{ts:t@ype}(sds, fmt: string, ts): sds0
*/
//
/* ****** ****** */
//
#define \
atscntrb_sdstring_sdscpy(sds, str) \
  sdscpy(sds, (const char*)str)
#define \
atscntrb_sdstring_sdscpylen(sds, str, size) \
  sdscpylen(sds, (const char*)str, size)
//
/* ****** ****** */

#define atscntrb_sdstring_sdstrim sdstrim
#define atscntrb_sdstring_sdsrange sdsrange

/* ****** ****** */

#define atscntrb_sdstring_sdstolower sdstolower
#define atscntrb_sdstring_sdstoupper sdstoupper

/* ****** ****** */

#define \
atscntrb_sdstring_sdsfromlonglong sdsfromlonglong

/* ****** ****** */

#define atscntrb_sdstring_sdsjoin sdsjoin
#define atscntrb_sdstring_sdsjoinsds sdsjoinsds

/* ****** ****** */

#define \
atscntrb_sdstring_sdsmapchars(sds, _from, _to, size) \
  sdsmapchars(sds, (const char*)_from, (const char*)_to, size)

/* ****** ****** */

#endif // end of [ifndef]

/* ****** ****** */

/* end of [sdstring.cats] */
