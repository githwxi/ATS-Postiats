(* ****** ****** *)
//
// HX-2014-11:
// A running example
// from ATS2 to Perl5
//
(* ****** ****** *)
//
#define
LIBATSCC2PL_targetloc
"$PATSHOME\
/contrib/libatscc2pl/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2PL}/SATS/integer.sats"
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
require "./libatscc2pl/libatscc2pl_all.pl";
%} // end of [%{^]

(* ****** ****** *)

%{$
#
$poly0 =
sub($) { my $x = $_[0]; return $x*$x + $x - 6; };
print "rtfind(lambda x: x*x + x - 6) = ", rtfind($poly0), "\n";
$poly1 =
sub($) { my $x = $_[0]; return $x*$x - $x - 6; };
print "rtfind(lambda x: x*x - x - 6) = ", rtfind($poly1), "\n";
#
$poly2 =
sub($) { my $x = $_[0]; return $x*$x + 2*$x - 99; };
print "rtfind(lambda x: x*x + 2*x - 6) = ", rtfind($poly2), "\n";
$poly3 =
sub($) { my $x = $_[0]; return $x*$x - 2*$x - 99; };
print "rtfind(lambda x: x*x - 2*x - 6) = ", rtfind($poly3), "\n";
#
%} // end of [%{$]

(* ****** ****** *)

(* end of [rtfind2.dats] *)
