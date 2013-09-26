(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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

(*
** Start Time: August, 2012
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no dynloading at run-time

(* ****** ****** *)
//
staload
UN="prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../SATS/mysql.sats"

(* ****** ****** *)

implement{}
fprint_mysql_error
  (out, conn) = {
  val errno = mysql_errno (conn)
  val error = mysql_error (conn)
  val () = fprintln! (out, "error(mysql): ", errno, ": ", error)
} // end of [fprint_mysql_error]

(* ****** ****** *)

implement{}
fprint_mysqlres$sep1 (out) = fprint (out, ", ")
implement{}
fprint_mysqlres$sep2 (out) = fprint (out, "; ")
implement{}
fprint_mysqlres
  {l} (out, res) = let
//
val [n:int]
  (pfrow | n) = mysql_num_fields (res)
//
fun loop1
(
  out: FILEref, res: !MYSQLRESptr l, i: int
) :<cloref1> void = let
  val fld =
    mysqlres_fetch_field (res)
  val p = MYSQLFIELDptr2ptr (fld)
in
//
if p > 0 then let
  val name = mysqlfield_get_name (fld)
  prval () = mysqlres_unfetch_field (res, fld)
  val () = if i > 0 then fprint_mysqlres$sep1 (out)
  val () = fprint_string (out, $UN.cast{string}(name))
in
  loop1 (out, res, i+1)
end else let
  prval () = mysqlres_unfetch_field (res, fld)
in
  // finished
end // end of [if]
//
end // end of [loop1]
//
fun loop2
(
  out: FILEref, res: !MYSQLRESptr l, i: int
) :<cloref1> void = let
  val row =
    mysqlres_fetch_row (res)
  val prow = MYSQLROW2ptr (row)
in
//
if prow > 0 then let
  val (
  ) = if i > 0 then fprint_mysqlres$sep2 (out)
  val () = let
    implement
    fprint_mysqlrow$sep<> = fprint_mysqlres$sep1<>
  in
    fprint_mysqlrow (pfrow | out, row, n)
  end // end of [val]
  prval () = mysqlres_unfetch_row (res, row)
in
  loop2 (out, res, i+1)
end else let
  prval () = mysqlres_unfetch_row (res, row)
in
  // nothing
end // end of [if]
//
end // end of [loop2]
//
val () = loop1 (out, res, 0)
val () = loop2 (out, res, 1)
//
in
  // nothing
end // end of [fprint_mysqlres]

implement{
} fprint_mysqlres_sep
  (out, res, sep1, sep2) = let
//
implement
fprint_mysqlres$sep1<> (out) = fprint (out, sep1)
implement
fprint_mysqlres$sep2<> (out) = fprint (out, sep2)
//
in
  fprint_mysqlres (out, res)
end // end of [fprint_mysqlres_sep]

(* ****** ****** *)

implement{}
fprint_mysqlrow$sep (out) = fprint (out, ", ")
implement{}
fprint_mysqlrow
  {l1,l2}{n}
  (pfrow | out, row, n) = let
//
prval () = lemma_MYSQLRESnfield_param (pfrow)
//
fun loop
  {i:nat | i <= n} .<n-i>.
(
  row: !MYSQLROW (l1, l2), i: int i
) : void =
  if i < n then let
    val () =
      if i > 0 then fprint_mysqlrow$sep (out)
    val p = mysqlrow_get_at (pfrow | row, i)
    val () = (
      if (p > 0) then
        fprint_string (out, $UN.cast{string}(p)) else fprint_string (out, "NULL")
      // end of [if]
    ) : void // end of [val]
  in
    loop (row, i+1)
  end else () // end of [if]
//
in
  loop (row, 0)
end // end of [fprint_mysqlrow]

implement{
} fprint_mysqlrow_sep
  {l1,l2}{n}
  (pfrow | out, row, n, sep) = let
//
implement
fprint_mysqlrow$sep<> (out) = fprint (out, sep)
//
in
  fprint_mysqlrow (pfrow | out, row, n)
end // end of [fprint_mysqlrow_sep]

(* ****** ****** *)

(* end of [mysql.dats] *)
