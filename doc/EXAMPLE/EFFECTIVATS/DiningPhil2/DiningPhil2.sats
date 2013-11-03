(* ****** ****** *)
//
// HX-2013-11
//
// Implementing a variant of
// the problem of Dining Philosophers
//
(* ****** ****** *)

%{#
#define NPHIL 5
%} // end of [%{#]
#define NPHIL 5

(* ****** ****** *)

fun randsleep (n: intGte(1)): void

(* ****** ****** *)
//
abstype phil_type = ptr
typedef phil = phil_type
//
(* ****** ****** *)
//
absvtype fork_vtype = ptr
vtypedef fork = fork_vtype
//
(* ****** ****** *)

fun phil_acquire_lfork (ph: phil): fork
fun phil_release_lfork (ph: phil, f: fork): void

(* ****** ****** *)

fun phil_acquire_rfork (ph: phil): fork
fun phil_release_rfork (ph: phil, f: fork): void

(* ****** ****** *)

fun phil_dine (ph: phil): void
fun phil_think (ph: phil): void

(* ****** ****** *)

fun phil_loop (ph: phil): void

(* ****** ****** *)

fun cleaner_loop ((*void*)): void

(* ****** ****** *)
//
// shfork: shared fork
//
abstype shfork_type = ptr
typedef shfork = shfork_type
//
(* ****** ****** *)

fun shfork_acquire_fork (shfork): fork
fun shfork_release_fork (shfork, fork): void

(* ****** ****** *)

fun phil_get_lshfork (ph: phil): shfork
fun phil_get_rshfork (ph: phil): shfork

(* ****** ****** *)
//
// shforkbuf: shared fork buffer
//
abstype forkbuf_type = ptr
typedef forkbuf = forkbuf_type
//
(* ****** ****** *)

fun the_forkbuf_get (): forkbuf

fun the_forkbuf_insert (fork): void
fun the_forkbuf_takeout ((*void*)): fork

(* ****** ****** *)

(* end of [DiningPhil2.sats] *)
