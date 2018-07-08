(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author of the file:
// Hongwei Xi (gmhwxiATgmailDOTcom)
// Start Time: March, 2013
//
(* ****** ****** *)
//
// HX-2013-03:
// lmacrodef: local macro definitions
//
(* ****** ****** *)
//
macdef :+= (x, a) = let val v = ,(x) in ,(x) := ,(a) + v end
macdef :-= (x, a) = let val v = ,(x) in ,(x) := ,(a) - v end
macdef :*= (x, a) = let val v = ,(x) in ,(x) := ,(a) * v end
macdef :/= (x, a) = let val v = ,(x) in ,(x) := ,(a) / v end
//
(* ****** ****** *)
//
macdef :=+ (x, a) = let val v = ,(x) in ,(x) := v + ,(a) end
macdef :=- (x, a) = let val v = ,(x) in ,(x) := v - ,(a) end
macdef :=* (x, a) = let val v = ,(x) in ,(x) := v * ,(a) end
macdef :=/ (x, a) = let val v = ,(x) in ,(x) := v / ,(a) end
//
(* ****** ****** *)
//
macdef
println(x) = (print(,(x)); print_newline())
macdef
prerrln(x) = (prerr(,(x)); prerr_newline())
//
macdef
fprintln(out, x) = (fprint(,(out), ,(x)); fprint_newline(,(out)))
//
(* ****** ****** *)
(*
//
// HX-2012-08:
//
// this example makes use of recursive macrodef
//
*)
(*
//
local
//
macrodef
rec
auxlist
  (xs, y) =
(
//
if
iscons! (xs)
then `(print ,(car! xs); ,(auxlist (cdr! xs, y))) else y
// end of [if]
//
) (* end of [auxlist] *)
//
in (* in of [local] *)

macdef
print_mac (x) =
,(
  if islist! (x) then auxlist (x, `()) else `(print ,(x))
) (* end of [print_mac] *)

macdef
println_mac (x) =
,(
  if islist! (x)
    then auxlist (x, `(print_newline())) else `(print ,(x); print_newline())
  // end of [if]
) (* end of [println_mac] *)

end // end of [local]
//
*)

(* ****** ****** *)
//
macdef
eqfn(x0) = lam(x) =<cloref1> (,(x0) = x)
macdef
cmpfn(x0) = lam(x) =<cloref1> compare(,(x0), x)
//
(* ****** ****** *)

(* end of [lmacrodef.hats] *)
