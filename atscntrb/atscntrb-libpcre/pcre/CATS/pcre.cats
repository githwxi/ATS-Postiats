/* ****** ****** */
//
// API in ATS for PCRE
//
/* ****** ****** */

/*
(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
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
*)
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: August, 2013 *)
*/

/* ****** ****** */

#ifndef LIBPCRE_PCRE_CATS
#define LIBPCRE_PCRE_CATS

/* ****** ****** */
//
#include <pcre.h>
//
#include <string.h>
//
/* ****** ****** */

typedef unsigned char uchar ;

/* ****** ****** */

#define \
atscntrb_pcre_memcpy memcpy

/* ****** ****** */

#define \
atscntrb_pcre_pcre_version() ((char*)(pcre_version()))

/* ****** ****** */

#define \
atscntrb_pcre_pcre_compile(code, options, errptr, erroffset, tableptr) \
pcre_compile(code, (int)options, (const char**)errptr, (int*)erroffset, (const uchar*)tableptr)

#define \
atscntr_pcre_pcre_compile2(code, options, errorcodeptr, errptr, erroffset, tableptr) \
pcre_compile2(code, (int)options, (int*)errorcodeptr, (const char**)errptr, (int*)erroffset, (const uchar*)tableptr)

/* ****** ****** */

#define \
atscntrb_pcre_pcre_free pcre_free

/* ****** ****** */

#define \
atscntrb_pcre_pcre_study pcre_study
#define \
atscntrb_pcre_pcre_free_study pcre_free_study

/* ****** ****** */

#define \
atscntrb_pcre_pcre_exec pcre_exec

/* ****** ****** */

#endif // end of [ifndef(LIBPCRE_PCRE_CATS)]

/* ****** ****** */

/* end of [pcre.cats] */
