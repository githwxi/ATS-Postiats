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

staload UT = "./pats_utils.sats"
staload LOC = "./pats_location.sats"

(* ****** ****** *)
//
staload
Q = "libats/SATS/linqueue_arr.sats"
//
stadef QUEUE = $Q.QUEUE
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"
//
(* ****** ****** *)

staload
R = "./pats_reader.sats"
stadef reader = $R.reader

(* ****** ****** *)

staload "./pats_lexbuf.sats"

(* ****** ****** *)
//
#define uc2i int_of_uchar
#define i2uc uchar_of_int
//
#define u2i int_of_uint
#define u2l lint_of_uint
#define u2sz size_of_uint
//
#define l2u uint_of_lint
#define l2sz size_of_lint
//
#define sz2i int_of_size
#define sz2l lint_of_size
//
#define size1 size1_of_size
//
(* ****** ****** *)
//
vtypedef
lexbuf_int_int
  (m: int, n:int) =
$extype_struct
"pats_lexbuf_struct" of {
  cbuf= QUEUE (uchar, m, n) // character buffer
, base= lint
, base_nrow=int, base_ncol= int
, nspace= int
, reader= reader
} (* end of [lexbuf] *)
//
typedef lexbuf0 = lexbuf_int_int(0, 0)?
//
(* ****** ****** *)

assume
lexbuf_vt0ype =
  [m,n:int] lexbuf_int_int (m, n)
// end of [lexbuf_vt0ype]

(* ****** ****** *)

#define QINISZ 1024 // initial size
#define QDELTA 1024 // subsequent increment

(* ****** ****** *)
//
macdef
Q_queue_initize = $Q.queue_initialize<uchar>
macdef
Q_queue_uninitize = $Q.queue_uninitialize{uchar}
//
(* ****** ****** *)

implement
lexbuf_initize_filp
  (pfmod, pffil | buf, p0) =
{
//
extern
prfun
lexbuf0_trans
  (buf: &lexbuf? >> lexbuf0): void
//
prval
() = lexbuf0_trans (buf)
//
val () = buf.base := 0L
val () = buf.base_nrow := 0
val () = buf.base_ncol := 0
val () = buf.nspace := 0
//
val () = Q_queue_initize (buf.cbuf, QINISZ)
val () = $R.reader_initize_filp (pfmod, pffil | buf.reader, p0)
//
} (* end of [lexbuf_initize_filp] *)

(* ****** ****** *)

implement
lexbuf_initize_getc
  (buf, getc) =
{
//
extern
prfun
lexbuf0_trans
  (buf: &lexbuf? >> lexbuf0): void
//
prval
() = lexbuf0_trans (buf)
//
val () = buf.base := 0L
val () = buf.base_nrow := 0
val () = buf.base_ncol := 0
val () = buf.nspace := 0
//
val () = Q_queue_initize (buf.cbuf, QINISZ)
val () = $R.reader_initize_getc (buf.reader, getc)
//
} (* end of [lexbuf_initize_getc] *)

(* ****** ****** *)

implement
lexbuf_initize_string
  (buf, inp) =
{
//
extern
prfun
lexbuf0_trans
  (buf: &lexbuf? >> lexbuf0): void
//
prval
() = lexbuf0_trans (buf)
//
val () = buf.base := 0L
val () = buf.base_nrow := 0
val () = buf.base_ncol := 0
val () = buf.nspace := 0
val () = Q_queue_initize (buf.cbuf, QINISZ)
val () = $R.reader_initize_string (buf.reader, inp)
//
} (* end of [lexbuf_initize_string] *)

(* ****** ****** *)

implement
lexbuf_initize_charlst_vt
  (buf, inp) = () where {
//
extern
prfun
lexbuf0_trans
  (buf: &lexbuf? >> lexbuf0): void
//
prval
() = lexbuf0_trans(buf)
//
val () = buf.base := 0L
val () = buf.base_nrow := 0
val () = buf.base_ncol := 0
val () = buf.nspace := 0
//
val () = Q_queue_initize (buf.cbuf, QINISZ)
val () = $R.reader_initize_charlst_vt (buf.reader, inp)
//
} (* end of [lexbuf_initize_charlst_vt] *)

(* ****** ****** *)

implement
lexbuf_uninitize
  (buf) = () where {
//
val () = Q_queue_uninitize (buf.cbuf)
val () = $R.reader_uninitize (buf.reader)
//
extern
prfun
lexbuf0_untrans (buf: &lexbuf0 >> lexbuf?): void
//
prval ((*void*)) = lexbuf0_untrans (buf)
} // end of [lexbuf_uninitize]

(* ****** ****** *)

implement
lexbufpos_diff
  (buf, pos) = let
  val nchr = $LOC.position_get_ntot (pos) - buf.base
in
  (l2u)nchr
end // end of [lexbufpos_diff]

(* ****** ****** *)

implement
lexbuf_get_base (buf) = buf.base

(* ****** ****** *)

implement
lexbuf_get_position
  (buf, pos) = let
  val ntot = buf.base
  val nrow = buf.base_nrow
  val ncol = buf.base_ncol
in
  $LOC.position_init (pos, ntot, nrow, ncol)
end // end of [lexbuf_get_position]

(* ****** ****** *)

implement
lexbuf_set_position
  (buf, pos) = let
//
prval () =
  $Q.lemma_queue_param (buf.cbuf)
//
val base = buf.base
val ntot = $LOC.position_get_ntot (pos)
//
val () = buf.base := ntot
val () = buf.base_nrow := $LOC.position_get_nrow (pos)  
val () = buf.base_ncol := $LOC.position_get_ncol (pos)  
//
val nchr = ntot - base
val nchr = size1(l2sz(nchr))
val nbuf = $Q.queue_size (buf.cbuf)
//
in
//
if
nchr < nbuf
then let
  val () =
    $Q.queue_clear<uchar> (buf.cbuf, nchr)
  // end of [val]
in
  // nothing
end // end of [then]
else let
  val () = $Q.queue_clear_all{uchar}(buf.cbuf)
in
  // nothing
end // end of [else]
//
end // end of [lexbuf_set_position]

(* ****** ****** *)

implement
lexbuf_get_nspace (buf) = buf.nspace
implement
lexbuf_set_nspace (buf, n) = buf.nspace := n

(* ****** ****** *)

implement
lexbufpos_get_location
  (buf, pos) = let
  var bpos: position
  val ((*void*)) =
    lexbuf_get_position (buf, bpos)
  // end of [val]
in
  $LOC.location_make_pos_pos (bpos, pos)
end // end of [lexbufpos_get_location]

(* ****** ****** *)

implement
lexbuf_get_char
  (buf, nchr) = let
//
prval
() = $Q.lemma_queue_param (buf.cbuf)
//
val nchr = (u2sz)nchr
val nchr = (size1)nchr
val n = $Q.queue_size (buf.cbuf)
//
in
//
if
nchr < n
then let
//
  val c =
  $Q.queue_get_elt_at<uchar> (buf.cbuf, nchr)
//
in
  (uc2i)c
end // end of [then]
else let
  val i = $R.reader_get_char (buf.reader)
in
  if i >= 0 then let
    val c = (i2uc)i
    val m = $Q.queue_cap {uchar} (buf.cbuf)
  in
    if m > n then let
      val () = $Q.queue_insert<uchar> (buf.cbuf, c)
    in
      i
    end else let
      val () = $Q.queue_update_capacity<uchar> (buf.cbuf, m+QDELTA)
      val () = $Q.queue_insert<uchar> (buf.cbuf, c)
    in
      i
    end // end of [if]
  end else
    i (* EOF *)
  // end of [if]
end // end of [else]
//
end // end of [lexbuf_get_char]

(* ****** ****** *)

implement
lexbufpos_get_char
  (buf, pos) = let
  val nchr = $LOC.position_get_ntot (pos) - buf.base
  val nchr = (l2u)nchr
in
  lexbuf_get_char (buf, nchr)
end // end of [lexbufpos_get_char]

(* ****** ****** *)

implement
lexbuf_incby_count
  (buf, cnt) = let
//
  prval () = $Q.lemma_queue_param (buf.cbuf)
//
  val nchr = u2sz(cnt)
  val nchr = (size1)nchr
  val n = $Q.queue_size (buf.cbuf)
in
  if nchr < n then let
    val () = buf.base := buf.base + (u2l)cnt
    val () = buf.base_ncol := buf.base_ncol + (u2i)cnt
    val () = $Q.queue_clear<uchar> (buf.cbuf, nchr)
  in
    // nothing
  end else let
    val () = buf.base := buf.base + (sz2l)n
    val () = buf.base_ncol := buf.base_ncol + (sz2i)n
    val () = $Q.queue_clear_all {uchar} (buf.cbuf)
  in
    // nothing
  end (* end of [if] *)
end // end of [lexbuf_incby_count]

(* ****** ****** *)

implement
lexbuf_get_strptr0
  (buf, ln) =
  lexbuf_get_substrptr0(buf, 0u, ln)
// end of [lexbuf_get_strptr0]

implement
lexbuf_get_strptr1
  (buf, ln) =
  lexbuf_get_substrptr1(buf, 0u, ln)
// end of [lexbuf_get_strptr]

(* ****** ****** *)

implement
lexbuf_get_substrptr0
  (buf, st, ln) = let
//
  prval () = $Q.lemma_queue_param (buf.cbuf)
//
  val i = u2sz(st)
  val i = (size1)i
  val k = u2sz(ln)
  val [k:int] k = (size1)k
  val n = $Q.queue_size (buf.cbuf)
//
(*
  val () = println! ("lexbuf_get_strptr: i = ", i)
  val () = println! ("lexbuf_get_strptr: k = ", k)
  val () = println! ("lexbuf_get_strptr: n = ", n)
*)
//
in
//
if i + k <= n then
  $UT.queue_get_strptr1 (buf.cbuf, i, k)
else
  strptr_null ()
// end of [if]
//
end // end of [lexbuf_get_substrptr0]

implement
lexbuf_get_substrptr1
  (buf, st, ln) = str where {
  val str = lexbuf_get_substrptr0 (buf, st, ln)
  val ((*void*)) = assertloc (strptr_isnot_null (str))
} // end of [lexbuf_get_substrptr1]

(* ****** ****** *)

implement
lexbufpos_get_strptr0
  (buf, pos) =
  lexbuf_get_strptr0(buf, lexbufpos_diff(buf, pos))
// end of [lexbufpos_get_strptr0]

implement
lexbufpos_get_strptr1
  (buf, pos) = 
  lexbuf_get_strptr1(buf, lexbufpos_diff(buf, pos))
// end of [lexbufpos_get_strptr1]

(* ****** ****** *)

(* end of [pats_lexbuf.dats] *)
