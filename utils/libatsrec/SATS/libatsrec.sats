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
"libats/ML/SATS/basis.sats"
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
(
xs: stream_vt(linenum_vt)
) : stream_vt(linenumlst_vt)
//
(* ****** ****** *)
//
fun{}
process_key_value
  (key: Strptr1, value: Strptr1): void
//
(* ****** ****** *)
//
fun{}
process_linenumlst(linenumlst_vt): void
//
(* ****** ****** *)
//
fun
streamize_fileref_gvhashtbl_0
  (inp: FILEref): stream_vt(gvhashtbl)
fun
streamize_fileref_gvhashtbl_cap
  (inp: FILEref, cap: intGte(1)): stream_vt(gvhashtbl)
//
symintr
streamize_fileref_gvhashtbl
overload
streamize_fileref_gvhashtbl with streamize_fileref_gvhashtbl_0
overload
streamize_fileref_gvhashtbl with streamize_fileref_gvhashtbl_cap
//
(* ****** ****** *)

(* end of [libatsrec.sats] *)
