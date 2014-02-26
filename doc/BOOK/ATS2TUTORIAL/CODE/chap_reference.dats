(*
** ATS2TUTORIAL
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

%{^
#define \
snprintf_mac(str, size, format, prfx, n) \
  snprintf ((char*)(str), size, format, (char*)(prfx), n)
%}

(* ****** ****** *)

local

#define BUFSZ 128

val count = ref<int> (0)

in (* in of [local] *)

fun genNewName
  (prfx: string): string = let
  val n = !count
  val () = !count := n + 1
  var res = @[byte][BUFSZ]()
  val _(*err*) =
  $extfcall (int, "snprintf_mac", addr@res, BUFSZ, "%s%i", prfx, n)
in
  strptr2string(string0_copy($UNSAFE.cast{string}(addr@res)))
end // end of [genNewName]

end // end of [local]

(* ****** ****** *)

fun fact
  (n: int): int = let
  val res = ref<int> (1)
  fun loop (n: int):<cloref1> void =
    if n > 0 then !res := n * !res else ()
  val () = loop (n)
in
  !res
end // end of [fact]

fun fact
  (n: int): int = let
  fun loop (n: int, res: int): int =
    if n > 0 then loop (n, n * res) else res
  // end of [loop]
in
  loop (n, 1)
end // end of [fact]

(* ****** ****** *)

var myvar: int = 0
val myref = ref_make_viewptr (view@(myvar) | addr@(myvar))

(* ****** ****** *)

implement main0 () =
{
//
val name1 = genNewName ("foo")
val name2 = genNewName ("bar")
val () = println! ("name1 = ", name1)
val () = println! ("name2 = ", name2)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [chap_reference.dats] *)
