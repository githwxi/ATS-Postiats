//
// A simple implementation of Co-routines
//
(* ****** ****** *)

absvtype
coroutine_vtype
  (inp:t@ype-, out:t@ype+) = ptr
stadef cortn = coroutine_vtype
stadef coroutine = coroutine_vtype

(* ****** ****** *)

typedef cfun1
  (a:vt0p, b:vt0p) = (a) -<cloref1> b
vtypedef lcfun1
  (a:vt0p, b:vt0p) = (a) -<lin,cloptr1> b

(* ****** ****** *)

(*
//
// HX-2013-08:
// if coroutines need to be properly freed,
// the following type is another possibililty for coroutines:
//
{i:bool} (option_vt (a, i)) -<lin,cloptr1> option_vt (@(b, cortn (a, b)), i)
*)

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
co_run (co: &cortn (INV(a), INV(b)) >> _, x: a): b
fun{a,b:t0p}
co_run2 (co: cortn (INV(a), INV(b)), x: a): (b, cortn (a, b))

(* ****** ****** *)

fun{a,b:t0p}
co_run_list{n:int}
(
  co: &cortn (INV(a), INV(b)) >> _, xs: list (a, n)
) : list_vt (b, n) // end of [co_run_list]

(* ****** ****** *)

fun{a,b,c:t0p}
co_fmap (co: cortn (INV(a), INV(b)), f: cfun1 (b, c)): cortn (a, c)

(* ****** ****** *)

fun{a,b:t0p}
co_arr (f: a -<cloref1> b): cortn (a, b)

(* ****** ****** *)

fun{a,b,c:t0p}
co_arr_fst (co: cortn(INV(a), INV(b))): cortn ((a,c), (b,c))
fun{a,b,c:t0p}
co_arr_snd (co: cortn(INV(a), INV(b))): cortn ((c,a), (c,b))

(* ****** ****** *)

fun{a,b,c:t0p}
co_arr_bind (
  cof: cortn (INV(a), INV(b))
, cog: cortn (INV(b), INV(c))
) : cortn (a, c)

(* ****** ****** *)

fun{a,b,c:t0p}
co_arr_fanout (
  cof: cortn (INV(a), INV(b))
, cog: cortn (INV(a), INV(c))
) : cortn (a, @(b,c))

(* ****** ****** *)

fun{a,b:t0p}
co_arr_loop (co: cortn((INV(a), INV(b)), b), seed: b): cortn(a, b)

(* ****** ****** *)

(* end of [coroutine_t.sats] *)
