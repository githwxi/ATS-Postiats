//
// Testing ATS API for mysql
//
(* ****** ****** *)
//
staload "mysql/SATS/mysql.sats"
//
(* ****** ****** *)

implement
main () = let
  val info = mysql_get_client_info ()
  val () = printf ("MySQL client info: %s\n", @(info))
  val version = mysql_get_client_version ()
  val () = printf ("MySQL client version: %lu\n", @(version))
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
