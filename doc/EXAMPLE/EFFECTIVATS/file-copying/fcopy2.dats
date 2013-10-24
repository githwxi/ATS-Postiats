(* ****** ****** *)
//
// HX-2013-04:
// Effective ATS: Copying files (2)
//
(* ****** ****** *)

%{^
#include <unistd.h>
%}

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

abst@ype fildes_t0ype = int
stadef fildes: t@ype = fildes_t0ype

(* ****** ****** *)

absvtype buffer_type = ptr
vtypedef buffer = buffer_type

(* ****** ****** *)

extern
fun buffer_create (m: size_t): buffer = "mac#"
extern
fun buffer_destroy (buf: buffer): void = "mac#"
extern
fun buffer_isnot_empty (buf: !buffer): bool = "mac#"

(* ****** ****** *)

%{^

typedef
struct {
  char* data ; size_t size ; size_t nchar ;
} buffer_struct ;
typedef buffer_struct *buffer ;

static
buffer
buffer_create (size_t m)
{
  buffer buf = atspre_malloc_gc(sizeof(buffer_struct)) ;
  buf->data = atspre_malloc_gc(m) ; buf->size = m ; buf->nchar = 0 ;
  return buf ;
}

static
void
buffer_destroy (buffer buf)
{
  atspre_mfree_gc (buf->data) ; atspre_mfree_gc (buf) ; return ;
}

#define buffer_isnot_empty(buf) (((buffer)buf)->nchar?1:0)

%}

(* ****** ****** *)

extern
fun readbuf (src: fildes, buf: !buffer): void = "sta#"
extern
fun writebuf (dst: fildes, buf: !buffer): void = "sta#"

(* ****** ****** *)

%{^

static
void
readbuf
(
  int src, atstype_ptr buf0
)
{
  buffer buf = (buffer)buf0 ;
  ssize_t nchar ;
  nchar = read(src, buf->data, buf->size) ;
  if (nchar < 0) exit(1) ; // HX: no error-handling
  buf->nchar = nchar ;
  return ;
}

static
void
writebuf
(
  int dst, atstype_ptr buf0
)
{
  ssize_t nchar ;
  buffer buf = (buffer)buf0 ;
  while (1)
  {
    if (buf->nchar==0) break ;
    nchar = write(dst, buf->data, buf->nchar) ;
    if (nchar < 0) exit(1) ; // HX: no error-handling
    buf->nchar -= nchar ;
  } // end of [while]
  return ;
}

%}

(* ****** ****** *)

#define BUFSZ (16*1024)

(* ****** ****** *)
//
extern
fun fcopy2 (src: fildes, dst: fildes): void
//
(* ****** ****** *)

implement
fcopy2 (src, dst) = let
//
fun loop
(
  src: fildes, dst: fildes, buf: !buffer
) : void = let
  val () = readbuf (src, buf)
  val isnot = buffer_isnot_empty (buf)
in
  if isnot then let
    val () = writebuf (dst, buf) in loop (src, dst, buf)
  end else () // end of [if]
//
end // end of [loop]
//
val buf =
  buffer_create (i2sz(BUFSZ))
val () = loop (src, dst, buf)
val () = buffer_destroy (buf)
//
in
  // nothing
end (* end of [fcopy2] *)

(* ****** ****** *)

val STDIN = $extval (fildes, "0")
val STDOUT = $extval (fildes, "1")

(* ****** ****** *)

implement
main0 () =
{
//
val () = fcopy2 (STDIN, STDOUT)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fcopy2.dats] *)
