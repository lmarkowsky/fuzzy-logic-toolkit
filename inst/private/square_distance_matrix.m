## Copyright (C) 2011-2025 L. Markowsky <lmarkowsky@gmail.com>
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
## @deftypefn {Function File} {@var{sqr_dist} =} square_distance_matrix (@var{X}, @var{V})
##
## Return a k x n matrix of ||x - v||^2 values (the squares of the
## distances between input data points x and cluster centers v), where
## k is the number of cluster centers and n is the number of data points.
##
## The element sqr_dist(i, j) will contain the square of the distance
## between the cluster center V(i, :) and the data point X(j, :).
##
## @end deftypefn

## Author:        L. Markowsky
## Keywords:      fuzzy-logic-toolkit fuzzy private
## Directory:     fuzzy-logic-toolkit/inst/private/
## Filename:      square_dist_matrix.m
## Last-Modified: 5 Jun 2024

function sqr_dist = square_distance_matrix (X, V)

  sqr_dist = (sumsq (X, 2) + (sumsq (V, 2))' - 2 * X * V')';

endfunction

%!test
%!  ## Test the faster version of this function (above) by comparing its
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
%!  function sqr_dist = square_distance_matrix_using_for_loops (X, V)
%!    k = rows (V);
%!    n = rows (X);
%!    sqr_dist = zeros (k, n);
%!    for i = 1 : k
%!      Vi = V(i, :);
%!      for j = 1 : n
%!        Vi_to_Xj = X(j, :) - Vi;
%!        sqr_dist(i, j) = sum (Vi_to_Xj .* Vi_to_Xj);
%!      endfor
%!    endfor
%!  endfunction
%!
%!  ## Fixed array sizes and tolerance for the test.
%!
%!  n = 100;
%!  f = 8;
%!  k = 5;
%!  tolerance = 10e-9;
%!
%!  ## Run the test 100 times, in a loop. Each test run is successful if
%!  ## the vectorized and nested-for-loop version of the function produce
%!  ## results within the hard-coded tolerance.
%!
%!  for i = 1 : 100
%!    X = rand (n, f);
%!    V = rand (k, f);
%!    vec_result = square_distance_matrix (X, V);
%!    loop_result = square_distance_matrix_using_for_loops (X, V);
%!    assert (abs (vec_result - loop_result) < tolerance)
%!  endfor
