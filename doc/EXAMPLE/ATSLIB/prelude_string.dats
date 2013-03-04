(*
** for testing [prelude/string]
*)

(* ****** ****** *)

staload "prelude/DATS/basics.dats"

staload "prelude/DATS/integer.dats"
staload "prelude/DATS/pointer.dats"

staload "prelude/DATS/char.dats"

staload "prelude/DATS/string.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

val alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () = {
  val ab = alphabet
  val () = assertloc (ab[0] = 'A')
  val () = assertloc (ab[1] = 'B')
  val () = assertloc (ab[2] = 'C')
  val () = assertloc (ab[23] = 'X')
  val () = assertloc (ab[24] = 'Y')
  val () = assertloc (ab[25] = 'Z')
  val () = assertloc (compare (ab, ab) = 0)
  val () = assertloc (strlen (ab) = 26)
  val () = assertloc (string_length (ab) = 26)
} // end of [val]

(* ****** ****** *)

val () = {
  val ab = alphabet
  val () = assertloc (strchr (ab, 'm') < 0)
  val () = assertloc (strrchr (ab, 'm') < 0)
  val () = assertloc (strchr (ab, 'A') = 0)
  val () = assertloc (strrchr (ab, 'A') = 0)
  val () = assertloc (strchr (ab, 'Z') = 25)
  val () = assertloc (strrchr (ab, 'Z') = 25)
  val () = assertloc (strstr (ab, "PQR") = strchr (ab, 'P'))
  val () = assertloc (strspn (ab, "ABC") = 3)
  val () = assertloc (strcspn (ab, "XYZ") = 23)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_string.dats] *)
