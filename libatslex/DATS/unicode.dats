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
//
staload
UN = "prelude/SATS/unsafe.sats"
//
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

implement
utf8_get_cpw
  {i} (cp) = let
//
val [w:int] cpw =
(
  case+ 0 of
  | _ when cp < 0 => ~1
  | _ when cp <= 0x7F => 1
  | _ when cp <= 0x7FF => 2
  | _ when cp <= 0x7FFFF => 3
  | _ when cp <= 0x10FFFF => 4
  | _ (*TOOBIG*) => ~1
) : Int // end of [val]
//
in
  $UN.cast{intcpw(i,w)}(cpw)
end // end of [utf8_get_cpw]

(* ****** ****** *)

implement{}
utf8_encode_err
  (cp, err) = let
//
val () = err := 0
//
macdef proc (x) = utf8_encode$fput (,(x))
//
in
//
case+ 0 of
| _ when cp <= 0x7FU => proc (cp)
| _ when cp <= 0x7FFU =>
  {
    val () = proc (0xC0U lor (cp >> 6))
    val () = proc (0x80U lor (cp land 0x3FU))
  } // end of [0x7FFU]
| _ when cp <= 0x7FFFFU => let
    val test = 0xD800U <= cp && cp < 0xE000U
  in
    if test then (err := err + 1) else
    {
      val () = proc (0xE0U lor (cp >> 12))
      val () = proc (0x80U lor ((cp >> 6) land 0x3FU))
      val () = proc (0x80U lor (cp land 0x3FU))
    } // end of [if]
  end // end of [0x7FFFFU]
| _ when cp <= 0x10FFFFU =>
  {
    val () = proc (0xF0U lor (cp >> 18))
    val () = proc (0x80U lor ((cp >> 12) land 0x3FU))
    val () = proc (0x80U lor ((cp >> 6) land 0x3FU))
    val () = proc (0x80U lor (cp land 0x3FU))
  } // end of [0x10FFFFU]
| _ => (err := err + 1)
//
end // end of [utf8_encode]

(* ****** ****** *)

(* end of [unicode.dats] *)
