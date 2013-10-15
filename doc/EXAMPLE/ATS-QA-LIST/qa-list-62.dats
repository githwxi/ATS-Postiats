(* ****** ****** *)
//
// HX-2013-08
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{^

#include <string.h>

#define _give_str give_str

void
give_str(char* buf, size_t* len)
{
  strncpy(buf, "hoho\0", 5); *len = 5; return;
}

%}
    
extern
fun give_str
  {l1,l2: addr}{m:nat}
(
  buf: &b0ytes(m) >> strbuf(m, n), len: &size_t? >> size_t(n)
) : #[n:nat | n < m] void = "mac#_give_str"

(* ****** ****** *)

implement
main0() = let
//
#define BUFSZ 1024
val (pf, pfgc | p) = malloc_gc(i2sz(BUFSZ))
var len: size_t
val () = give_str(!p, len)
val () = println! ("new str is ", !p)
val () = println! ("new str is ", $UN.cast{string}(p))
val () = println! ("new len is ", len)
prval () = pf := strbuf2bytes_v(pf)
//
in
  mfree_gc(pf, pfgc| p)
end // end of [main0]

(* ****** ****** *)

(* end of [qa-list_62.dats] *)
