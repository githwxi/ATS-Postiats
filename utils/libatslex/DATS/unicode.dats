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
  (c1, c2) = let
in
//
case+ 0 of
| _ when c1 = 0xFE =>
  (
    if c2 = 0xFF then BObig else BOmalformed
  )
| _ when c1 = 0xFF =>
  (
    if c2 = 0xFE then BOlittle else BOmalformed
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

local

macdef
fget () = utf8_decode$fget ()
macdef
isvalid (x) = (,(x) >> 6) = 2

fun{
} aux0
(
  err: &int >> _
) : int = let
  val c1 = fget ()
in
  if c1 >= 0 then g0u2i (aux1 (c1, err)) else c1
end // end of [aux0]

and aux1
(
  c1: int, err: &int >> _
) : uint = let
in
//
case+ 0 of
| _ when c1 < 128 => g0i2u(c1)
| _ when (192 <= c1 && c1 < 224) => let
    val c2 = fget ()
//
    val c1 = g0i2u(c1)
    and c2 = g0i2u(c2)
//
    val test = isvalid (c2)
    val () = if not(test) then err := err + 1
  in
    ((c1 land 0x1FU) << 6) lor (c2 land 0x3FU)
  end // end of [...]
| _ when (224 <= c1 && c1 < 240) => let
    val c2 = fget ()
    val c3 = (if c2 >= 0 then fget () else ~1): int
//
    val c1 = g0i2u(c1)
    and c2 = g0i2u(c2)
    and c3 = g0i2u(c3)
//
    val test = isvalid (c2) && isvalid (c3)
    val () = if not(test) then err := err + 1
  in
    ((c1 land 0x0FU) << 12) lor ((c2 land 0x3FU) << 6) lor (c3 land 0x3FU)
  end // end of [...]
| _ when (240 <= c1 && c1 < 248) => let
    val c2 = fget ()
    val c3 = (if c2 >= 0 then fget () else ~1): int
    val c4 = (if c3 >= 0 then fget () else ~1): int
//
    val c1 = g0i2u(c1)
    and c2 = g0i2u(c2)
    and c3 = g0i2u(c3)
    and c4 = g0i2u(c4)
//
    val test = isvalid (c2) && isvalid (c3) && isvalid (c4)
    val () = if not(test) then err := err + 1
  in
    ((c1 land 0x07U) << 18) lor ((c2 land 0x3FU) << 12) lor ((c3 land 0x3FU) << 6) lor (c4 land 0x3FU)
  end // end of [...]
| _ => (err := err + 1; g0i2u(c1))
//
end // end of [aux1]

in (* in of [local] *)

implement{}
utf8_decode_err (err) = aux0 (err)

end // end of [local]

(* ****** ****** *)

(* end of [unicode.dats] *)
