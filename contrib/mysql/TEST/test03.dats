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
  val pass = strsome"mysqlats16712"
  val dbname = strnone()
  val port = 16712U
  val socket = strnone()
  val perr = mysql_real_connect
    (conn, host, user, pass, dbname, port, socket, 0UL)
  val () = fprint_mysql_error (stderr_ref, conn)
  val () = assertloc (perr > nullp)
//
  val wild = strnone()
  val res =
    mysql_list_dbs (conn, wild)
  val () = fprint_mysql_error (stderr_ref, conn)
  val perr = MYSQLRESptr2ptr (res)
  val () = assertloc (perr > nullp)
//
  val () = fprintln! (stdout_ref, res)
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
  val () = assertloc (perr > nullp)
//
  val () = fprintln! (stdout_ref, res)
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
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test03.dats] *)
