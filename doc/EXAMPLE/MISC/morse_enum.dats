(*
//
// This code is based on some code by
// Eli Frey (eli.frey AT gmail DOT com)
//
// Minor modification by Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Time: July 18-19, 2012
//
*)
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc - -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -L${PATSHOME}/ccomp/atslib/lib -latslib
*)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/atspre.sats"
staload _ = "libats/ML/DATS/atspre.dats"
//
staload "libats/ML/SATS/string.sats"
staload _ = "libats/ML/DATS/string.dats"
//
(* ****** ****** *)

staload STDIO = "libats/libc/SATS/stdio.sats"

(* ****** ****** *)

#define nil stream_nil
#define cons stream_cons
#define :: stream_cons

(* ****** ****** *)

fun
from{n:int} (
  n: intGte(n)
) :<!ntm> stream (intGte(n)) = $delay(n :: from{n+1}(n+1))

(* ****** ****** *)

typedef sstring = stream string

(* ****** ****** *)

fun morse
  (n: Nat):<!laz> sstring = let
//
  fn add_dot  (str: string):<> string = "." + str
  fn add_dash (str: string):<> string = "-" + str
//
  fn go (n: Nat):<> sstring = $effmask_all
  (
    case+ n of
    | 0 => $delay (""  :: $delay (nil))
    | 1 => $delay ("." :: $delay (nil))
    | n =>> let
        val add_dots   = stream_map_fun( morse( n-1 ), add_dot )
        val add_dashes = stream_map_fun( morse( n-2 ), add_dash )
      in
        stream_merge_fun( add_dots, add_dashes, lam (_, _) => 0 )
      end // end of [n]
  ) // end of [go]
in
  stream_nth_exn (stream_map_fun(from{0}(0), go), n)
end // end of [morse]

(* ****** ****** *)

implement
main0 () =
{
//
val xs = morse (5)
val xs = stream2list (xs)
val () = list_vt_foreach_fun (xs, lam (x) =<1> $STDIO.puts_exn (x))
val () = list_vt_free (xs)
//
} // end of [main]

(* ****** ****** *)

(* end of [morse_enum.dats] *)
