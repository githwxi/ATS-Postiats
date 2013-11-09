(* ****** ****** *)
//
// HX-2013-11-08:
// while this one may look like a bug, it is
// actually not; it is just a bizzare behavior!
//
(* ****** ****** *)

extern
prfun mul_istot{i,j:int} (): [ij:int] MUL (i, j, ij)

extern
prfun mul_elim
  {i,j:int}{ij:int} (pf: MUL (i, j, ij)): [i*j==ij] void

(* ****** ****** *)

fun
foo{m:pos}{n:int} (): void = let
//
  prval [mn:int]
    pf_mn = mul_istot{m,n} ()
  prval () = mul_elim (pf_mn)
  prval () = prop_verify{mn==m*n} ()
//
  prval MULind (pf_m1n) = pf_mn
//
  prval () = prop_verify{mn==m*n} ()
//
in
  // nothing
end // end of [foo]

(* ****** ****** *)

(* end of [bug-2013-11-08.dats] *)
