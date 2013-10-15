(*  
** Handling JS events within ATS.
** Author: Will Blair (wdblair At cs Dot bu Dot edu)
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
  (event: event1): void = "ext#"
  
(* ****** ****** *)

implement fact_handle_keypress_fun (event) = let
  val key = document_event_get_keyCode (event)
  val (
  ) = if key = ENTER then
  {
    val input = document_event_get_target (event)
    val n = document_element_get_value_int (input)
    val () = println! ("fact(", n, ") = ", fact(n))
    val () = document_element_free (input)
  }
in
  document_event_free (event)
end // end of [fact_handle_keypress_fun]

(* ****** ****** *)

(* end of [fact.dats] *)
