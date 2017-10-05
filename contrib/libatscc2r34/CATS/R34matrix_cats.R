############################################
#
# HX-2017-10:
#
# for R code translated from ATS
#
############################################

############################################
#beg of [R34matrix_cats.R]
############################################

assign(
  "libatscc2r34_R34matrix.is.loaded", TRUE
)#assign

############################################

ats2r34pre_R34matrix_ncol <-
function(xss) { return(ncol(xss)) }
ats2r34pre_R34matrix_nrow <-
function(xss) { return(nrow(xss)) }

############################################
#
ats2r34pre_R34matrix_get_at <-
function(xss, i, j) { return(xss[[i,j]]) }
#
# HX-2017-10-03:
# No call-by-reference in R!!!
#
# ats2r34pre_R34matrix_set_at <-
# function(xss, i, j, x0) { xss[[i,j]] <- x0; return(NULL) }
#
############################################
#
ats2r34pre_R34matrix_transpose <-
  function(xss) { return(t(xss)) }
#
############################################

ats2r34pre_R34matrix_tabulate_fun <-
function(m0, n0, fopr)
{
  x1 = fopr(0, 0);
  xs = rep(x1, m0*n0)
  {
    if (n0 >= 2)
    {
      for (j in 2:n0)
      {
        xs[[j]] <- fopr(0, j-1)
      }
    }
    if (m0 >= 2)
    {
      for (i in 2:m0)
      for (j in 1:n0)
      {
        xs[[(i-1)*n0+j]] <= fopr(i-1, j-1)
      }
    }
  } ; return(matrix(xs, nrow=m0, ncol=n0))
} ## ats2r34pre_R34matrix_tabulate_fun

############################################
#end of [R34matrix_cats.R]
############################################
