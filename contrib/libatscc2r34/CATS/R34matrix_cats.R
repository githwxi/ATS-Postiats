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
ats2r34pre_R34vector_transpose <-
  function(xs) { return(t(xs)) }
ats2r34pre_R34matrix_transpose <-
  function(xss) { return(t(xss)) }
#
############################################
ats2r34pre_cbind_R34vector_R34vector <-
  function(xs, ys) { return(cbind(xs, ys)) }
ats2r34pre_cbind_R34vector_R34matrix <-
  function(xs, yss) { return(cbind(xs, yss)) }
ats2r34pre_cbind_R34matrix_R34vector <-
  function(xss, ys) { return(cbind(xss, ys)) }
ats2r34pre_cbind_R34matrix_R34matrix <-
  function(xss, yss) { return(cbind(xss, yss)) }

############################################

ats2r34pre_rbind_R34vector_R34vector <-
  function(xs, ys) { return(rbind(xs, ys)) }
ats2r34pre_rbind_R34vector_R34matrix <-
  function(xs, yss) { return(rbind(xs, yss)) }
ats2r34pre_rbind_R34matrix_R34vector <-
  function(xss, ys) { return(rbind(xss, ys)) }
ats2r34pre_rbind_R34matrix_R34matrix <-
  function(xss, yss) { return(rbind(xss, yss)) }

############################################

ats2r34pre_add_R34matrix_R34matrix <-
  function(M1, M2) { return(M1 + M2) }
ats2r34pre_mul_R34matrix_R34matrix <-
  function(M1, M2) { return(M1 * M2) }

############################################
#
ats2r34pre_matmult <-
  function(M1, M2) { return(M1 %*% M2) }
#
ats2r34pre_matmult_R34vector_R34matrix <-
  function(xs, yss)
  { return(ats2r34pre_matmult(xs, yss)) }
ats2r34pre_matmult_R34matrix_R34vector <-
  function(xss, ys)
  { return(ats2r34pre_matmult(xss, ys)) }
ats2r34pre_matmult_R34matrix_R34matrix <-
  function(xss, yss)
  { return(ats2r34pre_matmult(xss, yss)) }
#
############################################
#
# HX: R is column-major
#
ats2r34pre_R34matrix_tabulate_fun <-
function(m0, n0, fopr)
{
  x1 = fopr(0, 0);
  xs = rep(x1, m0*n0)
  {
    if (m0 >= 2)
    {
      for (i in 2:m0)
      {
        xs[[i]] <- fopr(0, i-1)
      }
    }
    if (n0 >= 2)
    {
      for (j in 2:n0)
      for (i in 1:m0)
      {
        xs[[(j-1)*m0+i]] <- fopr(i-1, j-1)
      }
    }
  } ; return(matrix(xs, nrow=m0, ncol=n0))
} ## ats2r34pre_R34matrix_tabulate_fun

############################################
#end of [R34matrix_cats.R]
############################################
