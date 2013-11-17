(* ****** ****** *)
//
// HX-2013-10-28(start)
//
// A shared buffer implementation
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "./sbuffer.sats"

(* ****** ****** *)
//
// HX: locking/unlocking a shared buffer
//
extern
fun sbuffer_acquire{a:vt0p} (sbuf: sbuffer(a)): buffer (a)
extern
fun sbuffer_release{a:vt0p} (sbuf: sbuffer(a), buf: buffer(a)): void
//
(* ****** ****** *)
//
extern
fun{a:vt0p}
sbuffer_insert2 (sbuffer(a), !buffer(INV(a)) >> _, x: a): void
extern
fun{a:vt0p}
sbuffer_takeout2 (sbf: sbuffer(a), buf: !buffer (INV(a)) >> _): (a)
//
(* ****** ****** *)

implement{a}
sbuffer_insert (sbuf, x) =
{
  val buf = sbuffer_acquire (sbuf)
  val ((*void*)) = sbuffer_insert2 (sbuf, buf, x)
  val ((*void*)) = sbuffer_release (sbuf, buf)
}

implement{a}
sbuffer_takeout (sbuf) = x where
{
  val buf = sbuffer_acquire (sbuf)
  val x(*a*) = sbuffer_takeout2 (sbuf, buf)
  val ((*void*)) = sbuffer_release (sbuf, buf)
}

(* ****** ****** *)
//
extern
fun
sbuffer_cond_wait_isnil
  {a:vt0p}{m:int} (sbuffer(a), !buffer(a, m, 0) >> buffer(a)): void
extern
fun sbuffer_cond_signal_isnil{a:vt0p}{m,n:int} (sbuf: sbuffer(a)): void
//
extern
fun
sbuffer_cond_wait_isful
  {a:vt0p}{m:int} (sbuffer(a), !buffer(a, m, m) >> buffer(a)): void
extern
fun sbuffer_cond_signal_isful{a:vt0p}{m,n:int} (sbuf: sbuffer(a)): void
//
(* ****** ****** *)

implement{a}
sbuffer_insert2
  (sbuf, buf, x) = let
//
val isful = buffer_isful (buf)
//
prval () = lemma_buffer_param (buf)
//
in
//
if isful
  then let
    val () =
      sbuffer_cond_wait_isful (sbuf, buf)
    // end of [val]
  in
    sbuffer_insert2 (sbuf, buf, x)
  end // end of [then]
  else let
    val isnil = buffer_isnil (buf)
    val ((*void*)) = buffer_insert (buf, x)
    val ((*void*)) = if isnil then sbuffer_cond_signal_isnil (sbuf)
  in
    // nothing
  end // end of [else]
//  
end // end of [sbuffer_insert2]

(* ****** ****** *)

implement{a}
sbuffer_takeout2
  (sbuf, buf) = let
//
val isnil = buffer_isnil (buf)
prval () = lemma_buffer_param (buf)
//
in
//
if isnil
  then let
    val () =
      sbuffer_cond_wait_isnil (sbuf, buf)
    // end of [val]
  in
    sbuffer_takeout2 (sbuf, buf)
  end // end of [then]
  else x where
  {
    val isful = buffer_isful (buf)
    val x(*a*) = buffer_takeout (buf)
    val ((*void*)) = if isful then sbuffer_cond_signal_isful (sbuf)
  } (* end of [else] *)
//  
end // end of [sbuffer_takeout2]

(* ****** ****** *)

local
//
staload UN = "prelude/SATS/unsafe.sats"
//
staload T =
  "{$LIBATSHWXI}/teaching/mythread/SATS/mythread.sats"
//
datatype
sbuffer =
{l1,l2,l3:agz}
SBUFFER of (ptr(*buffer*), $T.mutex(l1), $T.condvar(l2), $T.condvar(l3))
//
assume sbuffer_type (a:vt0ype) = sbuffer
//
in (* in of [local] *)

(* ****** ****** *)

implement
sbuffer_acquire{a}(sbuf) = let
//
val+SBUFFER (buf, mut, _, _) = sbuf
val (pfmut | ()) = $T.mutex_lock (mut)
//
in
  $UN.castvwtp0{buffer(a)}((pfmut | buf))
end // end of [sbuffer_acquire]

implement
sbuffer_release{a}(sbuf, buf) = let
//
val+SBUFFER{l1,l2,l3}(_, mut, _, _) = sbuf
prval pfmut = $UN.castview0{$T.mutex_v(l1)}(buf)
val ((*void*)) = $T.mutex_unlock (pfmut | mut)
//
in
  // nothing
end // end of [sbuffer_release]

(* ****** ****** *)

implement
sbuffer_cond_wait_isnil
  (sbuf, buf) = let
//
val+SBUFFER{l1,l2,l3}(_, mut, cvr, _) = sbuf
prval (pfmut, fpf) = __assert () where
{
  extern praxi __assert (): vtakeout0($T.mutex_v(l1))
}
val ((*void*)) = $T.condvar_wait (pfmut | cvr, mut)
prval ((*void*)) = fpf (pfmut)
//
in
  // nothing
end // end of [sbuffer_cond_wait_isnil]

implement
sbuffer_cond_signal_isnil
  (sbuf) = let
//
val+SBUFFER(_, mut, cvr, _) = sbuf
//
in
  $T.condvar_signal (cvr)
end // end of [sbuffer_cond_signal_isnil]

(* ****** ****** *)

implement
sbuffer_cond_wait_isful
  (sbuf, buf) = let
//
val+SBUFFER{l1,l2,l3}(_, mut, _, cvr) = sbuf
prval (pfmut, fpf) = __assert () where
{
  extern praxi __assert (): vtakeout0($T.mutex_v(l1))
}
val ((*void*)) = $T.condvar_wait (pfmut | cvr, mut)
prval ((*void*)) = fpf (pfmut)
//
in
  // nothing
end // end of [sbuffer_cond_wait_isful]

implement
sbuffer_cond_signal_isful
  (sbuf) = let
//
val+SBUFFER(_, mut, cvr, _) = sbuf
//
in
  $T.condvar_signal (cvr)
end // end of [sbuffer_cond_signal_isful]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [sbuffer.dats] *)
