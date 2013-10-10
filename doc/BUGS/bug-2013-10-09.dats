(*
//
// The 5th assignment
// BU CAS CS520, Fall, 2013
//
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

#define :: stream_cons
#define cons stream_cons
#define nil stream_nil

(* ****** ****** *)

typedef int2 = (int, int)

(* ****** ****** *)

(*
extern
fun foo
  (f: (int) -<fun> int): stream (int)
implement
foo (f) = let
//
fun fapp (): int = f (0)
fun fapp2 (): int = fapp ()
//
fun aux (): stream(int) = $delay (cons{int}(fapp2(), aux()))
//
in
  aux()
end // end of [foo]
*)

(* ****** ****** *)

extern
fun foo
  (x: int): int
implement
foo (x) = let
//
fun fapp (): int = x
fun fapp2 (): int = fapp ()
fun aux (): int = let
  fun bar (): int = fapp2 () in bar ()
end (* end of [aux] *)
//
in
  aux ()
end // end of [foo]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2013-10-09.dats] *)
