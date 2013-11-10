(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun strcmp (str1: string, str2: string): int

(* ****** ****** *)

(*

int
strcmp (char *p1, char *p2)
{
  int res ;
  unsigned char c1, c2;
  while (1)
  {
    c1 = *p1; c2 = *p2;
    if (c1 > c2) { res =  1 ; break ; } ;
    if (c1 < c2) { res = -1 ; break ; } ;
    if ((int)c1==0) { res = 0 ; break ; } else { p1++; p2++; } ;
  }
  return res ;
}

*)

(* ****** ****** *)

implement
strcmp (str1, str2) = let
//
fun loop
  (p1: ptr, p2: ptr): int = let
//
val c1 = $UN.ptr0_get<uchar> (p1)
val c2 = $UN.ptr0_get<uchar> (p2)
//
in
  case+ 0 of
  | _ when c1 > c2 =>  1
  | _ when c1 < c2 => ~1
  | _ (* c1 = c2 *) =>
    (
      if $UN.cast{int}(c1) = 0
        then 0 else loop (ptr0_succ<uchar>(p1), ptr0_succ<uchar>(p2))
      // end of [if]
    )
end (* end of [loop] *)
//
in
  loop (string2ptr(str1), string2ptr(str2))
end (* end of [strcmp] *)
  
(* ****** ****** *)

implement
main0 () =
{
val () = assertloc (strcmp("abcde", "abcde") = 0)
val () = assertloc (strcmp("abcdefg", "abcde") > 0)
val () = assertloc (strcmp("abccc", "abcde") < 0)
}

(* ****** ****** *)

(* end of [strcmp.dats] *)
