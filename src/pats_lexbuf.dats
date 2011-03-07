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

staload "pats_lexbuf.sats"

(* ****** ****** *)

staload Q = "libats/SATS/linqueue_arr.sats"
stadef QUEUE = $Q.QUEUE

(* ****** ****** *)

(*
staload _(*anon*) = "prelude/DATS/pointer.dats"
*)
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"

(* ****** ****** *)

#define c2i int_of_char
#define i2c char_of_int
#define u2sz size_of_uint
#define size1 size1_of_size

(* ****** ****** *)

viewtypedef
lexbuf_int_int (m: int, n:int) =
$extype_struct
"pats_lexbuf_struct" of {
  buf=QUEUE (char, m, n)
, base= lint
, nchr= size_t
, getchar= () -<cloref1> int(*char*)
} // end of [lexbuf]
typedef lexbuf0 = lexbuf_int_int(0, 0)?

(* ****** ****** *)

assume lexbuf = [m,n:int] lexbuf_int_int (m, n)

(* ****** ****** *)

#define QINISZ 1024 // initial size
#define QDELTA 1024 // subsequent increment

(* ****** ****** *)

implement
lexbuf_initialize_getchar
  (buf, getchar) = () where {
//
extern
prfun lexbuf0_trans (buf: &lexbuf? >> lexbuf0): void
//
  prval () = lexbuf0_trans (buf)
  val () = $Q.queue_initialize (buf.buf, QINISZ)
  val () = buf.base := 0L
  val () = buf.nchr := (size1)0
  val () = buf.getchar := getchar
} // end of [lexbuf_initialize_getchar]

(* ****** ****** *)

implement
lexbuf_uninitialize
  (buf) = () where {
  val () = $Q.queue_uninitialize (buf.buf)
//
extern
prfun lexbuf0_untrans (buf: &lexbuf0 >> lexbuf?): void
//
  prval () = lexbuf0_untrans (buf)
} // end of [lexbuf_uninitialize]

(* ****** ****** *)

implement
lexbuf_get_next_char
  (buf) = let
//
  prval () = $Q.queue_param_lemma (buf.buf)
//
  val nchr = buf.nchr
  val nchr = (size1)nchr
  val n = $Q.queue_size (buf.buf)
in
  if nchr < n then let
    val c = $Q.queue_get_elt_at<char> (buf.buf, nchr)
    val () = buf.nchr := nchr + 1
  in
    (c2i)c
  end else let
    val i = buf.getchar ()
  in
    if i >= 0 then let
      val c = (i2c)i
      val m = $Q.queue_cap {char} (buf.buf)
    in
      if m > n then let
        val () = $Q.queue_insert<char> (buf.buf, c)
      in
        i
      end else let
        val () = $Q.queue_update_capacity<char> (buf.buf, m+QDELTA)
        val () = $Q.queue_insert<char> (buf.buf, c)
      in
        i
      end // end of [if]
    end else
      i (* EOF *)
    // end of [if]
  end (* end of [if] *)
end // end of [lexbuf_get_next_char]

(* ****** ****** *)

implement
lexbuf_advance_reset
  (buf, k) = let
//
  prval () = $Q.queue_param_lemma (buf.buf)
//
  val k = u2sz(k)
  val k = (size1)k
  val () = buf.nchr := (size1)0
  val n = $Q.queue_size (buf.buf)
in
  if k < n then let
    val () = $Q.queue_clear<char> (buf.buf, k)
  in
    // nothing
  end else let
    val () = $Q.queue_clear_all {char} (buf.buf)
  in
    // nothing
  end (* end of [if] *)
end // end of [lexbuf_advance_reset]

(* ****** ****** *)

implement
lexbuf_strptrout_reset
  (buf, k) = let
//
  prval () = $Q.queue_param_lemma (buf.buf)
//
  val k = u2sz(k)
  val k = (size1)k
  val () = buf.nchr := (size1)0
  val n = $Q.queue_size (buf.buf)
//
  stavar k: int
  val k = min (k, n): size_t (k)
//
  val [l:addr] (
    pfgc, pfarr | p
  ) = array_ptr_alloc<byte> (k+1)
  prval (pf1, fpf2) =
   __assert (pfarr) where {
   extern prfun __assert (
     pfarr: b0ytes(k+1) @ l
   ) : (
     @[char?][k] @ l, @[char][k] @ l -<lin,prf> bytes(k+1) @ l
   ) (* end of [_assert] *)
  } // end of [prval]
  val () = $Q.queue_remove_many<char> (buf.buf, k, !p)
  prval () = pfarr := fpf2 (pf1)
  val () = bytes_strbuf_trans (pfarr | p, k)
//
in
  strptr_of_strbuf @(pfgc, pfarr | p)    
end // end of [lexbuf_advance_reset]

(* ****** ****** *)

(* end of [pats_lexbuf.dats] *)
