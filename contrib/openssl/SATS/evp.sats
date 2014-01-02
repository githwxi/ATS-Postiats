(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: December, 2013
*)

(* ****** ****** *)

%{#
//
#include "openssl/CATS/evp.cats"
//
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.openssl"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_openssl_" // prefix for external names

(* ****** ****** *)

#include "./../HATS/evp.hats"

(* ****** ****** *)

#define EVP_MAX_MD_SIZE ATSCNTRB_OPENSSL_EVP_MAX_MD_SIZE
#define EVP_MAX_KEY_LENGTH ATSCNTRB_OPENSSL_EVP_MAX_KEY_LENGTH
#define EVP_MAX_IV_LENGTH ATSCNTRB_OPENSSL_EVP_MAX_IV_LENGTH
#define EVP_MAX_BLOCK_LENGTH ATSCNTRB_OPENSSL_EVP_MAX_BLOCK_LENGTH

(* ****** ****** *)

typedef interr = intGte(0)

(* ****** ****** *)

/*
void OpenSSL_add_all_ciphers(void);
*/
fun OpenSSL_add_all_ciphers ((*void*)): void = "mac#%"

(* ****** ****** *)

/*
void OpenSSL_add_all_digests(void);
*/
fun OpenSSL_add_all_digests ((*void*)): void = "mac#%"

(* ****** ****** *)

/*
void OpenSSL_add_all_algorithms(void);
*/
fun OpenSSL_add_all_algorithms ((*void*)): void = "mac#%"

(* ****** ****** *)

fun EVP_cleanup ((*void*)): void = "mac#%"

(* ****** ****** *)
//
abstype
EVP_MD_ref (l:addr) = ptr (l)
typedef
EVP_MD_ref0 = [l:agez] EVP_MD_ref (l)
typedef
EVP_MD_ref1 = [l:addr | l > null] EVP_MD_ref (l)

(* ****** ****** *)
//
castfn
EVP_MD_ref2ptr
  {l:addr} (EVP_MD_ref(l)):<> ptr(l)
overload ptrcast with EVP_MD_ref2ptr
//
(* ****** ****** *)
  
/*
const EVP_MD *EVP_md_null(void);
const EVP_MD *EVP_md2(void);
const EVP_MD *EVP_md5(void);
const EVP_MD *EVP_sha(void);
const EVP_MD *EVP_sha1(void);
const EVP_MD *EVP_sha224(void);
const EVP_MD *EVP_sha256(void);
const EVP_MD *EVP_sha384(void);
const EVP_MD *EVP_sha512(void);
const EVP_MD *EVP_dss(void);
const EVP_MD *EVP_dss1(void);
const EVP_MD *EVP_mdc2(void);
const EVP_MD *EVP_ripemd160(void);
*/
fun
EVP_md_null((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_md2((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_md5((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_sha((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_sha1((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_sha224((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_sha256((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_sha384((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_sha512((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_dss((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_dss1((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_mdc2((*void*)): EVP_MD_ref1 = "mac#%"

fun EVP_ripemd160((*void*)): EVP_MD_ref1 = "mac#%"

(* ****** ****** *)

/*
const EVP_MD *EVP_get_digestbyname(const char *name);
*/
fun EVP_get_digestbyname (name: string): EVP_MD_ref0 = "mac#%"

(* ****** ****** *)

absvt@ype
EVP_MD_CTX = $extype"EVP_MD_CTX" // stack allocation

(* ****** ****** *)
//
absvtype
EVP_MD_CTX_ptr (l:addr) = ptr (l)
vtypedef EVP_MD_CTX_ptr0 = [l:agez] EVP_MD_CTX_ptr (l)
vtypedef EVP_MD_CTX_ptr1 = [l:addr | l > null] EVP_MD_CTX_ptr (l)
//
(* ****** ****** *)

castfn
EVP_MD_CTX_ptr2ptr
  {l:addr} (ctx: !EVP_MD_CTX_ptr (l)):<> ptr (l)
overload ptrcast with EVP_MD_CTX_ptr2ptr

(* ****** ****** *)
  
praxi
EVP_MD_CTX_takeout
  {l:agz}
(
  ctx: !EVP_MD_CTX_ptr (l)
): (EVP_MD_CTX @ l, minus (EVP_MD_CTX_ptr (l), EVP_MD_CTX @ l))
  
(* ****** ****** *)

praxi
EVP_MD_CTX_objfize
  {l:addr}
(
  pf: EVP_MD_CTX@l | p: !ptrlin l >> EVP_MD_CTX_ptr (l)
) :<prf> mfree_ngc_v (l) // endfun

praxi
EVP_MD_CTX_unobjfize
  {l:addr}
(
  pfgc: mfree_ngc_v (l) | ctx: !EVP_MD_CTX_ptr (l) >> ptrlin l
) :<prf> EVP_MD_CTX @ l // endfun
  
(* ****** ****** *)

fun EVP_MD_CTX_init (&EVP_MD_CTX? >> EVP_MD_CTX): void = "mac#%"
fun EVP_MD_CTX_cleanup (&EVP_MD_CTX >> EVP_MD_CTX?): interr = "mac#%"

(* ****** ****** *)

/*
EVP_MD_CTX *EVP_MD_CTX_create(void);
*/
fun EVP_MD_CTX_create ((*void*)): EVP_MD_CTX_ptr0 = "mac#%"

(* ****** ****** *)

/*
void EVP_MD_CTX_destroy(EVP_MD_CTX *ctx);
*/
fun EVP_MD_CTX_destroy (ctx: EVP_MD_CTX_ptr0): void = "mac#%"

(* ****** ****** *)

/*
int
EVP_MD_CTX_copy(EVP_MD_CTX *out,const EVP_MD_CTX *in);
*/
fun EVP_MD_CTX_copy
  (to: &EVP_MD_CTX? >> EVP_MD_CTX, from: &RD(EVP_MD_CTX)): interr = "mac#%"

/*
int
EVP_MD_CTX_copy_ex(EVP_MD_CTX *out,const EVP_MD_CTX *in);
*/
fun EVP_MD_CTX_copy_ex
  (to: &EVP_MD_CTX  >> EVP_MD_CTX, from: &RD(EVP_MD_CTX)): interr = "mac#%"
//
(* ****** ****** *)

abstype ENGINEptr = ptr

(* ****** ****** *)

/*
int
EVP_DigestInit
  (EVP_MD_CTX *ctx, const EVP_MD *type);
*/
fun
EVP_DigestInit
(
  ctx: &EVP_MD_CTX? >> EVP_MD_CTX, type: EVP_MD_ref1
) : interr = "mac#%" // end of [EVP_DigestInit]

/*
int
EVP_DigestInit_ex
  (EVP_MD_CTX *ctx, const EVP_MD *type, ENGINE *impl);
*/
fun
EVP_DigestInit_ex
(
  ctx: &EVP_MD_CTX >> EVP_MD_CTX, type: EVP_MD_ref1, impl: ENGINEptr
) : interr = "mac#%" // end-of-fun

(* ****** ****** *)

/*
int
EVP_DigestUpdate
  (EVP_MD_CTX *ctx, const void *d, size_t cnt);
*/
fun
EVP_DigestUpdate
  {n:int}
(
  ctx: &EVP_MD_CTX >> _, data: arrayref(uchar, n), n: size_t n
) : interr = "mac#%" // end of [EVP_DigestUpdate]

(* ****** ****** *)

/*
int
EVP_DigestFinal
  (EVP_MD_CTX *ctx, unsigned char *md, unsigned int *s);
*/
fun
EVP_DigestFinal
(
  ctx: &EVP_MD_CTX >> _?, md: Ptr1, len: &int(0) >> int(n)
) : #[n:nat] interr = "mac#%" // end-of-fun

(* ****** ****** *)

/*
int
EVP_DigestFinal_ex
  (EVP_MD_CTX *ctx, unsigned char *md, unsigned int *s);
*/
fun
EVP_DigestFinal_ex
(
  ctx: &EVP_MD_CTX >> EVP_MD_CTX, md: Ptr1, len: &int(0) >> int(n)
) : #[n:nat] interr = "mac#%" // end-of-fun

(* ****** ****** *)
//
// HX: convenience functions
//
(* ****** ****** *)

fun{}
fprint_mdval{n:int}
(
  out: FILEref, mdval: arrayref (uchar, n), mdlen: int n
) : void // end of [fprint_mdval]

(* ****** ****** *)

fun{}
EVP_Digestize_string
(
  dname: string, src: string, asz: &int? >> int(n)
) : #[n:nat] arrayptr (uchar, n) // end-of-fun

(* ****** ****** *)

fun{}
EVP_Digestize_fileref
(
  dname: string, inp: FILEref, asz: &int? >> int(n)
) : #[n:nat] arrayptr (uchar, n) // end-of-fun

(* ****** ****** *)
//
fun{}
EVP_DigestUpdate_string (ctx: &EVP_MD_CTX >> _, src: string): interr
//
fun{}
EVP_DigestUpdate_fileref (ctx: &EVP_MD_CTX >> _, inp: FILEref): interr
//
(* ****** ****** *)

(* end of [evp.sats] *)
