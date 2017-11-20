(* ****** ****** *)
(*
** For writing ATS code
** that translates into Erlang
*)
(* ****** ****** *)
//
// HX-2015-06:
// prefix for external names
//
#define
ATS_PACKNAME "ATSCC2ERL"
#define
ATS_EXTERN_PREFIX "ats2erlpre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/basics.sats"
//
(* ****** ****** *)
//
abstype pid_type
typedef pid = pid_type
//
abstype atom_type
typedef atom = atom_type
//
(* ****** ****** *)

abstype binary_type
typedef binary = binary_type

(* ****** ****** *)
//
abstype ERLval_type
typedef ERLval = ERLval_type
//
(* ****** ****** *)
//
abstype
ERLlist_type(a:t@ype)
//
typedef
ERLlist(a:t@ype) = ERLlist_type(a)
//
(* ****** ****** *)
//
(*
typedef string = ERLlist(char)
*)
//
(* ****** ****** *)
//
abstype
ERLmap_type(k:t@ype, x:t@ype)
//
typedef
ERLmap(k:t@ype, x:t@ype) = ERLmap_type(k, x)
//
(* ****** ****** *)
//
fun
string2atom(string): atom = "mac#%"
fun
atom2string(x: atom): string = "mac#%"
//
(* ****** ****** *)
//
fun
whereis(name: atom): Option(pid) = "mac#%"
//
fun
register(name: atom, pid: pid): void = "mac#%"
//
(* ****** ****** *)
//
fun
cloref0_app{b:t0p}(cfun0(b)): b = "mac#%"
//
fun
cloref1_app
  {a:t0p}{b:t0p}(cfun1(a, b), a): b = "mac#%"
//
fun
cloref2_app
  {a1,a2:t0p}{b:t0p}
  (cfun2(a1, a2, b), a1, a2): b = "mac#%"
fun
cloref3_app
  {a1,a2,a3:t0p}{b:t0p}
  (cfun3(a1, a2, a3, b), a1, a2, a3): b = "mac#%"
//
overload cloref_app with cloref0_app
overload cloref_app with cloref1_app
overload cloref_app with cloref2_app
overload cloref_app with cloref3_app
//
(* ****** ****** *)

(* end of [basics_erl.sats] *)
