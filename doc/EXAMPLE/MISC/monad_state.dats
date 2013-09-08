(* ****** ****** *)
//
// Experimenting with state-monad
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

datatype unit = unit of ()

(* ****** ****** *)

abstype
monad_type (t@ype(*env*), t@ype(*val*)) = ptr
typedef
monad (t:t@ype, a: t@ype) = monad_type (t, a)

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
fun
{t:t@ype}
{a,b:t@ype}
monad_bind
  (monad (t, a), cfun (a, monad (t, b))): monad (t, b)
// end of [monad_bind]
extern
fun
{t:t@ype}
{a1,a2,b:t@ype}
monad_bind2
(
  monad (t, a1), monad (t, a2), cfun (a1, a2, monad (t, b))
) : monad (t, b) // end of [monad_bind2]

(* ****** ****** *)

extern
fun
{t:t@ype}
{a:t@ype}
monad_return (x: a): monad (t, a)

extern
fun{t:t@ype} monad_get (): monad (t, t)
extern
fun{t:t@ype} monad_put (env: t): monad (t, unit)

extern
fun{t:t@ype}{a:t@ype}
monad_runST (m: monad (t, a), env: t): (a, t)

(* ****** ****** *)

local

assume
monad_type (env: t@ype, a: t@ype) = env -<cloref1> (a, env)

in (* in of [local] *)

implement
{t}{a,b}
monad_bind (m0, f) =
(
  lam (env) => let
    val (x0, env) = m0 (env)
    val m1 = f (x0): t -<cloref1> (b, t)
  in
    m1 (env)
  end // end of [lam]
)   
implement
{t}{a1,a2,b}
monad_bind2 (m0, m1, f) =
(
  lam (env) => let
    val (x0, env) = m0 (env)
    val (x1, env) = m1 (env)
    val m2 = f (x0, x1): t -<cloref1> (b, t)
  in
    m2 (env)
  end // end of [lam]
)   

implement
{t}{a}
monad_return (x) = lam (env) => (x, env)

implement{t} monad_get () = lam x => (x, x)
implement{t} monad_put (env) = lam _ => (unit(), env)

implement{t}{a} monad_runST (m, env) = m (env)

end // end of [local]

(* ****** ****** *)

typedef t = int

(* ****** ****** *)

fun
incr (
) : monad (t, unit) =
(
  monad_bind<t><t,unit> (monad_get<t> (), lam env => monad_put<t> (env+1))
) // end of [incr]

(* ****** ****** *)

fun addm
(
  mx: monad (t, int)
, my: monad (t, int)
) : monad (t, int) =
  monad_bind2
(
  mx, my, lam (x, y) => monad_bind<t><unit,int> (incr (), lam _ => monad_return (x+y))
) // end of [addm]

(* ****** ****** *)

val m0 = monad_return<t><int> (0)
val m1 = monad_return<t><int> (1)
val m_1 = monad_return<t><int> (~1)

val m012 = (m0 \addm m1) \addm m_1

(* ****** ****** *)
//
val (res, env) =
  monad_runST<t><int> (m012, 0(*env*))
//
val () = println! ("res(0) = ", res)
val () = println! ("env(2) = ", env)
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [monad_state.dats] *)
