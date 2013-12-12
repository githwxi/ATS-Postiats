(*
** A simple implementation of
** Game-of-24 in ATS for use in Java
*)

(* ****** ****** *)
//
// HX: no dynloading
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
local
#include "../GameOf24_card.dats"
in (*nothing*) end
//
local
#include "../GameOf24_cardset.dats"
in (*nothing*) end
//
local
#include "../GameOf24_solve.dats"
in (*nothing*) end
//
(* ****** ****** *)

staload "../GameOf24.sats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload JNI = "{$JNI}/SATS/jni.sats"

(* ****** ****** *)

stadef jint = $JNI.jint

(* ****** ****** *)

stadef JNIEnvPtr = $JNI.JNIEnvPtr
stadef jstring (l:addr) = $JNI.jstring(l)
stadef jobject (l:addr) = $JNI.jobject(l)

(* ****** ****** *)
//
// HX-2013-08:
// [play24] is declared in Java class [GameOf24]
//
extern
fun JNI_play24
  {l:addr}
(
  env: !JNIEnvPtr
, obj: jobject (l)
, n1: jint, n2: jint, n3: jint, n4: jint
) : void = "ext#Java_GameOf24_play24" // endfun

(* ****** ****** *)

implement
JNI_play24
(
  env, obj, n1, n2, n3, n4
) = let
//
val n1 = $UN.cast{int}(n1)
val n2 = $UN.cast{int}(n2)
val n3 = $UN.cast{int}(n3)
val n4 = $UN.cast{int}(n4)
//
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val (
) = fprintln! (out, "play24(", n1, ", ", n2, ", ", n3, ", ", n4, "):")
//
in
//
case+ res of
| list_cons _ =>
  (
    fpprint_cardlst (out, res); fprint_newline (out)
  )
| list_nil () => 
  {
    val () = fprintln! (out, "There is NO solution.")
  }
//
end // end of [JNI_play24]

(* ****** ****** *)

%{$
//
// HX: This is ATS runtime:
//
#include "pats_ccomp_runtime.c"
#include "pats_ccomp_runtime2_dats.c"
#include "pats_ccomp_runtime_memalloc.c"
#include "pats_ccomp_runtime_trywith.c"
%}

(* ****** ****** *)

(* end of [GameOf24.dats] *)
