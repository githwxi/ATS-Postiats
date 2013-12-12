/*
** ATS data for use in Java
*/

/* ****** ****** */
//
// java -Djava.library.path=. MyMatrix_test
//
/* ****** ****** */

class
MyMatrix_test
{
    static
    {
	// HX: for loading libGameOf24_dats.so only
	System.loadLibrary("MyMatrix_dats"); // once!!!
    }
    public
    static
    void main(String[] args)
    {
	long M ;
	M = MyMatrix.make_elt (10, 10, 0) ;
	System.out.println ("M00 = " + MyMatrix.get_at (M, 0, 0));
	MyMatrix.set_at (M, 0, 0, 1) ;
	System.out.println ("M00 = " + MyMatrix.get_at (M, 0, 0));
	MyMatrix.set_at (M, 0, 0, -1) ;
	System.out.println ("M00 = " + MyMatrix.get_at (M, 0, 0));
	return ;
    }
} // end of [MyMatrix_test]

/* ****** ****** */

/* end of [MyMatrix_test.java] */


