(*
** Source: reported by Will Blair
*)

(* ****** ****** *)

(*
** Status: Fixed by Hongwei Xi
*)

(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/pointer.dats"
staload _ = "prelude/DATS/reference.dats"

(* ****** ****** *)

(* 
**
** Symptom:
** In the following program, the template for "ref" is not fully
** instantiated in the C output if the staload declaration is made for
** reference.sats
**
** Template instantiation works fine when the following declaration is
** removed.
**
*)
staload "prelude/SATS/reference.sats"
        
(* ****** ****** *)

val i = ref<int> (0)
        
(* ****** ****** *)

implement main0() = ()
        
(*
Compile with
patscc -DATS_MEMALLOC_LIBC test.dats
*)

(* ****** ****** *)

(* end of [bug-2013-10-07.dats] *)
