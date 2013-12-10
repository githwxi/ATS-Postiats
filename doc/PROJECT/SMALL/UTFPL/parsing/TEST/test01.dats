(* ****** ****** *)
//
// Some simple tests for ATS -> JSON
//
(* ****** ****** *)

abstype OBJ

(* ****** ****** *)

fun fact (x) =
  if x > 0 then x * fact (x-1) else 1
(*
val
rec fact = lam x => if x > 0 then x * fact (x-1) else 1
*)

(* ****** ****** *)

val fact10 = fact (10)
and fact12 = fact (12)

(* ****** ****** *)

extern
fun acker (OBJ, OBJ): OBJ

implement
acker (m, n) =
(
if m > 0
  then
    if n > 0
      then acker (m-1, acker (m, n-1)) else acker (m-1, 1)
    // end of [if]
  else n+1
// end of [if]
)

(* ****** ****** *)

fun f91 (x) =
  if x > 100 then x-10 else f91 (f91 (x+11))

(* ****** ****** *)

fun isevn (n) = if n > 0 then isodd (n-1) else true
and isodd (n) = if n > 0 then isevn (n-1) else false

(* ****** ****** *)

fun pow (x, n) =
(
  if n >= 1 then let
    val n2 = n / 2
  in
    if n > 2*n2 then pow (x*x, n2) * x else pow (x*x, n2)
  end else 1 // end of [if]
)

(* ****** ****** *)

local

fun loop (n, res) = if n > 0 then loop (n-1, n * res) else res

in (* in of [local] *)

fun fact (n) = loop (n, 1)

end // end of [local]

(* ****** ****** *)

(* end of [test01.dats] *)
