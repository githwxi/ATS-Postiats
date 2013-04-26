(* ****** ****** *)

absvt@ype filedes = int

(* ****** ****** *)

absviewtype cbuffer = ptr

extern
fun cbuffer_isnot_empty (cbuf: !cbuffer): bool

(* ****** ****** *)

extern
fun read (fd: !filedes, cbuf: !cbuffer): void
extern
fun write (fd: !filedes, cbuf: !cbuffer): void

(* ****** ****** *)

extern
fun fcopy (
  src: !filedes, dst: !filedes, cbuf: !cbuffer
) : void // end of [fcopy]

implement
fcopy (src, dst, cbuf) = let
//
fun loop
(
  src: !filedes, dst: !filedes, cbuf: !cbuffer
) : void = let
//
val () = read (src, cbuf)
val isnot = cbuffer_isnot_empty (cbuf)
//
in
if isnot then let
  val () = write (dst, cbuf) in loop (src, dst, cbuf)
end // end of [if]
//
end (* end of [loop] *)
//
in
  loop (src, dst, cbuf)
end (* end of [fcopy] *)

(* ****** ****** *)

(* end of [file-copying.dats] *)
