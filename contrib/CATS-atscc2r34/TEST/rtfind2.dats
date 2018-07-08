(* ****** ****** *)
//
// HX-2017-10:
// A running example
// from ATS2 to R(stat)
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#define
LIBATSCC2R34_targetloc
"$PATSHOME/contrib/libatscc2r34"
//
(* ****** ****** *)
//
#staload
"{$LIBATSCC2R34}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun
rtfind (f: int -> int): int = "mac#"
//
implement
rtfind (f) = let
//
fun loop
  (i: int): int =
  if f (i) = 0 then i else loop (i+1)
//
in
  loop (0(*i*))
end // end of [rtfind]

(* ****** ****** *)

%{^
######
options(expressions=100000);
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
######
poly0 = function(x) { return (x*x + x - 6) ; }
message("rtfind(lambda x: x*x + x - 6) = ", rtfind(poly0))
######
poly1 = function(x) { return (x*x - x - 6) ; }
message("rtfind(lambda x: x*x - x - 6) = ", rtfind(poly1))
######
poly2 = function(x) { return (x*x + 2*x - 99) ; }
message("rtfind(lambda x: x*x + 2*x - 99) = ", rtfind(poly2))
######
poly3 = function(x) { return (x*x - 2*x - 99) ; }
message("rtfind(lambda x: x*x - 2*x - 99) = ", rtfind(poly3))
######
%} // end of [%{$]

(* ****** ****** *)

(* end of [rtfind2.dats] *)
