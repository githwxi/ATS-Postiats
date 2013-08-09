class Calculator
{
    public
    static
    native
    double eval(String inp) throws IllegalArgumentException;
    static
    {
	System.loadLibrary("Calulator_dats");
    }
    public static void main(String[] args)
    {
	if (args.length >= 1)
        {
	    String inp = args[0];
	    System.out.println ("eval(" + inp + ") = " + eval(inp)) ;
	} else {
	    System.out.println ("eval() = " + 0) ;
        } ;
	return ;
    }
} /* end of [Calculator] */
