/*
** ATS data for use in Java
*/

/* ****** ****** */

class
MyMatrix
{
    public
    static
    native
    long
    MyMatrix_make_elt (int m, int n, int elt) ;

    public
    static
    native
    int MyMatrix_get_at (long M, int i, int j) ;

    public
    static
    native
    void
    MyMatrix_set_at (long M, int i, int j, int x) ;

} // end of [MyMatrix]

/* ****** ****** */

/* end of [MyMatrix.java] */
