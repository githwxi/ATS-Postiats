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
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: December, 2013
*/

/* ****** ****** */

#ifndef OPENSSL_EVP_CATS
#define OPENSSL_EVP_CATS

/* ****** ****** */

#include <openssl/evp.h>

/* ****** ****** */

#define \
atscntrb_openssl_EVP_md_null ((EVP_MD*)(EVP_md_null()))
#define atscntrb_openssl_EVP_md2 ((EVP_MD*)(EVP_md2()))
#define atscntrb_openssl_EVP_md5 ((EVP_MD*)(EVP_md5()))
#define atscntrb_openssl_EVP_sha ((EVP_MD*)(EVP_sha()))
#define atscntrb_openssl_EVP_sha1 ((EVP_MD*)(EVP_sha1()))
#define atscntrb_openssl_EVP_sha224 ((EVP_MD*)(EVP_sha224()))
#define atscntrb_openssl_EVP_sha256 ((EVP_MD*)(EVP_sha256()))
#define atscntrb_openssl_EVP_sha384 ((EVP_MD*)(EVP_sha384()))
#define atscntrb_openssl_EVP_sha512 ((EVP_MD*)(EVP_sha512()))
#define atscntrb_openssl_EVP_dss ((EVP_MD*)(EVP_dss()))
#define atscntrb_openssl_EVP_dss1 ((EVP_MD*)(EVP_dss1()))
#define atscntrb_openssl_EVP_mdc2 ((EVP_MD*)(EVP_mdc2()))
#define atscntrb_openssl_EVP_ripemd160 ((EVP_MD*)(EVP_ripemd160()))
#define \
atscntrb_openssl_EVP_get_digestbyname(name) ((EVP_MD*)(EVP_get_digestbyname(name)))

/* ****** ****** */
//
#define \
atscntrb_openssl_OpenSSL_add_all_ciphers OpenSSL_add_all_ciphers
#define \
atscntrb_openssl_OpenSSL_add_all_digests OpenSSL_add_all_digests
#define \
atscntrb_openssl_OpenSSL_add_all_algorithms OpenSSL_add_all_algorithms
//
/* ****** ****** */

#define atscntrb_openssl_EVP_cleanup EVP_cleanup

/* ****** ****** */

#define atscntrb_openssl_EVP_MD_CTX_init EVP_MD_CTX_init
#define atscntrb_openssl_EVP_MD_CTX_cleanup EVP_MD_CTX_cleanup

/* ****** ****** */

#define atscntrb_openssl_EVP_MD_CTX_create EVP_MD_CTX_create
#define atscntrb_openssl_EVP_MD_CTX_destroy EVP_MD_CTX_destroy

/* ****** ****** */

#define atscntrb_openssl_EVP_DigestInit EVP_DigestInit
#define atscntrb_openssl_EVP_DigestUpdate EVP_DigestUpdate
#define atscntrb_openssl_EVP_DigestFinal EVP_DigestFinal

#define atscntrb_openssl_EVP_DigestInit_ex EVP_DigestInit_ex
#define atscntrb_openssl_EVP_DigestFinal_ex EVP_DigestFinal_ex

/* ****** ****** */

#endif // ifndef OPENSSL_EVP_CATS

/* ****** ****** */

/* end of [evp.cats] */
