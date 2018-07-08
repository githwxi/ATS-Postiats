(*
** Bug causing erroneous
** compilation of sequential pattern matching
*)

(* ****** ****** *)

(*
** Status: It is fixed by HX-2015-04-25
*)

(* ****** ****** *)

(*
fun
foo
(
  xs: List0(int)
) : int(1) =
(
case xs of
| list_nil () =>> 0 // type-checking passed but should haved failed!!!
| list_cons _ =>> 1 // type-checking passed but should haved failed!!!
)
*)

(* ****** ****** *)

(* end of [bug-2015-04-25.dats] *)
