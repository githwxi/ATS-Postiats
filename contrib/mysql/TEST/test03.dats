//
// Testing ATS API for mysql
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "mysql/SATS/mysql.sats"
//
(* ****** ****** *)

#define some stropt_some
#define none stropt_none

(* ****** ****** *)

implement
main () = let
  val [l:addr]
    conn = mysql_init ()
  val perr = MYSQLptr2ptr (conn)
  val () = fprint_mysql_error (stderr_ref, conn)
//
  val () = assertloc (perr > null)
//
// mysql -h... -P... -umysqlats mysqlats -p mysqlats16712
//
  val host = some"instance25474.db.xeround.com"
  val user = some"mysqlats"
  val pass = some"mysqlats16712"
  val port = 16712U
  val perr = mysql_real_connect
    (conn, host, user, pass, none, port, none, 0UL)
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (perr > null)
//
  val res =
    mysql_list_dbs (conn, none)
  val () = fprint_mysql_error (stderr_ref, conn)
  val perr = MYSQLRESptr2ptr (res)
  val () = assertloc (perr > null)
//
  val () =
    fprint_mysqlres_sep (stdout_ref, res, "\n", ", ")
  val () = fprint_newline (stdout_ref)
//
  val (
    _pf | nrow2
  ) = mysql_num_rows (res)
  val nrow2 = $UN.cast{ullint} (nrow2)
  val () = println! ("nrow2 = ", nrow2)
  val (_pf | nfld2) = mysql_num_fields (res)
  val () = println! ("nfld2 = ", nfld2)
//
  val () = mysql_free_result (res)
//
  val qry = "SHOW DATABASES"
  val ierr = mysql_query (conn, $UN.cast{query}(qry))
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (ierr = 0)
//
  val nfld1 = mysql_field_count (conn)
  val () = println! ("nfld1 = ", nfld1)
//
  val res =
    mysql_use_result (conn)
  val () = fprint_mysql_error (stderr_ref, conn)
  val perr = MYSQLRESptr2ptr (res)
  val () = assertloc (perr > null)
//
  val () =
    fprint_mysqlres_sep (stdout_ref, res, "\n", ", ")
  val () = fprint_newline (stdout_ref)
//
  val (
    _pf | nrow2
  ) = mysql_num_rows (res)
  val nrow2 = $UN.cast{ullint} (nrow2)
  val () = println! ("nrow2 = ", nrow2)
  val (_pf | nfld2) = mysql_num_fields (res)
  val () = println! ("nfld2 = ", nfld2)
//
  val () = mysql_free_result (res)
//
  val () = mysql_close (conn)
//
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test03.dats] *)
