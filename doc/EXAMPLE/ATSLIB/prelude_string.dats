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

staload UN = "prelude/SATS/unsafe.sats"

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
//
  val () = assertloc (strchr (ab, 'a') < 0)
  val () = assertloc (strrchr (ab, 'a') < 0)
  val () = assertloc (strchr (ab, 'A') = 0)
  val () = assertloc (strrchr (ab, 'A') = 0)
  val () = assertloc (strchr (ab, 'Z') = 25)
  val () = assertloc (strrchr (ab, 'Z') = 25)
  val () = assertloc (strchr (ab, '\0') = 26)
  val () = assertloc (strrchr (ab, '\0') = 26)
//
  val () = assertloc (strstr (ab, "PQR") = strchr (ab, 'P'))
  val () = assertloc (strspn (ab, "ABC") = 3)
  val () = assertloc (strcspn (ab, "XYZ") = 23)
//
  val () = assertloc (string_index (ab, 'P') = 15)
  val () = assertloc (string_rindex (ab, 'P') = 15)
//
} // end of [val]

(* ****** ****** *)

val () = {
  val ab = alphabet
  val ab2 = string0_copy (ab)
  val () = assertloc (ab = $UN.strptr2string (ab2))
  val () = strptr_free (ab2)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_string.dats] *)
