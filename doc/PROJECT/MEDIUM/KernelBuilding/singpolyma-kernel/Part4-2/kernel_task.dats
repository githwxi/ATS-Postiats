(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

#include "kernel_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./kernel.sats"

(* ****** ****** *)

staload "./../../utilities/string.dats"

(* ****** ****** *)

extern
fun first ((*void*)): void
extern
fun second (msg: string): void

(* ****** ****** *)

implement
first () =
{
//
val () = bwputs ("user-first:1\n")
val () = if (syscall_fork () != 0) then second (": user-first: forked")
val () = bwputs ("user-first:2\n")
val () = while (true) syscall ((*void*))
//
} (* end of [first] *)

(* ****** ****** *)

implement
second (msg) =
{
//
val () = bwputs ("user-second")
val () = (bwputs (msg); bwputs ("\n"))
val () = while (true) syscall ((*void*))
//
} (* end of [second] *)

(* ****** ****** *)
//
%{^
unsigned int
the_stacks[STACK_LIMIT][STACK_SIZE] ;
%}
extern val the_stacks : Ptr1 = "mac#"
//
local

var nstack: intGte(0) = 0
val nstack =
ref_make_viewptr{intGte(0)}(view@nstack | addr@nstack)

in (* in-of-local *)

implement
stack_alloc
  () = let
  val n = !nstack
in
//
if n >= STACK_LIMIT
  then
    $UN.cast{stack0}(the_null_ptr)
  else let
    val () = !nstack := n + 1
    val stack =
      ptr_add<uint> (the_stacks, n*STACK_SIZE)
    // end of [val]
  in
    $UN.cast{stack1}(stack)
  end // end of [else]
//
end // end of [stack_alloc]

end // end of [local]

(* ****** ****** *)
//
%{^
unsigned
int stack_first[STACK_SIZE] ;
unsigned int *the_tasks[TASK_LIMIT] ;
unsigned int *the_tinfo[TASK_LIMIT] ;
%} // end of [%{^]
extern val stack_first: stack1 = "mac#"
extern
val the_tasks : arrayref (task, TASK_LIMIT) = "mac#"
extern
val the_tinfo : arrayref (stack1, TASK_LIMIT) = "mac#"
//
(* ****** ****** *)

extern
fun task_forkto
  (id: int, task: task, child: stack1): task = "ext#"

(* ****** ****** *)

local
//
var ntask: int = 0
val ntask =
ref_make_viewptr{intGte(0)}(view@ntask | addr@ntask)
//
var ntask_all: int = 0
val ntask_all =
ref_make_viewptr{intGte(0)}(view@ntask_all | addr@ntask_all)
//
in (* in-of-local *)

implement
choose_tid
  () = id where
{
  val id = !ntask
  val id1 = id + 1
  val () = if id1 < !ntask_all then !ntask := id1 else !ntask := 0
} (* end of [choose_tid] *)

(* ****** ****** *)

implement
fetch_task (id) = let
//
(*
val () = bwputs ("update_task: id = ")
val () = bwputi (id)
val () = bwputs ("\n")
*)
//
val id = $UN.cast{natLt(TASK_LIMIT)}(id)
//
in
  the_tasks[id]
end // end of [choose_task]

(* ****** ****** *)

implement
update_task
  (id, x) = let
//
(*
val () = bwputs ("update_task: id = ")
val () = bwputi (id)
val () = bwputs ("\n")
*)
//
val id =
  $UN.cast{natLt(TASK_LIMIT)}(id)
//
val ((*void*)) = the_tasks[id] := x
//
in
  // nothing
end (* end of [update_task] *)

(* ****** ****** *)

implement
insert_task
  (task, stack) = let
//
val n = !ntask_all
//
(*
val () = bwputs ("insert_task: ")
val () = bwputi (n)
val () = bwputs ("\n")
*)
//
in
//
if n < TASK_LIMIT
  then let
    val () = !ntask_all := n+1
    val () = the_tasks[n] := task
    val () = the_tinfo[n] := stack
  in
    n (*tid*)
  end // end of [then]
  else (~1) // end of [else]
// end of [if]
//
end // end of [insert_task]

(* ****** ****** *)

implement
task_forkto
(
  id, task, stack2
) = let
//
  val id =
    $UN.cast{natLt(TASK_LIMIT)}(id)
  // end of [val]
//
  val stack = stack2ptr(the_tinfo[id])
  val stack_bot = ptr_add<uint> (stack, STACK_SIZE)
  val stack_used = $UN.cast{size_t}(stack_bot - $UN.cast2ptr(task))
//
  val stack2_bot = ptr_add<uint> (stack2ptr(stack2), STACK_SIZE)
//
  val task2 = ptr_sub<uint> (stack2_bot, stack_used)
  val task2 = mymemcpy<> (task2, $UN.cast2ptr(task), stack_used)
//
  val task2 = $UN.cast{task}(task2)
  val () = task_set_forkret (task2, 0)
//
in
  task2
end // end of [task_forkto]

(* ****** ****** *)

implement
kernel_task_initize () =
{
//
prval () = lemma_sizeof{uint}()
//
val start_first =
  ptr_add<uint> (stack2ptr(stack_first), STACK_SIZE-16)
//
val p = start_first
val ((*void*)) = $UN.ptr1_set<uint> (p, 0x10u(*umode*))
val p = ptr_succ<uint> (p)
val ((*void*)) = $UN.ptr1_set<uint> (p, $UN.cast{uint}(first))
//
val task_first = $UN.cast{task}(start_first)
//
val id = insert_task (task_first, stack_first)
//
} (* end of [kernel_task_initize] *)

end // end of [local]

(* ****** ****** *)
//
implement
task_get_syscall (task) =
  $UN.ptr0_get<uint> (ptr_add<uint> ($UN.cast2ptr(task), 2+7))
//
(* ****** ****** *)
//
implement
task_set_forkret (task, ret) =
  $UN.ptr0_set<uint> (ptr_add<uint> ($UN.cast2ptr(task), 2+0), g0i2u(ret))
//
(* ****** ****** *)

implement
syscall_process
  (id, task) = let
//
val knd = task_get_syscall(task)
//
in
//
case+ knd of
| _ when knd = 0u => ()
| _ when knd = 1u => syscall_process_fork (id, task)
| _ (*unrecognized*) => ()
//
end // end of [syscall_process]

(* ****** ****** *)

implement
syscall_process_fork
  (id, task) = let
//
val stack2 = stack_alloc ()
val p_stack2 = stack2ptr (stack2)
//
in
//
if p_stack2 > 0
  then let
    val task2 =
      task_forkto (id, task, stack2)
    // end of [val]
    val id2 = insert_task (task2, stack2)
  in
    task_set_forkret (task, id2)
  end // end of [then]
  else task_set_forkret (task, ~1(*fail*))
// end of [if]
//
end // end of [syscall_process_fork]

(* ****** ****** *)

(* end of [kernel_task.dats] *)
