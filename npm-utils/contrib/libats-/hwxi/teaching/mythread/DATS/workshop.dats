(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** HX-2014-06-01: Start it now!
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
AT = "libats/SATS/athread.sats"
//
(* ****** ****** *)

staload "./../SATS/channel.sats"
staload "./../SATS/workshop.sats"

(* ****** ****** *)

typedef tid = $AT.tid
typedef spin1 = $AT.spin1

(* ****** ****** *)

vtypedef
workshop_struct
  (a:vt0p) =
@{
//
WS_spin= spin1
//
,
WS_chan= channel(a)
,
WS_workerlst= List0_vt(tid)
//
} (* end of [workshop_struct] *)

(* ****** ****** *)
//
extern
fun{}
workshop_add_tid
  {a:vt0p} (workshop(a), tid): void
//
(* ****** ****** *)
//
extern
fun{}
workshop_get_channel
  {a:vt0p}(workshop(a)): channel(a)
//
(* ****** ****** *)

local
//
assume
workshop_type
  (a:vt0p) = ref(workshop_struct(a))
//
in (* in-of-local *)

(* ****** ****** *)

implement
{}(*tmp*)
workshop_get_capacity
  (ws) = let
//
val (
  vbox pf | p
) = ref_get_viewptr(ws)
//
in
  channel_get_capacity(p->WS_chan)
end (* end of [workshop_get_capacity] *)

(* ****** ****** *)

implement
{}(*tmp*)
workshop_get_channel
  (ws) = let
//
  val (vbox pf | p) = ref_get_viewptr(ws) in p->WS_chan
//
end // end of [workshop_get_channel]

(* ****** ****** *)

implement
{}(*tmp*)
workshop_get_nworker
  (ws) = let
//
val (
  vbox pf | p
) = ref_get_viewptr(ws)
//
val spn = p->WS_spin
val (
  pflock | ()
) = $AT.spin_lock (spn)
val nworker = list_vt_length(p->WS_workerlst)
val ((*void*)) = $AT.spin_unlock(pflock | spn)
//
in
  nworker
end (* end of [workshop_get_nworker] *)

(* ****** ****** *)

implement
{}(*tmp*)
workshop_add_tid
  (ws, tid) = let
//
val (
  vbox pf | p
) = ref_get_viewptr (ws)
//
val spn = p->WS_spin
val (
  pflock | ()
) = $AT.spin_lock(spn)
val tids = p->WS_workerlst
val ((*void*)) =
  p->WS_workerlst := list_vt_cons(tid, tids)
//
val ((*void*)) = $AT.spin_unlock(pflock | spn)
//
in
  // nothing
end (* end of [workshop_add_tid] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)
  
implement
{a}(*tmp*)
workshop_create_cap
  (cap) = let
//
val
(
pf, fpf | p
) = ptr_alloc<workshop_struct(a)>()
//
val () =
p->WS_spin := $AT.spin_create_exn()
val () =
p->WS_chan := channel_create_exn<a>(cap)
val () =
p->WS_workerlst := list_vt_nil((*void*))
//
in
  $UN.castvwtp0{workshop(a)}((pf, fpf | p))
end // end of [workshop_create_cap]
  
(* ****** ****** *)

implement
{a}(*tmp*)
workshop_insert_job
  (ws, x) = let
//
val
chan =
workshop_get_channel<>(ws)
// end of [val]
in
  channel_insert<a>(chan, x)
end // end of [workshop_insert_job]

(* ****** ****** *)

implement
{a}(*tmp*)
workshop_takeout_job
  (ws) = let
//
val
chan =
workshop_get_channel<>(ws)
// end of [val]
in
  channel_takeout<a>(chan)
end // end of [workshop_takeout_job]

(* ****** ****** *)

implement
{a}(*tmp*)
workshop_add_worker
  (ws) = let
//
fun fworker
(
  ws: workshop(a)
) : void = let
//
val x0 = workshop_takeout_job(ws)
val status = workshop_handle_job(ws, x0)
//
in
  if status >= 0 then fworker(ws) else ((*exit*))
end // end of [fworker]
//
var tid: lint?
//
val err =
$AT.athread_create_cloptr
  (tid, llam ((*void*)) => fworker(ws))
//
val
((*void*)) =
if (err = 0) then workshop_add_tid (ws, tid)
//
in
  err
end // end of [workshop_add_worker]

(* ****** ****** *)

implement
{a}(*tmp*)
workshop_add_nworker
  {n}(ws, n) = let
//
fun
loop
(
ws: workshop(a), n: int, res: int
) : int = let
in
//
if
n > 0
then let
//
val err = workshop_add_worker<a>(ws)
//
in
  if err = 0 then loop(ws, n - 1, res + 1) else res
end // end of [then]
else res // end of [else]
//
end // end of [loop]
//
in
  $UN.cast{natLte(n)}(loop(ws, n, 0))
end // end of [workshop_add_nworker]

(* ****** ****** *)
//
// lincloptr = ((*void*)) -<lincloptr> void
//
(* ****** ****** *)
//
implement
{}(*tmp*)
workshop_handle_job_lincloptr
  (ws, job) = let
//
val () =
  $UN.castvwtp0{()-<lincloptr>void}(job)() in (0)
//
end (* end of [workshop_handle_job_lincloptr] *)
  
(* ****** ****** *)
//
implement
workshop_handle_job<lincloptr> = workshop_handle_job_lincloptr<>
//
(* ****** ****** *)
//
implement
{}(*tmp*)
workshop_insert_job_lincloptr
  (ws, job) =
  workshop_insert_job<lincloptr>(ws, $UN.castvwtp0{lincloptr}(job))
//
(* ****** ****** *)

(* end of [workshop.dats] *)
