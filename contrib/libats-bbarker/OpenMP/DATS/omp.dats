
(*
implement
omp_parallel_private(th_id) = {
%{
  #pragma omp parallel private(th_id)
%}
}
*)