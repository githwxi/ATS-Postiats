//
// Based on mip1_c.c in gurobi_dir/examples/c/
// (Gurobi version 5.6)
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

staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

(* ****** ****** *)

staload 
GRB = "atsoptml/SATS/gurobi.sats"


