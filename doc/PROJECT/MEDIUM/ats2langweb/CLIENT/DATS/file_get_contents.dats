(*
//
// For file_get_contents RPC
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
ATS_STATIC_PREFIX "_atslangweb_file_get_contents_"
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
file_get_contents_rpc
  (fname) = let
//
val xmlhttp =
  XMLHttpRequest_new()
val ((*void*)) =
xmlhttp.onreadystatechange
(
lam((*void*)) =>
(
  if xmlhttp.is_ready_okay()
    then file_get_contents_rpc$reply<> (xmlhttp.responseText)
  // end of [if]
) (* end of [lam] *)
)
//
val command = file_get_contents_rpc$cname()
//
val ((*void*)) =
  xmlhttp.open("POST", command, true(*async*))
val ((*void*)) =
  xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
val ((*void*)) =
  xmlhttp.send("fname=" + encodeURIComponent(fname))
//
in
  // nothing
end // end of [file_get_contents_rpc]

(* ****** ****** *)

(* end of [file_get_contents.dats] *)
