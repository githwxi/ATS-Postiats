(*
** HX-2014-10:
** Patsopt-as-a-Service (PATSOPTAAS)
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload "{$LIBATSHWXI}/weboxy/SATS/weboxy.sats"
staload _ = "{$LIBATSHWXI}/weboxy/DATS/weboxy.dats"
//
(* ****** ****** *)

local
//
val () = randcolor_initize ()
//
val webox_make_ = webox_make<>
//
in (* in-of-local *)
//
implement
{}(*tmp*)
webox_make
  () = wbx where
{
  val wbx = webox_make_ ()
  val () = wbx.bgcolor(randcolor())
} (* end of [webox_make] *)
//
end // end of [local]

(* ****** ****** *)
//
val thePage =
  webox_make_name ("thePage")
//
(* ****** ****** *)
//
val thePageTop =
  webox_make_name ("thePageTop")
val thePageBody =
  webox_make_name ("thePageBody")
//
val () = thePage.children(thePageTop, thePageBody)
//
(* ****** ****** *)
//
val thePageBodyLeft =
  webox_make_name ("thePageBodyLeft")
val thePageBodyRight =
  webox_make_name ("thePageBodyRight")
//
val () = thePageBody.tabstyle(TShbox)
val () = thePageBody.percentlst ($list(15, ~1))
val () = thePageBody.children(thePageBodyLeft, thePageBodyRight)
//
(* ****** ****** *)
//
val theBodyProp =
  webox_make_name ("theBodyProp")
//
val () = theBodyProp.bgcolor("")
//
val () = theBodyProp.children(thePage)
//
(* ****** ****** *)

(* end of [mylayout2.dats] *)
