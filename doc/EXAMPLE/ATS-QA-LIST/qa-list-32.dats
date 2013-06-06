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
"share/atspre_staload_tmpdef.hats"
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
val A =
arrayptr_make_uninitized<int> (asz)
//
implement
array_initize$init<int> (i, x) = x := LEN-g0u2i(i)
val () = arrayptr_initize<int> (A, asz)
//
val () = $extfcall (void, "display_numbers", arrayptr2ptr(A), LEN)
//
val () = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list_32.dats] *)
