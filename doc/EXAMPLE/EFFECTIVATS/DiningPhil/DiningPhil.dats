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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/fcntl.sats"
staload "libc/SATS/unistd.sats"
staload "libc/SATS/stdlib.sats"
staload "libc/sys/SATS/stat.sats"
staload "libc/sys/SATS/types.sats"
staload "libc/sys/SATS/mman.sats"

(* ****** ****** *)

staload "./DiningPhil.sats"

(* ****** ****** *)

implement phil_left (n) = n
implement phil_right (n) = (n+1) mod NPHIL

(* ****** ****** *)

implement
randsleep (n) =
  ignoret (sleep($UN.cast{uInt}(rand() mod n + 1)))
// end of [randsleep]

(* ****** ****** *)

staload "{$LIBATSHWXI}/teaching/fileAsLock/SATS/fileAsLock.sats"
staload _ = "{$LIBATSHWXI}/teaching/fileAsLock/DATS/fileAsLock.dats"

(* ****** ****** *)

extern
fun phil_loop2 (n: phil): void
extern
fun phil_initiate (ntot: int): void

(* ****** ****** *)

local

val lock = lock_create ("DiningPhil_init")

in (* in of [local] *)

implement
phil_loop (n) = let
  val pid = getpid ()
  val () = srand ($UN.cast2uint(pid))
  val status = lock_acquire (lock)
in
//
if status > 0
  then let
    val err =
      lock_release (lock) in phil_loop2 (n)
    // end of [val]
  end // end of [then]
  else let
    val _(*left*) = sleep (1) in phil_loop (n)
  end // end of [else]
//
end // end of [phil_loop]

implement
phil_initiate (ntot) = let
//
fun loop
(
  i: int
) : int = let
in
//
if i < ntot then let
//
val pid = fork ()
val pid = $UN.cast2lint(pid)
//
in
//
case+ 0 of
| _ when pid = 0 => let
    val () = phil_loop (i)
  in
    (_Exit (0); ~1)
  end // end of [loop]
| _ when pid > 0 => let
    val () = println! ("Parent: forked child: ", pid)
  in
    loop (i+1)
  end // end of [pid > 0]
| _ (*error*) => i
//
end else ntot // end of [if]
//
end // end of [loop]
//
val status = lock_acquire (lock)
val () = assertloc (status > 0)
//
val n = loop (0)
val () = println! ("Initiation: ", n, " phils are added.")
//
val err(*int*) = lock_release (lock)
//
in
  // nothing
end // end of [phil_initiate]

end // end of [local]

(* ****** ****** *)

implement
phil_loop2 (n) = let
  val () = phil_think (n)
  val ((*void*)) = phil_dine (n)
in
  phil_loop2 (n)
end // end of [phil_loop2]

(* ****** ****** *)
//
(*
dynload "DiningPhil.sats"
*)
dynload "DiningPhil_fork.dats"
//
(* ****** ****** *)

extern
fun the_forkarr_get (): arrayref(int, NPHIL) = "ext#"

(* ****** ****** *)

%{^
typedef int forkarr_t[NPHIL] ;
%}
typedef
forkarr = $extype"forkarr_t"
//
val theForkArr_ref = ref<ptr> (the_null_ptr)
//
implement
the_forkarr_get () =
  $UN.cast{arrayref(int,NPHIL)}(!theForkArr_ref)
//
fun
the_forkarr_init () = let
  val A = the_forkarr_get ()
  fun loop (i: natLte (NPHIL)): void =
    if i < NPHIL then (A[i] := 1; loop (succ(i))) else ()
  // end of [loop]
in
  loop (0)
end // end of [the_forkarr_init ()]
//
(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val p0 = $extfcall
(
  ptr, "mmap", 0(*null*), sizeof<forkarr>
, PROT_READ lor PROT_WRITE, MAP_SHARED lor MAP_ANONYMOUS, ~1(*fd*), 0(*ofs*)
) (* end of [val] *)
val () = assertloc (p0 != $extval (ptr, "MAP_FAILED"))
//
val () = !theForkArr_ref := p0
//
val () = the_forkarr_init ()
//
val () = phil_initiate (NPHIL)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [DiningPhil.dats] *)
