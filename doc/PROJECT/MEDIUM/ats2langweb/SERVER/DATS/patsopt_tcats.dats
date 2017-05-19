(*
//
// [patsopt]
// for typechecking only
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
staload
UN = "prelude/SATS/unsafe.sats"
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
  stadyn
, fname_dats, fname_dats_log
) = let
//
val
patsopt = patsopt_command<> ()
//
val
fname_dats =
  $UN.castvwtp1{string}(fname_dats)
val
fname_dats_log =
  $UN.castvwtp1{string}(fname_dats_log)
//
val
stadyn =
(
  if stadyn = 0 then "--static" else "--dynamic"
) : string // end of [val]
//
in
//
$extfcall
(
  string, "sprintf"
, "%s 2>%s --typecheck %s %s"
, patsopt, fname_dats_log, stadyn, fname_dats
) (* end of [$extfcall] *)
//
end // end of [patsopt_tcats_command]

(* ****** ****** *)

implement
{}(*tmp*)
patsopt_tcats_code
(
  stadyn, ptext
) = tcats_res where
{
//
val pfx = "patsopt_tcats_"
//
val
fname_dats =
tmpfile_make_string (pfx, ptext)
//
val tcats_res =
  patsopt_tcats_file (stadyn, fname_dats)
//
val unlink_ret = tmpfile_unlink (fname_dats)
//
} (* end of [patsopt_tcats_code] *)

(* ****** ****** *)

implement
{}(*tmp*)
patsopt_tcats_file
(
  stadyn, fname_dats
) = tcats_res where
{
//
val
fname_dats_log =
tmpfile_make_nil ("patsopt_tcats_")
//
val
command =
patsopt_tcats_command
(
  stadyn
, fname_dats, fname_dats_log
) (* patsopt_tcats_command *)
//
val
exec_ret = exec_retval(command)
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
