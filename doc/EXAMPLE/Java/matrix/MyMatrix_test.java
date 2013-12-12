/*
** ATS data for use in Java
*/

/* ****** ****** */
//
// java -Djava.library.path=. MyMatrix_test
//
/* ****** ****** */

class
_Matrix
{
    long M = 0 ;
    _Matrix (int nrow, int ncol)
    {
	M = MyMatrix.make_elt (nrow, ncol, 0) ;
    }
//
    int get_at (int i, int j) { return MyMatrix.get_at(M, i, j) ; }
//
    void set_at (int i, int j, int x) { MyMatrix.set_at(M, i, j, x) ; return ; }
//
}

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
	_Matrix M ;
	M = new _Matrix(10, 10) ;
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


