//
// A simple implementation of Co-routines
//
(* ****** ****** *)

absvtype
coroutine_vtype (inp: t@ype-, out: t@ype+)

(* ****** ****** *)

stadef cortn = coroutine_vtype
stadef coroutine = coroutine_vtype

(* ****** ****** *)

absvtype event_vtype (a: t@ype+)
vtypedef event (a:t0p) = event_vtype (a)

(* ****** ****** *)

typedef cfun1
  (a:vt0p, b:vt0p) = (a) -<cloref1> b
vtypedef lcfun1
  (a:vt0p, b:vt0p) = (a) -<lin,cloptr1> b

(* ****** ****** *)

fun{a,b:t0p}
co_make_lcfun
  (cf: lcfun1 (a, @(b, cortn (a, b)))): cortn (a, b)
// end of [co_make_lcfun]

(* ****** ****** *)

fun{a,b:t0p}
co_run (co: &cortn (a, b) >> _, x: a): b
fun{a,b:t0p}
co_run2 (co: cortn (a, b), x: a): (b, cortn (a, b))

(* ****** ****** *)

fun{a,b:t0p}
co_run_seq{n:int}
  (co: &cortn (a, b) >> _, xs: list (a, n)): list_vt (b, n)
// end of [co_run_seq]

(* ****** ****** *)

fun{a,b,c:t0p}
co_fmap (co: cortn (a, b), f: cfun1 (b, c)): cortn (a, c)

(* ****** ****** *)

(* end of [coroutine.sats] *)
