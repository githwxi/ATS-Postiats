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
fun
line_is_key
{n:int}(line: string(n)): intLt(n)
//
(* ****** ****** *)
//
fun
line_get_key
  (line: string): Option_vt(Strptr1)
//
(* ****** ****** *)
//
fun
line_is_comment
  (line: string, nsharp: intGte(1)): bool
//
(* ****** ****** *)

(* end of [libatsrec.sats] *)
