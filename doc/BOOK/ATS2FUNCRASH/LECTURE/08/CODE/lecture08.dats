(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<string> = fprint_string

(* ****** ****** *)
//
val r0 = ref<int>(0)
val () = println! (!r0)
val () = (!r0 := !r0 + 1)
val () = println! (!r0)
val () = (!r0 := !r0 + 2)
val () = println! (!r0)
//
val r1 = ref<int>(0)
val () = println! (r1[])
val () = (r1[] := r1[] + 1)
val () = println! (r1[])
val () = (r1[] := r1[] + 2)
val () = println! (r1[])
//
(* ****** ****** *)

fun
fact_ref
(n: int): int = let
//
val i = ref<int>(0)
val r = ref<int>(1)
//
fun loop(): void =
  if !i < n then (!i := !i+1; !r := !r * !i; loop())
//
in
  let val () = loop() in !r end
end (* end of [fact_ref] *)

val () = println! ("fact_ref(10) = ", fact_ref(10))

(* ****** ****** *)
//
(*
extern
fun
{a:t@ype}
array0_make_elt(asz: int, x0: a): array0(a)
*)
//
(* ****** ****** *)
//
val A =
array0_make_elt<int>(3, 0)
//
val () =
println! (A[0], A[1], A[2])
//
val () = A[0] := 1
val () = A[1] := A[0] + 1
val () = A[2] := A[1] + 1
//
val () =
println! (A[0], A[1], A[2])
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
array0_foreach
(A: array0(a), fwork: cfun(a, void)): void
//
implement
{a}(*tmp*)
array0_foreach(A, fwork) =
(
  int_foreach<>(sz2i(A.size()), lam(i) => fwork(A[i]))
) (* end of [array0_foreach] *)
//
(* ****** ****** *)
//
extern
fun
{r:t@ype}
{a:t@ype}
array0_foldleft
(A: array0(a), r0: r, fopr: cfun(r, a, r)): r
//
implement
{r}{a}
array0_foldleft
  (A, r0, fopr) =
(
//
int_foldleft<r>
  (sz2i(A.size()), r0, lam(r, i) => fopr(r, A[i]))
//
) (* end of [array0_foldleft] *)
//
(* ****** ****** *)
//
extern
fun
{r:t@ype}
{a:t@ype}
array0_foldright
(A: array0(a), fopr: cfun(a, r, r), r0: r): r
//
implement
{r}{a}
array0_foldright
  (A, fopr, r0) = let
  val asz = sz2i(A.size())
in
  int_foldleft<r>(asz, r0, lam(r, i) => fopr(A[asz-i-1], r))
end (* end of [array0_foldright] *)
//
(* ****** ****** *)
(*
//
fun
{a:t@ype}
matrix0_make_elt(nrow: int, ncol: int, x0: a): matrix0(a)
//
*)
(* ****** ****** *)
//
extern
fun
{a:t@ype}
matrix0_foreach
(M: matrix0(a), fwork: cfun(a, void)): void
//
implement
{a}(*tmp*)
matrix0_foreach
  (M, fwork) = let
  val nrow = sz2i(M.nrow())
  val ncol = sz2i(M.ncol())
in
  int_cross_foreach<>(nrow, ncol, lam(i, j) => fwork(M[i,j]))
end (* end of [matrix0_foreach] *)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
matrix0_iforeach
(M: matrix0(a), fwork: cfun(int, int, a, void)): void
//
implement
{a}(*tmp*)
matrix0_iforeach
  (M, fwork) = let
  val nrow = sz2i(M.nrow())
  val ncol = sz2i(M.ncol())
in
  int_cross_foreach<>(nrow, ncol, lam(i, j) => fwork(i, j, M[i,j]))
end (* end of [matrix0_iforeach] *)
//
(* ****** ****** *)

implement
(a:t@ype)
fprint_matrix0_sep<a>
(
  out, M, sep1, sep2
) = let
//
val ncol = sz2i(M.ncol())
//
in
matrix0_iforeach<a>
( M
, lam(i, j, x) =>
  (
   if j > 0 then fprint(out, sep1);
   fprint_val<a>(out, x);
   if j+1=ncol then fprint(out, sep2)
  )
)
end // end of [fprint_matrix0]

(* ****** ****** *)
//
val M0 =
matrix0_tabulate<int>
( i2sz(5)
, i2sz(5)
, lam(i, j) => sz2i(max(i, j)) + 1
)
//
val () = fprint_matrix0_sep<int>(stdout_ref, M0, ",", "\n")
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture08.dats] *)
