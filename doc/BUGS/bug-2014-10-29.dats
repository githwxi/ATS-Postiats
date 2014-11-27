(*
** Bug in embedded templates
*)

(*
** Source:
** reported by Hongwei Xi
*)

(* ****** ****** *)

(*
** Status: fixed by HX-2014-11-01
*)

(* ****** ****** *)
//
extern
fun{a:t0p}
foo (a): a = "mac#"
implement{a} foo (x) = x
//
(* ****** ****** *)
//
extern
fun{a:t0p}
foo2 (a): a = "mac#"
implement
{a}(*tmp*)
foo2 (x) =
let
//
fun{} bar2 (): a = x
//
in
  bar2 ()
end // end of [foo2]
//
(* ****** ****** *)
//
(*
//
// HX-2014-11-01:
// a reasonably simple way to avoid this issue
// is given as follows:
//
extern
fun{a:t0p}
foo2 (a): a = "mac#"
implement
{a}(*tmp*)
foo2 (x) =
let
//
extern
fun{}
bar2 (): a = "mac#"
implement bar2<> () = x
//
in
  bar2 ()
end // end of [foo2]
*)
//
(* ****** ****** *)
//
extern
fun
foo2_int
  (int): int = "mac#"
//
implement
foo2_int (x) = foo2<int> (x)
//
(* ****** ****** *)

(* end of [bug-2014-10-29.dats] *)
