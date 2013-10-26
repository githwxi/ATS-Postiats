(*  
** Handling JS events within ATS.
** Author: Will Blair
** Authoremail: wdblairATcsDOTbuDOTedu
** Start time: October 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define
ATS_EXTERN_PREFIX "ATSJS_"

(* ****** ****** *)

staload "{$HTML}/SATS/document.sats"

(* ****** ****** *)
//
fun fact (n: int): int =
  if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)

#define ENTER 13

(* ****** ****** *)

extern
fun fact_handle_keypress_fun
  (event: event1): void = "ext#%"
implement
fact_handle_keypress_fun
  (event) = let
//
val key = document_event_get_keyCode (event)
val (
) = if key = ENTER then
{
  val input = document_event_get_target (event)
  val funarg = document_element_get_value_int (input)
  val ((*void*)) = println! ("fact(", funarg, ") = ", fact(funarg))
  val ((*void*)) = document_element_free (input)
} (* end of [if] *) // end of [val]
//
in
  document_event_free (event)
end // end of [fact_handle_keypress_fun]

(* ****** ****** *)

(*
//
// HX-2013:
// this one works, but may not be of a good style ...
//
extern
fun document_element_addEventListener_fun
(
  !element1, type: string, func: (event1) -> void
) : void
  = "ext#JS_document_element_addEventListener_fun"
// end of [document_element_addEventListener_fun]
implement
main0 ((*void*)) =
{
val input = document_getElementById ("input")
val ((*void*)) = assertloc (ptrcast(input) > 0)
val ((*void*)) =
  document_element_addEventListener_fun (input, "keypress", fact_handle_keypress_fun)
val ((*void*)) = document_element_free (input)
} (* end of [main0] *)
*)

(* ****** ****** *)

(* end of [fact.dats] *)
