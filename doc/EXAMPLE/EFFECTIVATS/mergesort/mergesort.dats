(*
** A refinement-based
** implementation of mergesort
*)

(* ****** ****** *)

abstype myseq

(* ****** ****** *)

extern
fun mergesort (xs: myseq): myseq

(* ****** ****** *)

extern
fun myseq_length (xs: myseq): int
extern
fun myseq_split (xs: myseq): (myseq, myseq)
extern
fun myseq_merge (xs1: myseq, xs2: myseq): myseq

(* ****** ****** *)

implement
mergesort (xs) = let
  val n = myseq_length (xs)
in
//
  if n >= 2 then let
    val (xs1, xs2) = myseq_split (xs)
  in
    myseq_merge (mergesort (xs1), mergesort (xs2))
  end else (xs) // end of [if]
//
end // end of [mergesort]

(* ****** ****** *)
//
// specifying more accurately with dependent types
//
(* ****** ****** *)

abstype myseq(n:int)

(* ****** ****** *)

extern
fun mergesort{n:nat} (xs: myseq(n)): myseq(n)

(* ****** ****** *)

extern
fun myseq_length{n:int} (xs: myseq(n)): int(n)
extern
fun myseq_split{n:int | n >= 2}
  (xs: myseq(n)): [n1,n2:pos | n1+n2==n] (myseq(n1), myseq(n2))
extern
fun myseq_merge{n1,n2:nat} (xs1: myseq(n1), xs2: myseq(n2)): myseq(n1+n2)

(* ****** ****** *)

implement
mergesort (xs) = let
//
fun sort
  {n:nat} .<n>.
(
  xs: myseq(n)
) : myseq(n) = let
  val n = myseq_length (xs)
in
  if n >= 2 then let
    val (xs1, xs2) = myseq_split (xs)
  in
    myseq_merge (sort (xs1), sort (xs2))
  end else (xs) // end of [if]
end // end of [sort]
//
in
  sort (xs)
end // end of [mergesort]

(* ****** ****** *)

extern
fun myseq_split{n:int | n >= 2}
  (xs: myseq(n), n: int n): (myseq(n/2), myseq(n-n/2))

(* ****** ****** *)

implement
mergesort (xs) = let
//
fun sort
  {n:nat} .<n>.
(
  xs: myseq(n), n: int n
) : myseq(n) = let
in
  if n >= 2 then let
    val n2 = half (n)
    val (xs1, xs2) = myseq_split (xs, n)
  in
    myseq_merge (sort (xs1, n2), sort (xs2, n-n2))
  end else (xs) // end of [if]
end // end of [sort]
//
in
  sort (xs, myseq_length(xs))
end // end of [mergesort]

(* ****** ****** *)

(* end of [mergesort.dats] *)
