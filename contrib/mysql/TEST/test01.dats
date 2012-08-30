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
  val version = mysql_get_client_info ()
  val () = printf("MySQL client version: %s\n", @(version))
in
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
