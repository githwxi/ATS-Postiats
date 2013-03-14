//
// testing the support for extfcall
//

(* ****** ****** *)

%{^
#include <stdlib.h>
%} // end of [%{^]

(* ****** ****** *)

implement
main0 () =
{
  val USER =
    $extfcall(string, "getenv", "USER")
  val () = println! ("Hello from the user [", USER, "].")
} // end of [main0]

(* ****** ****** *)

(* end of [extfcall.dats] *)