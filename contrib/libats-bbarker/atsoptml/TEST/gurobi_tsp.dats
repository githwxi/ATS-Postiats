(*
** Testing API for GUROBI:
** Traveling salesman problem.
*)


(*
  Based on tsp_c.c from Gurobi 5.6:
  
  Solve a traveling salesman problem on a randomly generated set of
  points using lazy constraints.   The base MIP model only includes
  'degree-2' constraints, requiring each node to have exactly
  two incident edges.  Solutions to this model may contain subtours -
  tours that don't visit every node.  The lazy constraint callback
  adds new constraints to cut them off.
*)