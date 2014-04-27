(*
** Source:
** APUE3-page-5/figure-1.3
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atslib_staload_libc.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./apue.sats"

(* ****** ****** *)

staload $UNISTD // opening the name space

(* ****** ****** *)

#define BUFFSIZE 4096

(* ****** ****** *)

implement
main0 () =
{
//
fun loop
  {fd1,fd2:nat}
  {sz:nat | sz >= BUFFSIZE}
(
  src: !fildes(fd1)
, dst: !fildes(fd2)
, buf: &b0ytes(sz) >> bytes(sz)
) : int(*err*) = let
//
val n =
read_err (src, buf, i2sz(BUFFSIZE))
//
in
//
if n > 0 then let
  val n2 = write_err (dst, buf, g1i2u(n))
  val () =
  if n != n2
    then $extfcall (void, "err_sys", "write error")
  // end of [if]
in
  loop (src, dst, buf)
end else $UN.cast{int}(n) // end of [if]
//
end // end of [loop]
//
var buf = @[byte][BUFFSIZE]()
val src = $UN.castvwtp0{fildes(0)}(0)
val dst = $UN.castvwtp0{fildes(1)}(1)
val nread = loop (src, dst, buf)
prval ((*void*)) = $UN.cast2void(src)
prval ((*void*)) = $UN.cast2void(dst)
//
val () = if nread < 0 then $extfcall (void, "err_sys", "read error")
//
val ((*void*)) = exit(0){void}
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [APUE3-1-4.dats] *)
