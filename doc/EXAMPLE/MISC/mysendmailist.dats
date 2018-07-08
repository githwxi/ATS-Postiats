(* ****** ****** *)
//
// HX-2015-03-05:
// For sending a message
// to a list of email addresses
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
STDLIB = "libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)
//
%{^
typedef char *charptr;
%} (* %{^ *)
abstype charptr = $extype"charptr"
//
(* ****** ****** *)
//
extern
fun{} theFrom_get(): charptr
extern
fun{} theSubject_get(): charptr
extern
fun{} theOtherOpt_get(): charptr
extern
fun{} theMessage_fname(): charptr
//
(* ****** ****** *)

extern
fun{}
mysendmail 
  (string): void
implement
{}(*tmp*)
mysendmail(x0) = let
//
#define N 1024
var buf = @[char][N]()
//
val x0 = $UN.cast{charptr}(x0)
//
val err =
$extfcall
( int
, "snprintf", addr@buf, N
, "mailx -s '%s' -r '%s' %s %s < %s"
, theSubject_get(), theFrom_get(), theOtherOpt_get(), x0(*receiver*), theMessage_fname()
) (* end of [val] *)
//
val
command =
$UNSAFE.cast{string}(addr@buf)
//
val ((*void*)) =
println! ("mysendmail: command = ", command)
//
// (*
val err = $STDLIB.system(command)
val ((*void*)) =
if (err = 0) then println! ("mysendmail: message is sent!")
val ((*void*)) =
if (err != 0) then println! ("mysendmail: message is not sent!")
// *)
//
in
end // end of [mysendmail]

(* ****** ****** *)
//
implement
theFrom_get<>() = $UN.cast{charptr}("hwxi@bu.edu")
implement
theSubject_get<>() = $UN.cast{charptr}("Mysendmailist")
implement
theOtherOpt_get<>() = $UN.cast{charptr}("-c gmhwxi@gmail.com")
implement
theMessage_fname<>() = $UN.cast{charptr}("./mysendmailist.dats")
//
(* ****** ****** *)
//
val xs =
$list{string}
(
  "hwxi@cs.bu.edu"
)
val () =
list_foreach_cloref (xs, lam (x) =<cloref1> mysendmail(x))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [mysendmailist.dats] *)
