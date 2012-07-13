(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: May, 2012
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
IT = "prelude/SATS/iterator.sats"
stadef iterator = $IT.iterator_5
stadef iterator = $IT.iterator_3

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

stadef fmr() = file_mode_r()

(* ****** ****** *)

stadef itrknd = iter_fileptr_charlst_kind
stadef itrkpm = iter_fileptr_charlst_param

(* ****** ****** *)

extern
castfn iterk2iter
  {l:addr}
  {m:fm}
  {f,r:int} (
  fp: FILEptr (l, m)
) :<> iterator (itrknd, itrkpm(l, m), char, f, r)
// end of [iter2iterk]
extern
castfn iter2iterk
  {l:addr}{m:fm}
  (itr: iterator (itrknd, itrkpm(l, m), char)):<> FILEptr (l, m)
// end of [iter2iterk]

(* ****** ****** *)

extern
praxi encode
  {kpm:tk}
  {x:vt0p}
  {f,r:int}
  {l:agz}
  {m:fm} (
  pf: fmlte (m, fmr())
| filp: !FILEptr (l, m)
    >> iterator (itrknd, kpm, char, f, r)
) : void // end of [encode]
extern
praxi decode
  {kpm:tk}
  {x:vt0p} (
  itr: !iterator (itrknd, kpm, char) >> FILEptr (l, m)
) : #[l:agz;m:fm] fmlte (m, fmr()) // end of [decode]

(* ****** ****** *)

implement
$IT.iter_is_atend<itrknd><char>
  {kpm}{f,r} (itr) = let
  prval pf = decode (itr)
  val atend = feof (itr)
  prval () = encode (pf | itr)
  extern castfn
    __cast {b:bool} (x: bool b):<> [b==(r==0)] bool (b)
  // end of [extern]
in
  if (atend != 0) then __cast(true) else __cast(false)
end // end of [iter_isnot_atend]

(* ****** ****** *)

implement
$IT.iter_vttake_inc<itrknd><char>
//
  {kpm}{f,r} (itr) = let
  prval pf = decode (itr)
  val c = fgetc1_err (pf | itr)
  prval () = encode (pf | itr)
  prval () = __assert () where {
    extern praxi __assert (): [false] void // HX: skip constraint-solving
  } // end of [where] // end of [prval]
//
  var c = $UN.cast {char} (c)
//
in
  $UN.vttakeout_void (c)
end // end of [iter_vttake_inc]

(* ****** ****** *)

(* end of [stdio_iterator.dats] *)
