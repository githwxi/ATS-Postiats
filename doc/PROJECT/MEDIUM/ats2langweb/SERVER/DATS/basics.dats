(*
//
// Some basics stuff
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
staload
UN = "prelude/SATS/unsafe.sats"
//
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
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)

staload "./../SATS/atslangweb.sats"

(* ****** ****** *)
//
extern
fun
file_get_contents (fname: string): string = "mac#"
//
(* ****** ****** *)
//
implement
tmpfile_unlink
  (fname) =
  unlink ($UN.castvwtp0{string}(fname))
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
  (pfx) = let
//
val dir =
  $extfcall(string, "sys_get_temp_dir")
val fname =
  $extfcall (string, "tempnam", dir, pfx)
//
in
  $UN.castvwtp0{tmpfile}(fname)
end (* end of [tmpfile_make_nil] *)
//
(* ****** ****** *)
//
implement
tmpfile_make_string
  (pfx, inp) = let
//
val dir =
  $extfcall(string, "sys_get_temp_dir")
val fname =
  $extfcall (string, "tempnam", dir, pfx)
//
val fhandle =
  $extfcall (PHPfilp0, "fopen", fname, "w")
//
val nwrit = fwrite (fhandle, inp)
(*
val ((*void*)) = fwrite_checkret (nwrit)
*)
//
val closed = fclose (fhandle)
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
