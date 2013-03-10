//
// Selection sort
//

(* ****** ****** *)
//
// HX-2012-07-22:
// A glorious implementation of selection-sort in ATS :)
//
(* ****** ****** *)

fun{a:vt0p}
SelectionSort$cmp (x1: &a, x2: &a):<> int

fun{a:vt0p}
SelectionSort {n:int} (A: &array(INV(a), n), n: size_t n):<!wrt> void

(* ****** ****** *)

(* end of [program-1-2.sats] *)
