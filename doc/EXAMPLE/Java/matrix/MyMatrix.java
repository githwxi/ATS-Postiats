/*
** Exporting a matrix in ATS for use in Java
*/

/* ****** ****** */

class
MyMatrix
{
    public
    static
    native
    long
    matrix_make_elt (int m, int n, int elt) ;

    public
    static
    native
    int matrix_get_at (long M, int i, int j) ;

    public
    static
    native
    void
    matrix_set_at (long M, int i, int j, int x) ;

} // end of [MyMatrix]

/* ****** ****** */

/* end of [MyMatrix.java] */
