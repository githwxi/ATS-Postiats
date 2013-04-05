(*
**
** Unicode encoding/decoding functions
**
*)

(* ****** ****** *)

(*
** Author: Artyom Shalkhakov
** Authoremail: 
** Start Time: February 2013
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: 
** Start Time: April 4, 2013
*)

(* ****** ****** *)

staload "libatslex/SATS/unicode.sats"

(* ****** ****** *)

implement
char2_get_byte_order
  (c0, c1) = let
in
//
case+ 0 of
| _ when c0 = 0xFE =>
  (
    if c1 = 0xFF then BObig else BOmalformed
  )
| _ when c0 = 0xFF =>
  (
    if c1 = 0xFE then BOlittle else BOmalformed
  )
| _ => BOmalformed
//
end // end of [char2_get_byte_order]

(* ****** ****** *)

(* end of [unicode.dats] *)
