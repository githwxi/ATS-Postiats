(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/matrix0.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

fun listprod1
  (xs: list0 (int)): int = case+ xs of
  | list0_cons (x, xs) => x * listprod1 (xs) | list0_nil () => 1
// end of [listprod1]

fun listprod2
  (xs: list0 (int)): int = case+ xs of
  | list0_cons (x, xs) => if x = 0 then 0 else x * listprod2 (xs)
  | list0_nil () => 1
// end of [listprod2]

fun listprod3
  (xs: list0 (int)): int = let
  exception ZERO of ()
  fun aux (xs: list0 (int)): int =
    case+ xs of
    | list0_cons (x, xs) =>
        if x = 0 then $raise ZERO() else x * aux (xs)
    | list0_nil () => 1
  // end of [aux]
in
  try aux (xs) with ~ZERO () => 0
end // end of [listprod3]

(* ****** ****** *)

val r = ref<int> (0) // creating a reference and init. it with 0
val () = assertloc (!r = 0)
val () = !r := !r + 1 // increasing the value stored at [r] by 1
val () = assertloc (!r = 1)

(* ****** ****** *)
//
// HX: this one is done in a deplorable style
//
fun sum
  (n: int): int = let
//
  val i = ref<int> (1)
  val res = ref<int> (0)
//
  fun loop ():<cloref1> void =
    if !i <= n then (!res := !res + !i; !i := !i + 1; loop ())
  // end of [loop]
in
  loop (); !res
end // end of [sum]

(* ****** ****** *)

typedef counter = '{
  get= () -<cloref1> int
, inc= () -<cloref1> void
, reset= () -<cloref1> void
} // end of [counter]

fun newCounter
  (): counter = let
  val count = ref<int> (0)
in '{
  get= lam () => !count
, inc= lam () => !count := !count + 1
, reset= lam () => !count := 0
} end // end of [newCounter]

(* ****** ****** *)

local

val counter = newCounter ()

in

fun getNewVar (): string = let
  val n = counter.get (); val () = counter.inc ()
in
  "X" + tostring (n)
end // end of [getNewVar]

end // end of [local]

(* ****** ****** *)

fun{a:t@ype}
matrix0_transpose
  (M: matrix0 a): void = let
//
  val nrow = matrix0_row (M)
//
  fn* loop1
    (i: size_t):<cloref1> void =
    if i < nrow then loop2 (i, 0) else ()
  and loop2
    (i: size_t, j: size_t):<cloref1> void =
    if j < i then let
      val tmp = M[i,j]
    in
      M[i,j] := M[j,i]; M[j,i] := tmp; loop2 (i, j+1)
    end else
      loop1 (i+1)
    // end of [if]
//
in
  loop1 (0)
end // end of [matrix0_transpose]

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = double
implement randgen<T> () = drand48 ()
implement fprint_elt<T> (out, x) = fprint_double (out, x)

(* ****** ****** *)

implement
main () = () where {
//
  val xs = $lst {int} (tupz! 1 3 5 7 9 0 2 4 6 8)
  val xs = list0_of_list (xs)
  val () = assertloc (listprod1 (xs) = 0)
  val () = assertloc (listprod2 (xs) = 0)
  val () = assertloc (listprod3 (xs) = 0)
//
  #define N 1000
  val () = assertloc (sum (N) = N * (N+1) / 2)
//
  val () = println! (getNewVar ())
  val () = println! (getNewVar ())
  val () = println! (getNewVar ())
  val () = print_newline ()
//
  val () = srand48_with_time ()
//
  #define NROW 5; #define NCOL 5
  val M = matrix0_randgen<T> (NROW, NCOL)
  val () = print ("M =\n")
  val () = matrix0_fprint_elt (stdout_ref, M, ", ", "\n")
  val () = print_newline ()
  val () = matrix0_transpose (M)
  val () = print ("M(transposed) =\n")
  val () = matrix0_fprint_elt (stdout_ref, M, ", ", "\n")
  val () = print_newline ()
//
} // end of [main]

(* ****** ****** *)

(* end of [misc.dats] *)
