## Copyright (C) 2011-2024 L. Markowsky <lmarkov@users.sourceforge.net>
##
## This file is part of the fuzzy-logic-toolkit.
##
## The fuzzy-logic-toolkit is free software; you can redistribute it
## and/or modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 3 of
## the License, or (at your option) any later version.
##
## The fuzzy-logic-toolkit is distributed in the hope that it will be
## useful, but WITHOUT ANY WARRANTY; without even the implied warranty
## of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with the fuzzy-logic-toolkit; see the file COPYING.  If not,
## see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {@var{Mu} =} update_cluster_membership (@var{V}, @var{X}, @var{m}, @var{k}, @var{n}, @var{sqr_dist})
##
## Compute Mu for each (cluster center, input point) pair.
##
## @seealso{fcm, gustafson_kessel, init_cluster_prototypes, update_cluster_prototypes, compute_cluster_obj_fcn, compute_cluster_convergence}
##
## @end deftypefn

## Authors:       Tony Trew, L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy partition clustering
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      update_cluster_membership.m
## Last-Modified: 5 Jun 2024

##----------------------------------------------------------------------
## Note:     This function is an implementation of Equation 13.4 in
##           Fuzzy Logic: Intelligence, Control and Information, by
##           J. Yen and R. Langari, Prentice Hall, 1999, page 380
##           (International Edition) and Step 3 of Algorithm 4.1 in
##           Fuzzy and Neural Control, by Robert Babuska, November 2009,
##           p. 63.
##----------------------------------------------------------------------

function Mu = update_cluster_membership (V, X, m, k, n, sqr_dist)

  sqr_dist_zeros = (sqr_dist == 0);
  num_zeros = sum (sum (sqr_dist_zeros));

  if (num_zeros == 0)
    exponent = 1.0 / (m - 1);
    summation = (sqr_dist ./ sum(sqr_dist)).^exponent;

    if (all (all (summation != 0)))
      Mu = 1.0 ./ summation;
      Mu ./= sum (Mu);
    else
      error ("division by 0 in update_cluster_membership'\n");
    endif

  else
    Mu = sqr_dist_zeros / num_zeros;

  endif

endfunction

%!test
%!  ## Test the vectorized version of this function (above) by comparing its
%!  ## output with the output of the previous, nested-for-loop version (below).
%!  ##
%!  ## The test is run 100 times (but is reported by the Octave interpreter as
%!  ## "1 test"). In each of the 100 test runs, the vectorized and loop versions
%!  ## of the function are called using randomly generated matrices X, V.
%!  ##
%!  ## The sizes of X and V, however, aren't random: X has 100 rows, 8 cols,
%!  ## and V has 5 rows, 8 cols. That is, the entries in X and V are random
%!  ## values in the range [0, 1], but the sizes of X and V are hard-coded.
%!  ##
%!  ## The test is passed if all entries of the two results differ by less than
%!  ## a tolerance of 10e-9 in all 100 test runs.
%!  
%!  function Mu = update_cluster_membership_using_for_loops (V, X, m, k, n, sqr_dist)
%!
%!    Mu = zeros (k, n);
%!
%!    if (min (min (sqr_dist)) > 0)
%!      exponent = 1.0 / (m - 1);
%!      for i = 1 : k
%!        for j = 1 : n
%!          summation = 0.0;
%!          for l = 1 : k
%!            summation += (sqr_dist(i, j) / sqr_dist(l, j))^exponent;
%!          endfor
%!          if (summation != 0)
%!            Mu(i, j) = 1.0 / summation;
%!          else
%!            error ("division by 0 in update_cluster_membership'\n");
%!          endif
%!        endfor
%!      endfor
%!
%!    else
%!      num_zeros = 0;
%!      for i = 1 : k
%!        for j = 1 : n
%!          if (sqr_dist(i, j) == 0)
%!            num_zeros++;
%!            Mu(i, j) = 1.0;
%!          endif
%!        endfor
%!      endfor
%!      Mu = Mu / num_zeros;
%!    endif
%!
%!  endfunction
%!
%!  ## Fixed array sizes, exponent, and tolerance for the test.
%!
%!  n = 100;
%!  f = 8;
%!  k = 5;
%!  m = 2;
%!  tolerance = 10e-9;
%!
%!  ## Run the test 100 times, in a loop. In the last 5 test runs, make 3 of
%!  ## the data points in X identical to cluster centers in V in order to test
%!  ## the else case in the function. 
%!
%!  ## Each test run is successful if the vectorized and nested-for-loop
%!  ## version of the function produce results within the hard-coded tolerance.
%!
%!  for i = 1 : 100
%!    X = rand (n, f);
%!    V = rand (k, f);
%!
%!    if (i > 95)
%!      X(1:3) = V(1:3);
%!    endif
%!
%!    sqr_dist = square_distance_matrix (X, V);
%!    vec_result = update_cluster_membership (V, X, m, k, n, sqr_dist);
%!    loop_result = update_cluster_membership_using_for_loops (V, X, m, k, n, sqr_dist);
%!    assert (abs (vec_result - loop_result) < tolerance)
%!  endfor

