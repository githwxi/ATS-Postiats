(* ****** ****** *)
//
// Generalized Processing of Shared Resources
//
(* ****** ****** *)

absvtype Resource
abstype SharedResource

(* ****** ****** *)

extern // it never blocks
fun Resource_process (R: !Resource >> _): bool
extern // it may block the caller
fun SharedResource_process (SR: SharedResource): void

(* ****** ****** *)

extern
fun SharedResource_acquire (SR: SharedResource): Resource
extern
fun SharedResource_release (SR: SharedResource, R: Resource): void

(* ****** ****** *)

extern
fun SharedResource_cond_wait
  (SR: SharedResource, R: !Resource >> _): void
extern
fun SharedResource_cond_signal (SR: SharedResource): void
extern
fun SharedResource_process2 (SR: SharedResource, R: !Resource >> _): void

(* ****** ****** *)

implement
SharedResource_process
  (SR) = () where
{
  val R = SharedResource_acquire (SR)
  val () = SharedResource_process2 (SR, R)
  val () = SharedResource_release (SR, R)
}

implement
SharedResource_process2
  (SR, R) = let
  val ans = Resource_process (R)
in
//
if ans
  then ()
  else let
    val () = SharedResource_cond_wait (SR, R)
  in
    SharedResource_process2 (SR, R)
  end // end of [else]
//
end // end of [SharedResource_process2]

(* ****** ****** *)

(* end of [SharedResource.dats] *)
