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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "mysql/SATS/mysql.sats"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

macdef null = the_null_ptr

(* ****** ****** *)

implement
mysql_init0_exn
  ((*null*)) = let
  val conn = mysql_init0 ()
  val p = MYSQLptr2ptr (conn)
in
//
  if p > null then conn
  else let
//
    val () =
      fprint_mysql_error (stderr_ref, conn)
    prval () = mysql_free_null (conn) // HX: no-op
    val () = fprint_string (stderr_ref, "exit(ATS): [mysql_init0] failed.")
    val () = fprint_newline (stderr_ref)
//
  in
    exit (1)
  end // end of [if]
//  
end // end of [mysql_init0_exn]

(* ****** ****** *)

implement
fprint_mysql_error
  (out, conn) = {
  val errno = mysql_errno (conn)
  val error = mysql_error (conn)
  val () = fprintf (out, "error(mysql): %u: %s", @(errno, error))
  val () = fprint_newline (out)
} // end of [fprint_mysql_error]

(* ****** ****** *)

implement
fprint_mysqlres_sep
  {l} (out, res, sep1, sep2) = let
//
val [n:int]
  (pfrow | n) = mysql_num_fields (res)
//
fun loop1 (
  out: FILEref
, res: !MYSQLRESptr l, i: int
) :<cloref1> void = let
  val fld =
    mysqlres_fetch_field (res)
  val p = MYSQLFIELDptr2ptr (fld)
in
//
if p > null then let
  val name = mysqlfield_get_name (fld)
  prval () = mysqlres_unfetch_field (res, fld)
  val () = if i > 0 then fprint_string (out, sep2)
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
fun loop2 (
  out: FILEref
, res: !MYSQLRESptr l, i: int
) :<cloref1> void = let
  val row =
    mysqlres_fetch_row (res)
  val prow = MYSQLROW2ptr (row)
in
//
if prow > null then let
  val () = if i > 0 then fprint_string (out, sep1)
  val () = fprint_mysqlrow_sep (pfrow | out, row, n, sep2)
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
end // end of [fprint_mysqlres_sep]

(* ****** ****** *)

implement
fprint_mysqlrow_sep
  {l1,l2}{n}
  (pfrow | out, row, n, sep) = let
//
prval () = lemma_MYSQLRESnfield_param (pfrow)
//
fun loop
  {i:nat | i <= n} .<n-i>. (
  out: FILEref, row: !MYSQLROW (l1, l2), n: int n, sep: string, i: int i
) : void =
  if i < n then let
    val () =
      if i > 0 then fprint_string (out, sep)
    val p = mysqlrow_get_at (pfrow | row, i)
    val () = (
      if (p > null) then
        fprint_string (out, $UN.cast{string}(p)) else fprint_string (out, "NULL")
      // end of [if]
    ) : void // end of [val]
  in
    loop (out, row, n, sep, i+1)
  end else () // end of [if]
//
in
  loop (out, row, n, sep, 0)
end // end of [fprint_mysqlrow_sep]

(* ****** ****** *)

(* end of [mysql.dats] *)
