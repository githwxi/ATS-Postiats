(*  
  fact.dats
  
  An example of handling Javascript events given by the user with ATS.
  
  Author: Will Blair (wdblair At cs Dot bu Dot edu)
  Date: October 2013
*)

#include
"share/atspre_staload.hats"

staload "contrib/HTML/SATS/document.sats"

fun fact (n: int): int = let
  fun loop (i: int, r: int): int =
    if i > 1 then 
      loop(pred(i), i*r)
    else
      r
in loop(n, 1) end

fun print_fact (input: !element1): void = {
  val n = document_element_get_value_int (input)
  val () = println! ("fact(", n, ") = ", fact(n))
}

fun handle_calc (evnt: event1): void = let
  val input = document_getElementById ("input")
  val () = assertloc (ptr_isnot_null(element2ptr (input)))
  val () = print_fact (input)
in 
  document_element_free (input);
  document_event_free (evnt)
end

#define ENTER 13

fun handle_keypress (evnt: event1): void = let
  val key = document_event_get_keyCode (evnt)
  val () = if key = ENTER then let
      val target = document_event_get_target (evnt)
      val () = print_fact (target)
  in
    document_element_free (target);
  end
in
  document_event_free (evnt)
end

implement main0 () = {
  //  
  val btn = document_getElementById ("calc")
  val () = assertloc (ptr_isnot_null(element2ptr (btn)))
  val () = document_element_addEventListener (btn, "click", handle_calc)
  val () = document_element_free (btn)
  //
  val textbox = document_getElementById ("input")
  val () = assertloc (ptr_isnot_null(element2ptr (textbox)))
  val () = document_element_addEventListener (textbox, "keypress", handle_keypress)
  val () = document_element_free (textbox)
}