//
// Testing ATS API for mysql
//
(* ****** ****** *)
//
staload "./../SATS/mysql.sats"
//
(* ****** ****** *)

implement
main () = let
  val version = mysql_get_client_info ()
  val () = println! ("MySQL client version: ", version)
in
  0(*normal*)
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
