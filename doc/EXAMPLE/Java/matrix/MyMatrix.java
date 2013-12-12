/*
** ATS data for use in Java
*/

/* ****** ****** */

class
MyMatrix
{
//
    long M = 0 ;
//
    MyMatrix (int nrow, int ncol)
    {
	M = _make_elt (nrow, ncol, 0) ;
    }
    MyMatrix (int nrow, int ncol, int x0)
    {
	M = _make_elt (nrow, ncol, x0) ;
    }
//
    int get_at (int i, int j) { return _get_at(M, i, j) ; }
//
    void set_at (int i, int j, int x) { _set_at(M, i, j, x) ; return ; }
//
    private
    static
    native
    long _make_elt (int m, int n, int x0) ;

    private
    static
    native
    int _get_at (long M, int i, int j) ;

    private
    static
    native
    void _set_at (long M, int i, int j, int x) ;
//
} // end of [MyMatrix]

/* ****** ****** */

/* end of [MyMatrix.java] */
