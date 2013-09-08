(* ****** ****** *)
//
// Experimenting with maybe-monad
//
(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: hwxi AT cs DOT bu DOT edu
** Time: the third of July, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

abstype monad_type (a: t@ype) = ptr
typedef monad (a: t@ype) = monad_type (a)

(* ****** ****** *)

typedef
cfun1 (a: t@ype, b: t@ype) = a -<cloref1> b
typedef
cfun2 (a1: t@ype, a2: t@ype, b: t@ype) = (a1, a2) -<cloref1> b

(* ****** ****** *)

stadef cfun = cfun1
stadef cfun = cfun2

(* ****** ****** *)

extern
fun{
a,b:t@ype
} monad_bind
  (monad (a), cfun (a, monad (b))): monad (b)
// end of [monad_bind]

extern
fun{a:t@ype} monad_return (x: a): monad (a)
extern
fun{a:t@ype} monad_unretn (m: monad (a)): Option (a)

(* ****** ****** *)

extern
fun{
a,b:t@ype
} monad_fmap (f: cfun (a, b), m: monad (a)): monad (b)
extern
fun{
a,b:t@ype
} monad_lift (f: cfun (a, b), m: monad (a)): monad (b)

(* ****** ****** *)

implement
{a,b}
monad_fmap (f, m) =
  monad_bind<a,b> (m, lam (x) => monad_return<b> (f (x)))
// end of [monad_fmap]

implement
{a,b}
monad_lift (f, m) = monad_fmap<a,b> (f, m)

(* ****** ****** *)

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

#define mbind monad_bind
#define mretn monad_return

#define mlift monad_lift
#define mfmap monad_fmap

#define munretn monad_unretn

(* ****** ****** *)

fun
test_maybe
(
  x0: int
) : int = let
//
val m0 = mretn<int> (x0)
val m0 = mlift<int,int> (lam x => x+3, m0)
val m0 = mbind<int,int> (m0, lam x => mretn (x*2))
val-Some(res) = munretn<int> (m0)
//
in
  res (* = (x0+3)*2 *)
end // end of [test_maybe]

(* ****** ****** *)

val () = assertloc (test_maybe(10) = (10+3)*2)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [monad_maybe.dats] *)
