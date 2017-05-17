(* ****** ****** *)
(*
** For implementing a DSL
** that supports ATS and OpenSCAD co-programming
*)
(* ****** ****** *)
//
datatype
point2 =
POINT2 of (double, double)
datatype
point3 =
POINT3 of (double, double, double)
//
(* ****** ****** *)
//
fun
point2_make_int2
  (x: int, y: int): point2
fun
point2_make_float2
  (x: double, y: double): point2
//
fun
point3_make_int3
  (x: int, y: int, z: int): point3
fun
point3_make_float3
  (x: double, y: double, z: double): point3
//
symintr point2 point3
//
overload
point2 with point2_make_int2
overload
point2 with point2_make_float2
//
overload
point3 with point3_make_int3
overload
point3 with point3_make_float3
//
(* ****** ****** *)
//
abstype label_type
typedef label = label_type
//
(* ****** ****** *)
//
fun
label_make(x: string): label
//
symintr label
overload label with label_make
//
(* ****** ****** *)
//
fun
fprint_label
  : fprint_type(label)
//
overload
fprint with fprint_label
//
(* ****** ****** *)
//
fun
eq_label_label(label, label): bool
fun
neq_label_label(label, label): bool
//
fun
compare_label_label
  (l1: label, l2: label): int(*sgn*)
//
overload = with eq_label_label
overload != with neq_label_label
overload compare with compare_label_label
//
(* ****** ****** *)

abstype scadenv_type
typedef scadenv = scadenv_type

(* ****** ****** *)

datatype
scadexp =
//
| SCADEXPnil of ()
//
| SCADEXPint of (int)
//
| SCADEXPbool of (bool)
//
| SCADEXPfloat of double
//
| SCADEXPstring of string
//
| SCADEXPvec of scadexplst
//
| SCADEXPcond of
    (scadexp, scadexp, scadexp)
  // SCADEXPcond
//
| SCADEXPextfcall of
    (string(*fun*), scadenv, scadarglst)
  // SCADEXPextfcall
//
(* end of [scadexp] *)

and scadarg =
//
| SCADARGexp of scadexp
| SCADARGlabexp of (label, scadexp)
//
where
scadexplst = List0(scadexp)
and
scadarglst = List0(scadarg)

(* ****** ****** *)
(*
//
datatype
scadvec(n:int) =
{n:int}
SCADVEC of list(scadexp, n)
//
typedef scadv2d = scadvec(2)
typedef scadv3d = scadvec(3)
typedef scadvec0 = [n:int | n >= 0] scadvec(n)
//
macdef
SCADV2D(x, y) =
SCADVEC($list{scadexp}(,(x), ,(y)))
macdef
SCADV3D(x, y, z) =
SCADVEC($list{scadexp}(,(x), ,(y), ,(z)))
//
*)
(* ****** ****** *)
//
datatype
scadobj =
//
| SCADOBJfapp of
  (
    string(*fopr*), scadenv, scadarglst
  ) (* SCADOBJfopr *)
//
| SCADOBJmapp of (string(*mopr*), scadobjlst)
//
| SCADOBJtfmapp of (scadtfm(*mtfm*), scadobjlst)
//
| SCADOBJextcode of (string(*code*)) // HX: external one-liners
//
// end of [scadobj]

and
scadtfm =
//
| SCADTFMident of ()
//
| SCADTFMcompose of (scadtfm, scadtfm)
//
| SCADTFMextmcall of
  (
    string(*fmod*), scadenv(*env*), scadarglst(*args*)
  ) (* SCADTFMextmcall *)
//
where scadobjlst = List0(scadobj)
//
(* ****** ****** *)
//
fun
scadenv_nil(): scadenv
fun
scadenv_sing
  (l: label, x: scadexp): scadenv
//
(* ****** ****** *)
//
fun
scadenv_is_nil(scadenv): bool
fun
scadenv_is_cons(scadenv): bool
//
(* ****** ****** *)
//
fun
fprint_scadenv : fprint_type(scadenv)
//
fun
fprint_scadexp : fprint_type(scadexp)
fun
fprint_scadarg : fprint_type(scadarg)
//
(* ****** ****** *)

overload fprint with fprint_scadenv
overload fprint with fprint_scadexp
overload fprint with fprint_scadarg

(* ****** ****** *)
//
fun
scadenv_search
  (env: scadenv, k: label): Option_vt(scadexp)
fun
scadenv_insert_any
  (env: scadenv, k: label, x: scadexp): scadenv
//
(* ****** ****** *)
//
fun
scadexp_femit(FILEref, scadexp): void
fun
scadexplst_femit(FILEref, scadexplst): void
//
(* ****** ****** *)
//
fun
scadenv_femit(FILEref, scadenv): void
//
(* ****** ****** *)
//
fun
scadarg_femit(FILEref, scadarg): void
fun
scadarglst_femit(FILEref, scadarglst): void
fun
scadarglst_env_femit(FILEref, scadarglst, scadenv): void
//
(* ****** ****** *)
//
fun
scadobj_femit
  (out: FILEref, int(*indent*), scadobj): void
fun
scadtfm_femit
  (out: FILEref, int(*indent*), scadtfm): void
//
fun
scadobjlst_femit
  (out: FILEref, int(*indent*), scadobjlst): void
//
(* ****** ****** *)

(* end of [OpenSCAD.sats] *)
