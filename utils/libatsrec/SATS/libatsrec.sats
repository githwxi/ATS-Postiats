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
) : Strptr1
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
//
fun
line_lines_get_key_value
(
  line: string, lines: List(string)
) : (Strptr1(*key*), Strptr1(*value*))
//
(* ****** ****** *)
//
datavtype
linenum_vt =
| LINENUM of (int, Strptr1)
//
where
linenumlst_vt = List0_vt(linenum_vt)
//
(* ****** ****** *)
//
fun
lines_grouping
(stream_vt(linenum_vt)): stream_vt(linenumlst_vt)
//
(* ****** ****** *)

(* end of [libatsrec.sats] *)
