(* ****** ****** *)
//
// Some simple tests for ATS -> JSON
//
(* ****** ****** *)

fun fact (x) =
  if x > 0 then x * fact (x - 1) else 1

(* ****** ****** *)

val fact10 = fact (10)
and fact12 = fact (12)

(* ****** ****** *)

fun
ack (m, n) =
(
if m > 0
  then
    if n > 0 then ack (m-1, ack (m, n-1)) else ack (m-1, 1)
  else n+1
// end of [if]
)

(* ****** ****** *)

fun isevn (n) = if n > 0 then isodd (n-1) else true
and isodd (n) = if n > 0 then isevn (n-1) else false

(* ****** ****** *)

(* end of [test01.dats] *)
