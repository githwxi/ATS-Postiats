(* ****** ****** *)
(*
**
** Author: Hongwei Xi
** Start Time: May, 2017
** Authoremail: gmhwxiATgmailDOTcom
**
*)
(* ****** ****** *)
//
#staload
"libats/SATS/stringbuf.sats"
//
(* ****** ****** *)
//
fun
line_is_key
{n:int}(line: string(n)): intLt(n)
//
(* ****** ****** *)
//
fun
line_get_key
  {n:int}
(
  line: string(n), kend: intBtw(0, n)
) : Option_vt(Strptr1)
//
(* ****** ****** *)
//
fun
line_is_nsharp
  (line: string, nsharp: intGte(1)): bool
//
(* ****** ****** *)
//
fun
line_add_value
  {n:int}
(
  line: string(n)
, kend: intBtw(0, n), buf: !stringbuf
) : int // end of [line_add_value]
//
fun
line_add_value_cont
  (line: string, buf: !stringbuf): int
//
(* ****** ****** *)


(* ****** ****** *)

(* end of [libatsrec.sats] *)
