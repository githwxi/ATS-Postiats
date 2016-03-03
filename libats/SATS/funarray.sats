(*
** libatscc-common
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSLIB.libats.funarray"
//
(* ****** ****** *)
//
abstype
funarray_t0ype_int_type(a:t@ype+, n:int)
//
typedef
funarray
(
  a:t0p, n:int
) = funarray_t0ype_int_type(a, n)
//
typedef
funarray(a:t0p) = [n:int] funarray(a, n)
//
(* ****** ****** *)
//
praxi
lemma_funarray_param
  {a:t0p}{n:int}
  (A: funarray(INV(a), n)): [n >= 0] void
//
(* ****** ****** *)
//
fun{}
funarray_is_nil
  {a:t0p}{n:int}
  (funarray(a, n)):<> bool(n==0)
fun{}
funarray_isnot_nil
  {a:t0p}{n:int}
  (funarray(a, n)):<> bool(n > 0)
//
(* ****** ****** *)
//
fun{}
funarray_make_nil
  {a:t0p}((*void*)):<> funarray(a, 0) = "mac#%"
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_size{n:int}
  (A: funarray(INV(a), n)): int(n) = "mac#%"
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_get_at{n:int}
  (A: funarray(INV(a), n), i: natLt(n)): (a) = "mac#%"
//
fun
{a:t0p}
funarray_set_at{n:int}
  (A: &funarray(INV(a), n) >> _, i: natLt(n), x: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_insert_l{n:int}
(
  A: &funarray(INV(a), n) >> funarray(a, n+1), x: a
) : void = "mac#%" // end-of-function
fun
{a:t0p}
funarray_insert_r{n:int}
(
  A: &funarray(INV(a), n) >> funarray(a, n+1), n: int(n), x: a
) : void = "mac#%" // end-of-function
//
(* ****** ****** *)
//
fun
{a:t0p}
funarray_remove_l{n:pos}
(
  A: &funarray(INV(a), n) >> funarray(a, n-1)
) : a = "mac#%" // end of [funarray_remove_l]
//
fun
{a:t0p}
funarray_remove_r{n:pos}
(
  A: &funarray(INV(a), n) >> funarray(a, n-1), n: int(n)
) : a = "mac#%" // end of [funarray_remove_r]
//
(* ****** ****** *)
//
fun{
x:t0p
} funarray_foreach (xs: funarray(INV(x))): void
fun{
x:t0p}{env:vt0p
} funarray_foreach_env (xs: funarray(INV(x)), env: &(env) >> _): void
//
fun{
x:t0p}{env:vt0p
} funarray_foreach$cont (x: x, env: &env): bool
fun{
x:t0p}{env:vt0p
} funarray_foreach$fwork (x: x, env: &(env) >> _): void
//
(* ****** ****** *)

(* end of [funarray.sats] *)
