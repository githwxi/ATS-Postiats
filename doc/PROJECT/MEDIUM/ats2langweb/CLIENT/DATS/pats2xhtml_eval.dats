(*
//
// [pats2xhtml] for syntax-hiliting
//
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "atslangweb_"
#define
ATS_STATIC_PREFIX "_atslangweb_pats2xhtml_eval_"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
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
pats2xhtml_eval_rpc
  (stadyn, mycode) = let
//
val
xmlhttp =
XMLHttpRequest_new()
val ((*void*)) =
xmlhttp.onreadystatechange
(
lam((*void*)) =>
(
  if xmlhttp.is_ready_okay()
    then pats2xhtml_eval_rpc$reply<>(xmlhttp.responseText())
  // end of [if]
) (* end of [lam] *)
)
//
val command = pats2xhtml_eval_rpc$cname()
//
val ((*void*)) =
  xmlhttp.open("POST", command, true(*async*))
val ((*void*)) =
  xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
val stadyn = String(stadyn)
val ((*void*)) =
  xmlhttp.send("stadyn=" + stadyn + "&" + "mycode=" + encodeURIComponent(mycode))
//
in
  // nothing
end // end of [pats2xhtml_eval_rpc]

(* ****** ****** *)

(* end of [pats2xhtml_eval.dats] *)
