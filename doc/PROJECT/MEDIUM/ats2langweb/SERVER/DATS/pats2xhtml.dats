(*
//
// [pats2xhtml]:
// for syntax-coloring ATS2 code
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
ATS_STATIC_PREFIX "_atslangweb_pats2xhtml_"
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
pats2xhtml_comp_command
(
  stadyn, fname_xats
, fname_xats_html, fname_xats_stderr
) = let
//
val pats2xhtml = pats2xhtml_command<> ()
//
val stadyn =
(
  if (stadyn = 0) then "--static" else "--dynamic"
) : string // end of [val]
//
val fname_xats = $UN.castvwtp1{string}(fname_xats)
val fname_xats_html = $UN.castvwtp1{string}(fname_xats_html)
val fname_xats_stderr = $UN.castvwtp1{string}(fname_xats_stderr)
//
in
//
$extfcall
(
  string, "sprintf"
, "%s 2>%s --embedded --output %s %s %s"
, pats2xhtml, fname_xats_stderr, fname_xats_html, stadyn, fname_xats
) (* end of [$extfcall] *)
//
end // end of [pats2xhtml_comp_command]

(* ****** ****** *)

implement
{}(*tmp*)
pats2xhtml_comp_code
(
  stadyn, ptext
) = comp_res where
{
//
val pfx = "pats2xhtml_"
//
val fname_xats =
  tmpfile_make_string (pfx, ptext)
//
val comp_res =
  pats2xhtml_comp_file (stadyn, fname_xats)
//
val unlink_ret = tmpfile_unlink (fname_xats)
//
} (* end of [pats2xhtml_comp_code] *)

(* ****** ****** *)

implement
{}(*tmp*)
pats2xhtml_comp_file
(
  stadyn, fname_xats
) = comp_res where
{
//
val fname_xats_html =
  tmpfile_make_nil ("pats2xhtml_")
val fname_xats_stderr =
  tmpfile_make_nil ("pats2xhtml_")
//
val
command =
pats2xhtml_comp_command
(
  stadyn, fname_xats
, fname_xats_html, fname_xats_stderr
) (* end of [val] *)
//
(*
val () = prerrln! ("command = ", command)
*)
//
val
exec_ret = exec_retval (command)
//
val
comp_res = (
//
if exec_ret = 0
  then let
    val code = tmpfile2string (fname_xats_html)
    val unlink_ret = tmpfile_unlink (fname_xats_html)
  in
    COMPRES0_succ (code)
  end // end of [then]
  else let
    val errmsg = tmpfile2string (fname_xats_stderr)
    val unlink_ret = tmpfile_unlink (fname_xats_html)
  in
    COMPRES1_fail (errmsg)
  end (* end of [else] *)
// end of [if]
) : compres // end of [val]
//
val unlink_ret = tmpfile_unlink (fname_xats_stderr)
//
} (* end of [pats2xhtml_comp_file] *)

(* ****** ****** *)

(* end of [pats2xhtml.dats] *)
