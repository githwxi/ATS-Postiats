/*
** Testing code for Arrayptr
*/

/* ****** ****** */
//
// java -classpath .:./../Java -Djava.library.path=./../Java Arrayptr_test
//
/* ****** ****** */

public
class
Arrayptr_test
{
//
    static
    {
	System.loadLibrary("Arrayptr_dats");
    }
//
    public
    static
    void main(String[] args)
    {
	long A ;
	System.out.println("Hello from [Arrayptr_test]!");
	A = Arrayptr.make_elt(10L, 0) ;
	System.out.println("A[5] = " + Arrayptr.get_at(A,5));
	Arrayptr.set_at(A, 5, 1L);
	System.out.println("A[5] = " + Arrayptr.get_at(A,5));
	Arrayptr.set_at(A, 5, -1L);
	System.out.println("A[5] = " + Arrayptr.get_at(A,5));
	Arrayptr.free(A) ; // [A] is linear!
	return ;
    }
//
} // end of [Arrayptr_test]

/* ****** ****** */

/* end of [Arrayptr_test.java] */
