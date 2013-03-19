(*
** for testing [prelude/char]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

val () = {
  val () = assertloc ('A' = 'A')
  val () = assertloc ('A' < 'B')
  val () = assertloc ('A' <= 'B')
  val () = assertloc ('Z' > 'Y')
  val () = assertloc ('Z' >= 'Y')
  val () = assertloc (compare ('A', 'B') = ~1)
  val () = assertloc (compare ('A', 'C') = ~2)
  val () = assertloc (compare ('P', 'P') =  0)
  val () = assertloc (compare ('Z', 'X') =  2)
  val () = assertloc (compare ('Z', 'Y') =  1)
} // end of [val]

(* ****** ****** *)

val () = {
//
  val () = assertloc (isalpha ('A'))
  val () = assertloc (~isalpha ('0'))
//
  val () = assertloc (isalnum ('A'))
  val () = assertloc (isalnum ('0'))
  val () = assertloc (~isalnum ('*'))
//
  val () = assertloc (isascii ('A'))
  val () = assertloc (isascii (127))
  val () = assertloc (isascii ('\177'))
  val () = assertloc (~isascii (128))
  val () = assertloc (~isascii ('\200'))
//
  val () = assertloc (isblank (' '))
  val () = assertloc (isblank ('\t'))
  val () = assertloc (~isblank ('\n'))
//
  val () = assertloc (isspace (' '))
  val () = assertloc (isspace ('\t'))
  val () = assertloc (~isspace ('t'))
  val () = assertloc (isspace ('\n'))
  val () = assertloc (~isspace ('n'))
//
  val () = assertloc (iscntrl ('\001'))
  val () = assertloc (iscntrl ('\002'))
//
  val () = assertloc (isdigit ('0'))
  val () = assertloc (~isdigit ('a'))
  val () = assertloc (~isdigit ('A'))
  val () = assertloc (isxdigit ('0'))
  val () = assertloc (isxdigit ('a'))
  val () = assertloc (isxdigit ('A'))
  val () = assertloc (~isxdigit ('g'))
//
  val () = assertloc (isprint ('a'))
  val () = assertloc (isprint ('A'))
  val () = assertloc (isprint (' '))
  val () = assertloc (~isprint ('\t'))
  val () = assertloc (~isprint ('\n'))
  val () = assertloc (~isprint ('\000'))
  val () = assertloc (~isprint ('\001'))
//
  val () = assertloc (ispunct (':'))
  val () = assertloc (ispunct (','))
  val () = assertloc (ispunct (';'))
  val () = assertloc (ispunct ('.'))
//
  val () = assertloc (islower ('a'))
  val () = assertloc (~islower ('A'))
  val () = assertloc (~islower ('0'))
//
  val () = assertloc (isupper ('A'))
  val () = assertloc (~isupper ('a'))
  val () = assertloc (~isupper ('0'))
//
  val () = assertloc (tolower 'A' = 'a')
  val () = assertloc (toupper 'a' = 'A')
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_char.dats] *)
