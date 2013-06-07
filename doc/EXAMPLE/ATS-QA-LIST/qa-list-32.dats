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
local
implement
array_tabulate$fwork<int> (i) = LEN-g0u2i(i)
in (* in of [local] *)
val A = arrayptr_tabulate<int> (asz)
end // end of [local]
//
val () = $extfcall (void, "display_numbers", arrayptr2ptr(A), LEN)
//
val () = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-32.dats] *)
