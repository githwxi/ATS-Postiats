(*
//
// HX-2014-03-28: 
// A program to solve the 8-queens problem
// based on lazy evaluation
//
*)
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload UN = $UNSAFE
//
(* ****** ****** *)

fun path_test
(
  xs: list0 (int), x0: int
) : bool = let
//
fun aux
(
  xs: list0 (int), df: int
) : bool =
(
  case+ xs of
  | nil0 () => true
  | cons0 (x, xs) =>
      if x0 != x && abs (x0 - x) != df then aux (xs, df+1) else false
    // end of [cons0]
)
//
in
  aux (xs, 1(*df*))
end // end of [path_test]

(* ****** ****** *)

#define N 8

(* ****** ****** *)

fun path_next
(
  xs: list0(int)
) : stream(list0(int)) = $delay
(
let
  val n = length (xs)
in
//
if n < N
  then path_next2 (xs, 0)
  else let
    val-cons0 (x, xs) = xs
  in
    path_next2 (xs, x + 1)
  end // end of [else]
//
end
) // end of [path_next]

and path_next2
(
  xs: list0(int), x0: int
) : stream_con(list0(int)) =
(
if x0 < N
  then let
    val pass = path_test (xs, x0)
  in
    if pass
      then let
        val xs = cons0 (x0, xs)
      in
        stream_cons (xs, path_next (xs))
      end // end of [then]
      else path_next2 (xs, x0 + 1)
    // end of [if]
  end // end of [then]
  else (
    case+ xs of
    | cons0 (x, xs) => path_next2 (xs, x+1) | nil0 () => stream_nil(*void*)
  ) (* end of [else] *)
) (* end of [path_next2] *)
  
(* ****** ****** *)

val theSolutions =
  stream_filter_cloref (path_next (nil0(*void*)), lam (xs) => length (xs) >= N)
// end of [theSolutions]

(* ****** ****** *)

fun fprint_row
(
  out: FILEref, i: int
) : void = let
//
fun aux (i: int): void =
  if i > 0 then (fprint (out, ". "); aux (i-1)) else ()
//
val () = aux (i)
val () = fprint (out, "Q ")
val () = aux (N-1-i)
//
in
  // nothing
end // end of [fprint_row]  

(* ****** ****** *)

fun fprint_board
(
  out: FILEref, xs: list0(int)
) : void = let
//
implement
fprint_val<int> (out, x) = fprint_row (out, x)
//
val () =
fprint_list0_sep (out, xs, "\n")
val () = fprint_newline (out)
//
in
  // nothing
end // end of [fprint_board]

(* ****** ****** *)

val () = let
//
fun printall
(
  xss: stream(list0(int)), i: int
) : void =
(
case+ !xss of
| stream_cons
    (xs, xss) =>
  {
    val () =
      println! ("Solution #", i, ":")
    val () = fprint_board (stdout_ref, list0_reverse(xs))
    val () = print_newline ()
    val () = printall (xss, i+1)
  }
| stream_nil () => ()
)
//
in
  printall (theSolutions, 1)
end // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [queens_lazy.dats] *)
