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
//
	ATSarrayptr A ;
	long I1 = 1L, I_1 = -1L ;
//
	System.out.println("Hello from [ATSarrayptr_test]!");
//
	A = new ATSarrayptr(10) ;
//
	System.out.println ("A.size = " + A.size) ;
//
	for (int i = 0; i < 10; i += 1) A.set_at(i, i) ;
//
	for (int i = 0; i < 10; i += 1)
	    {
		System.out.println ("A[" + i + "] = " + A.get_at(i)) ;
	    }
//
	A.free() ; // [A] is linear!
//
	return ;
//
    }
//
} // end of [ATSarrayptr_test]

/* ****** ****** */

/* end of [ATSarrayptr_test.java] */
