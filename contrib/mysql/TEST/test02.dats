//
// Testing ATS API for mysql
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"

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
  val dbname = strnone()
  val pass = strsome"mysqlats16712"
  val port = 16712U
  val socket = strnone()
  val perr = mysql_real_connect
    (conn, host, user, pass, dbname, port, socket, 0UL)
  val () = fprint_mysql_error (stderr_ref, conn)
//
  val () = assertloc (perr > nullp)
//
  val stat = mysql_stat (conn)
  val () = println! ("stat: ", stat)
  val sqlstate = mysql_sqlstate (conn)
  val () = println! ("sqlstate: ", sqlstate)
//
  val info = mysql_get_host_info (conn)
  val () = println! ("host info: ", info)
  val proto = mysql_get_proto_info (conn)
  val () = println! ("proto info: ", proto)
//
  val info = mysql_get_server_info (conn)
  val () = println! ("serve info: ", info)
  val version = mysql_get_server_version (conn)
  val () = println! ("serve version: ", version)
//
  val qry = "create database testdb"
  val ierr = mysql_query (conn, $UN.cast{query}(qry))
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (ierr = 0)
//
  val qry = "drop database testdb"
  val ierr = mysql_query (conn, $UN.cast{query}(qry))
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (ierr = 0)
//
  val () = mysql_close (conn)
in
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test02.dats] *)
