(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

(*
#include
"share/atspre_staload.hats"
*)

(* ****** ****** *)

staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/bool.dats"
staload _ = "prelude/DATS/char.dats"
staload _ = "prelude/DATS/string.dats"

(* ****** ****** *)

staload _(*UNSAFE*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

(*
int
main(void) {
  char *string = "Hello, World!\n";
//
  while(*string) {
    *(volatile char *)0x101f1000 = *string;
    string++;
  }
//
  while(1); /* We can't exit, there's nowhere to go */
  return 0;
} /* end of [main] */
*)

(* ****** ****** *)
//
extern
fun output (char): void = "mac#"
%{^
static
void output (char c)
{ 
  *(volatile char*)(0x101f1000) = c; return ;
}
%}
//
(* ****** ****** *)
//
extern
fun
mymain (): void = "ext#"
//
implement
mymain ((*void*)) =
{
//
val hello = "Hello, world!\n"
//
local
implement(env)
string_foreach$fwork<env> (c, env) = output (c)
in(*in-of-local*)
val _ = string_foreach (hello)
end // end of [local]
//
} (* end of [mymain] *)

(* ****** ****** *)

%{$

int main () { mymain (); return 0 ;}

%} // end of [%{$}

(* ****** ****** *)

(* end of [kernel.dats] *)
