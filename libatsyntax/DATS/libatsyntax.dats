(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
*)

(* ****** ****** *)

staload "libatsyntax/SATS/libatsyntax.sats"

(* ****** ****** *)

implement
fstring_putc (x, putc) = let
//
fun loop {n:int}
  {i:nat | i <= n} .<n-i>. (
  x: string n
, i: size_t i
, putc: putc_type
, nerr: &int
) : int(*nerr*) =
  if string_isnot_at_end (x, i) then let
    val err = putc (x[i])
    val () = if err != 0 then nerr := nerr + 1
  in
    loop (x, i+1, putc, nerr)
  end else nerr // end of [if]
//
var nerr: int = 0
val x = string1_of_string (x)
//
in
  loop (x, 0, putc, nerr)
end // end of [fstring_putc]

(* ****** ****** *)

(* end of [libatsyntax.dats] *)
