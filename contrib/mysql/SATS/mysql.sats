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

%{#
#include "mysql/CATS/mysql.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no static loading at run-time

(* ****** ****** *)

absviewt@ype MYSQL = $extype "MYSQL_struct"
absviewt@ype MYSQLRES = $extype "MYSQLRES_struct"
absviewt@ype MYSQLFIELD = $extype "MYSQLFIELD_struct"

(* ****** ****** *)

/*
typedef char **MYSQLROW;
*/
absviewtype MYSQLROW (l1:addr, l2:addr)
viewtypedef MYSQLROW0 (l1:addr) = [l2:addr] MYSQLROW (l1, l2)
viewtypedef MYSQLROW1 (l1:addr) = [l2:addr| l2 > null] MYSQLROW (l1, l2)

(* ****** ****** *)

absviewtype MYSQLROWLEN (l1:addr, l2:addr)
viewtypedef MYSQLROWLEN0 (l1:addr) = [l2:addr] MYSQLROWLEN (l1, l2)
viewtypedef MYSQLROWLEN1 (l1:addr) = [l2:addr| l2 > null] MYSQLROWLEN (l1, l2)

(* ****** ****** *)

absviewtype MYSQLptr (l:addr)
viewtypedef MYSQLptr0 = [l:addr] MYSQLptr (l)
viewtypedef MYSQLptr1 = [l:addr| l > null] MYSQLptr (l)

(* ****** ****** *)

absviewtype MYSQLRESptr (l:addr)
viewtypedef MYSQLRESptr0 = [l:addr] MYSQLRESptr (l)
viewtypedef MYSQLRESptr1 = [l:addr| l > null] MYSQLRESptr (l)

(* ****** ****** *)

absviewtype MYSQLFIELDptr (l1:addr, l2:addr)
viewtypedef MYSQLFIELDptr0 (l1:addr) = [l2:addr] MYSQLFIELDptr (l1, l2)
viewtypedef MYSQLFIELDptr1 (l1:addr) = [l2:addr| l2 > null] MYSQLFIELDptr (l1, l2)

(* ****** ****** *)

castfn MYSQLptr2ptr {l:addr} (x: !MYSQLptr l):<> ptr (l)
castfn MYSQLRESptr2ptr {l:addr} (x: !MYSQLRESptr (l)):<> ptr (l)
castfn MYSQLFIELDptr2ptr {l1,l2:addr} (x: !MYSQLFIELDptr (l1, l2)):<> ptr (l2)

(* ****** ****** *)

castfn MYSQLROW2ptr {l1,l2:addr} (x: !MYSQLROW (l1, l2)):<> ptr (l2)

(* ****** ****** *)

abstype query = string

(* ****** ****** *)

symintr free_null

prfun mysql_free_null
  {l:addr | l <= null} (x: MYSQLptr (l)):<> void
overload free_null with mysql_free_null

prfun mysqlres_free_null
  {l:addr | l <= null} (x: MYSQLRESptr (l)):<> void
overload free_null with mysqlres_free_null

prfun mysqlrow_free_null
  {l1,l2:addr | l2 <= null} (x: MYSQLROW (l1, l2)):<> void
overload free_null with mysqlrow_free_null

prfun mysqlfield_free_null
  {l1,l2:addr | l2 <= null} (x: MYSQLFIELDptr (l1, l2)):<> void
overload free_null with mysqlfield_free_null

(* ****** ****** *)

fun mysql_init0
  ((*null*)): MYSQLptr0 = "mac#atsctrb_mysql_init0"
fun mysql_init0_exn ((*null*)): MYSQLptr1

(* ****** ****** *)

fun mysql_close (x: MYSQLptr0): void = "mac#atsctrb_mysql_close"

(* ****** ****** *)

/*
MYSQL *		STDCALL mysql_real_connect(MYSQL *mysql, const char *host,
					   const char *user,
					   const char *passwd,
					   const char *db,
					   unsigned int port,
					   const char *unix_socket,
					   unsigned long clientflag);
*/
fun mysql_real_connect
  {l:agz} (
  mysql: !MYSQLptr (l)
, host: stropt
, user: stropt
, passwd: stropt
, dbname: stropt
, port: uint
, socket: stropt
, clientflag: ulint
) : [l1:addr | l1==null || l1==l] ptr l1
  = "mac#atsctrb_mysql_real_connect"
// end of [mysql_real_connect]

(* ****** ****** *)

/*
my_bool mysql_eof(MYSQL_RES *result);
*/
(*
// HX-2012-08: this one is deprecated
*)

/*
unsigned int
mysql_errno(MYSQL *mysql);
*/
fun mysql_errno
  {l:addr} (
  mysql: !MYSQLptr l
) : uint = "mac#atsctrb_mysql_errno"

/*
const char*
mysql_error(MYSQL *mysql);
*/
fun mysql_error
  {l:addr} (
  mysql: !MYSQLptr l
) : string = "mac#atsctrb_mysql_error"

(* ****** ****** *)

/*
int mysql_ping(MYSQL *mysql);
*/
fun mysql_ping
  {l:agz} (
  mysql: !MYSQLptr l
) : int = "mac#atsctrb_mysql_ping"

(* ****** ****** *)

/*
my_bool mysql_commit (MYSQL *mysql);
*/
fun mysql_commit
  {l:agz} (
  mysql: !MYSQLptr l
) : int = "mac#atsctrb_mysql_commit"

(* ****** ****** *)

/*
int mysql_query(MYSQL *mysql, const char *q);
*/
fun mysql_query
  {l:agz} (
  mysql: !MYSQLptr l, q: query
) : int(*err*) = "mac#atsctrb_mysql_query"

(* ****** ****** *)

/*
int mysql_create_db
  (MYSQL *mysql, const char *db);
*/
(*
// HX-2012-08: it is deprecated; use mysql_query instead
*)

/*
int mysql_drop_db (MYSQL *mysql, const char *db)
*/
(*
// HX-2012-08: it is deprecated; use mysql_query instead
*)

(* ****** ****** *)

/*
MYSQL_RES*
mysql_list_dbs(MYSQL *mysql, const char *wild)
*/
fun mysql_list_dbs
  {l:agz} (
  mysql: !MYSQLptr l, wild: stropt
) : MYSQLRESptr0 = "mac#atsctrb_mysql_list_dbs"

(* ****** ****** *)

fun mysql_field_count
  {l:agz} (
  mysql: !MYSQLptr l
) : uint = "mac#atsctrb_mysql_field_count"

(* ****** ****** *)

absprop MYSQLRESnrow (addr, int)

praxi
lemma_MYSQLRESnrow_param
  {l:addr}{n:int} (pf: MYSQLRESnrow (l, n)): [l>null;n>=0] void
// end of [lemma_MYSQLRESnrow_param]

(* ****** ****** *)

absprop MYSQLRESnfield (addr, int)

praxi
lemma_MYSQLRESnfield_param
  {l:addr}{n:int} (pf: MYSQLRESnfield (l, n)): [l>null;n>=0] void
// end of [lemma_MYSQLRESnfield_param]

(* ****** ****** *)

fun mysql_num_rows
  {l:agz} (
  res: !MYSQLRESptr l
) : [n:nat] (MYSQLRESnrow (l, n) | ullint n) = "mac#atsctrb_mysql_num_rows"
macdef mysqlres_get_nrow = mysql_num_rows

fun mysql_num_fields
  {l:agz} (
  res: !MYSQLRESptr l
) : [n:nat] (MYSQLRESnfield (l, n) | int n) = "mac#atsctrb_mysql_num_fields"
macdef mysqlres_get_nfield = mysql_num_fields

(* ****** ****** *)

/*
my_ulonglong mysql_affected_rows(MYSQL *mysql)
*/
fun mysql_affected_rows
  {l:agz} (mysql: !MYSQLptr l): ullint = "mac#mysql_affected_rows"
// end of [mysql_affected_rows]

(* ****** ****** *)

/*
MYSQL_RES *mysql_use_result(MYSQL *mysql);
*/
fun mysql_use_result
  {l:agz} (
  mysql: !MYSQLptr l
) : MYSQLRESptr0 = "mac#atsctrb_mysql_use_result"

/*
MYSQL_RES *mysql_store_result(MYSQL *mysql);
*/
fun mysql_store_result
  {l:agz} (
  mysql: !MYSQLptr l
) : MYSQLRESptr0 = "mac#atsctrb_mysql_store_result"

(* ****** ****** *)

/*
void mysql_free_result(MYSQL_RES *result);
*/
fun mysql_free_result
  (result: MYSQLRESptr0): void = "mac#atsctrb_mysql_free_result"
// end of [mysql_free_result]

(* ****** ****** *)

/*
MYSQL_ROW mysql_fetch_row(MYSQL_RES *result);
*/
fun mysql_fetch_row
  {l:agz} (
  res: !MYSQLRESptr l
) : MYSQLROW0 (l) = "mac#atsctrb_mysql_fetch_row"
macdef mysqlres_fetch_row = mysql_fetch_row

prfun mysql_unfetch_row
  {l1,l2:addr} (
  res: !MYSQLRESptr (l1), row: MYSQLROW (l1, l2)
) :<> void // end of [mysql_unfetch_row]
macdef mysqlres_unfetch_row = mysql_unfetch_row

(* ****** ****** *)

/*
MYSQL_ROWLEN
mysql_fetch_lengths(MYSQL_RES *result);
*/
fun mysql_fetch_lengths
  {l:agz} (
  res: !MYSQLRESptr l
) : MYSQLROWLEN0 (l) = "mac#atsctrb_mysql_fetch_lengths"
macdef mysqlres_fetch_lengths = mysql_fetch_lengths

prfun mysql_unfetch_lengths
  {l1,l2:addr} (
  res: !MYSQLRESptr l1, rowlen: MYSQLROWLEN (l1, l2)
) :<> void // end of [mysql_unfetch_rowlen]
macdef mysqlres_unfetch_lengths = mysql_unfetch_lengths

(* ****** ****** *)

fun mysqlrow_get_at
  {l1,l2:addr | l2 > null}{n:int} (
  pfrow: MYSQLRESnfield (l1, n) | row: !MYSQLROW (l1, l2), i: natLt n
) : ptr = "mac#atsctrb_mysqlrow_get_at" // endfun

(* ****** ****** *)

fun mysqlrowlen_get_at
  {l1,l2:addr | l2 > null}{n:int} (
  pfrow: MYSQLRESnfield (l1, n) | rowlen: !MYSQLROWLEN (l1, l2), i: natLt n
) : ulint = "mac#atsctrb_mysqlrowlen_get_at" // endfun

(* ****** ****** *)

/*
MYSQL_FIELD mysql_fetch_field(MYSQL_RES *result);
*/
fun mysql_fetch_field
  {l:agz} (
  res: !MYSQLRESptr l
) : MYSQLFIELDptr0 (l) = "mac#atsctrb_mysql_fetch_field"
macdef mysqlres_fetch_field = mysql_fetch_field

prfun mysql_unfetch_field
  {l1,l2:addr} (
  res: !MYSQLRESptr (l1), field: MYSQLFIELDptr (l1, l2)
) :<> void // end of [mysql_unfetch_field]
macdef mysqlres_unfetch_field = mysql_unfetch_field

(* ****** ****** *)

/*
MYSQL_FIELD*
mysql_fetch_field_direct(MYSQL_RES *result, unsigned int fieldnr)
*/
fun mysql_fetch_field_direct
  {l:agz}{n:int} (
  pfrow: MYSQLRESnfield (l, n) | res: !MYSQLRESptr (l), i: natLt n
) : MYSQLFIELDptr1 (l) = "mac#atsctrb_mysql_fetch_field_direct"
macdef mysqlres_fetch_field_at = mysql_fetch_field_direct

(* ****** ****** *)

fun mysqlfield_get_name
  {l1,l2:addr | l2 > null}
  (fld: !MYSQLFIELDptr (l1, l2)) : ptr(*char*)
  = "mac#atsctrb_mysqlfield_get_name" // endfun

fun mysqlfield_get_length
  {l1,l2:addr | l2 > null}
  (fld: !MYSQLFIELDptr (l1, l2)) : ulint
  = "mac#atsctrb_mysqlfield_get_length" // endfun

fun mysqlfield_get_max_length
  {l1,l2:addr | l2 > null}
  (fld: !MYSQLFIELDptr (l1, l2)) : ulint
  = "mac#atsctrb_mysqlfield_get_max_length" // endfun

(* ****** ****** *)

/*
const char *mysql_info (MYSQL *mysql);
*/
fun mysql_info
  {l:agz} (
  mysql: !MYSQLptr l
) : string = "mac#atsctrb_mysql_info"
// end of [mysql_info]  

(* ****** ****** *)

/*
const char *mysql_get_host_info (MYSQL *mysql);
*/
fun mysql_get_host_info
  {l:agz} (
  mysql: !MYSQLptr l
) : string = "mac#atsctrb_mysql_get_host_info"
// end of [mysql_get_host_info]  

/*
unsigned int mysql_get_proto_info(MYSQL *mysql)
*/
fun mysql_get_proto_info
  {l:agz} (
  mysql: !MYSQLptr l
) : uint = "mac#atsctrb_mysql_get_proto_info"
// end of [mysql_get_proto_info]  

(* ****** ****** *)

/*
const char* mysql_get_client_info(void);
*/
fun mysql_get_client_info
  (): string = "mac#atsctrb_mysql_get_client_info"
// end of [mysql_get_client_info]  

/*
unsigned long mysql_get_client_version(void);
*/
fun mysql_get_client_version
  (): ulint = "mac#atsctrb_mysql_get_client_version"
// end of [mysql_get_client_version]

(* ****** ****** *)

/*
const char *mysql_get_server_info (MYSQL *mysql);
*/
fun mysql_get_server_info
  {l:agz} (
  mysql: !MYSQLptr l
) : string = "mac#atsctrb_mysql_get_server_info"
// end of [mysql_get_server_info]  

/*
unsigned long int mysql_get_server_version(MYSQL *mysql)
*/
fun mysql_get_server_version
  {l:agz} (
  mysql: !MYSQLptr l
) : ulint = "mac#atsctrb_mysql_get_server_version"
// end of [mysql_get_server_version]

(* ****** ****** *)
//
// Some convenience functions
//
(* ****** ****** *)

fun fprint_mysql_error
  {l:addr} (out: FILEref, mysql: !MYSQLptr l): void
// end of [fprint_mysql_error]

(* ****** ****** *)

fun fprint_mysqlres_sep
  {l:agz} (
  out: FILEref, res: !MYSQLRESptr (l), sep1: string, sep2: string
) : void // end of [fprint_mysqlres_sep]

fun fprint_mysqlrow_sep
  {l1,l2:addr | l2 > null}{n:int} (
  pfrow: MYSQLRESnfield (l1, n)
| out: FILEref, row: !MYSQLROW (l1, l2), n: int n, sep: string
) : void // end of [fprint_mysqlrow_sep]

(* ****** ****** *)

(* end of [mysql.sats] *)
