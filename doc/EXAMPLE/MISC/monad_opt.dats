(* ****** ****** *)
//
// Experimenting with (simple) monad
//
(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: hwxi AT cs DOT bu DOT edu
** Time: July, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

abstype monad_type (a: t@ype) = ptr
typedef monad (a: t@ype) = monad_type (a)

(* ****** ****** *)

typedef
cfun1 (a: t@ype, b: t@ype) = a -<cloref1> b
typedef
cfun2 (a1: t@ype, a2: t@ype, b: t@ype) = (a1, a2) -<cloref1> b

stadef cfun = cfun1
stadef cfun = cfun2

(* ****** ****** *)

extern
fun{
a,b:t@ype
} monad_bind
  (monad (INV(a)), cfun (a, monad (INV(b)))): monad (b)
// end of [monad_bind]

extern
fun{a:t@ype} monad_return (x: a): monad (a)

extern
fun{a:t@ype} monad_unretn (m: monad(INV(a))): Option (a)

(* ****** ****** *)

extern
fun{
a,b:t@ype
} monad_fmap (f: cfun (a, b), m: monad (a)): monad (b)
extern
fun{
a,b:t@ype
} monad_lift (f: cfun (a, b), m: monad (a)): monad (b)

implement
{a,b}
monad_fmap (f, m) =
  monad_bind<a,b> (m, lam (x) => monad_return<b> (f (x)))
// end of [monad_fmap]

implement
{a,b}
monad_lift (f, m) = monad_fmap<a,b> (f, m)

local

assume monad_type (a: t@ype) = Option a

in (* in of [local] *)

implement{a,b}
monad_bind (m, f) =
(
  case m of Some (x) => f (x) | None () => None ()
) // end of [monad_bind]

implement{a}
monad_return (x) = Some{a}(x)

implement{a}
monad_unretn (m) = m

end // end of [local]

(* ****** ****** *)

infix >>=
macdef >>= = monad_bind
macdef mret = monad_return

(* ****** ****** *)

fun
test_maybe (
) : void = let
//
val m0 = monad_lift<int,int> (lam x => x + 3, mret (2)) >>= (lam x => mret (x*2))
//
in
//
case+ monad_unretn<int> (m0) of
| Some x =>
    println! ("The value equals Some(", x, ")")
| None _ => println! ("The value equals None()")
//
end // end of [test_maybe]

(* ****** ****** *)

val () = test_maybe ()

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [monad_option.dats] *)
