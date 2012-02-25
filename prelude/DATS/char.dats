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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: February, 2012
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [char.dats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

implement
print_char (c) = fprint_char (stdout_ref, c)
implement
prerr_char (c) = fprint_char (stderr_ref, c)

(* ****** ****** *)

implement{a}
g0int_of_char
  (c) = __cast (c) where {
  extern castfn __cast (c: char): g0int (a)
} // end of [g0int_of_char]
implement{a}
g0int_of_schar
  (c) = __cast (c) where {
  extern castfn __cast (c: schar): g0int (a)
} // end of [g0int_of_schar]
implement{a}
g0int_of_uchar
  (c) = __cast (c) where {
  extern castfn __cast (c: uchar): g0int (a)
} // end of [g0int_of_uchar]

implement{a}
g0uint_of_uchar
  (c) = __cast (c) where {
  extern castfn __cast (c: uchar): g0uint (a)
} // end of [g0uint_of_uchar]

(* ****** ****** *)

implement{a}
g1int_of_char1
  {c} (c) = __cast (c) where {
  extern castfn __cast (c: char c): g1int (a, c)
} // end of [g1int_of_char1]
implement{a}
g1int_of_schar1
  {c} (c) = __cast (c) where {
  extern castfn __cast (c: schar c): g1int (a, c)
} // end of [g1int_of_schar1]
implement{a}
g1int_of_uchar1
  {c} (c) = __cast (c) where {
  extern castfn __cast (c: uchar c): g1int (a, c)
} // end of [g1int_of_uchar1]

implement{a}
g1uint_of_uchar1
  {c} (c) = __cast (c) where {
  extern castfn __cast (c: uchar c): g1uint (a, c)
} // end of [g1uint_of_uchar1]

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [char.dats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [char.dats] *)
