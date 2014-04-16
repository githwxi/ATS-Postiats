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

fun bwputi (int): void = "ext#"
fun bwputp (ptr): void = "ext#"
fun bwputs (string): void = "ext#"

(* ****** ****** *)

fun choose_task (): task = "ext#"
fun update_task (task): void = "ext#"

(* ****** ****** *)

fun syscall (): void = "ext#" // assembly
fun activate (task): task = "ext#" // assembly

(* ****** ****** *)

fun kernel_task_initize ((*void*)): void = "ext#"

(* ****** ****** *)

(* end of [kernel.sats] *)
