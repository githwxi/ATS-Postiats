(*
** HX-2013-12-31:
** packing a list of files into one
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

staload "./packing.sats"

(* ****** ****** *)

(*
fun pack_sing
  (out: FILEref, inp: FILEref): int(*err*)
// end of [pack_sing]
*)

(* ****** ****** *)

#define BUFSZ 1024

(* ****** ****** *)

implement
pack_fprint_sep (out) = fprint (out, "\014\n")

(* ****** ****** *)

implement
pack_sing_fileref
  (out, inp) = let
//
fun loop
(
  sbf: !stringbuf
, ctx: &EVP_MD_CTX >> _
, nerr: &int >> _
) : void = let
//
val nread =
  stringbuf_insert_fread (sbf, inp, ~1(*all*))
//
in
//
if nread > 0
  then let
    var n: size_t
    val (pf, fpf | p) =
      stringbuf_takeout_strbuf (sbf, n)
    prval [n:int] EQINT() = g1uint_get_index (n)
//
    val (pf2, fpf2 | p2) = $UN.ptr0_vtake{bytes(n)}(p)
    val [nw:int] nwrit = $STDIO.fwrite (!p2, i2sz(1), n, out)
    prval () = fpf2 (pf2)
    val () = if n > nwrit then nerr := nerr + 1
//
    val ret =
      EVP_DigestUpdate (ctx, $UN.cast{arrayref(uchar,nw)}(p), nwrit)
    val () = if ret = 0(*fail*) then nerr := nerr + 1
//
    prval () = fpf (pf)
//
    val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
//
  in
    loop (sbf, ctx, nerr)
  end
  else let
    val _(*err*) = $STDIO.fputc ('\n', out) in ((*exit*))
  end // end of [else]
// end of [if] 
//
end // end of [loop]
//
val sbf =
stringbuf_make_nil (i2sz(BUFSZ))
//
var ctx: EVP_MD_CTX
val md = EVP_get_digestbyname ("SHA256")
val () = assertloc (ptrcast(md) > 0)
val () = assertloc (EVP_DigestInit (ctx, md) > 0)
//
var nerr: int = 0
//
val ((*void*)) = loop (sbf, ctx, nerr)
//
var mdlen: int = 0
var mdval = @[uchar][EVP_MAX_MD_SIZE]()
val ret = EVP_DigestFinal (ctx, addr@mdval, mdlen)
prval [mdlen:int] EQINT() = g1int_get_index(mdlen)
//
val () = stringbuf_free (sbf)
//
val () = pack_fprint_sep (out)
//
val (
) = fprint_mdval
(
  out, $UN.cast{arrayref(uchar,mdlen)}(addr@mdval), mdlen
) (* end of [val] *)
val () = fprint_newline (out)
//
in
  nerr
end // end of [pack_sing_fileref]

(* ****** ****** *)

implement
pack_sing_filename
  (out, fname) = let
//
val () = pack_fprint_sep (out)
//
val filp =
  $STDIO.fopen (fname, file_mode_r)
//
in
//
if ptrcast(filp) > 0
  then let
    val () = fprint (out, fname)
    val () = fprint_char (out, '\n')
    val () = pack_fprint_sep (out)
    val nerr =
    pack_sing_fileref
      (out, $UN.castvwtp1{FILEref}(filp))
    val _(*err*) =
    $STDIO.fclose0 ($UN.castvwtp0{FILEref}(filp))
  in
    nerr
  end // end of [then]
  else let
    prval () = $STDIO.FILEptr_free_null (filp)
  in
    1(*nerr*)
  end // end of [else]
// end of [if]
//
end // end of [pack_sing_filename]

(* ****** ****** *)

(* end of [packing.dats] *)
