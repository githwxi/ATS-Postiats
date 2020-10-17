(* ****** ****** *)
//
// Reported by
// Dambaev-2020-10-14
//
(* ****** ****** *)
//
// HX-2020-10-17:
// The cause is due to
// labp2atcstlst_diff not being implemented
// It is now implemented.
//
(* ****** ****** *)
//
fun
foo(
x1:
Option(int)
,
x2:
Option(int)) : void =
(
case+ @(x1, x2) of
| @(None(), None()) => ()
| @(None(), Some _) => ()
| @(Some _, None()) => ()
| @(Some _, Some _) => ()
)
//
(* ****** ****** *)

(* end of [bug-2020-10-14.dats] *)
