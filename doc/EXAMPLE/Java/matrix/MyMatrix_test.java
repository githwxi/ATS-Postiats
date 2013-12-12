/*
** ATS data for use in Java
*/

/* ****** ****** */
//
// java -Djava.library.path=. MyMatrix_test
//
/* ****** ****** */

public
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
	MyMatrix M ;
	M = new MyMatrix(10, 10) ;
	System.out.println ("M00 = " + M.get_at (0, 0));
	M.set_at (0, 0, 1) ;
	System.out.println ("M00 = " + M.get_at (0, 0));
	M.set_at (0, 0, -1) ;
	System.out.println ("M00 = " + M.get_at (0, 0));
	return ;
    }
} // end of [MyMatrix_test]

/* ****** ****** */

/* end of [MyMatrix_test.java] */


