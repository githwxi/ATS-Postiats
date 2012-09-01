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
  val passwd = some"mysqlats16712"
  val dbname = some"testdb"
  val port = 16712U
  val socket = none
  val perr = mysql_real_connect
    (conn, host, user, passwd, dbname, port, socket, 0UL)
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (perr > null)
//
  val qry = "CREATE DATABASE testdb"
  val ierr = mysql_query (conn, $UN.cast{query}(qry))
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (ierr = 0)
//
  val () = mysql_close (conn)
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test04.dats] *)
