(* ****** ****** *)
(*
** Sample code for
** Effectivats-StreamPar
*)
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)
//
fun
intrange_stream
  (m: int, n: int): stream(int) =
  $delay
  (
  if
  (m >= n)
  then stream_nil()
  else stream_cons(m, intrange_stream(m+1, n))
  )
//
fun
intrange_stream_vt
  (m: int, n: int): stream_vt(int) =
  $ldelay
  (
  if
  (m >= n)
  then stream_vt_nil()
  else stream_vt_cons(m, intrange_stream_vt(m+1, n)) 
  )
//
(* ****** ****** *)
//
val xs =
intrange_stream(0, 1000)
//
val ys =
intrange_stream_vt(0, 1000)
//
(* ****** ****** *)

val nxs = stream_length(xs) // nxs = 1000
val nys = stream_vt_length(ys) // nys = 1000

(* ****** ****** *)

(* end of [sample.dats] *)
