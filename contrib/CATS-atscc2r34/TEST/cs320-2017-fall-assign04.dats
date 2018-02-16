(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "my_dynload"
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#include
  "{$LIBATSCC2R34}/mylibies.hats"
//
(* ****** ****** *)

#define
NDX100_fname "./DATA/NDX100-index.csv"

(* ****** ****** *)

val
NDX100_dframe =
$extfcall
( R34dframe(double)
, "read.csv"
, NDX100_fname, $extval(optarg,"header=TRUE")
)

(* ****** ****** *)
//
val
NDX100_dframe_names = names(NDX100_dframe)
//
val () =
$extfcall(void, "message", NDX100_dframe_names)
//
(* ****** ****** *)
//
val () = println!
("|NDX100_dframe_names| = ", length(NDX100_dframe_names))
//
(* ****** ****** *)

(*
val () =
assertloc(length(NDX100_dframe_names) >= 7)
val () =
println!("NDX100_dframe_names[1] = ", NDX100_dframe_names[1])
val () =
println!("NDX100_dframe_names[2] = ", NDX100_dframe_names[2])
val () =
println!("NDX100_dframe_names[3] = ", NDX100_dframe_names[3])
val () =
println!("NDX100_dframe_names[4] = ", NDX100_dframe_names[4])
val () =
println!("NDX100_dframe_names[5] = ", NDX100_dframe_names[5])
val () =
println!("NDX100_dframe_names[6] = ", NDX100_dframe_names[6])
val () =
println!("NDX100_dframe_names[7] = ", NDX100_dframe_names[7])
val () = // HX: this one is out-of-bounds
println!("NDX100_dframe_names[8] = ", NDX100_dframe_names[8])
*)

(* ****** ****** *)
//
val
Adj_Close_pos =
match("Adj.Close", NDX100_dframe_names)
val ((*void*)) =
println! ("Adj_Close_pos = ", Adj_Close_pos)
val ((*void*)) = assertloc(Adj_Close_pos > 0)
//
(* ****** ****** *)
//
(*
val
Adj_Close_data =
getcol_at(NDX100_dframe, Adj_Close_pos)
*)
//
val
Adj_Close_data =
getcol_by(NDX100_dframe, "Adj.Close")
//
val () = println!
("|Adj_Close_data| = ", length(Adj_Close_data))
//
(* ****** ****** *)
//
val n0 =
  length(Adj_Close_data)
//
val () = assertloc(n0 >= 2)
//
(* ****** ****** *)
//
val
Daily_price_changes =
(
R34vector_tabulate_cloref{double}
( n0-1
, lam(i) =>
  fopr(Adj_Close_data[i+1], Adj_Close_data[i+2]))
) where
{
  fn fopr(x: double, y: double): double = (y/x-1.0)
}
//
(* ****** ****** *)
//
val
volat =
sqrt(252*variance(Daily_price_changes))
//
val ((*void*)) =
$extfcall(void, "message", "Volatility = ", volat)
//
(* ****** ****** *)

%{^
######
if
(
!(exists("libatscc2r34.is.loaded"))
)
{
  assign("libatscc2r34.is.loaded", FALSE)
}
######
if
(
!(libatscc2r34.is.loaded)
)
{
  sys.source("./libatscc2r34/libatscc2r34_all.R")
}
######
%} // end of [%{^]

(* ****** ****** *)

%{$
my_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* end of [cs320-2017-fall-assign04.dats] *)
