(*
//
// [atscc2js]:
// *_dats.c -> *_dats.js
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
ATS_STATIC_PREFIX "_atslangweb_atscc2js_comp_"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)

staload "./../SATS/atslangweb.sats"

(* ****** ****** *)

implement
{}(*tmp*)
atscc2js_comp_command
(
  fname_dats_c, fname_dats_js, fname_dats_stderr
) = let
//
val atscc2js = atscc2js_command<> ()
//
val fname_dats_c = $UN.castvwtp1{string}(fname_dats_c)
val fname_dats_js = $UN.castvwtp1{string}(fname_dats_js)
val fname_dats_stderr = $UN.castvwtp1{string}(fname_dats_stderr)
//
in
//
$extfcall
(
  string, "sprintf"
, "%s 2>%s --output %s --input %s"
, atscc2js, fname_dats_stderr, fname_dats_js, fname_dats_c
) (* end of [$extfcall] *)
//
end // end of [atscc2js_comp_command]

(* ****** ****** *)

implement
{}(*tmp*)
atscc2js_comp_file
  (fname_dats_c) =
  compres where
{
//
val fname_dats_js =
  tmpfile_make_nil ("atscc2js_comp_")
val fname_dats_stderr =
  tmpfile_make_nil ("atscc2js_comp_")
//
val
command =
atscc2js_comp_command
  (fname_dats_c, fname_dats_js, fname_dats_stderr)
//
(*
val () = prerrln! ("command = ", command)
*)
//
val
exec_ret = exec_retval (command)
//
val
compres = (
//
if exec_ret = 0
  then let
    val code = tmpfile2string (fname_dats_js)
    val unlink_ret = tmpfile_unlink (fname_dats_js)
  in
    COMPRES0_succ (code)
  end // end of [then]
  else let
    val errmsg = tmpfile2string (fname_dats_stderr)
    val unlink_ret = tmpfile_unlink (fname_dats_js)
  in
    COMPRES1_fail (errmsg)
  end (* end of [else] *)
// end of [if]
) : compres // end of [val]
//
val unlink_ret = tmpfile_unlink (fname_dats_stderr)
//
} (* end of [atscc2js_comp_file] *)

(* ****** ****** *)

(* end of [atscc2js_comp.dats] *)
