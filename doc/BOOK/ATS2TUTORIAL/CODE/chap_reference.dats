(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef charptr = $extype"char*"

(* ****** ****** *)

local
//
#define BUFSZ 128
//
val count = ref<int> (0)
//
in (* in of [local] *)

fun genNewName
  (prfx: string): string = let
  val n = !count
  val () = !count := n + 1
  var res = @[byte][BUFSZ]((*void*))
  val err =
  $extfcall (
    int, "snprintf", addr@res, BUFSZ, "%s%i", $UNSAFE.cast{charptr}(prfx), n
  ) (* end of [$extfcall] *)
in
  strptr2string(string0_copy($UNSAFE.cast{string}(addr@res)))
end // end of [genNewName]

end // end of [local]

fun fact
  (n: int): int = let
  val res = ref<int> (1)
  fun loop (n: int):<cloref1> void =
    if n > 0
      then (!res := n * !res; loop(n-1)) else ()
    // end of [if]
  val () = loop (n)
in
  !res
end // end of [fact]

val fact1 = fact

(* ****** ****** *)

fun fact
  (n: int): int = let
  fun loop (n: int, res: int): int =
    if n > 0 then loop (n-1, n * res) else res
  // end of [loop]
in
  loop (n, 1)
end // end of [fact]

val fact2 = fact

(* ****** ****** *)

val () = assertloc (fact1(10) = fact2(10))

(* ****** ****** *)

var myvar: int = 0
val myref = ref_make_viewptr (view@(myvar) | addr@(myvar))

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_reference.dats] *)

