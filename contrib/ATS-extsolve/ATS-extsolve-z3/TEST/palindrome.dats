(* ****** ****** *)
//
// ATS-extsolve-z3:
//
// Proving that
// append(xs, reverse(xs)) is a palindrome
//
(* ****** ****** *)
//  
// Author: HX-2015-06-09
//
(* ****** ****** *)
//
staload
"libats/SATS/ilist_prf.sats"
//
(* ****** ****** *)
//
stacst
append: (ilist, ilist) -> ilist
//
stacst reverse: (ilist) -> ilist
//
(* ****** ****** *)
//
// A list xs is a palindrome if xs = reverse(xs):
//
propdef
isPalindrome(xs: ilist) = ILISTEQ(xs, reverse(xs))
//
(* ****** ****** *)
//
extern
prfun
mylemma1{xs:ilist}(): ILISTEQ(xs, reverse(reverse(xs)))
//
(* ****** ****** *)
//
extern
prfun
mylemma2
{xs,ys:ilist}
(
// argumentless
) :
ILISTEQ
(
  reverse(append(xs, ys)), append(reverse(ys), reverse(xs))
) (* end of [mylemma2] *)
//
(* ****** ****** *)
//
extern
prfun
mylemma_main{xs:ilist}(): isPalindrome(append(xs, reverse(xs)))
//
(* ****** ****** *)

primplmnt
mylemma_main
  {xs}() = ILISTEQ() where
{
//
prval ILISTEQ() = mylemma1{xs}()
prval ILISTEQ() = mylemma2{xs,reverse(xs)}()
//
} (* end of [mylemma_main] *)

(* ****** ****** *)

(* end of [palindrome.dats] *)
