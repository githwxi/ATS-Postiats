(*
** for testing
** [libats/libc/signal]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = $UNSAFE // aliasing
//
(* ****** ****** *)

staload "libats/libc/SATS/signal.sats"
staload "libats/libc/SATS/unistd.sats"

(* ****** ****** *)

implement
main0 () = () where
{
//
(*
//
// HX-2014-04-07: this one does not work:
//
val err = signal
(
  SIGALRM
, sighandler(lam (sgn) => println! ("SIGALRM: sgn = ", $UN.cast2int(sgn)))
) (* end of [val] *)
*)
//
var sigact: sigaction
val () =
ptr_nullize<sigaction>
  (__assert () | sigact) where
{
  extern prfun __assert (): is_nullable (sigaction)
} (* end of [val] *)
val (
) = sigact.sa_handler :=
  sighandler(lam (sgn) => println! ("SIGALRM: sgn = ", $UN.cast2int(sgn)))
//
val () = assertloc (sigaction_null (SIGALRM, sigact) = 0)
//
val (pf | _) = alarm_set (2u)
//
#define BUFSZ 128
var nerr: int = 0
var buf = @[byte][BUFSZ]()
val inp =
$UN.castvwtp0{fildes(0)}(STDIN_FILENO)
val nread = read_err (inp, buf, i2sz(BUFSZ))
prval () = $UN.cast2void (inp)
//
val leftover = alarm_cancel (pf | (*void*))
//
(*
val () = println! ("nread = ", nread)
*)
//
val () =
if (nread < 0) then println! ("There is NO input available!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [libats_libc_signal.dats] *)
