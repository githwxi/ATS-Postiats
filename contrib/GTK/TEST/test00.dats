(*
**
** Start with GTK3
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: September, 2013
**
*)

(* ****** ****** *)

staload "./../SATS/gtk.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement
main0 (argc, argv) = let
//
val major = gtk_get_major_version ()
val major = $UN.cast2int (major)
val minor = gtk_get_minor_version ()
val minor = $UN.cast2int (minor)
val micro = gtk_get_micro_version ()
val micro = $UN.cast2int (micro)
//
in
//
println! ("GTK version: ", major, ".", minor, ".", micro)
//
end // end of [main0]

(* ****** ****** *)

(* end of [test00.dats] *)
