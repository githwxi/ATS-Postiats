(*
//
// A program to solve the 8-queens problem
//
// This example is taken from Appel's book:
// Modern Compiler Design and Implementation in ML
//
*)

(* ****** ****** *)

#define N 8
#define N1 (N-1)

(* ****** ****** *)

local

var _NSOL: Nat = 0

in // in of [local]

val NSOL = ref_make_viewptr {Nat} (view@ (_NSOL) | addr@(_NSOL))

end // end of [local]

(* ****** ****** *)
//
val row = arrayref_make_elt<int> (g1int2uint(N), 0)
val col = arrayref_make_elt<int> (g1int2uint(N), 0)
//
val diag1 = arrayref_make_elt<int> (g1int2uint(N+N1), 0)
val diag2 = arrayref_make_elt<int> (g1int2uint(N+N1), 0)
//
(* ****** ****** *)

fun fprint_board
  (out: FILEref): void = let
  var i: int? and j: int?
  val () = for* (i: natLte N) =>
    (i := 0; i < N; i := i + 1) let
    val i = i
    val () = for* (j: natLte N) =>
      (j := 0; j < N; j := j + 1) let
      val j = j
    in
      fprint_string (out, if (col[i] = j) then " Q" else " .")
    end // end of [val]
  in
    fprint_string (out, "\n")
  end // end of [for]
  val () = fprint_string (out, "\n")
in
  // empty
end (* end of [fprint_board] *)

(* ****** ****** *)

fun _try (
  out: FILEref, c: natLte N
) : void =
  if (c = N) then let
    val () = !NSOL := !NSOL + 1
  in
    fprint_board (out)
  end else let
    var r: natLte(N)
    val () =
      for (
      r := 0; r < N; r := r+1
    ) let
      val r = r
    in
      if (row[r] = 0) then (
        if (diag1[r+c] = 0) then (
          if (diag2[r+N1-c] = 0) then (
            row[r] := 1; diag1[r+c] := 1; diag2[r+N1-c] := 1;
            col[c] := r; _try (out, c+1);
            row[r] := 0; diag1[r+c] := 0; diag2[r+N1-c] := 0;
          ) (* end of [if] *)
        ) (* end of [if] *)
      ) (* end of [if] *)
    end // end of [val]
  in
    // empty
  end // end of [if]
// end of [_try]

(* ****** ****** *)
	
implement
main () = let
  val out = stdout_ref
  val () = _try (out, 0)
  val () = 
    println! ("The total number of solutions is [", !NSOL, "]")
  // end of [val]
in
  0 (*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [queens_loop.dats] *)
