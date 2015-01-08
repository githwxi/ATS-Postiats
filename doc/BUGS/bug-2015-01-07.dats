(*
** Bug causing erroneous handling
** of mutually recursive templates
*)

(* ****** ****** *)

(*
** Source: Reported by WB-2015-01-07
*)

(* ****** ****** *)

(*
** Status: FIXME!
*)

(* ****** ****** *)

extern
fun add_int_int : (int, int) -> int
overload + with add_int_int of 1000000

(* ****** ****** *)

extern fun{} foo(): int
extern fun{} bar1(int): int
extern fun{} bar2(int): int
extern fun{} bar12(int): int

(* ****** ****** *)

implement{} bar1 (x) = bar2 (x)
implement{} bar2 (x) = foo() + bar1 (x)

(* ****** ****** *)

implement
main(argc, argv) = let
//
implement{} foo () = argc
//
in
  bar2 (1000000)
end // end of [main]

(* ****** ****** *)

(* end of [bug-2015-01-07.dats] *)
