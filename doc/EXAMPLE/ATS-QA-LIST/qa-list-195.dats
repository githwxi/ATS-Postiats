(* ****** ****** *)
//
// HX-2014-02-14
//
(* ****** ****** *)
//
// Please use valgrind to check that there is no memory leak
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libc/SATS/alloca.sats"
//
(* ****** ****** *)
//
extern
fun{a:t0p} 
list2array_filter$pred (x: a): bool
//
extern
fun{a:t0p}
list2array_filter
  (xs: List(INV(a)), asz: &int? >> int(n)): #[n:nat] arrayptr(a, n)
//
(* ****** ****** *)

implement{a}
list2array_filter
  (xs, asz) = let
//
fun loop
(
  xs: List(a), res: List0_vt(a)
) : [n:nat] (arrayptr(a, n), int(n)) =
(
  case+ xs of
  | list_nil () => let
      val len = list_vt_length (res)
      val ares = arrayptr_make_rlist (len, $UNSAFE.list_vt2t(res))
      prval () = $UNSAFE.cast2void (res)
    in
      (ares, len)
    end // end of [loop]
  | list_cons (x, xs) => let
      val ans = list2array_filter$pred<a> (x)
    in
      if ans
        then let
          typedef node = @(a, ptr)
          val p = $extfcall(ptr, "atslib_alloca", sizeof<node>)
          val res1 = $UNSAFE.castvwtp1{list_vt_cons_pstruct(a?,ptr?)}(p)
          val+list_vt_cons (x0, xs0) = res1
          val () = x0 := x
          val () = xs0 := res
          prval () = fold@(res1)
        in
          loop (xs, res1)
        end // end of [then]
        else loop (xs, res)
      // end of [if]
    end
)
//
val (A, n) = loop (xs, list_vt_nil)
//
in
  asz := n; A
end // end of [list2array_filter]

(* ****** ****** *)

implement
main0 () =
{
//
val xs = list_make_intrange (0, 10)
//
implement
list2array_filter$pred<int> (x) = (x mod 2 = 1)
//
var n: int
val A = list2array_filter<int> ($UNSAFE.list_vt2t(xs), n)
//
val () = list_vt_free (xs)
//
val () = fprint! (stdout_ref, "A=[")
val () = fprint_arrayptr (stdout_ref, A, i2sz(n))
val () = fprintln! (stdout_ref, "]")
//
val ((*void*)) = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-195.dats] *)
