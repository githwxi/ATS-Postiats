//
// testing the support for extfcall
//

(* ****** ****** *)

%{^
#include <stdlib.h>
%} // end of [%{^]

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*anon*) = "prelude/DATS/basics.dats"

(* ****** ****** *)

staload TM = "libc/SATS/time.sats"

(* ****** ****** *)

implement
main0 () = let
//
var tval = $TM.time ()
val TSTR =
  $extfcall(Ptr0, "ctime", addr@(tval))
val () = assertexn (TSTR > 0)
val () = print! ($UN.cast{string}(TSTR))
val USER =
  $extfcall(Ptr0, "getenv", "USER")
in
//
if USER > 0 then let
  val USER = $UN.cast{string}(USER)
  val () = println! ("Hello from the user [", USER, "].")
in
  // nothign
end else let
  val () = println! ("Hello from an unknown user.")
in
  // nothign
end // end of [if]
//
end // end of [main0]

(* ****** ****** *)

(* end of [extfcall.dats] *)