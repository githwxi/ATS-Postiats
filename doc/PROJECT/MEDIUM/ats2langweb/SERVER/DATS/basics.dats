(* ****** ****** *)
(*
//
// Some basics stuff
//
*)
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
#define
ATS_EXTERN_PREFIX "atslangweb_"
#define
ATS_STATIC_PREFIX "_atslangweb_patsopt_tcats_"
//
(* ****** ****** *)
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME\
/contrib/libatscc2php/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)
//
staload "./../SATS/atslangweb.sats"
//
(* ****** ****** *)
//
extern
fun
file_get_contents
  (fname: string): string = "mac#"
//
(* ****** ****** *)
//
implement
tmpfile_unlink
  (fname) =
(
$extfcall
( bool
, "unlink", $UN.castvwtp0{string}(fname)
) (* $extfcall *)
) (* tmpfile_unlink *)
//
(* ****** ****** *)
//
implement
tmpfile2string(fname) =
  file_get_contents($UN.castvwtp1{string}(fname))
//
(* ****** ****** *)
//
implement
tmpfile_make_nil
  (prfx) = let
//
val dir =
  $extfcall(string, "sys_get_temp_dir")
val fname =
  $extfcall(string, "tempnam", dir, prfx)
//
in
  $UN.castvwtp0{tmpfile}(fname)
end (* end of [tmpfile_make_nil] *)
//
(* ****** ****** *)
//
implement
tmpfile_make_string
  (prfx, inp) = let
//
val dir =
  $extfcall(string, "sys_get_temp_dir")
val fname =
  $extfcall(string, "tempnam", dir, prfx)
//
val fhandle =
  $extfcall(PHPfilp0, "fopen", fname, "w")
//
val filp =
  $UN.castvwtp1{ptr}(fhandle)
val nwrit =
  $extfcall(int, "fwrite", filp, inp)
(*
val ((*void*)) = fwrite_checkret (nwrit)
*)
//
val filp =
  $UN.castvwtp0{ptr}(fhandle)
val closed = $extfcall(bool, "fclose", filp)
(*
val ((*void*)) = fclose_checkret (closed)
*)
//
in
  $UN.castvwtp0{tmpfile}(fname)
end (* end of [tmpfile_make_string] *)
//
(* ****** ****** *)

(* end of [basics.dats] *)
