(*
** Channels
*)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/SATS/athread.sats"  
//  
(* ****** ****** *)
//
absvtype
queue_vtype
  (a:vt@ype+, int(*id*)) = ptr
//
vtypedef
queue(a:vt0p, id:int) = queue_vtype(a, id)
vtypedef queue(a:vt0p) = [id:int] queue(a, id)
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_make (cap: intGt(0)): queue(a)
//
extern
fun
{a:vt0p}
queue_free_exn (que: queue(a)): void
//
(* ****** ****** *)
//
absprop ISNIL(id:int, b:bool)
absprop ISFUL(id:int, b:bool)
//
extern
fun
{a:vt0p}
queue_isnil{id:int}
(
  que: !queue(a, id)
) : [b:bool] (ISNIL(id, b) | bool(b))
extern
fun
{a:vt0p}
queue_isful{id:int}
(
  que: !queue(a, id)
) : [b:bool] (ISFUL(id, b) | bool(b))
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_insert
  {id:int}
(
  ISFUL(id, false)
| xs: !queue(a, id) >> queue(a, id2), x: a
) : #[id2:int] void
//
extern
fun
{a:vt0p}
queue_remove
  {id:int}
(
  ISNIL(id, false) | xs: !queue(a, id) >> queue(a, id2)
) : #[id2:int] a // end-of-fun
//
(* ****** ****** *)

local
//
staload
"libats/SATS/deqarray.sats"
//
assume
queue_vtype
  (a:vt0p, id:int) = deqarray(a)
//
assume ISNIL(id:int, b:bool) = unit_p
assume ISFUL(id:int, b:bool) = unit_p
//
in (* in-of-local *)
//
implement
{a}(*tmp*)
queue_make(cap) =
  deqarray_make_cap(i2sz(cap))
//
implement
{a}(*tmp*)
queue_free_exn
  (que) = let
//
val () =
assertloc(deqarray_is_nil(que))
//
in
  deqarray_free_nil(que)
end // end of [queue_free_exn]
//
implement
{a}(*tmp*)
queue_isnil(xs) = (unit_p() | deqarray_is_nil(xs))
//
implement
{a}(*tmp*)
queue_isful(xs) = (unit_p() | deqarray_is_full(xs))
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_insert
  (pf | xs, x0) =
{
//
prval () =
__assert (pf) where
{
  extern
  praxi
  __assert
    {id:int}
  (
    pf: ISFUL(id, false)
  ) : [false] void
} (* end of [prval] *)
//
val () =
  deqarray_insert_atend<a> (xs, x0)
//
} (* end of [queue_insert] *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_remove
  (pf | xs) = let
//
prval () =
__assert (pf) where
{
  extern
  praxi
  __assert
    {id:int}
  (
    pf: ISNIL(id, false)
  ) : [false] void
} (* end of [prval] *)
//
in
  deqarray_takeout_atbeg<a> (xs)
end (* end of [queue_remove] *)
//
end // end of [local]

(* ****** ****** *)
//
absvtype
uchan_vtype(a:vt@ype) = ptr
vtypedef
uchan(a:vt0p) = uchan_vtype(a)
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
uchan_make(cap: intGt(0)): uchan(a)
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
uchan_ref
  (ch: !uchan(a)): uchan(a)
//
extern
fun
{a:vt0p}
uchan_unref(ch: uchan(a)): void
//
(* ****** ****** *)

extern
fun{}
uchan_rfcnt{a:vt0p}(ch: !uchan(a)): intGt(0)

(* ****** ****** *)

extern
fun{a:vt0p}
uchan_insert (!uchan(a), a): void
extern
fun{a:vt0p}
uchan_remove (chan: &uchan(a) >> _): (a)

(* ****** ****** *)
//
extern
fun{a:vt0p}
uchan_qinsert
  (ch0: !uchan(a), chx: uchan(a)): void
//
(* ****** ****** *)
//
datavtype
uchan_ =
{
l0,l1,l2,l3:agz
} UCHAN of
@{
  cap=intGt(0)
//
, rfcnt=intGt(0) // by spin
//
, queue=ptr(*deque*) // by mutex
, qnext=ptr(*uchan*) // by mutex
//
, spin=spin_vt(l0)
, mutex=mutex_vt(l1)
, CVisnil=condvar_vt(l2)
, CVisful=condvar_vt(l3)
//
} (* end of [uchan_] *)
//
(* ****** ****** *)

assume
uchan_vtype(a:vt0p) = uchan_

(* ****** ****** *)

implement
{a}(*tmp*)
uchan_make
  (cap) = let
//
extern
praxi __assert(): [l:agz] void
//
prval [l0:addr] () = __assert()
prval [l1:addr] () = __assert()
prval [l2:addr] () = __assert()
prval [l3:addr] () = __assert()
//
val chan = UCHAN{l0,l1,l2,l3}(_)
//
val+UCHAN(ch) = chan
//
val () = ch.cap := cap
val () = ch.rfcnt := 1
//
val q0 = queue_make<a>(cap)
val () = ch.queue := $UN.castvwtp0{ptr}(q0)
//
val () = ch.qnext := the_null_ptr
//
local
val x = spin_create_exn()
in(*in-of-local*)
val () = ch.spin := unsafe_spin_t2vt(x)
end // end of [local]
//
local
val x = mutex_create_exn()
in(*in-of-local*)
val () = ch.mutex := unsafe_mutex_t2vt(x)
end // end of [local]
//
local
val x = condvar_create_exn()
in(*in-of-local*)
val () = ch.CVisnil := unsafe_condvar_t2vt(x)
end // end of [local]
//
local
val x = condvar_create_exn()
in(*in-of-local*)
val () = ch.CVisful := unsafe_condvar_t2vt(x)
end // end of [local]
//
in
  fold@(chan); chan
end // end of [uchan_make]

(* ****** ****** *)

implement
{a}(*tmp*)
uchan_ref
  (chan) = let
//
val@UCHAN(ch) = chan
//
val spin =
  unsafe_spin_vt2t(ch.spin)
//
val
(pf | ()) = spin_lock (spin)
val () = ch.rfcnt := ch.rfcnt + 1
val ((*void*)) = spin_unlock (pf | spin)
//
prval ((*fold*)) = fold@(chan)
//
in
  $UN.castvwtp1{uchan(a)}(chan)
end // end of [uchan_ref]

(* ****** ****** *)

implement
{a}(*tmp*)
uchan_unref
  (chan) = let
//
val@UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val spin =
  unsafe_spin_vt2t(ch.spin)
//
val
(pf | ()) = spin_lock (spin)
val rfcnt = ch.rfcnt
val ((*void*)) = spin_unlock (pf | spin)
//
in (* in-of-let *)
//
if
rfcnt <= 1
then let
  val que =
    $UN.castvwtp0{queue(a)}(ch.queue)
  // end of [val]
  val qnxt = ch.qnext
//
  val ((*freed*)) = queue_free_exn (que)
  val ((*freed*)) = spin_vt_destroy(ch.spin)
  val ((*freed*)) = mutex_vt_destroy(ch.mutex)
  val ((*freed*)) = condvar_vt_destroy(ch.CVisnil)
  val ((*freed*)) = condvar_vt_destroy(ch.CVisful)
  val ((*freed*)) = free@{l0,l1,l2,l3}(chan)
//
  val ((*freed*)) =
  if qnxt > 0
     then uchan_unref($UN.castvwtp0{uchan(a)}(qnxt))
  // end of [if]
//
in
  // nothing
end // end of [then]
else let
  val () = ch.rfcnt := rfcnt - 1
  prval ((*fold*)) = fold@(chan)
  prval ((*freed*)) = $UN.cast2void(chan)
in
  // nothing
end // end of [else]
//
end // end of [uchan_unref]

(* ****** ****** *)

implement
{}(*tmp*)
uchan_rfcnt
  {a}(chan) = let
//
val@UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val rfcnt = ch.rfcnt
//
in
  fold@(chan); rfcnt
end // end of [uchan_rfcnt]

(* ****** ****** *)
//
extern
fun{a:vt0p}
uchan_insert2
  (!uchan(a), queue(a), a): void
//
(* ****** ****** *)

implement
{a}(*tmp*)
uchan_insert
  (chan, x0) = let
//
val+UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val
mutex = unsafe_mutex_vt2t(ch.mutex)
//
val (pfmut | ()) = mutex_lock (mutex)
//
val xs =
  $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
//
val ((*void*)) = uchan_insert2<a> (chan, xs, x0)
//
in
  // nothing
end // end of [uchan_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
uchan_insert2
  (chan, xs, x0) = let
//
val+UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val
mutex = unsafe_mutex_vt2t(ch.mutex)
//
val (pf | isful) = queue_isful (xs)
//
in
//
if
isful
then let
  prval
  (pfmut, fpf) =
  __assert () where
  {
    extern
    praxi __assert (): vtakeout0(locked_v(l1))
  } (* end of [prval] *)
  val
  CVisful = unsafe_condvar_vt2t(ch.CVisful)
  val () = condvar_wait (pfmut | CVisful, mutex)
  prval ((*ret*)) = fpf (pfmut)
in
  uchan_insert2 (chan, xs, x0)
end // end of [then]
else let
  val
  isnil = queue_isnil (xs)
  val () = queue_insert (pf | xs, x0)
  val () =
  if isnil.1
    then condvar_broadcast(unsafe_condvar_vt2t(ch.CVisnil))
  // end of [if]
  val ((*void*)) =
  mutex_unlock ($UN.castview0{locked_v(l1)}(xs) | mutex)
//
in
  // nothing
end // end of [else]
//
end // end of [uchan_insert2]

(* ****** ****** *)
//
extern
fun{a:vt0p}
uchan_remove2
  (chan: &uchan(a) >> _, queue(a)): (a)
//
(* ****** ****** *)

implement
{a}(*tmp*)
uchan_remove
  (chan) = let
//
val+UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val
mutex = unsafe_mutex_vt2t(ch.mutex)
//
val (pfmut | ()) = mutex_lock (mutex)
//
val xs =
  $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
//
in
  uchan_remove2<a> (chan, xs)
end // end of [uchan_remove]

(* ****** ****** *)

implement
{a}(*tmp*)
uchan_remove2
  (chan, xs) = let
//
val+@UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val
mutex = unsafe_mutex_vt2t(ch.mutex)
//
macdef
queue_unlock_mac(xs) =
mutex_unlock
  ($UN.castview0{locked_v(l1)}(,(xs)) | mutex)
//
val (pf | isnil) = queue_isnil (xs)
//
in
//
if
isnil
then let
  val qnxt = ch.qnext
in
  if qnxt > 0
    then let
      val () =
      ch.qnext := the_null_ptr
      val () = queue_unlock_mac(xs)
      prval ((*fold*)) = fold@chan
      val () = uchan_unref (chan)
      val () =
      chan := $UN.castvwtp0{uchan(a)}(qnxt)
    in
      uchan_remove (chan)
    end (* end of [then] *)
    else let
      prval
      (pfmut, fpf) =
      __assert () where
      {
        extern
        praxi __assert (): vtakeout0(locked_v(l1))
      } (* end of [prval] *)
      val CVisnil = unsafe_condvar_vt2t(ch.CVisnil)
      val ((*void*)) = condvar_wait (pfmut | CVisnil, mutex)
      prval ((*ret*)) = fpf (pfmut)
      prval ((*fold*)) = fold@chan
    in
      uchan_remove2 (chan, xs)
    end // end of [else]
  // end of [if]
end // end of [then]
else let
  val isful = queue_isful (xs)
  val x0_out = queue_remove (pf | xs)
  val () =
  if isful.1
    then condvar_broadcast(unsafe_condvar_vt2t(ch.CVisful))
  // end of [if]
  val () = queue_unlock_mac(xs)
  prval ((*fold*)) = fold@chan
in
  x0_out
end // end of [else]
//
end // end of [uchan_remove2]

(* ****** ****** *)
//
extern
fun{a:vt0p}
qnext_insert
  (chx0: &ptr >> _, chx: uchan(a)): void
//
extern
fun{a:vt0p}
uchan_qinsert2
  (!uchan(a), queue(a), uchan(a)): void
//
(* ****** ****** *)

implement
{a}(*tmp*)
uchan_qinsert
  (chan, chx) = let
//
val+UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val
mutex = unsafe_mutex_vt2t(ch.mutex)
//
val (pfmut | ()) = mutex_lock (mutex)
//
val xs = $UN.castvwtp0{queue(a)}((pfmut | ch.queue))
//
val ((*void*)) = uchan_qinsert2<a> (chan, xs, chx)
//
in
  // nothing
end // end of [uchan_qinsert]

(* ****** ****** *)

implement
{a}(*tmp*)
qnext_insert
  (chx0, chx) = let
in
//
if
chx0 = 0
then (
  chx0 := $UN.castvwtp0{ptr}(chx)
) // end of [then]
else let
//
val chan =
$UN.castvwtp0{uchan(a)}(chx0)
val ((*void*)) = uchan_qinsert (chan, chx)
prval ((*void*)) = $UN.cast2void(chan)
//
in
  // nothing
end // end of [else]
//
end // end of [qnext_insert]

(* ****** ****** *)

implement
{a}(*tmp*)
uchan_qinsert2
  (chan, xs, chx) = let
//
val+@UCHAN
  {l0,l1,l2,l3}(ch) = chan
//
val
mutex = unsafe_mutex_vt2t(ch.mutex)
//
val isnil = queue_isnil (xs)
//
val () = qnext_insert (ch.qnext, chx)
//
val () =
if isnil.1
  then condvar_broadcast(unsafe_condvar_vt2t(ch.CVisnil))
// end of [if]
//
prval ((*fold*)) = fold@chan
//
in
  mutex_unlock($UN.castview0{locked_v(l1)}(xs) | mutex)
end // end of [uchan_qinsert2]

(* ****** ****** *)

(* end of [basis_uchan.dats] *)
