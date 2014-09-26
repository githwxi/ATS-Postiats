(*
//
// [patsopt]
// for typechecking only
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

implement
{}(*tmp*)
patsopt_tcats_command
(
  fname_dats, fname_dats_log
) = let
//
val patsopt = patsopt_command<> ()
//
val fname_dats = $UN.castvwtp1{string}(fname_dats)
val fname_dats_log = $UN.castvwtp1{string}(fname_dats_log)
//
in
//
$extfcall
(
  string, "sprintf"
, "%s 2>%s --typecheck --dynamic %s"
, patsopt, fname_dats_log, fname_dats
) (* end of [$extfcall] *)
//
end // end of [patsopt_tcats_command]

(* ****** ****** *)

implement
{}(*tmp*)
patsopt_tcats_code
  (ptext) =
  tcats_res where
{
//
val pfx = "patsopt_tcats_"
//
val fname_dats =
  tmpfile_make_string (pfx, ptext)
//
val tcats_res = patsopt_tcats_file (fname_dats)
//
val unlink_ret = tmpfile_unlink (fname_dats)
//
} (* end of [patsopt_tcats_code] *)

(* ****** ****** *)

implement
{}(*tmp*)
patsopt_tcats_file
  (fname_dats) =
  tcats_res where
{
//
val fname_dats_log =
  tmpfile_make_nil ("patsopt_tcats_")
//
val
command =
patsopt_tcats_command
  (fname_dats, fname_dats_log)
//
val
exec_ret = exec_retval (command)
//
val
tcats_res = (
//
if exec_ret = 0
  then let
    val str = "Typechecking passed!"
  in
    COMPRES0_succ (str)
  end // end of [then]
  else let
    val str = tmpfile2string (fname_dats_log)
  in
    COMPRES1_fail (str)
  end (* end of [else] *)
// end of [if]
) : compres // end of [val]
//
val unlink_ret = tmpfile_unlink (fname_dats_log)
//
} (* end of [patsopt_tcats_file] *)

(* ****** ****** *)

(* end of [patsopt_tcats.dats] *)
