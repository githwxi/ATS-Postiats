(*
** for testing [prelude/string]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () =
{
//
val () = assertloc ("AB" < "ABC")
val () = assertloc ("BC" > "ABC")
val () = assertloc ("XYZ" > "XY")
val () = assertloc ("XYZ" < "YZ")
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
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
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
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

val () =
{
//
val ab = alphabet
val ab2 = string0_copy (ab)
val () = assertloc (ab = $UN.strptr2string (ab2))
val () = strptr_free (ab2)
val abab = string0_append (ab, ab)
val () = assertloc (strstr ($UN.strptr2string (abab), ab) = 0)
val () = assertloc (strrchr ($UN.strptr2string (abab), 'A') = 26)
val () = assertloc (strrchr ($UN.strptr2string (abab), 'B') = 27)
val () = assertloc (strrchr ($UN.strptr2string (abab), 'C') = 28)
val () = strptr_free (abab)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val ab = alphabet
//
implement{}
string_tabulate$fopr(i) = let
  val c = int2char0 (char2int0('A') + g0u2i(i))
in
  $UN.cast{charNZ}(c) // HX: [c] cannot be NUL
end // end of [string_tabulate$fwork]
//
val ab2 =
  string_tabulate(i2sz(26))
val ((*void*)) =
  assertloc (ab = $UN.castvwtp1{string}(ab2))
val ((*void*)) = strnptr_free (ab2)
//
val ab3 =
string_tabulate_cloref
  (i2sz(26), lam(i) => $UN.cast{charNZ}('A'+sz2i(i)))
//
val ((*void*)) = assertloc (ab = $UN.castvwtp1{string}(ab3))
val ((*void*)) = strnptr_free (ab3)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val asz = i2sz(5)
val A = arrayptr_make_elt<string> (asz, "")
val () =
(
  A[0] := "H";
  A[1] := "e";
  A[2] := "l";
  A[3] := "l";
  A[4] := "o";
) (* end of [val] *)
val str = stringarr_concat ($UN.arrayptr2ref(A), asz)
val () = arrayptr_free (A)
//
val out = stdout_ref
val () = fprintln! (out, "str = ", str)
val () = strptr_free (str)
//
} // end of [val]

(* ****** ****** *)

val () =
{
val out = stdout_ref
val cs = string_explode ("abcde")
val abcde = string_make_list ($UN.list_vt2t{charNZ}(cs))
val () = list_vt_free (cs)
val () = assertloc ("abcde" = $UN.strnptr2string(abcde))
val () = strnptr_free (abcde)
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val ab = alphabet
//
val out = stdout_ref
//
implement{env}
string_foreach$fwork
  (c, env) = fprint_char (out, c)
val () = assertloc (string_foreach (ab) = 26)
val () = fprint_newline (out)
//
implement{env}
string_rforeach$fwork
  (c, env) = fprint_char (out, c)
val () = assertloc (string_rforeach (ab) = 26)
val () = fprint_newline (out)
//
} (* end of [val] *)

(* ****** ****** *)
//
val () = assertloc (strcmp("a", "a") = 0)
val () = assertloc (strcmp("b", "b") = 0)
val () = assertloc (strcmp("b", "a") > 0)
val () = assertloc (strcmp("a", "b") < 0)
//
val () = assertloc (compare("a", "a") =  0)
val () = assertloc (compare("b", "b") =  0)
val () = assertloc (compare("b", "a") =  1)
val () = assertloc (compare("a", "b") = ~1)
//
(* ****** ****** *)

val () =
{
//
val () = assertloc (stropt_length (stropt_none ()) = ~1)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val res =
$extfcall (Strptr0, "atspre_string_make_snprintf", "%i:%s", 1234567890, "abcdefghijklmnopqrstuvwxyz")
//
val () = println! (res)
val () = strptr_free (res)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_string.dats] *)
