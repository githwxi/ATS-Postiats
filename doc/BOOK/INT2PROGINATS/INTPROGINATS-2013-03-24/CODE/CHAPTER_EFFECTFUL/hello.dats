(*
** Some code used in the book
*)

(* ****** ****** *)

staload _(*anon*) = "libc/SATS/stdio.sats"

(* ****** ****** *)

implement
main () = () where {
  val out = open_file_exn
    ("hello.txt", file_mode_w)
  val () = fprint_string (out, "Hello, world!\n")
  val () = close_file_exn (out)
} // end of [main]

(* ****** ****** *)

(* end of [hello.dats] *)
