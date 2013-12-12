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
	ATSarrayptr A ;
	long I1 = 1L, I_1 = -1L ;
//
	System.out.println("Hello from [ATSarrayptr_test]!");
//
	A = new ATSarrayptr(10) ;
//
	A.set_at(5, I1) ;
	System.out.println ("A[5] = " + A.get_at(5));
//
	A.set_at(5, I_1) ;
	System.out.println ("A[5] = " + A.get_at(5));
//
	A.free() ; // [A] is linear!
//
	return ;
    }
//
} // end of [ATSarrayptr_test]

/* ****** ****** */

/* end of [ATSarrayptr_test.java] */
