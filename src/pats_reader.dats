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

staload "./pats_reader.sats"

(* ****** ****** *)

viewtypedef
freader (v:view) =
$extype_struct
"pats_reader_struct" of {
  pfres= v
, getchar= (!v | (*none*)) -<cloptr1> int
, freeres= ( v | (*none*)) -<cloptr1> void  
} // end of [freader]

(* ****** ****** *)

absviewt@ype reader0 = reader? // for initialization

(* ****** ****** *)

local
//
staload
"libc/SATS/stdio.sats"
//
assume reader0 = freader (unit_v)?
assume reader_vt0ype = [v:view] freader (v)
//
in (* in of [local] *)

(* ****** ****** *)
//
implement
reader_get_char
  (r) = r.getchar (r.pfres | (*none*))
//
(* ****** ****** *)

fun
reader0_initize_filp
  {m:fmode}{l0:addr}
(
  pfmod:
  file_mode_lte(m,r)
, pffil: FILE(m) @ l0
| r: &reader0 >> reader, p0: ptr l0
) : void = () where
{
//
viewdef v = FILE(m) @ l0
//
val
getchar = lam
  (pffil: !v | (*none*)): int =<cloptr1> fgetc_err (pfmod | !p0)
// end of [getchar]
//
val
freeres = lam
  (pffil: v | (*none*)): void =<cloptr1> fclose_exn (pffil | p0)
//
prval () = r.pfres := pffil
//
val ((*void*)) = r.getchar := getchar
val ((*void*)) = r.freeres := freeres  
//
} (* end of [reader0_initize_filp] *)

(* ****** ****** *)

fun
reader0_initize_getc
(
  r: &reader0 >> reader, getc: () -<cloptr1> int
) : void = () where {
  viewdef v = unit_v
  val getchar = __cast (getc) where {
    extern castfn __cast
      (f: () -<cloptr1> int): (!v | (*none*)) -<cloptr1> int
    // end of [extern]
  } // end of [val]
  val freeres = lam (
    pf: v | (*none*)
  ) : void =<cloptr1> let prval unit_v () = pf in (*none*) end 
  val () = r.pfres := unit_v ()
  val () = r.getchar := getchar
  val () = r.freeres := freeres
} // end of [reader0_initize_getc]

(* ****** ****** *)

fun
reader0_initize_string
  {n:nat} {l:addr} (
  pfgc: free_gc_v (size_t?, l)
, pfat: sizeLte n @ l
| r: &reader0 >> reader, inp: string n, p: ptr l
) : void = () where {
//
  viewdef v = (
    free_gc_v (size_t?, l), sizeLte n @ l
  ) // end of [viewdef]
//
  val getchar = lam
    (pf: !v | (*none*)): int =<cloptr1> let
    prval pf1 = pf.1
    val i = !p
    prval () = pf.1 := pf1
    val isnotend = string_isnot_atend (inp, i)
  in
    if isnotend then let
      val c = string_get_char_at (inp, i)
      prval pf1 = pf.1      
      val () = !p := i + 1
      prval () = pf.1 := pf1
    in
      (int_of_char)c
    end else ~1 (*EOF*) // end of [if]
  end // end of [val]
//
  val freeres = lam
    (pf: v | (*none*)): void =<cloptr1> ptr_free (pf.0, pf.1 | p)
  // end of [freeres]
//
  val () = r.pfres := (pfgc, pfat)
  val () = r.getchar := getchar
  val () = r.freeres := freeres
} // end of [reader0_initize_string]

(* ****** ****** *)

local
//
viewtypedef cs = List_vt (char)
//
in (* in of [local] *)

fun
reader0_initize_charlst_vt
  {l:addr} (
  pfgc: free_gc_v (cs?, l)
, pfat: cs @ l
| r: &reader0 >> reader, p: ptr l
) : void = () where {
//
  viewdef v = (
    free_gc_v (cs?, l), cs @ l
  ) // end of [viewdef]
//
  val getchar =
    lam (
    pf: !v | (*none*)
  ) : int =<cloptr1> let
    prval pf1 = pf.1 // for dereferencing [p]
  in
    case+ !p of
    | ~list_vt_cons
        (c, cs) => let
        val () = !p := cs; prval () = pf.1 := pf1
      in
        int_of_uchar (uchar_of_char (c))
      end // end of [list_vt_cons]
    | list_vt_nil () => let
        prval () = fold@ (!p); prval () = pf.1 := pf1
      in
        ~1 (*EOF*)
      end // end of [list_vt_nil]
  end // end of [lam] // end of [val]
//
  val freeres =
    lam (
    pf: v | (*none*)
  ) : void =<cloptr1> let
    prval (pf0, pf1) = pf
    val () = list_vt_free<char> (!p)
  in
    ptr_free (pf0, pf1 | p)
  end // end of [freeres]
//
  val () = r.pfres := (pfgc, pfat)
  val () = r.getchar := getchar
  val () = r.freeres := freeres
} // end of [reader0_initize_charlst_vt]

end // end of [local]

(* ****** ****** *)

fun
reader0_uninitize
(
  r: &reader >> reader0
) : void = () where {
  stavar v: view
  prval pf = r.pfres : v
  val () = r.freeres (pf | (*none*))
  val () = cloptr_free (r.getchar)
  val () = cloptr_free (r.freeres)
  prval () = __assert (r) where {
    extern prfun __assert (r: &freader(v)? >> reader0): void
  } // end of [prval]
} // end of [reader0_uninitize]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

extern
prfun reader0_encode (r: &reader? >> reader0): void
extern
prfun reader0_decode (r: &reader0 >> reader?): void

in // in of [local]

(* ****** ****** *)

implement
reader_initize_filp
(
  pfmod, pffil | r, p
) = () where
{
//
prval () = reader0_encode (r)
//
val ((*void*)) =
  reader0_initize_filp (pfmod, pffil | r, p)
//
} // end of [reader_initize_filp]

(* ****** ****** *)

implement
reader_initize_getc
  (r, getc) = () where
{
//
prval () = reader0_encode (r)
//
val ((*void*)) = reader0_initize_getc (r, getc)
//
} // end of [reader_initize_getc]

(* ****** ****** *)

implement
reader_initize_string
  (r, inp) = () where
{
//
val inp = string1_of_string inp
val (pfgc, pfat | p) = ptr_alloc<size_t> ()
val () = !p := size1_of_int1 (0)
//
prval () = reader0_encode (r)
//
val () =
  reader0_initize_string (pfgc, pfat | r, inp, p)
//
} (* end of preader_initize_string] *)

(* ****** ****** *)

implement
reader_initize_charlst_vt
  (r, inp) = () where
{
val
(
  pfgc, pfat | p
) =
ptr_alloc<List_vt(char)> ()
//
val () = !p := inp
//
prval () = reader0_encode (r)
//
val ((*void*)) =
  reader0_initize_charlst_vt (pfgc, pfat | r, p)
//
} (* end of preader_initize_charlst_vt] *)

(* ****** ****** *)

implement
reader_uninitize
  (r) = () where {
//
val () = reader0_uninitize (r)
//
prval ((*void*)) = reader0_decode (r)
//
} (* end of [reader_uninitize] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_reader.dats] *)
