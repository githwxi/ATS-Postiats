//
// HX-2013-10
//

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "./../SATS/fileAsLock.sats"
staload _ = "./../DATS/fileAsLock.dats"

(* ****** ****** *)

extern fun randsleep1 (): void
extern fun randsleep2 (): void

(* ****** ****** *)

implement
randsleep1 (
) = ignoret(sleep($UN.cast{uInt}((rand() mod 5) + 1)))
implement
randsleep2 (
) = ignoret(sleep($UN.cast{uInt}((rand() mod 5) + 5)))

(* ****** ****** *)

fun testlock () = let
//
val lock =
  lock_create ("myFileAsLock")
//
fun loop
(
  lock: lock, N: int, i: int
) : int =
(
if i < N then let
  var err: int = 0
  val ans = lock_acquire (lock)
in
  case+ ans of
  | 0 => let
      val () =
        println! ("Process ", $UN.cast{lint}(getpid()), " missed the lock")
      val () = randsleep2 ()
    in
      loop (lock, N, i+1)
    end // end of [ans = 0]
  | 1 => let
      val () =
        println! ("Process ", $UN.cast{lint}(getpid()), " acquired the lock")
      val () = randsleep1 ()
      val ans = lock_release (lock)
      val () = randsleep2 ()
      val () = if ans < 0 then (err := err + 1)
    in
      if err = 0 then loop (lock, N, i+1) else err
    end // end of [ans = 1]
  | _(*~1*) => let
      val () = err := err + 1
      val () =
        println! ("Process ", $UN.cast{lint}(getpid()), " encountered error")
      // end of [val]
    in
      err
    end // end of [-1]
end else 0(*error-free*)
)
//
val err = loop (lock, 5, 0)
//
in
  // nothing
end // end of [testlock]

(* ****** ****** *)

implement main0 () = testlock ()

(* ****** ****** *)

(* end of [testlock.dats] *)
