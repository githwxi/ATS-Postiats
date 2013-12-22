(*
** A refinement-based
** implementation of mergesort
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STRING = "libc/SATS/string.sats"

(* ****** ****** *)

extern
fun{a:t0p}
mergesort{n:nat}
  (xs: arrayref(a, n), n: int n): arrayref(a, n)

(* ****** ****** *)

extern
fun{a:t0p}
myseq_split
  {n:int | n >= 2}
(
  xs: arrayref (a, n), n: int n
) : (arrayref(a, n/2), arrayref(a, n-n/2))

(* ****** ****** *)

extern
fun{a:t0p}
myseq_merge
  {n1,n2:nat}
(
  xs1: arrayref(a, n1)
, xs2: arrayref(a, n2)
, n1: int(n1), n2: int(n2)
) : arrayref(a, n1+n2)
// end of [myseq_merge]

(* ****** ****** *)

implement
{a}(*tmp*)
myseq_split
  {n} (xs, n) = let
  val p0 = ptrcast (xs)
  val n2 = half (n)
  val xs1 = $UN.cast{arrayref(a,n/2)}(p0)
  val xs2 = $UN.cast{arrayref(a,n-n/2)}(ptr_add<a> (p0, n2))
in
  (xs1, xs2)
end // end of [myseq_split]

(* ****** ****** *)

implement
{a}(*tmp*)
myseq_merge
  {n1,n2} (xs10, xs20, n1, n2) = let
//
extern
fun memcpy
  : (ptr, ptr, size_t) -> ptr = "mac#atslib_memcpy"
//
fun loop{n1,n2:nat}
(
  p1: ptr, p2: ptr, n1: int n1, n2: int n2, p_res: ptr
) : void =
(
if n1 = 0
then
  ignoret(memcpy(p_res, p2, n2*sizeof<a>))
else (
  if n2 = 0
  then 
    ignoret(memcpy(p_res, p1, n1*sizeof<a>))
  else let
    val x1 = $UN.ptr0_get<a> (p1)
    val x2 = $UN.ptr0_get<a> (p2)
    val sgn = gcompare_val<a> (x1, x2)
  in
    if sgn <= 0
    then let
      val () = $UN.ptr0_set<a> (p_res, x1)
      val p1 = ptr_succ<a> (p1) and n1 = n1 - 1
    in
      loop (p1, p2, n1, n2, ptr_succ<a> (p_res))
    end // end of [then]
    else let
      val () = $UN.ptr0_set<a> (p_res, x2)
      val p2 = ptr_succ<a> (p2) and n2 = n2 - 1
    in
      loop (p1, p2, n1, n2, ptr_succ<a> (p_res))
    end // end of [else]
  end // end of [else]
) (* end of [if] *)
)
//
val A = arrayptr_make_uninitized<a> (i2sz(n1+n2))
val p_A = ptrcast(A)
val ((*void*)) = loop (ptrcast(xs10), ptrcast(xs20), n1, n2, p_A)
//
in
  $UN.castvwtp0{arrayref(a,n1+n2)}(A)
end // end of [myseq_merge]

(* ****** ****** *)

implement
{a}(*tmp*)
mergesort (xs, n) = let
//
fun sort
  {n:nat} .<n>.
(
  xs: arrayref (a, n), n: int n
) : arrayref (a, n) = let
in
  if n >= 2 then let
    val n21 = half(n)
    val n22 = n - n21
    val (xs1, xs2) = myseq_split<a> (xs, n)
  in
    myseq_merge<a> (sort (xs1, n21), sort (xs2, n22), n21, n22)
  end else (xs) // end of [if]
end // end of [sort]
//
in
  sort (xs, n)
end // end of [mergesort]

(* ****** ****** *)

implement
main0 () = let
//
val N = 10
val N2 = i2sz(N)
//
typedef T = double
//
val xs =
$arrpsz{T}
(
  2.0, 9.0, 8.0, 4.0, 5.0, 3.0, 1.0, 7.0, 6.0, 0.0
) (* end of [val] *)
//
val xs = arrayref(xs)
//
val () = fprint! (stdout_ref, "xs(*input*)  = ")
val () = fprint_arrayref (stdout_ref, xs, N2)
val () = fprintln! (stdout_ref)
//
val xs = mergesort<T> (xs, N) (* [mergesort]: template *)
//
val () = fprint! (stdout_ref, "xs(*sorted*) = ")
val () = fprint_arrayref (stdout_ref, xs, N2)
val () = fprintln! (stdout_ref)
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [mergesort_array.dats] *)
