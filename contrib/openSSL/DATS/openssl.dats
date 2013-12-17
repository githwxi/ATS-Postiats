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

#define ATS_PACKNAME "ATSCNTRB.openssl"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_openssl_" // prefix for external names

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
staload
STRING = "libc/SATS/string.sats"
//
(* ****** ****** *)

#include "./../HATS/mybasis.hats"

(* ****** ****** *)

staload "./../SATS/evp.sats"

(* ****** ****** *)

implement{}
EVP_Digestize_string
  (digest, subject, asz) = let
//
var nerr: int = 0
//
var mdctx: EVP_MD_CTX
val md = EVP_get_digestbyname (digest)
val () = assertloc (ptrcast(md) > 0)
//
val err = EVP_DigestInit (mdctx, md)
val () = if err = 0 then nerr := nerr + 1
//
val err = EVP_DigestUpdate_string (mdctx, subject)
val () = if err = 0 then nerr := nerr + 1
//
var mdlen: int = 0
var mdval = @[uchar][EVP_MAX_MD_SIZE]()
val p_mdval = addr@mdval
val err = EVP_DigestFinal (mdctx, p_mdval, mdlen)
val () = if err = 0 then nerr := nerr + 1
//
in
//
if nerr = 0
  then let
    val () = asz := mdlen
    prval [n:int] EQINT () = g1int_get_index (asz)
    val asz2 = i2sz (asz)
    val res = arrayptr_make_uninitized<char> (asz2)
    val p_res = ptrcast (res)
    val p_res = $UN.cast2Ptr1(p_res)
    val p_res = $STRING.memcpy_unsafe (p_res, p_mdval, asz2)
  in
    $UN.castvwtp0{arrayptr(uchar,n)}(res)
  end // end of [then]
  else let
    val () = asz := 0(*error*) in $UN.castvwtp0{arrayptr(uchar,0)}(0)
  end // end of [else]
//
end // end of [EVP_Digestize_string]

(* ****** ****** *)

implement{}
EVP_DigestUpdate_string
  (ctx, data) = let
  val [n:int] data = g1ofg0 (data)
  val data2 = $UN.cast{arrayref(uchar,n)}(data)
in
  EVP_DigestUpdate (ctx, data2, string1_length (data))
end // end of [EVP_DigestUpdate_string]

(* ****** ****** *)

(* end of [openssl.dats] *)
