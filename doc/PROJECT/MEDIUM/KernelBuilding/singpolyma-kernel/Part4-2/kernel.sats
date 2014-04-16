(* ****** ****** *)
//
%{#
#include "./kernel_param.hats"
%} // end of [%{#]
//
#include "./kernel_param.hats"
//
(* ****** ****** *)
//
abstype task_type = ptr
typedef task = task_type
//
(* ****** ****** *)
//
abstype stack_type(l:addr) = ptr(l)
typedef stack(l:addr) = stack_type(l)
//
typedef stack0 = [l:addr] stack(l)
typedef stack1 = [l:addr | l > null] stack(l)
//
(* ****** ****** *)

castfn stack2ptr {l:addr} (stack(l)):<> ptr(l)

(* ****** ****** *)

fun bwputi (int): void = "ext#"
fun bwputp (ptr): void = "ext#"
fun bwputs (string): void = "ext#"

(* ****** ****** *)
//
fun choose_tid (): int = "ext#"
//
fun fetch_task (id: int): task = "ext#"
fun update_task (id: int, x: task): void = "ext#"
fun insert_task (task, stack1): int(*id*) = "ext#"
//
(* ****** ****** *)

fun syscall (): void = "ext#" // assembly
fun syscall_fork (): int = "ext#" // assembly
fun activate (task): task = "ext#" // assembly

(* ****** ****** *)

fun stack_alloc (): stack0

(* ****** ****** *)

fun task_get_syscall (task): uint = "ext#"

(* ****** ****** *)

fun task_set_forkret (task, int): void = "ext#"

(* ****** ****** *)

fun syscall_process (id: int, x: task): void = "ext#"
fun syscall_process_fork (id: int, x: task): void = "ext#"

(* ****** ****** *)

fun kernel_task_initize ((*void*)): void = "ext#"

(* ****** ****** *)

(* end of [kernel.sats] *)
