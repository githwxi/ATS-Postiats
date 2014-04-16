(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

#include "kernel_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./kernel.sats"

(* ****** ****** *)

extern
fun first ((*void*)): void
extern
fun second ((*void*)): void

(* ****** ****** *)

implement
first () =
{
//
val () = bwputs ("user-first:1\n")
val () = syscall ((*void*))
val () = bwputs ("user-first:2\n")
val () = while (true) syscall ((*void*))
//
} (* end of [first] *)

(* ****** ****** *)

implement
second () =
{
//
val () = bwputs ("user-second:1\n")
val () = syscall ((*void*))
val () = bwputs ("user-second:2\n")
val () = while (true) syscall ((*void*))
//
} (* end of [second] *)

(* ****** ****** *)

%{^
unsigned int stack_first[STACK_SIZE] ;
unsigned int stack_second[STACK_SIZE] ;
unsigned int *start_first = &stack_first[STACK_SIZE-16] ;
unsigned int *start_second = &stack_second[STACK_SIZE-16] ;
unsigned int *the_tasks[TASK_LIMIT] ;
%} // end of [%{^]
extern val start_first: Ptr1 = "mac#"
extern val start_second: Ptr1 = "mac#"
extern val the_tasks : arrayref (task, TASK_LIMIT) = "mac#"

(* ****** ****** *)

implement
kernel_task_initize () =
{
//
prval () = lemma_sizeof{uint}()
//
val umode = 0x10u
val p = start_first
val ((*void*)) = $UN.ptr1_set<uint> (p, umode)
val p = ptr_succ<uint> (p)
val ((*void*)) = $UN.ptr1_set<uint> (p, $UN.cast{uint}(first))
//
val umode = 0x10u
val p = start_second
val ((*void*)) = $UN.ptr1_set<uint> (p, umode)
val p = ptr_succ<uint> (p)
val ((*void*)) = $UN.ptr1_set<uint> (p, $UN.cast{uint}(second))
//
val () = the_tasks[0] := $UN.cast{task}(start_first)
val () = the_tasks[1] := $UN.cast{task}(start_second)
//
} (* end of [kernel_task_initize] *)

(* ****** ****** *)

local

var ntask: int = 0
val ntask =
ref_make_viewptr{int}(view@ntask | addr@ntask)

in (* in-of-local *)

implement
choose_task () = let
//
val n = !ntask
//
(*
val () = bwputs ("choose_task: ")
val () = bwputi (n)
val () = bwputs ("\n")
*)
//
in
//
case+ n of
| 0 => the_tasks[0]
| 1 => the_tasks[1]
| _(*dead*) => choose_task ()
//
end // end of [choose_task]

implement
update_task (x) = let
//
val n = !ntask
val () = !ntask := 1 - n
//
(*
val () = bwputs ("update_task: ")
val () = bwputi (n)
val () = bwputs ("\n")
*)
//
in
//
case+ n of
| 0 => the_tasks[0] := x
| 1 => the_tasks[1] := x
| _(*dead*) => update_task (x)
//
end // end of [update_task]

end // end of [local]

(* ****** ****** *)

(* end of [kernel_task.dats] *)
