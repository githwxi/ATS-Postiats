(* ****** ****** *)
//
// HX-2013-04:
// Effective ATS: Copying files (1)
//
(* ****** ****** *)

%{^
#include <unistd.h>
%}

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

abst@ype fildes_t0ype = int
stadef fildes: t@ype = fildes_t0ype

(* ****** ****** *)

extern
fun readch (src: fildes): int = "sta#"
extern
fun writech (src: fildes, c: char): void = "sta#"

(* ****** ****** *)

%{^

static
atstype_int
readch (int src)
{
  char c ;
  ssize_t n ;
  n = read (src, &c, 1) ;
  if (n <= 0) return -1 ;
  return c ;
}

static
atsvoid_t0ype
writech (int dst, char c)
{
  ssize_t n ;
  n = write (dst, &c, 1) ;
  return ;
}

%}

(* ****** ****** *)

#define i2c int2char0

(* ****** ****** *)

extern
fun fcopy (src: fildes, dst: fildes): void

implement
fcopy (src, dst) = let
  val c = readch (src)
in
//
if c >= 0 then
  (writech (dst, i2c(c)); fcopy (src, dst))
// end of [if]
//
end (* end of [fcopy] *)

(* ****** ****** *)

val STDIN = $extval (fildes, "0")
val STDOUT = $extval (fildes, "1")

(* ****** ****** *)

implement
main0 () =
{
//
val () = fcopy (STDIN, STDOUT)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fcopy-1.dats] *)
