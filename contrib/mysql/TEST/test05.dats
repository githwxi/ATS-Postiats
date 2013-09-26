//
// Testing ATS API for mysql
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
_(*INT*) = "prelude/DATS/integer.dats"

(* ****** ****** *)
//
staload "./../SATS/mysql.sats"
staload _(*anon*) = "./../DATS/mysql.dats"
//
(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

macdef strnone() = stropt_none()
macdef strsome(x) = stropt_some(,(x))

(* ****** ****** *)

implement
main () = let
  val conn = mysql_init0_exn ()
  val perr = MYSQLptr2ptr (conn)
  val () = fprint_mysql_error (stderr_ref, conn)
//
  val () = assertloc (perr > nullp)
//
// mysql -h... -P... -umysqlats mysqlats -p mysqlats16712
//
  val host = strsome"instance25474.db.xeround.com"
  val user = strsome"mysqlats"
  val passwd = strsome"mysqlats16712"
  val dbname = strsome"testdb"
  val port = 16712U
  val socket = strnone()
  val perr = mysql_real_connect
    (conn, host, user, passwd, dbname, port, socket, 0UL)
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (perr > nullp)
//
  macdef query (x) = $UN.cast{query}{string}(,(x))
//
  val ierr =
    mysql_query(conn, query"DROP TABLE writers")
  val () = fprint_mysql_error (stderr_ref, conn)
  val ierr =
    mysql_query(conn, query"CREATE TABLE writers(id INT UNSIGNED AUTO_INCREMENT, name VARCHAR(25), PRIMARY KEY(id))")
  val () = fprint_mysql_error (stderr_ref, conn)
//
  val ierr =
    mysql_query(conn, query"INSERT INTO writers VALUES(NULL, 'William Shakespeare')")
  val () = fprint_mysql_error (stderr_ref, conn)
  val ierr =
    mysql_query(conn, query"INSERT INTO writers VALUES(NULL, 'Leo Tolstoy')")
  val () = fprint_mysql_error (stderr_ref, conn)
  val ierr =
    mysql_query(conn, query"INSERT INTO writers VALUES(NULL, 'Jack London')")
  val () = fprint_mysql_error (stderr_ref, conn)
  val ierr = 
    mysql_query(conn, query"INSERT INTO writers VALUES(NULL, 'Honore de Balzac')")
  val () = fprint_mysql_error (stderr_ref, conn)
  val ierr =
    mysql_query(conn, query"INSERT INTO writers VALUES(NULL, 'Lion Feuchtwanger')")
  val () = fprint_mysql_error (stderr_ref, conn)
  val ierr =
    mysql_query(conn, query"INSERT INTO writers VALUES(NULL, 'Emile Zola')")
  val () = fprint_mysql_error (stderr_ref, conn)
//
  val () = mysql_close (conn)
in
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test05.dats] *)
