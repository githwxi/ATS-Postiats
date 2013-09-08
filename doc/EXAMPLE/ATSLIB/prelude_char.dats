(*
** for testing [prelude/char]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () =
{
//
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
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val c211 = '\211'
val c212 = '\212'
//
val uc211 = c2uc(c211)
val uc212 = c2uc(c212)
//
val i211 = char2i(c211)
val i212 = char2i(c212)
val () = println! ("i211_c2i = ", i211)
val () = println! ("i212_c2i = ", i212)
val i211 = uchar2i(uc211)
val i212 = uchar2i(uc212)
val () = println! ("i211_uc2i = ", i211)
val () = println! ("i212_uc2i = ", i212)
val i211 = char2u2i(c211)
val i212 = char2u2i(c212)
val () = println! ("i211_c2u2i = ", i211)
val () = println! ("i212_c2u2i = ", i212)
//
val ui211 = char2ui(c211)
val ui212 = char2ui(c212)
val () = println! ("ui211_c2ui = ", ui211)
val () = println! ("ui212_c2ui = ", ui212)
val ui211 = uchar2ui(uc211)
val ui212 = uchar2ui(uc212)
val () = println! ("ui211_uc2ui = ", ui211)
val () = println! ("ui212_uc2ui = ", ui212)
val ui211 = char2u2ui(c211)
val ui212 = char2u2ui(c212)
val () = println! ("ui211_c2u2ui = ", ui211)
val () = println! ("ui212_c2u2ui = ", ui212)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
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
