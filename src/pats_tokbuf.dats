(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload LBF = "pats_lexbuf.sats"
viewtypedef lexbuf = $LBF.lexbuf

(* ****** ****** *)

staload LEX = "pats_lexing.sats"
typedef token = $LEX.token

(* ****** ****** *)

staload Q = "libats/SATS/linqueue_arr.sats"
stadef QUEUE = $Q.QUEUE
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"

(* ****** ****** *)

staload "pats_tokbuf.sats"

(* ****** ****** *)

#define u2sz size_of_uint
#define size1 size1_of_size

(* ****** ****** *)

viewtypedef
tokbuf_int_int
  (m: int, n:int) =
$extype_struct
"pats_tokbuf_struct" of {
  tbuf= QUEUE (token, m, n)
, ntok= uint
, lexbuf= lexbuf
} // end of [tokbuf]
typedef tokbuf0 = tokbuf_int_int(0, 0)?

(* ****** ****** *)

assume
tokbuf_vt0ype =
  [m,n:int] tokbuf_int_int (m, n)
// end of [tokbuf_vt0ype]

(* ****** ****** *)

#define QINISZ 1024 // initial size
#define QDELTA 1024 // subsequent increment

(* ****** ****** *)

implement
tokbuf_initialize_filp
  (pfmod, pffil | buf, p) = () where {
//
extern
prfun tokbuf0_trans (buf: &tokbuf? >> tokbuf0): void
//
  prval () = tokbuf0_trans (buf)
  val () = $Q.queue_initialize (buf.tbuf, QINISZ)
  val () = buf.ntok := 0u
  val () = $LBF.lexbuf_initialize_filp (pfmod, pffil | buf.lexbuf, p)
} // end of [tokbuf_initialize_filp]

implement
tokbuf_initialize_getc
  (buf, getc) = () where {
//
extern
prfun tokbuf0_trans (buf: &tokbuf? >> tokbuf0): void
//
  prval () = tokbuf0_trans (buf)
  val () = $Q.queue_initialize (buf.tbuf, QINISZ)
  val () = buf.ntok := 0u
  val () = $LBF.lexbuf_initialize_getc (buf.lexbuf, getc)
} // end of [tokbuf_initialize_getc]

(* ****** ****** *)

implement
tokbuf_uninitialize
  (buf) = () where {
  val () = $Q.queue_uninitialize (buf.tbuf)
  val () = $LBF.lexbuf_uninitialize (buf.lexbuf)
//
extern
prfun tokbuf0_untrans (buf: &tokbuf0 >> tokbuf?): void
//
  prval () = tokbuf0_untrans (buf)
} // end of [tokbuf_uninitialize]

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
  prval () = $Q.queue_param_lemma (buf.tbuf)
//
  val ntok = buf.ntok
  val () = buf.ntok := 0u
  val ntok = (u2sz)ntok
  val ntok = (size1)ntok
  val n = $Q.queue_size (buf.tbuf)
in
  if ntok < n then let
    val () = $Q.queue_clear<token> (buf.tbuf, ntok)
  in
    // nothing
  end else let
    val () = $Q.queue_clear_all {token} (buf.tbuf)
  in
    // nothing
  end (* end of [if] *)
end // end of [tokbuf_reset]

(* ****** ****** *)

implement
tokbuf_get_token
  (buf) = let
//
  prval () = $Q.queue_param_lemma (buf.tbuf)
//
  val ntok = buf.ntok
  val ntok = (u2sz)ntok
  val ntok = (size1)ntok
  val n = $Q.queue_size (buf.tbuf)
in
  if ntok < n then
    $Q.queue_get_elt_at<token> (buf.tbuf, ntok)
  else let
    val tok = $LEX.lexing_next_token (buf.lexbuf)
  in
    case+ tok.token_node of
    | $LEX.T_EOF () => tok // HX: tokens are all generated
    | _ => let
        val m = $Q.queue_cap {token} (buf.tbuf)
      in
        if m > n then let
          val () = $Q.queue_insert<token> (buf.tbuf, tok)
        in
          tok
        end else let
          val () = $Q.queue_update_capacity<token> (buf.tbuf, m+QDELTA)
          val () = $Q.queue_insert<token> (buf.tbuf, tok)
        in
          tok
        end // end of [if]
      end (* end of [_] *)
    // end of [case]
  end (* end of [if] *)
end // end of [tokbuf_get_token]

(* ****** ****** *)

implement
tokbuf_getinc_token
  (buf) = tok where {
  val tok = tokbuf_get_token (buf)
  val () = buf.ntok := buf.ntok + 1u
} // end of [tokbuf_getinc_token]

(* ****** ****** *)

(* end of [pats_tokbuf.dats] *)
