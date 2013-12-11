/*
** Testing code for ATSarrayptr
*/

/* ****** ****** */
//
// java -classpath .:./../Java -Djava.library.path=./../Java ATSarrayptr_test
//
/* ****** ****** */

public
class
ATSarrayptr_test
{
//
    static
    {
	System.loadLibrary("ATSarrayptr_dats");
    }
//
    public
    static
    void main(String[] args)
    {
	long A ;
	long I ;
        long I1 = 1L ;
        long I_1 = -1L ;
//
	System.out.println("Hello from [ATSarrayptr_test]!");
//
	A = ATSarrayptr.make_elt(10, 0) ;
//
	ATSarrayptr.set_at(A, 5, I1) ;
	System.out.println ("A[5] = " + ATSarrayptr.get_at(A, 5));
//
	ATSarrayptr.set_at(A, 5, I_1) ;
	System.out.println ("A[5] = " + ATSarrayptr.get_at(A, 5));
//
	ATSarrayptr.free(A) ; // [A] is linear!
//
	return ;
    }
//
} // end of [ATSarrayptr_test]

/* ****** ****** */

/* end of [ATSarrayptr_test.java] */
