(* ****** ****** *)

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

staload "./../SATS/evp.sats"

(* ****** ****** *)

implement{}
fprint_mdval{n}
  (out, mdval, mdlen) = let
//
prval () =
lemma_arrayref_param (mdval)
//
implement
fprint_array$sep<> (out) = ()
implement
fprint_val<uchar>
  (out, uc) = {
  val _ = $extfcall (int, "printf", "%02x", uc)
} (* end of [fprint_val] *)
//
in
//
fprint_arrayref<uchar> (out, mdval, i2sz(mdlen))
//
end // end of [fprint_mdval]

(* ****** ****** *)

implement{}
EVP_Digestize_string
  (dname, src, asz) = let
//
var nerr: int = 0
//
var mdctx: EVP_MD_CTX
val md = EVP_get_digestbyname (dname)
val p_md = ptrcast (md)
val () =
if p_md = 0 then
{
val () = prerrln! (
  "exit(ATSCNTRB/openSSL): digest(", dname, ") is not available."
) (* end of [val] *)
}
val () = assertloc (p_md > 0)
//
val err = EVP_DigestInit (mdctx, md)
val () = if err = 0 then nerr := nerr + 1
//
val err = EVP_DigestUpdate_string (mdctx, src)
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
EVP_Digestize_fileref
  (dname, inp, asz) = let
//
var nerr: int = 0
//
var mdctx: EVP_MD_CTX
val md = EVP_get_digestbyname (dname)
val p_md = ptrcast (md)
val () =
if p_md = 0 then
{
val () = prerrln! (
  "exit(ATSCNTRB/openSSL): digest(", dname, ") is not available."
) (* end of [val] *)
}
val () = assertloc (p_md > 0)
//
val err = EVP_DigestInit (mdctx, md)
val () = if err = 0 then nerr := nerr + 1
//
val err = EVP_DigestUpdate_fileref (mdctx, inp)
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
end // end of [EVP_Digestize_fileref]

(* ****** ****** *)

implement{}
EVP_DigestUpdate_string
  (ctx, src) = let
  val [n:int] src = g1ofg0 (src)
  val src2 = $UN.cast{arrayref(uchar,n)}(src)
in
  EVP_DigestUpdate (ctx, src2, string1_length (src))
end // end of [EVP_DigestUpdate_string]

(* ****** ****** *)

implement{}
EVP_DigestUpdate_fileref
  (ctx, inp) = let
//
var nerr: int = 0
val p_ctx = addr@ctx
val p_nerr = addr@nerr
//
stadef CTX = EVP_MD_CTX
//
(*
implement
fileref_foreach$bufsize<> () = i2sz(4096)
*)
implement{env}
fileref_foreach$fworkv
  {n} (A, n, env) = () where
{
  val A = $UN.cast{arrayref(uchar,n)}(A)
  val (pf, fpf | p_ctx) = $UN.ptr0_vtake{CTX}(p_ctx)
  val err = EVP_DigestUpdate (!p_ctx, A, n)
  prval ((*void*)) = fpf (pf)
  val (pf, fpf | p_nerr) = $UN.ptr0_vtake{int}(p_nerr)
  val () = if err = 0 then !p_nerr := !p_nerr + 1
  prval ((*void*)) = fpf (pf)
} (* end of [fileref_foreach$fworkv] *)
//
val () = fileref_foreach (inp)
//
in
  if nerr = 0 then 1(*success*) else 0(*failure*)
end (* end of [EVP_DigestUpdate_fileref] *)

(* ****** ****** *)

(* end of [openssl.dats] *)
