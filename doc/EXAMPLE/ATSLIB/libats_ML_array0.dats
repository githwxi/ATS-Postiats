(*
** for testing [libats/ML/array0]
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

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/array0.dats"
//
(* ****** ****** *)

val () =
{
//
val asz = i2sz(3)
val A_elt = array0_make_elt<int> (asz, 0)
val ((*void*)) = println! ("A_elt = ", A_elt)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val asz = (i2sz)10
//
val A = array0_tabulate<int> (asz, lam i => $UN.cast{int}(i))
//
val out = stdout_ref
//
val () = fprintln! (out, "A = ", A)
//
val A2 = array0_map<int><int> (A, lam (x) => 2 * x)
//
local
implement
fprint_array$sep<> (out) = fprint (out, "| ")
in
val () = fprintln! (out, "A2 = ", A2)
end // end of [local]
//
val sum = array0_foldleft<int><int> (A, 0, lam (res, x) => res + x)
val () = fprintln! (out, "sum(45) = ", sum)
//
val isum = array0_ifoldleft<int><int> (A, 0, lam (res, i, x) => res + $UN.cast2int(i) * x)
val () = fprintln! (out, "isum(285) = ", isum)
//
val rsum = array0_foldright<int><int> (A, lam (x, res) => x + res, 0)
val () = fprintln! (out, "rsum(45) = ", rsum)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val xs =
  $list{int}(3, 9, 7, 8, 6, 0, 4, 2, 1, 5)
//
val A0 = array0_make_list(g0ofg1_list(xs))
//
val () = println! ("A0(bef) = ", A0)
//
val () = array0_quicksort<int> (A0, lam(x, y) => compare(x, y))
//
val () = println! ("A0(aft) = ", A0)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val asz = (i2sz)10
//
val A0 =
  array0_tabulate<int>
    (asz, lam(i) => $UN.cast{int}(i))
  // array0_tabulate
//
val A2 = array0_make_subarray (A0, i2sz(3), i2sz(5))
val ((*void*)) = fprintln!(out, "A2(A[3,5]) = ", A2)
//
val () =
assertloc
( 0+1+2+3+4+5+6+7+8+9
= A0.foldleft(TYPE{int})(0, lam(res, x) => res + x))
//
val () =
assertloc
( 0+1+2+3+4+5+6+7+8+9
= A0.foldright(TYPE{int})(lam(x, res) => x + res, 0))
//
} (* end of [val] *)

(* ****** ****** *)

fun
array0_make_fileref
(
  inp: FILEref
) : array0 (char) = A0 where
{
  val cs =
    fileref_get_file_charlst(inp)
  val A0 =
    array0_make_list($UN.castvwtp1{list0(char)}(cs))
  val ((*freed*)) = list_vt_free(cs)
} (* end of [array0_make_fileref] *)

(* ****** ****** *)

val () =
{
val opt =
fileref_open_opt
(
"./libats_ML_array0.dats", file_mode_r
)
val-~Some_vt(inp) = opt
val A0 = array0_make_fileref(inp)
val ((*closed*)) = fileref_close(inp)
implement
fprint_array$sep<> (out) = ()
val () = fprintln! (stdout_ref, "A0 =\n", A0)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_array0.dats] *)
