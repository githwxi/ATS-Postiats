(*
//
// [patsopt] for typechecking
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
patsopt_tcats_rpc
  (code) = let
//
val xmlhttp =
  XMLHttpRequest_new()
val ((*void*)) =
xmlhttp.onreadystatechange
(
  lam((*void*)) =>
    if xmlhttp.is_ready_okay()
      then patsopt_tcats_rpc$reply<> (xmlhttp.responseText)
  // end of [lam]
)
//
val command =
  "SERVER/mycode/atslangweb__patsopt_tcats_1_.php"
//
val ((*void*)) = xmlhttp.open("POST", command, true)
//
val ((*void*)) =
  xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
//
val () = xmlhttp.send("mycode=" + encodeURIComponent(code))
//
in
  // nothing
end // end of [patsopt_tcats_rpc]

(* ****** ****** *)

(* end of [patsopt_tcats.dats] *)
