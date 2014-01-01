(*
** HX-2013-12-31:
** unpacking a packed file into a list of files
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"
overload ptrcast with $STDIO.FILEptr2ptr

(* ****** ****** *)

staload
"{$OPENSSL}/SATS/evp.sats"
staload
_(*OPENSSL*) = "{$OPENSSL}/DATS/openssl.dats"

(* ****** ****** *)

staload
"libats/SATS/stringbuf.sats"
staload _ =
"libats/DATS/stringbuf.dats"

(* ****** ****** *)

staload "./unpacking.sats"

(* ****** ****** *)

#define BUFSZ 1024

(* ****** ****** *)

implement
unpack_test_sep
  (A, n) = let
in
//
if n >= 1
  then (if A[0] = '\014' then true else false)
  else false
// end of [if]
//
end // end of [unpack_test_sep]

(* ****** ****** *)

local

fun auxtest
  (sbf: !stringbuf): bool = let
//
var n0: size_t
val (pf, fpf | p0) = 
  stringbuf_takeout_strbuf (sbf, n0)
//
prval [n:int] EQINT() = g1uint_get_index (n0)
//
val ans = unpack_test_sep ($UN.cast{arrayref(char,n)}(p0), n0)
//
prval () = fpf (pf)
//
in
  ans
end // end of [auxtest]

(* ****** ****** *)

fun auxfname
(
  inp: FILEref, sbf: !stringbuf
) : string = let
//
var last: char = '\000'
val nread =
  stringbuf_insert_fgets (sbf, inp, last)
//
var n0: size_t
val (pf, fpf | p0) =
  stringbuf_takeout_strbuf (sbf, n0)
prval [n:int] EQINT() = g1uint_get_index (n0)
val fname =
  string_make_substring ($UN.cast{string(n)}(p0), i2sz(0), n0)
prval () = fpf (pf)
//
val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
//
in
  $UN.castvwtp0{string}(fname)
end // end of [auxfname]

(* ****** ****** *)

fun auxfbody
(
  inp: FILEref
, sbf: !stringbuf
, sbf2: !stringbuf
, nerr: &int >> int
) : void = let
//
var last: char = '\000'
val nread =
  stringbuf_insert_fgets (sbf, inp, last)
//
in
//
if nread > 0
  then let
    val ans = auxtest (sbf)
  in
    if ans
      then let
        val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
      in
        // nothing
      end // end of [then]
      else let
        var n0: size_t
        val (pf, fpf | p0) = 
          stringbuf_takeout_strbuf (sbf, n0)
        prval [n:int] EQINT() = g1uint_get_index (n0)
        val _ =
          stringbuf_insert_strlen (sbf2, $UN.cast{string(n)}(p0), n0)
        prval () = fpf (pf)
        val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
      in
        auxfbody (inp, sbf, sbf2, nerr)
      end // end of [else]
    // end of [if]
  end // end of [then]
  else let
    val () = nerr := nerr + 1 in ((*exit*))
  end // end of [else]
//
end // end of [auxfbody]

(* ****** ****** *)

in (* in of [local] *)

implement
unpack_fileref
  (inp) = let
//
val sbf =
stringbuf_make_nil (i2sz(BUFSZ))
//
var last: char = '\000'
val _ = stringbuf_insert_fgets (sbf, inp, last)
val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
//
val fname = auxfname (inp, sbf)
//
var last: char = '\000'
val _ = stringbuf_insert_fgets (sbf, inp, last)
val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
//
val sbf2 =
stringbuf_make_nil (i2sz(128*BUFSZ))
//
var nerr: int = 0
val () = auxfbody (inp, sbf, sbf2, nerr)
//
var ctx: EVP_MD_CTX
val md = EVP_get_digestbyname ("SHA256")
val () = assertloc (ptrcast(md) > 0)
val () = assertloc (EVP_DigestInit (ctx, md) > 0)
//
var nwrit: size_t
val (pf2, fpf2 | p0) = stringbuf_takeout_strbuf (sbf2, nwrit)
prval [nw:int] EQINT() = g1uint_get_index (nwrit)
val () = assertloc (nwrit > 0)
val () = fprintln! (stdout_ref, "nwrit = ", nwrit)
val ret =
  EVP_DigestUpdate (ctx, $UN.cast{arrayref(uchar,nw-1)}(p0), pred(nwrit))
val () = if ret = 0(*fail*) then nerr := nerr + 1
prval () = fpf2 (pf2)
//
var mdlen: int = 0
var mdval = @[uchar][EVP_MAX_MD_SIZE]()
val ret = EVP_DigestFinal (ctx, addr@mdval, mdlen)
prval [mdlen:int] EQINT() = g1int_get_index(mdlen)
//
local
implement
fprint_array$sep<> (out) = ()
implement
fprint_val<uchar> (out, c) = {
  val _ = $extfcall (int, "printf", "%02x", c)
} (* end of [fprint_val] *)
in(*in-of-local*)
val () =
fprint_arrayref<uchar>
  (stdout_ref, $UN.cast{arrayref(uchar,mdlen)}(addr@mdval), i2sz(mdlen))
end // end of [local]
val () = fprint_newline (stdout_ref)
//
val () = stringbuf_free (sbf)
val () = stringbuf_free (sbf2)
//
in
  nerr
end // end of [unpack_fileref]

end // end of [local]

(* ****** ****** *)

(* end of [unpacking.dats] *)
