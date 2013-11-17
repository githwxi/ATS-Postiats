(* ****** ****** *)
//
// HX-2013-10-28(start)
//
// A shared buffer implementation
//
(* ****** ****** *)
//
// HX: linear buffer
//
absvtype
buffer_vtype (a:vt@ype+, m:int, n: int) = ptr
//
vtypedef
buffer (a:vt0p) = [m,n:int] buffer_vtype (a, m, n)
vtypedef
buffer (a:vt0p, m:int, n:int) = buffer_vtype (a, m, n)
//
(* ****** ****** *)

praxi
lemma_buffer_param{a:vt0p}
  {m,n:int}(!buffer (INV(a), m, n)): [m >= n; n >= 0] void
// end of [lemma_buffer_param]

(* ****** ****** *)

fun{a:vt0p}
buffer_make_nil{m:pos} (cap: int m): buffer (a, m, 0)

(* ****** ****** *)

fun buffer_isnil{a:vt0p}
  {m,n:int} (!buffer (INV(a), m, n)): bool (n==0)
fun buffer_isful{a:vt0p}
  {m,n:int} (!buffer (INV(a), m, n)): bool (m==n)

(* ****** ****** *)
//
fun{a:vt0p}
buffer_insert{m,n:int | n < m}
(
  !buffer (INV(a), m, n) >> buffer (a, m, n+1), x: a
) : void // end of [buffer_insert]
fun{a:vt0p}
buffer_takeout{m,n:int | n > 0}
  (buf: !buffer (INV(a), m, n) >> buffer (a, m, n-1)): (a)
//
(* ****** ****** *)
//
// HX: shared buffer
//
abstype
sbuffer_type (a:vt@ype) = ptr
//
typedef sbuffer (a:vt0p) = sbuffer_type (a)
//
(* ****** ****** *)

fun{a:vt0p}
sbuffer_make_buffer (buffer(a)): sbuffer (a)

(* ****** ****** *)
//
fun{a:vt0p}
sbuffer_insert (sbuffer(a), x: a): void // called by producer
fun{a:vt0p}
sbuffer_takeout (sbuf: sbuffer(a)): (a) // called by consumer
//
(* ****** ****** *)

(* end of [sbuffer.sats] *)
