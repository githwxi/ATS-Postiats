(*
** Module [filename]
*)

(* ****** ****** *)
//
// HX-2015-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2erlibc_filename_"
//
(* ****** ****** *)
//
staload
"./../../basics_erl.sats"
//
(* ****** ****** *)

typedef name = string
typedef filename = string

(* ****** ****** *)
//
fun
absname_1(Filename: name): filename = "mac#%"
fun
absname_2(Filename: name, Dir: name): filename = "mac#%"
//
(* ****** ****** *)

overload absname with absname_1
overload absname with absname_2

(* ****** ****** *)
//
fun
absname_join
  (Dir: name, Filename: name): filename = "mac#%"
//
(* ****** ****** *)
//
fun
basename_1(Filename: name): filename = "mac#%"
fun
basename_2(Filename: name, Ext: name): filename = "mac#%"
//
(* ****** ****** *)

overload basename with basename_1
overload basename with basename_2

(* ****** ****** *)

fun
dirname(Filename: name): filename = "mac#%"

(* ****** ****** *)

fun
extension(Filename: name): filename = "mac#%"

(* ****** ****** *)

(*
fun
flatten (Filename: name): filename = "mac#%"
*)

(* ****** ****** *)
//
fun join_1
  (Components: ERLlist(name)): filename = "mac#%"
//
fun join_2
  (Filename1: name, Filename2: name): filename = "mac#%"
//
(* ****** ****** *)

fun pathtype(Path: name): atom = "mac#%"

(* ****** ****** *)

fun nativename(Path: name): filename = "mac#%"

(* ****** ****** *)
//
fun
rootname_1(Filename: name): filename = "mac#%"
fun
rootname_2(Filename: name, Ext: name): filename = "mac#%"
//
(* ****** ****** *)

overload rootname with rootname_1
overload rootname with rootname_2

(* ****** ****** *)

fun split(filename): ERLlist(name) = "mac#%"

(* ****** ****** *)

(* end of [filename.sats] *)
