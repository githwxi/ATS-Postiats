//
// Finding the max common prefix of
// two given strings
//
// Author: Hongwei Xi (February 22, 2013)
//

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

fun string_tail
  {n:int | n > 0}
  (str: string n): string (n-1) = 
  $UN.cast{string(n-1)} (ptr_succ<char> (string2ptr (str)))
// end of [string_tail]

(* ****** ****** *)

extern
fun strprefix
  {n1,n2:int} (string (n1), string (n2)): sizeLte (min(n1,n2))
// end of [strprefix]

(* ****** ****** *)

#define CNUL '\000'

implement
strprefix
  {n1,n2} (str1, str2) = let
//
fun loop
  {n1,n2:nat} .<n1>. (
  str1: string n1, str2: string n2, i: size_t
) : size_t = let
  val (pf1 | c1) = string_test_at (str1, 0)
in
//
if c1 != CNUL then let
  val (pf2 | c2) = string_test_at (str2, 0)
in
//
if c2 != CNUL then
(
  if c1 = c2 then let
    prval
      string_index_p_neqz () = pf1
    val str1 = string_tail (str1)
    prval
      string_index_p_neqz () = pf2
    val str2 = string_tail (str2)
  in
    loop (str1, str2, succ(i))
  end else (i) // end of [if]
) else (i)
//
end else (i)
//
end // end of [loop]
//
prval () = lemma_string_param (str1)
prval () = lemma_string_param (str2)
//
in
  $UN.cast {sizeLte(min(n1,n2))} (loop (str1, str2, g1int2uint(0)))
end // end of [strprefix]

(* ****** ****** *)

implement
main0 () = {
  val str1 = "abcde"
  val str2 = "abcfgh"
  val ind = strprefix (str1, str2)
  val () = println! ("strprefix(", "\"", str1, "\"", ", ", "\"", str2, "\"", ") = ", ind)
  val () = assertloc (ind = 3)
} // end of [main0]

(* ****** ****** *)

(* end of [strprefix.dats] *)
