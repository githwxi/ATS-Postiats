(* ****** ****** *)
//
// HX-2013-10-18
//
// A straightforward implementation
// of the problem of Dining Philosophers
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./DiningPhil.sats"

(* ****** ****** *)

staload "{$LIBATSHWXI}/teaching/fileAsLock/SATS/fileAsLock.sats"
staload _ = "{$LIBATSHWXI}/teaching/fileAsLock/DATS/fileAsLock.dats"

(* ****** ****** *)

assume fork_vtype = int

(* ****** ****** *)

extern
fun fork_acquire (n: int): fork
extern
fun fork_release (n: int, f: fork): void

(* ****** ****** *)

implement
phil_acquire_lfork (n) = f where
{
  val f = fork_acquire (phil_left(n))
  val () = println! ("Phil(", n, ") acquires left fork.")
}
implement
phil_acquire_rfork (n) = f where
{
  val f = fork_acquire (phil_right(n))
  val () = println! ("Phil(", n, ") acquires right fork.")
}

(* ****** ****** *)

implement
phil_release_lfork (n, f) = 
{
  val () = fork_release (phil_left(n), f)
  val () = println! ("Phil(", n, ") releases left fork.")
}
implement
phil_release_rfork (n, f) =
{
  val () = fork_release (phil_right(n), f)
  val () = println! ("Phil(", n, ") releases right fork.")
}

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

local
//
extern
fun
the_forkarr_get (
) : arrayref(int, NPHIL) = "ext#"
//
fun forkarr_takeout
  (n: natLt(NPHIL)): int = f where
{
  val A = the_forkarr_get ()
  val f = A[n]
  val ((*void*)) = if f > 0 then A[n] := 0
}
fun forkarr_addback
  (n: natLt(NPHIL), f: int): void =
{
  val A = the_forkarr_get ()
  val ((*void*)) = A[n] := (f)
}
//
val lock = lock_create ("DiningPhil_forkarr")
//
in (* in of [local] *)

(* ****** ****** *)

implement
fork_acquire (n) = let
//
val status = lock_acquire (lock)
//
in
//
if status > 0 then let
  val n =
    $UN.cast{natLt(NPHIL)}(n)
  val f = forkarr_takeout (n)
  val _(*err*) = lock_release (lock)
in
  if f > 0
    then (f)
    else (randsleep (1); fork_acquire (n))
  // end of [if]
end else (randsleep (1); fork_acquire (n))
//
end // end of [fork_acquire]

(* ****** ****** *)

implement
fork_release (n, f) = let
//
val status = lock_acquire (lock)
//
in
//
if status > 0 then let
  val n =
    $UN.cast{natLt(NPHIL)}(n)
  val () = forkarr_addback (n, f)
  val _(*err*) = lock_release (lock)
in
  // nothing
end else
  (randsleep (1); fork_release (n, f))
//
end // end of [fork_release]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [DininigPhil_fork.dats] *)
