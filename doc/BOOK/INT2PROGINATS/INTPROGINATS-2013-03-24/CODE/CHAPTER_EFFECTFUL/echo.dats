(*
** Some code used in the book
*)

(* ****** ****** *)

staload _(*anon*) = "libc/SATS/stdio.sats"

(* ****** ****** *)

implement
main () = loop () where {
  fun loop (): void = let
    val line = input_line (stdin_ref)
  in
    if stropt_is_some (line) then let
      val () = output_line (stdout_ref, stropt_unsome (line))
    in
      loop ()
    end else
      () // loop exits as the end-of-file is reached
    // end of [if]
  end (* end of [loop] *)
} // end of [main]

(* ****** ****** *)

(* end of [echo.dats] *)
