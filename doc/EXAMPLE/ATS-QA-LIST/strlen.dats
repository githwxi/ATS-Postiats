(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun
strlen{n:nat}
(
  str: string(n)
) : int(n) = let
//
fun loop{i,j:nat}
  (str: string(i), j: int(j)): int(i+j) =
  if isneqz (str) then loop (str.tail, succ(j)) else j
//
in
  loop (str, 0)
end // end of [strlen]

(* ****** ****** *)

implement main0 () =
println! ("strlen(abcdefghijklmnopqrstuvwxyz) = ", strlen("abcdefghijklmnopqrstuvwxyz"))

(* ****** ****** *)

(* end of [strlen.dats] *)
