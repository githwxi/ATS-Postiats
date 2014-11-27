(*
//
// [patsopt] for
// typechecking and codegen(JS)
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
ATS_STATIC_PREFIX "_atslangweb_patsopt_atscc2js_"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/Ajax/Ajax.sats"
//
(* ****** ****** *)

staload "./../SATS/atslangweb.sats"

(* ****** ****** *)

implement
{}(*tmp*)
patsopt_atscc2js_rpc
  (mycode) = let
//
val xmlhttp =
XMLHttpRequest_new()
//
val ((*void*)) =
xmlhttp.onreadystatechange
(
lam((*void*)) =>
(
  if xmlhttp.is_ready_okay()
    then patsopt_atscc2js_rpc$reply<> (xmlhttp.responseText)
  // end of [if]
) (* end of [lam] *)
) (* end of [onreadystatechange] *)
//
val command = patsopt_atscc2js_rpc$cname()
//
val ((*void*)) =
  xmlhttp.open("POST", command, true)
val ((*void*)) =
  xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
val ((*void*)) =
  xmlhttp.send("mycode=" + encodeURIComponent(mycode))
//
in
  // nothing
end // end of [patsopt_atscc2js_rpc]

(* ****** ****** *)

(* end of [patsopt_atscc2js.dats] *)
