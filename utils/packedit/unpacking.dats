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

#include "./params.hats"

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

val cnt = ref<int> (0)

in (* in of [local] *)

fun
genfname () = let
  val n = !cnt
  val () = !cnt := n + 1
  val BSZ = i2sz(64)
  val (pf, pfgc | p) = malloc_gc(BSZ)
  val _ = $extfcall (int, "snprintf", p, BSZ, "%s%i", FNAME_PREFIX, n)
in
  $UN.castvwtp0{string}((pf, pfgc | p))
end // end of [genfname]

end // end of [local]

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

fun auxskip
(
  inp: FILEref, sbf: !stringbuf
) : bool = ans where
{
var last: char = '\000'
val _ = stringbuf_insert_fgets (sbf, inp, last)
val ans = auxtest (sbf)
val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
} (* end of [auxskip] *)

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
val () = assertloc (n0 > 0)
val fname =
  string_make_substring ($UN.cast{string(n)}(p0), i2sz(0), pred(n0))
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

fun
auxcheck{n:nat}
(
  inp: FILEref
, sbf: !stringbuf
, mdval: arrayref(uchar,n), mdlen: int(n)
) : bool = let
//
fun CK
(
  uc: uchar, c0: char, c1: char
) : bool = let
//
  val uc = $UN.cast{intBtw(0,256)}(uc)
  val i0 = $UN.cast{intBtw(0, 16)}(uc / 16)
  val i1 = $UN.cast{intBtw(0, 16)}(uc mod 16)
in
//
if int2xdigit(i0) = c0
  then
    if int2xdigit(i1) = c1 then true else false
  else false
//
end // end of [CK]
//
fun
loop{i:nat | i <= n}
(
  p0: ptr, n0: int, i: int(i)
) : bool =
(
  if i < mdlen
    then
      if n0 >= 2
        then let
          val c0 = $UN.ptr0_get<char> (p0)
          val p0 = ptr_succ<char> (p0)
          val c1 = $UN.ptr0_get<char> (p0)
          val p0 = ptr_succ<char> (p0)
          val ans = CK (mdval[i], c0, c1)
        in
          if ans then loop (p0, n0-2, i+1) else false
        end // end of [then]
        else false
    else true
  // end of [if]
) (* end of [loop] *)
//
var last: char = '\000'
val _(*int*) = stringbuf_insert_fgets (sbf, inp, last)
//
var n0: size_t
val (pf, fpf | p0) =
  stringbuf_takeout_strbuf (sbf, n0)
val ans = loop (p0, g0uint2int(n0), 0)
prval ((*void*)) = fpf (pf)
//
val _(*true*) = stringbuf_truncate (sbf, i2sz(0))
//
in
  ans
end // end of [auxcheck]

(* ****** ****** *)

fun
auxwrite{n:nat}
(
  fname: string, data: arrayref(uchar, n), n: size_t(n)
) : void = let
//
val fname2 = genfname ()
val opt = fileref_open_opt (fname2, file_mode_w)
//
in
//
case+ opt of
| ~Some_vt (out) =>
  {
    val p = ptrcast(data)
    val (
      pf, fpf | p
    ) = $UN.ptr_vtake{bytes(n)}(p)
    val nwrit = $STDIO.fwrite0 (!p, i2sz(1), n, out)
    prval () = fpf (pf)
    val ((*void*)) =
    fprintln! (stdout_ref, "unpack_copy_from(", fname, ", ", fname2, ")")
  }
| ~None_vt ((*void*)) => ()
//
end // end of [auxwrite]

(* ****** ****** *)

fun auxfsing
(
  inp: FILEref
, sbf: !stringbuf
, sbf2: !stringbuf
, ctx: &EVP_MD_CTX >> _, md: EVP_MD_ref1
, nerr: &int >> int
) : void = let
//
val fname = auxfname (inp, sbf)
(*
val () = fprintln! (stdout_ref, "auxfsing: fname = ", fname)
*)
//
val () = assertloc (auxskip (inp, sbf))
//
val () = auxfbody (inp, sbf, sbf2, nerr)
//
var nwrit: size_t
val (pf2, fpf2 | p0) =
  stringbuf_takeout_strbuf (sbf2, nwrit)
prval [nw:int] EQINT() = g1uint_get_index (nwrit)
//
val ret =
EVP_DigestInit_ex (ctx, md, $UN.cast{ENGINEptr}(0))
//
val () =
assertloc (nwrit > 0)
val nwrit1 = pred(nwrit)
val ret =
EVP_DigestUpdate (
  ctx, $UN.cast{arrayref(uchar,nw-1)}(p0), nwrit1
) (* end of [val] *)
//
var mdlen: int = 0
var mdval = @[uchar][EVP_MAX_MD_SIZE]()
val p_mdval = addr@mdval
val ret = EVP_DigestFinal_ex (ctx, addr@mdval, mdlen)
prval [mdlen:int] EQINT() = g1int_get_index(mdlen)
//
val ans =
auxcheck (
  inp, sbf, $UN.cast{arrayref(uchar,mdlen)}(p_mdval), mdlen
) (* end of [val] *)
//
val () =
if not(ans) then
  auxwrite (fname, $UN.cast{arrayref(uchar,nw-1)}(p0), nwrit1)
//
prval () = fpf2 (pf2)
//
val _(*true*) = stringbuf_truncate (sbf2, i2sz(0))
//
in
  // nothing
end // end of [auxfsing]

(* ****** ****** *)

fun auxfmany
(
  inp: FILEref
, sbf: !stringbuf
, sbf2: !stringbuf
, ctx: &EVP_MD_CTX >> _, md: EVP_MD_ref1
, nerr: &int >> int
) : void = let
//
val ans = auxskip (inp, sbf)
//
in
//
if ans
  then let
    val () =
    auxfsing (inp, sbf, sbf2, ctx, md, nerr)
  in
    auxfmany (inp, sbf, sbf2, ctx, md, nerr)
  end // end of [then]
  else ((*exit*))
//
end // end of [auxfmany]

in (* in of [local] *)

implement
unpack_many_fileref
  (inp) = let
//
var nerr: int = 0
//
val sbf = stringbuf_make_nil (i2sz(BUFSZ))
val sbf2 = stringbuf_make_nil (i2sz(128*BUFSZ))
//
var ctx: EVP_MD_CTX
val () = EVP_MD_CTX_init (ctx)
//
val md =
  EVP_get_digestbyname ("SHA256")
val () = assertloc (ptrcast(md) > 0)
//
val () = auxfmany (inp, sbf, sbf2, ctx, md, nerr)
//
val () = assertloc (EVP_MD_CTX_cleanup (ctx) > 0)
//
val ((*void*)) = stringbuf_free (sbf)
val ((*void*)) = stringbuf_free (sbf2)
//
in
  nerr
end // end of [unpack_many_fileref]

end // end of [local]

(* ****** ****** *)

(* end of [unpacking.dats] *)
