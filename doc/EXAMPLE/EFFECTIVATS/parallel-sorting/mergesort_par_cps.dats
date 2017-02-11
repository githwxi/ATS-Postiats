(* ****** ****** *)
//
// For use in Effective-ATS
//
(* ****** ****** *)

extern
fun
{a:t@ype}
mergesort
{n:int}
(xs: list(a, n)): list(a, n)

(* ****** ****** *)

extern
fun
{a:t@ype}
list_split
{n:int}{k:nat | k <= n}
(
xs: list(a, n), k: int(k)
) : (list(a, k), list(a, n-k))

extern
fun
{a:t@ype}
list_merge
{n1,n2:int}
(
xs: list(a, n1), ys: list(a, n2)
) : list(a, n1+n2)

(* ****** ****** *)
//
fun {
a:t@ype
} msort{n:int}
(
xs: list(a, n), n: int(n),
k0: list(a, n) -<cloref1> void
) : void = let
//
// For sending to a thread pool
// a given closure (representing work)
extern fun submit : lazy(void) -> void
//
in
//
if
(n >= 2)
then let
//
val n2 = n / 2
val
(xs1, xs2) =
list_split<a>(xs, n2)
//
//
// [cnt] should be
// guarded by a spinlock:
val cnt = ref<int>(0)
//
val ys1 = ref<list(a, n/2)>(_)
val ys2 = ref<list(a, n-n/2)>(_)
//
val () =
submit
(
delay(
msort(
  xs1, n2
, lam(ys1_) =>
  (!ys1 := ys1_;
   !cnt := !cnt + 1;
   if !cnt < 2 then () else k0(list_merge<a>(!ys1, !ys2))
  )
) (* msort *)
) (* delay *)
) (* submit *)
//
val () =
submit
(
delay(
msort(
  xs2, n-n2
, lam(ys2_) =>
  (!ys2 := ys2_;
   !cnt := !cnt + 1;
   if !cnt < 2 then () else k0(list_merge<a>(!ys1, !ys2))
  )
) (* msort *)
) (* delay *)
) (* submit *)
//
in
  // nothing
end // end of [then]
else k0(xs) // end of [else]
//
end (* end of [msort] *)
//
(* ****** ****** *)

implement
{a}(*tmp*)
mergesort
 {n}(xs) = let
//
extern
fun block(): void // for blocking
and unblock(): void // for unblocking
//
// For sending to a thread pool
// a given closure (representing work)
extern fun submit : lazy(void) -> void
//
val ys = ref<list(a, n)>(_)
//
val () =
submit
(
delay(
msort<a>
( xs
, length(xs)
, lam(ys_) => (!ys := ys_; unblock())
)
) (* delay *)
) (* submit *)
//
in
  block(); !ys  
end // end of [mergesort]

(* ****** ****** *)

(* end of [mergesort_par_cps.dats] *)
