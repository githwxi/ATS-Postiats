//
// A simple implementation of Co-routines
//
(* ****** ****** *)

absvtype
coroutine_vtype
  (inp: t@ype-, out: t@ype+) = ptr
stadef cortn = coroutine_vtype
stadef coroutine = coroutine_vtype

(* ****** ****** *)

absvtype event_vtype (a: t@ype+) = ptr
vtypedef event (a:t0p) = event_vtype (a)

(* ****** ****** *)

typedef cfun1
  (a:vt0p, b:vt0p) = (a) -<cloref1> b
vtypedef lcfun1
  (a:vt0p, b:vt0p) = (a) -<lin,cloptr1> b

(* ****** ****** *)

castfn
lcfun2cortn{a,b:t0p}
  (cf: lcfun1 (a, @(b, cortn (a, b)))):<> cortn (a, b)
// end of [lcfun2cortn]

castfn
cortn2lcfun{a,b:t0p}
  (co: cortn (a, b)):<> lcfun1 (a, @(b, cortn (a, b)))
// end of [cortn2lcfun]

(* ****** ****** *)

fun{a,b:t0p}
co_run (co: &cortn (a, b) >> _, x: a): b
fun{a,b:t0p}
co_run2 (co: cortn (a, b), x: a): (b, cortn (a, b))

(* ****** ****** *)

fun{a,b:t0p}
co_run_list{n:int}
  (co: &cortn (a, b) >> _, xs: list (a, n)): list_vt (b, n)
// end of [co_run_list]

(* ****** ****** *)

fun{a,b,c:t0p}
co_fmap (co: cortn (a, b), f: cfun1 (b, c)): cortn (a, c)

(* ****** ****** *)

(* end of [coroutine.sats] *)
