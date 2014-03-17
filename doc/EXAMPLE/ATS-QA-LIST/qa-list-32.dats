(* ****** ****** *)
//
// HX-2013-06
//
(* ****** ****** *)

%{^
#include <stdio.h>

void display_numbers
(
  unsigned int* array, unsigned int size
) {
  int i;
  if( array != NULL ) {
    for(i=0;i<size;i++) { printf("%i\n", array[i]); }
  }
}
%}

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
extern
fun{a:t0p}
display_numbers (A: ptr, asz: int) : void
//
implement{a}
display_numbers (A, asz) = let
//
var A: ptr = A
var i: int = 0
//
in
//
while (i < asz)
{
val () = i := i + 1
val () = fprint_val<a> (stdout_ref, $UN.ptr0_get<a> (A))
val () = fprint_newline (stdout_ref)
val () = A := ptr_succ<a> (A)
}
//
end // end of [display_numbers]

(* ****** ****** *)

/*

#define LEN 17

int main(int argc, char* argv[]) {
  int i;
  unsigned int* my_array = (unsigned int*)malloc(LEN*sizeof(unsigned int));
  for(i=0;i<LEN;i++) {
    my_array[i] = LEN - i;
  }
            
  display_numbers(my_array, LEN);//--> from my external lib
              
  free(my_array);
}

*/

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define LEN 17

(* ****** ****** *)

implement
main0 () =
{
//
val asz = i2sz(LEN)
//
typedef T = int
//
local
implement
array_tabulate$fopr<T> (i) = LEN-g0u2i(i)
in (* in of [local] *)
val A = arrayptr_tabulate<T> (asz)
end // end of [local]
//
val () =
display_numbers<T> (arrayptr2ptr(A), LEN)
val () = $extfcall
(void, "display_numbers", arrayptr2ptr(A), LEN)
//
val () = arrayptr_free (A)
//
typedef T = float
//
local
implement
array_tabulate$fopr<T> (i) = g0i2f(LEN-g0u2i(i))
in (* in of [local] *)
val A = arrayptr_tabulate<T> (asz)
end // end of [local]
//
val () = display_numbers<T> (arrayptr2ptr(A), LEN)
//
val () = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-32.dats] *)
