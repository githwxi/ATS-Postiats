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
UN =
"prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
AT =
"libats/SATS/athread.sats"
//
typedef tid = $AT.tid
typedef spin1 = $AT.spin1
//
(* ****** ****** *)
//
abstype
fworkshop_type = ptr
typedef
fworkshop = fworkshop_type

abstype
fws$store_type = ptr
typedef
fws$store = fws$store_type
//
(* ****** ****** *)
//
absvtype
fws$fwork_vtype = ptr
vtypedef
fws$fwork = fws$fwork_vtype
//
(* ****** ****** *)

vtypedef
fworkshop_struct =
@{
//
FWS_spin= spin1
//
,
FWS_store= fws$store
,
FWS_workerlst= List0_vt(tid)
//
} (* end of [fworkshop_struct] *)

(* ****** ****** *)
//
extern
fun{}
fworkshop_create_exn(): fworkshop
extern
fun{}
fws$store_create_exn(): fws$store
//
(* ****** ****** *)
//
extern
fun{}
fworkshop_add_tid
  (fws: fworkshop, tid): void
//
(* ****** ****** *)
//
extern
fun{}
fworkshop_get_store
  (fws: fworkshop): fws$store
//
(* ****** ****** *)
//
extern
fun{}
fworkshop_get_nworker
  (fws: fworkshop): intGte(0)
//
(* ****** ****** *)
//
extern
fun{}
fworkshop_takeout_work
  (fws: fworkshop): fws$fwork
extern
fun{}
fworkshop_process_work
  (fws: fworkshop, fwork: fws$fwork): int
//
(* ****** ****** *)
//
extern
fun{}
fworkshop_add_worker
  (fws: fworkshop): int(*err*)
extern
fun{}
fworkshop_add_nworker
  {n:nat}
  (fws: fworkshop, int(n)): natLte(n)
//
(* ****** ****** *)

local
//
assume
fworkshop_type = ref(fworkshop_struct)
//
in (* in-of-local *)

(* ****** ****** *)

implement
{}(*tmp*)
fworkshop_create_exn
  ((*void*)) = let
//
val (
pf, fpf | p0
) = ptr_alloc<fworkshop_struct>()
//
val () =
p0->FWS_spin := $AT.spin_create_exn()
val () =
p0->FWS_store := fws$store_create_exn<>()
val () =
p0->FWS_workerlst := list_vt_nil((*void*))
//
in
  $UN.castvwtp0{fworkshop}((pf, fpf | p0))
end // end of [fworkshop_create_exn]

(* ****** ****** *)

implement
{}(*tmp*)
fworkshop_add_tid
  (fws, tid) = let
//
val (
  vbox pf | p
) = ref_get_viewptr(fws)
//
val spn = p->FWS_spin
val (
  pflock | ()
) = $AT.spin_lock(spn)
val tids = p->FWS_workerlst
val ((*void*)) =
  p->FWS_workerlst := list_vt_cons(tid, tids)
//
val ((*void*)) = $AT.spin_unlock(pflock | spn)
//
in
  // nothing
end (* end of [fworkshop_add_tid] *)

(* ****** ****** *)

implement
{}(*tmp*)
fworkshop_get_store
  (fws) = let
//
val (
  vbox pf | p
) = ref_get_viewptr(fws) in p->FWS_store
//
end // end of [fworkshop_get_store]

(* ****** ****** *)

implement
{}(*tmp*)
fworkshop_get_nworker
  (fws) = let
//
val (
  vbox pf | p
) = ref_get_viewptr(fws)
//
val spn = p->FWS_spin
val (
  pflock | ()
) = $AT.spin_lock (spn)
val nworker = list_vt_length(p->FWS_workerlst)
val ((*void*)) = $AT.spin_unlock(pflock | spn)
//
in
  nworker
end (* end of [fworkshop_get_nworker] *)

(* ****** ****** *)

implement
{}(*tmp*)
fworkshop_add_worker
  (ws) = err where
{
//
fun
fworker
(
  fws: fworkshop
) : void = let
//
val fwork =
  fworkshop_takeout_work(fws)
val status =
  fworkshop_process_work(fws, fwork)
//
in
  if status >= 0 then fworker(fws) else ((*exit*))
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
if (err = 0) then fworkshop_add_tid(ws, tid)
//
} // end of [fworkshop_add_worker]

(* ****** ****** *)

implement
{}(*tmp*)
fworkshop_add_nworker
  {n}(fws, n) =
  loop(0, 0) where
{  
//
fun
loop
{i:nat | i <= n}
(
 i: int(i), res: natLte(i)
) : natLte(n) = let
in
//
if
i < n
then let
//
val
err = fworkshop_add_worker<>(fws)
//
in
//
if err = 0
  then loop(i + 1, res + 1) else res
// end of [if]
//
end // end of [then]
else res // end of [else]
//
end // end of [loop]
//
} (* end of [fworkshop_add_nworker] *)

(* ****** ****** *)

end // end of [local]

////  
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

(* end of [fworkshop.dats] *)
