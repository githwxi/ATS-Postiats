(*
//
Barry Schwartz
Sunday, 2018-09-16
//
The attached program causes the stack to overflow, I presume due to
infinite alloca calls. (If so, this strikes me as one case where C99
stack arrays may be superior to alloca, since they can be limited to a
{}-scope.)
//
*)
(*
  On Linux, overruns the stack.

  Due to this behavior, I had a test program fail
  for large test cases.
*)

#define ATS_DYNLOADFLAG 0

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

%{#

#include <alloca.h>
#include <sys/time.h>
#include <sys/resource.h>

%}

%{^

static void
set_stack_limit (void)
{
  struct rlimit rlim;
  rlim.rlim_cur = 8192 * 1024;
  rlim.rlim_max = 8192 * 1024;
  (void) setrlimit (RLIMIT_STACK, &rlim);
}

%}

exception Lulz

fn
raise_Lulz () : void =
  begin
    println! "LOL!";
    $raise Lulz
  end

fun
try_and_catch () : void =
  try
    raise_Lulz ();
    println! "Uncaught";
    try_and_catch ()
  with
    ~Lulz () =>
      begin
        println! "Caught";
        try_and_catch ()
      end

implement
main () =
  begin
    $extfcall (void, "set_stack_limit");
    try_and_catch ();
    0
  end
