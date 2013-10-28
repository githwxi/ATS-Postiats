//
(* ****** ****** *)
//
// HX-2013-10-22
//
// Implementing
// the produce/consume problem
//
(* ****** ****** *)
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

extern
praxi
lemma_buffer_param{a:vt0p}
  {m,n:int}(!buffer (INV(a), m, n)): [m >= n; n > 0] void
// end of [lemma_buffer_param]

(* ****** ****** *)

extern
fun buffer_isnil{a:vt0p}
  {m,n:int} (!buffer (INV(a), m, n)): bool (n==0)
extern
fun buffer_isful{a:vt0p}
  {m,n:int} (!buffer (INV(a), m, n)): bool (m==n)

(* ****** ****** *)
//
extern
fun{a:vt0p}
buffer_insert{m,n:int | n < m}
(
  !buffer (INV(a), m, n) >> buffer (a, m, n+1), x: a
) : void // end of [buffer_insert]
//
extern
fun{a:vt0p}
buffer_takeout{m,n:int | n > 0}
  (buf: !buffer (INV(a), m, n) >> buffer (a, m, n-1)): (a)
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
buffer_insert2
  (!buffer (INV(a)) >> _, x: a): void
//
extern
fun{a:vt0p}
buffer_takeout2 (buf: !buffer (INV(a)) >> _): a
//
(* ****** ****** *)

extern
fun
buffer_condwait_isnil
  {a:vt0p}{m:int} (!buffer (INV(a), m, 0) >> buffer (a)): void
// end of [buffer_condwait_isnil]
extern
fun
buffer_condwait_isful
  {a:vt0p}{m:int} (!buffer (INV(a), m, m) >> buffer (a)): void
// end of [buffer_condwait_isful]

(* ****** ****** *)

implement{a}
buffer_insert2
  (buf, x) = let
//
val isful = buffer_isful (buf)
prval () = lemma_buffer_param (buf)
//
in
//
if isful then let
  val () = buffer_condwait_isful (buf) in buffer_insert2 (buf, x)
end else buffer_insert (buf, x)
//  
end // end of [buffer_insert2]

(* ****** ****** *)

implement{a}
buffer_takeout2
  (buf) = let
//
val isnil = buffer_isnil (buf)
prval () = lemma_buffer_param (buf)
//
in
//
if isnil then let
  val () = buffer_condwait_isnil (buf) in buffer_takeout2 (buf)
end else buffer_takeout (buf)
//  
end // end of [buffer_takeout2]

(* ****** ****** *)
//
// HX: shared buffer
//
abstype
sbuffer_type (a:vt@ype+) = ptr
//
typedef sbuffer (a:vt0p) = sbuffer_type (a)
//
(* ****** ****** *)
//
// HX: locking/unlocking a shared buffer
//
extern
fun sbuffer_acquire{a:vt0p} (sbuffer(INV(a))): buffer (a)
extern
fun sbuffer_release{a:vt0p} (sbuffer(INV(a)), buffer(a)): void
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
<<<<<<< HEAD
sbuffer_insert (sbuffer(INV(a)), x: a): void
extern
fun{a:vt0p}
sbuffer_takeout (sbuf: sbuffer(INV(a))): (a)
=======
sbuffer_insert (sbuffer(a), x: a): void
extern
fun{a:vt0p}
sbuffer_takeout (sbuf: sbuffer(a)): (a)
>>>>>>> 8ae9efe5ce65e8ea8654a99141de887e5656b037
//
(* ****** ****** *)

implement{a}
sbuffer_insert (sbuf, x) =
{
  val buf = sbuffer_acquire (sbuf)
  val ((*void*)) = buffer_insert2 (buf, x)
  val ((*void*)) = sbuffer_release (sbuf, buf)
}

implement{a}
sbuffer_takeout (sbuf) = x where
{
  val buf = sbuffer_acquire (sbuf)
  val x(*a*) = buffer_takeout2 (buf)
  val ((*void*)) = sbuffer_release (sbuf, buf)
}

(* ****** ****** *)

(* end of [produce-consume.dats] *)
