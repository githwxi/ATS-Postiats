(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)
//
staload
LBF = "./pats_lexbuf.sats"
//
vtypedef lexbuf = $LBF.lexbuf
//
(* ****** ****** *)
//
staload
DQ = "libats/ngc/SATS/deque_arr.sats"
staload
_(*DQ*) = "libats/ngc/DATS/deque_arr.dats"
//
stadef DEQUE = $DQ.DEQUE // double-ended queue
//
(* ****** ****** *)

staload "./pats_lexing.sats"

(* ****** ****** *)

staload "./pats_tokbuf.sats"

(* ****** ****** *)

extern castfn u2sz1 (x: uint):<> Size

(* ****** ****** *)

vtypedef
tokbuf_int_int
  (m: int, n:int) =
$extype_struct
"pats_tokbuf_struct" of
{
  tbuf= DEQUE (token, m, n)
, ntok= uint
, lexbuf= lexbuf
} // end of [tokbuf]
typedef tokbuf0 = tokbuf_int_int(0, 0)?

(* ****** ****** *)

assume
tokbuf_vt0ype =
  [m,n:int | m > 0] tokbuf_int_int (m, n)
// end of [tokbuf_vt0ype]

(* ****** ****** *)

#define QINISZ 1024 // initial size

(* ****** ****** *)
//
macdef
DQ_deque_initize = $DQ.deque_initialize<token>
macdef
DQ_deque_uninitize = $DQ.deque_uninitialize{token}
//
(* ****** ****** *)

implement
tokbuf_initize_filp
  (pfmod, pffil | buf, p) =
{
//
extern
prfun
tokbuf0_trans
  (buf: &tokbuf? >> tokbuf0): void
//
prval
() = tokbuf0_trans (buf)
val
(
  pfgc, pfarr | pa
) = array_ptr_alloc<token> (QINISZ)
//
val () =
DQ_deque_initize
  (pfgc, pfarr | buf.tbuf, QINISZ, pa)
//
val () = buf.ntok := 0u
val () = $LBF.lexbuf_initize_filp (pfmod, pffil | buf.lexbuf, p)
//
} // end of [tokbuf_initize_filp]

(* ****** ****** *)

implement
tokbuf_initize_getc
  (buf, getc) = () where {
//
extern
prfun
tokbuf0_trans
  (buf: &tokbuf? >> tokbuf0): void
//
prval
() = tokbuf0_trans (buf)
//
val
(
  pfgc, pfarr | pa
) = array_ptr_alloc<token> (QINISZ)
//
val () =
DQ_deque_initize
  (pfgc, pfarr | buf.tbuf, QINISZ, pa)
//
val () = buf.ntok := 0u
val () = $LBF.lexbuf_initize_getc (buf.lexbuf, getc)
//
} // end of [tokbuf_initize_getc]

(* ****** ****** *)

implement
tokbuf_initize_string
  (buf, inp) = () where {
//
extern
prfun
tokbuf0_trans
  (buf: &tokbuf? >> tokbuf0): void
//
prval
() = tokbuf0_trans (buf)
//
val
(
  pfgc, pfarr | pa
) = array_ptr_alloc<token> (QINISZ)
//
val () =
DQ_deque_initize
  (pfgc, pfarr | buf.tbuf, QINISZ, pa)
//
val () = buf.ntok := 0u
val () = $LBF.lexbuf_initize_string (buf.lexbuf, inp)
//
} // end of [tokbuf_initize_string]

(* ****** ****** *)

implement
tokbuf_initize_lexbuf
  (buf, lbf) = () where {
//
extern
prfun
tokbuf0_trans
  (buf: &tokbuf? >> tokbuf0): void
//
prval
() = tokbuf0_trans (buf)
val
(
  pfgc, pfarr | pa
) = array_ptr_alloc<token> (QINISZ)
//
val () =
DQ_deque_initize
  (pfgc, pfarr | buf.tbuf, QINISZ, pa)
//
val () = buf.ntok := 0u
val () = buf.lexbuf := lbf
//
} // end of [tokbuf_initize_lexbuf]

(* ****** ****** *)

implement
tokbuf_uninitize
  (buf) = () where {
//
val (
  pfgc, pfarr | pa
) = DQ_deque_uninitize (buf.tbuf)
//
val () = array_ptr_free (pfgc, pfarr | pa)
val () = $LBF.lexbuf_uninitize (buf.lexbuf)
//
extern
prfun tokbuf0_untrans (buf: &tokbuf0 >> tokbuf?): void
//
  prval () = tokbuf0_untrans (buf)
} // end of [tokbuf_uninitize]

(* ****** ****** *)

implement
tokbuf_get_ntok (buf) = buf.ntok
implement
tokbuf_set_ntok (buf, n) = buf.ntok := n

(* ****** ****** *)

implement
tokbuf_incby1 (buf) = buf.ntok := buf.ntok + 1u
implement
tokbuf_incby_count (buf, k) = buf.ntok := buf.ntok + k

(* ****** ****** *)

implement
tokbuf_reset (buf) = let
//
  prval () = $DQ.lemma_deque_param (buf.tbuf)
//
  val ntok = buf.ntok
  val () = buf.ntok := 0u
  val ntok = (u2sz1)ntok
  val nqsz = $DQ.deque_size (buf.tbuf)
in
  if ntok < nqsz then let
    val () =
      $DQ.deque_clear_beg<token> (buf.tbuf, ntok)
    // end of [val]
  in
    // nothing
  end else let
    val () = $DQ.deque_clear_all {token} (buf.tbuf)
  in
    // nothing
  end (* end of [if] *)
end // end of [tokbuf_reset]

(* ****** ****** *)

implement
tokbuf_get_token
  (buf) = let
//
prval () =
$DQ.lemma_deque_param (buf.tbuf)
//
val ntok = (u2sz1)buf.ntok
val nqsz = $DQ.deque_size (buf.tbuf)
//
in
//
if
ntok < nqsz
then
  $DQ.deque_get_elt_at<token> (buf.tbuf, ntok)
else let
  val tok =
    lexing_next_token_ncmnt (buf.lexbuf)
  val m = $DQ.deque_cap {token} (buf.tbuf)
  val () =
  if (
    m > nqsz
  ) then {
    val () = $DQ.deque_insert_end<token> (buf.tbuf, tok)
  } else {
    val m2 = m + m
(*
    val () = println! ("tokbuf_get_token: m2 = ", m2)
*)
    val (pfgc2, pfarr2 | p2) = array_ptr_alloc<token> (m2)
    val (pfgc1, pfarr1 | p1) =
      $DQ.deque_update_capacity<token> (pfgc2, pfarr2 | buf.tbuf, m2, p2)
    val () = array_ptr_free (pfgc1, pfarr1 | p1)
    val () = $DQ.deque_insert_end<token> (buf.tbuf, tok)
  } (* end of [if] *)
in
  tok
end // end of [else]
//
end // end of [tokbuf_get_token]

(* ****** ****** *)

implement
tokbuf_getinc_token
  (buf) = tok where
{
  val tok = tokbuf_get_token (buf)
  val ((*void*)) = buf.ntok := buf.ntok + 1u
} (* end of [tokbuf_getinc_token] *)

(* ****** ****** *)

implement
tokbuf_discard_all
  (buf) = while (true) let
  val tok = tokbuf_getinc_token (buf)
(*
  val () = println! ("tokbuf_discard_all: tok = ", tok)
*)
in
  case+ tok.token_node of T_EOF () => break | _ => continue
end // end of [tokbuf_discard_all]

(* ****** ****** *)

implement
tokbuf_unget_token
  (buf, tok) = let
//
prval () =
  $DQ.lemma_deque_param (buf.tbuf)
//
val n = $DQ.deque_size (buf.tbuf)
val m = $DQ.deque_cap {token} (buf.tbuf)
//
in
//
if(
m > n
) then (
  $DQ.deque_insert_beg<token> (buf.tbuf, tok)
) else let
  val m2 = m + m
(*
  val () = println! ("tokbuf_get_token: m2 = ", m2)
*)
  val (pfgc2, pfarr2 | p2) = array_ptr_alloc<token> (m2)
  val (pfgc1, pfarr1 | p1) =
    $DQ.deque_update_capacity<token> (pfgc2, pfarr2 | buf.tbuf, m2, p2)
  val () = array_ptr_free (pfgc1, pfarr1 | p1)
in
  $DQ.deque_insert_beg<token> (buf.tbuf, tok)
end (* end of [if] *)
//
end // end of [tokbuf_unget_token]

(* ****** ****** *)

(* end of [pats_tokbuf.dats] *)
