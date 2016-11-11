(*
theCounter_callback
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"theCounter_callback_start"
//
#define
ATS_STATIC_PREFIX "theCounter_callback_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)

extern
fun
theCounter_button_up_click(): void = "mac#"
extern
fun
theCounter_button_down_click(): void = "mac#"
extern
fun
theCounter_button_reset_click(): void = "mac#"

(* ****** ****** *)

local

val
theCount =
ref{int}(0)

fun
theCount_update() =
{
//
  val n = theCount[]
//
  val d0 = n%10 and d1 = n/10
  val d0 = String(d0) and d1 = String(d1)
//
  val theCount_p = $extval(ptr, "$(\"#theCount_p\")")
  val ((*void*)) = $extmcall(void, theCount_p, "text", d1+d0)
} (* end of [theCount_update] *)

in (* in-of-local *)

implement
theCounter_button_up_click
  ((*void*)) = let
  val () =
  theCount[] :=
  min(theCount[]+1, 99) in theCount_update()
end // end of [theCounter_button_up_click]

implement
theCounter_button_down_click
  ((*void*)) = let
  val () =
  theCount[] :=
  max( 0, theCount[]-1) in theCount_update()
end // end of [theCounter_button_down_click]

implement
theCounter_button_reset_click
  ((*void*)) = let
  val () = theCount[] := 0 in theCount_update()
end // end of [theCounter_button_down_click]

end // end of [local]

(* ****** ****** *)

%{$
//
theCounter_callback_start();
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [theCounter_callback.dats] *)
